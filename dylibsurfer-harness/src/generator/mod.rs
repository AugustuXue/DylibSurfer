//! 模糊测试 Harness 生成器

mod context;

pub use context::GenerationContext;

use crate::config::HarnessConfig;
use crate::error::HarnessError;
use crate::template::{TemplateEngine, TemplateContext, CodeFormatter};
use crate::input_conversion::generate_extractor_code;
use dylibsurfer_ir::FunctionSignature;
use std::fs;
use std::path::Path;

/// 模糊测试 Harness 生成器
pub struct HarnessGenerator {
    /// Harness 生成配置
    config: HarnessConfig,
    
    /// 模板引擎
    template_engine: TemplateEngine<'static>,
}

impl HarnessGenerator {
    /// 创建新的 Harness 生成器
    pub fn new(config: &HarnessConfig) -> Self {
        let mut template_engine = TemplateEngine::new();
        
        // 注册增强型模板
        template_engine.register_template_string("enhanced_harness", r#"
fn harness_{{function_name}}(data: &[u8]) -> bool {
    // 检查最小数据大小
    if data.len() < {{min_data_size}} {
        return false;  
    }
    
    // 创建资源管理器
    let mut resource_manager = ResourceManager::new();
    
    // 初始化光标位置
    let mut cursor = 0;
    
    // 提取参数
    {{param_extractors}}
    
    // 使用异常捕获执行目标函数
    let result = std::panic::catch_unwind(|| {
        unsafe {
            {{lib_name}}::{{function_name}}(
                {{#each parameters}}
                {{name}}{{#unless @last}},{{/unless}}
                {{/each}}
            )
        }
    });
    
    // 清理所有分配的资源
    resource_manager.cleanup_all();
    
    // 如果函数执行未崩溃，则返回true
    result.is_ok()
}
"#).expect("注册增强型模板失败");
        
        // 从配置注册自定义模板
        for (name, template) in &config.template.custom_templates {
            template_engine.register_template_string(name, template)
                .expect("注册自定义模板失败");
        }
        
        // 如果指定了模板目录，注册该目录中的模板
        if let Some(template_dir) = &config.template.template_dir {
            let dir = Path::new(template_dir);
            if dir.exists() && dir.is_dir() {
                template_engine.register_templates_dir(dir)
                    .expect("从目录注册模板失败");
            }
        }
        
        Self {
            config: config.clone(),
            template_engine,
        }
    }
    
    /// 为函数生成 harness
    /// 
    /// # 参数
    /// * `signature` - 函数签名
    /// 
    /// # 返回值
    /// * `Ok(String)` - 生成的 harness 代码
    /// * `Err(HarnessError)` - 生成过程中发生错误
    pub fn generate_harness(&self, signature: &FunctionSignature) -> Result<String, HarnessError> {
        // 创建模板上下文
        let mut context = TemplateContext::new();
        
        // 添加函数信息到上下文
        context.insert("function_name".to_string(), serde_json::Value::String(signature.name.clone()));
        context.insert("lib_name".to_string(), serde_json::Value::String(self.config.general.project_name.clone()));
        
        // 计算最小数据大小
        let min_data_size = signature.parameters.len().max(1) * 4;
        context.insert("min_data_size".to_string(), serde_json::Value::Number(serde_json::Number::from(min_data_size)));
        
        // 添加参数到上下文
        let mut parameters = Vec::new();
        let mut param_extractors = Vec::new();
        
        for param in &signature.parameters {
            let mut param_info = serde_json::Map::new();
            param_info.insert("name".to_string(), serde_json::Value::String(param.name.clone()));
            param_info.insert("type".to_string(), serde_json::Value::String(format!("{:?}", param.ty)));
            
            // 确定参数是否为指针
            let is_pointer = matches!(param.ty, dylibsurfer_ir::TypeInfo::Pointer(_));
            param_info.insert("is_pointer".to_string(), serde_json::Value::Bool(is_pointer));
            
            // 参数类型名称（用于生成提取函数）
            let type_name = match &param.ty {
                dylibsurfer_ir::TypeInfo::Int(_) => "int",
                dylibsurfer_ir::TypeInfo::Float => "float",
                dylibsurfer_ir::TypeInfo::Pointer(_) => "pointer",
                dylibsurfer_ir::TypeInfo::Void => "void",
                dylibsurfer_ir::TypeInfo::Struct { name, .. } => name,
            };
            param_info.insert("type_name".to_string(), serde_json::Value::String(type_name.to_string()));
            
            // 生成参数提取代码
            if let Ok(extractor) = generate_extractor_code(&param.ty, &param.name, "cursor") {
                param_extractors.push(extractor);
            }
            
            parameters.push(serde_json::Value::Object(param_info));
        }
        
        context.insert("parameters".to_string(), serde_json::Value::Array(parameters));
        context.insert("param_extractors".to_string(), 
                      serde_json::Value::String(param_extractors.join("\n    ")));
        
        // 优先使用增强型模板
        let template_name = if self.template_engine.has_template("enhanced_harness") {
            "enhanced_harness"
        } else {
            "basic_harness"
        };
        
        let rendered = self.template_engine.render(template_name, &context)?;
        
        // 如果启用了格式化，格式化代码
        if self.config.template.format_code {
            let formatter = CodeFormatter::default();
            formatter.format(&rendered)
        } else {
            Ok(rendered)
        }
    }
    
    /// 为所有函数生成 harness 并写入文件
    /// 
    /// # 参数
    /// * `signatures` - 函数签名列表
    /// * `output_dir` - 输出目录
    /// 
    /// # 返回值
    /// * `Ok(())` - harness 生成并写入成功
    /// * `Err(HarnessError)` - 生成或写入过程中发生错误
    pub fn generate_and_write(&self, signatures: &[FunctionSignature], output_dir: &Path) -> Result<(), HarnessError> {
        if !output_dir.exists() {
            fs::create_dir_all(output_dir)?;
        }
        
        // 生成每个函数的harness代码
        let mut harnesses = Vec::new();
        for signature in signatures.iter().take(self.config.general.max_harnesses) {
            let harness = self.generate_harness(signature)?;
            harnesses.push(harness);
        }
        
        // 创建输出文件路径
        let output_file = output_dir.join(format!("{}_harness.rs", self.config.general.project_name));
        
        // 创建完整的输出内容
        let mut output = String::new();
        
        // 添加头部注释和导入
        output.push_str(&format!("// Generated harness for {}\n\n", self.config.general.project_name));
        output.push_str("use std::os::raw::*;\n");
        output.push_str("use std::ffi::*;\n");
        output.push_str("use std::ptr;\n\n");
        
        // 添加基本的数据提取函数
        output.push_str("// Basic data extraction functions\n");
        output.push_str(r#"
    fn extract_i8_from_data(data: &[u8], cursor: &mut usize) -> i8 {
        if *cursor >= data.len() {
            return 0;
        }
        let result = data[*cursor] as i8;
        *cursor += 1;
        result
    }
    
    fn extract_i16_from_data(data: &[u8], cursor: &mut usize) -> i16 {
        if *cursor + 2 > data.len() {
            return 0;
        }
        let result = i16::from_le_bytes([
            data[*cursor],
            data[*cursor + 1],
        ]);
        *cursor += 2;
        result
    }
    
    fn extract_i32_from_data(data: &[u8], cursor: &mut usize) -> i32 {
        if *cursor + 4 > data.len() {
            return 0;
        }
        let result = i32::from_le_bytes([
            data[*cursor],
            data[*cursor + 1],
            data[*cursor + 2],
            data[*cursor + 3],
        ]);
        *cursor += 4;
        result
    }
    
    fn extract_i64_from_data(data: &[u8], cursor: &mut usize) -> i64 {
        if *cursor + 8 > data.len() {
            return 0;
        }
        let result = i64::from_le_bytes([
            data[*cursor],
            data[*cursor + 1],
            data[*cursor + 2],
            data[*cursor + 3],
            data[*cursor + 4],
            data[*cursor + 5],
            data[*cursor + 6],
            data[*cursor + 7],
        ]);
        *cursor += 8;
        result
    }
    
    fn extract_float_from_data(data: &[u8], cursor: &mut usize) -> f32 {
        if *cursor + 4 > data.len() {
            return 0.0;
        }
        let result = f32::from_le_bytes([
            data[*cursor],
            data[*cursor + 1],
            data[*cursor + 2],
            data[*cursor + 3],
        ]);
        *cursor += 4;
        result
    }
    
    fn extract_double_from_data(data: &[u8], cursor: &mut usize) -> f64 {
        if *cursor + 8 > data.len() {
            return 0.0;
        }
        let result = f64::from_le_bytes([
            data[*cursor],
            data[*cursor + 1],
            data[*cursor + 2],
            data[*cursor + 3],
            data[*cursor + 4],
            data[*cursor + 5],
            data[*cursor + 6],
            data[*cursor + 7],
        ]);
        *cursor += 8;
        result
    }
    "#);
    
        // 添加资源管理器
        output.push_str("\n// Resource management system\n");
        output.push_str(r#"
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub enum ResourceType {
        Buffer,
        String,
        Object,
        File,
        Custom(u32),
    }
    
    #[derive(Debug)]
    pub struct ResourceManager {
        allocations: Vec<usize>,
        resource_types: Vec<ResourceType>,
        max_allocations: usize,
    }
    
    impl ResourceManager {
        pub fn new() -> Self {
            Self {
                allocations: Vec::with_capacity(32),
                resource_types: Vec::with_capacity(32),
                max_allocations: 100,
            }
        }
    
        pub fn track_allocation(&mut self, address: usize, resource_type: ResourceType) {
            if self.allocations.len() >= self.max_allocations {
                return;
            }
            self.allocations.push(address);
            self.resource_types.push(resource_type);
        }
    
        pub fn cleanup_all(&mut self) {
            for i in (0..self.allocations.len()).rev() {
                let address = self.allocations[i];
                let resource_type = self.resource_types[i];
                if address == 0 {
                    continue;
                }
                unsafe {
                    match resource_type {
                        ResourceType::Buffer | ResourceType::String | ResourceType::Object => {
                            libc::free(address as *mut libc::c_void);
                        },
                        ResourceType::File => {
                            libc::fclose(address as *mut libc::FILE);
                        },
                        ResourceType::Custom(_) => {
                            libc::free(address as *mut libc::c_void);
                        },
                    }
                }
            }
            self.allocations.clear();
            self.resource_types.clear();
        }
        
        pub fn resource_count(&self) -> usize {
            self.allocations.len()
        }
    }
    
    impl Drop for ResourceManager {
        fn drop(&mut self) {
            self.cleanup_all();
        }
    }
    "#);
    
        // 添加特定类型提取函数
        output.push_str("\n// Type-specific extraction functions\n");
        output.push_str(r#"
    fn extract_c_string_from_data(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut i8 {
        if *cursor >= data.len() {
            return std::ptr::null_mut();
        }
        let max_length = std::cmp::min(4096, data.len() - *cursor);
        let mut length = 0;
        for i in 0..max_length {
            if data[*cursor + i] == 0 {
                length = i + 1; 
                break;
            }
            if i == max_length - 1 {
                length = max_length;
            }
        }
        if length == 0 {
            return std::ptr::null_mut();
        }
        let buffer = unsafe { libc::malloc(length) as *mut i8 };
        if buffer.is_null() {
            return std::ptr::null_mut();
        }
        unsafe {
            std::ptr::copy_nonoverlapping(
                data[*cursor..].as_ptr(),
                buffer as *mut u8,
                length.min(max_length)
            );
            if data[*cursor + length - 1] != 0 {
                *buffer.add(length - 1) = 0;
            }
        }
        resource_manager.track_allocation(buffer as usize, ResourceType::String);
        *cursor += length;
        buffer
    }
    
    fn extract_buffer_from_data(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut libc::c_void {
        if *cursor >= data.len() {
            return std::ptr::null_mut();
        }
        let size_percent = data[*cursor] as f32 / 255.0;
        *cursor += 1;
        let size = (4 + (size_percent * 4092.0)) as usize;
        let available = std::cmp::min(size, data.len() - *cursor);
        let buffer = unsafe { libc::malloc(size) as *mut libc::c_void };
        if buffer.is_null() {
            return std::ptr::null_mut();
        }
        unsafe {
            std::ptr::copy_nonoverlapping(
                data[*cursor..].as_ptr(),
                buffer as *mut u8,
                available
            );
            if available < size {
                for i in available..size {
                    *(buffer as *mut u8).add(i) = (i % 256) as u8;
                }
            }
        }
        resource_manager.track_allocation(buffer as usize, ResourceType::Buffer);
        *cursor += available;
        buffer
    }
    
    fn extract_typed_pointer_from_data<T>(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut T {
        let void_ptr = extract_buffer_from_data(data, cursor, resource_manager);
        void_ptr as *mut T
    }
    "#);
    
        // 添加每个生成的harness函数
        output.push_str("\n// Generated harness functions\n");
        for harness in harnesses {
            output.push_str(&harness);
            output.push_str("\n\n");
        }
        
        // 写入文件
        fs::write(&output_file, output)?;
        println!("Successfully wrote harness to: {:?}", output_file);
        
        Ok(())
    }
}