//! 模糊测试 Harness 生成器

mod context;

pub use context::GenerationContext;

use crate::config::HarnessConfig;
use crate::error::HarnessError;
use crate::template::{TemplateEngine, TemplateContext};
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
        context.insert("min_data_size".to_string(), serde_json::Value::Number(serde_json::Number::from(16)));
        
        // 添加参数到上下文
        let mut parameters = Vec::new();
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
            
            parameters.push(serde_json::Value::Object(param_info));
        }
        
        context.insert("parameters".to_string(), serde_json::Value::Array(parameters));
        
        // 渲染模板
        let template_name = "basic_harness";
        let rendered = self.template_engine.render(template_name, &context)?;
        
        // 如果启用了格式化，格式化代码
        if self.config.template.format_code {
            let formatter = crate::template::CodeFormatter::default();
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
        // 如果输出目录不存在，创建它
        if !output_dir.exists() {
            fs::create_dir_all(output_dir)?;
        }
        
        // 生成 harness
        let mut harnesses = Vec::new();
        
        for signature in signatures.iter().take(self.config.general.max_harnesses) {
            let harness = self.generate_harness(signature)?;
            harnesses.push(harness);
        }
        
        // 将 harness 写入文件
        let output_file = output_dir.join(format!("{}_harness.rs", self.config.general.project_name));
        
        let mut output = String::new();
        
        // 添加文件头
        output.push_str(&format!(
            "//! 为 {} 生成的 harness\n//!\n//! 此文件由 DylibSurfer 自动生成\n\n",
            self.config.general.project_name
        ));
        
        // 添加工具函数（用于从数据中提取参数）
        output.push_str(r#"
/// 从数据中提取整数
fn extract_int_from_data(data: &[u8], cursor: &mut usize) -> i32 {
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

/// 从数据中提取浮点数
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

/// 从数据中提取指针数据
fn extract_pointer_from_data(data: &[u8], cursor: &mut usize, size: usize) -> *mut u8 {
    if *cursor >= data.len() {
        return std::ptr::null_mut();
    }
    
    // 分配内存
    let actual_size = std::cmp::min(size, data.len() - *cursor);
    let buffer = unsafe { libc::malloc(actual_size) as *mut u8 };
    
    if buffer.is_null() {
        return std::ptr::null_mut();
    }
    
    // 复制数据
    unsafe {
        std::ptr::copy_nonoverlapping(
            data[*cursor..].as_ptr(),
            buffer,
            actual_size,
        );
    }
    
    *cursor += actual_size;
    buffer
}

/// 清理指针
fn cleanup_pointer(ptr: *mut u8) {
    if !ptr.is_null() {
        unsafe {
            libc::free(ptr as *mut libc::c_void);
        }
    }
}
"#);
        
        // 添加 harness
        for harness in harnesses {
            output.push_str(&harness);
            output.push_str("\n\n");
        }
        
        // 写入文件
        fs::write(&output_file, output)?;
        
        Ok(())
    }
}
