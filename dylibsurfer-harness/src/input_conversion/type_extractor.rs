//! 类型提取系统，用于将原始字节转换为结构化数据类型
//!
//! 该模块建立在字节解析系统（ByteParser）上

use crate::error::HarnessError;
use super::byte_parser::ByteParser;
use super::resource_manager::{ResourceManager, ResourceType};
use dylibsurfer_ir::TypeInfo;
use std::collections::HashMap;

/// 在提取过程中维护状态和配置，提供对 ResourceManager 的引用以管理资源
#[derive(Debug)]
pub struct ExtractorContext<'a> {
    /// 存储类型特定的选项或参数
    options: HashMap<String, String>,
    /// 对 ResourceManager 的可变引用，用于注册和跟踪动态分配的资源
    pub resource_manager: &'a mut ResourceManager,
}

impl<'a> ExtractorContext<'a> {
    /// 创建一个新的 ExtractorContext，初始化空选项表并绑定 ResourceManager
    pub fn new(resource_manager: &'a mut ResourceManager) -> Self {
        Self {
            options: HashMap::new(),
            resource_manager,
        }
    }
    
    /// 设置提取过程中的一个选项
    pub fn set_option(&mut self, key: &str, value: &str) {
        self.options.insert(key.to_string(), value.to_string());
    }
    
    /// 获取某个选项的值（若存在）
    pub fn get_option(&self, key: &str) -> Option<&String> {
        self.options.get(key)
    }
}

/// 负责从字节流中提取结构化数据类型，并支持自定义提取逻辑
#[derive(Debug)]
pub struct TypeExtractor {
    /// 分配缓冲区的最大大小
    max_buffer_size: usize,
    /// 将类型名称映射到自定义提取处理代码（以字符串形式存储）的 HashMap
    custom_handlers: HashMap<String, String>,
}

impl TypeExtractor {
    /// 创建默认配置的 TypeExtractor（max_buffer_size 为 8192，custom_handlers 为空）
    pub fn new() -> Self {
        Self {
            max_buffer_size: 8192, // 8KB default max allocation
            custom_handlers: HashMap::new(),
        }
    }
    
    /// 使用指定的 max_buffer_size 和 custom_handlers 创建 TypeExtractor
    pub fn with_config(max_buffer_size: usize, custom_handlers: HashMap<String, String>) -> Self {
        Self {
            max_buffer_size,
            custom_handlers,
        }
    }
    
    /// 特定类型设置自定义提取处理代码
    pub fn set_custom_handler(&mut self, type_name: &str, handler_code: &str) {
        self.custom_handlers.insert(type_name.to_string(), handler_code.to_string());
    }
    
    /// 根据 TypeInfo 从 ByteParser 中提取数据并返回字节向量
    pub fn extract_value<'a>(
        &self,
        type_info: &TypeInfo,
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        match type_info {
            TypeInfo::Void => Ok(Vec::new()),
            TypeInfo::Int(bits) => self.extract_integer(*bits, parser),
            TypeInfo::Float => self.extract_float(parser),
            TypeInfo::Pointer(inner_type) => self.extract_pointer(inner_type, parser, context),
            TypeInfo::Struct { name, fields } => self.extract_struct(name, fields, parser, context),
        }
    }
    
    /// 根据指定位宽提取整数
    fn extract_integer<'a>(
        &self,
        bits: u32,
        parser: &mut ByteParser<'a>,
    ) -> Result<Vec<u8>, HarnessError> {
        let mut result = Vec::new();
        
        match bits {
            8 => {
                let value = parser.extract_u8()?;
                result.push(value);
            },
            16 => {
                let value = parser.extract_u16()?;
                result.extend_from_slice(&value.to_le_bytes());
            },
            32 => {
                let value = parser.extract_u32()?;
                result.extend_from_slice(&value.to_le_bytes());
            },
            64 => {
                let value = parser.extract_u64()?;
                result.extend_from_slice(&value.to_le_bytes());
            },
            _ => {
                // Fallback to u32 for non-standard sizes
                let value = parser.extract_u32()?;
                result.extend_from_slice(&value.to_le_bytes());
            }
        }
        
        Ok(result)
    }
    
    /// 提取一个 32 位浮点数
    fn extract_float<'a>(
        &self,
        parser: &mut ByteParser<'a>,
    ) -> Result<Vec<u8>, HarnessError> {
        let value = parser.extract_f32()?;
        let mut result = Vec::with_capacity(4);
        result.extend_from_slice(&value.to_le_bytes());
        Ok(result)
    }
    
    /// 将字节流转换为合适的指针对象
    fn extract_pointer<'a>(
        &self,
        inner_type: &Box<TypeInfo>,
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        match &**inner_type {
            TypeInfo::Void => {
                // 通用缓冲区分配
                self.extract_buffer(parser, context)
            },
            TypeInfo::Int(8) => {
                // 视为C字符串
                self.extract_string(parser, context)
            },
            _ => {
                // 分配有类型的对象
                self.extract_typed_object(inner_type, parser, context)
            }
        }
    }
    
    /// 提取一个通用缓冲区（void*）
    fn extract_buffer<'a>(
        &self,
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        // 动态确定缓冲区大小（通过改变第一个字节来控制分配的缓冲区大小）
        let max_buffer_size = self.max_buffer_size;
        let size_byte = parser.extract_u8()? as f32 / 255.0;
        let buffer_size = (size_byte * max_buffer_size as f32) as usize;
        
        if buffer_size == 0 {
            // 返回一个空向量
            return Ok(Vec::new());
        }
        
        // 填充缓冲区内容
        let buffer_content = if buffer_size <= parser.remaining() {
            let content = parser.extract_bytes(buffer_size)?;
            content.to_vec()
        } else {
            // 如果输入字节不足，先提取所有可用的字节，然后用确定性模式填充剩余部分 (位置 % 256)
            let available = parser.remaining();
            let mut content = Vec::with_capacity(buffer_size);
            
            if available > 0 {
                content.extend_from_slice(parser.extract_bytes(available)?);
            }
            
            // Pad the rest with repeated pattern
            while content.len() < buffer_size {
                content.push((content.len() % 256) as u8);
            }
            
            content
        };
        
        // 注册资源
        let resource_id = context.resource_manager.register_resource(
            buffer_content,
            ResourceType::Buffer,
        );
        
        // 返回资源标识符
        Ok(resource_id.to_le_bytes().to_vec())
    }
    
    /// 提取一个 C 风格字符串（以 null 结尾），并注册到 ResourceManager
    fn extract_string<'a>(
        &self,
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        // Limit string size to max_buffer_size - 1 (leaving room for null terminator)
        let max_string_len = self.max_buffer_size.saturating_sub(1);
        
        // Extract the string content including null terminator if present
        let string_content = parser.extract_c_string(max_string_len)?;
        
        if string_content.is_empty() {
            // Return null pointer for empty strings
            return Ok(Vec::new());
        }
        
        // Ensure null termination
        let mut buffer = string_content.to_vec();
        if !buffer.ends_with(&[0]) {
            buffer.push(0);
        }
        
        // Register this allocation with the resource manager
        let resource_id = context.resource_manager.register_resource(
            buffer,
            ResourceType::String,
        );
        
        // Return the resource ID as a pointer value
        Ok(resource_id.to_le_bytes().to_vec())
    }
    
    /// 提取一个类型化对象（非 void* 或字符串的指针）
    fn extract_typed_object<'a>(
        &self,
        type_info: &TypeInfo,
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        // First extract the object value
        let object_data = self.extract_value(type_info, parser, context)?;
        
        if object_data.is_empty() {
            // Return null pointer for empty objects
            return Ok(Vec::new());
        }
        
        // Register this allocation with the resource manager
        let resource_id = context.resource_manager.register_resource(
            object_data,
            ResourceType::Object,
        );
        
        // Return the resource ID as a pointer value
        Ok(resource_id.to_le_bytes().to_vec())
    }
    
    /// 提取一个结构体，处理字段对齐和数据提取
    fn extract_struct<'a>(
        &self,
        name: &str,
        fields: &[TypeInfo],
        parser: &mut ByteParser<'a>,
        context: &mut ExtractorContext,
    ) -> Result<Vec<u8>, HarnessError> {
        // Check if we have a custom handler for this struct
        if let Some(handler) = self.custom_handlers.get(name) {
            // Invoke custom handler logic - this would be more complex in a real implementation
            return Err(HarnessError::GenerationError(
                format!("Custom handler invocation not implemented: {}", handler)
            ));
        }
        
        // Extract each field in order
        let mut struct_data = Vec::new();
        
        for field in fields {
            // Align field to its natural alignment
            let alignment = self.get_type_alignment(field);
            let current_pos = struct_data.len();
            let padding = (alignment - (current_pos % alignment)) % alignment;
            
            // Add padding bytes
            for _ in 0..padding {
                struct_data.push(0);
            }
            
            // Extract the field value
            let field_data = self.extract_value(field, parser, context)?;
            
            // Add field data to the struct
            struct_data.extend_from_slice(&field_data);
        }
        
        Ok(struct_data)
    }
    
    /// 返回类型的对齐要求（字节数）
    fn get_type_alignment(&self, type_info: &TypeInfo) -> usize {
        match type_info {
            TypeInfo::Void => 1,
            TypeInfo::Int(bits) => {
                match *bits {
                    8 => 1,
                    16 => 2,
                    32 => 4,
                    64 => 8,
                    _ => 4, // Default to 4 for unusual sizes
                }
            },
            TypeInfo::Float => 4,
            TypeInfo::Pointer(_) => {
                // Size of pointer depends on architecture
                if cfg!(target_pointer_width = "64") {
                    8
                } else {
                    4
                }
            },
            TypeInfo::Struct { .. } => {
                // Assume largest alignment for structs
                8
            }
        }
    }
}

/// 生成一组类型提取函数的 Rust 代码（作为字符串），用于 fuzzing harness
pub fn generate_type_extractor_code() -> String {
    r#"
/// Extract a C string from the data
fn extract_c_string_from_data(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut i8 {
    if *cursor >= data.len() {
        return std::ptr::null_mut();
    }
    
    // Determine string length - limited to 4KB to prevent excessive allocation
    let max_length = std::cmp::min(4096, data.len() - *cursor);
    let mut length = 0;
    
    // Find null terminator or calculate length
    for i in 0..max_length {
        if data[*cursor + i] == 0 {
            length = i + 1; // Include null terminator
            break;
        }
        if i == max_length - 1 {
            length = max_length;
        }
    }
    
    if length == 0 {
        return std::ptr::null_mut();
    }
    
    // Allocate memory for the string
    let buffer = unsafe { libc::malloc(length) as *mut i8 };
    if buffer.is_null() {
        return std::ptr::null_mut();
    }
    
    // Copy data including null terminator
    unsafe {
        std::ptr::copy_nonoverlapping(
            data[*cursor..].as_ptr(),
            buffer as *mut u8,
            length.min(max_length)
        );
        
        // Ensure null termination
        if data[*cursor + length - 1] != 0 {
            *buffer.add(length - 1) = 0;
        }
    }
    
    // Register for cleanup
    resource_manager.track_allocation(buffer as usize, ResourceType::String);
    
    *cursor += length;
    buffer
}

/// Extract a fixed-size buffer from the data
fn extract_buffer_from_data(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut libc::c_void {
    if *cursor >= data.len() {
        return std::ptr::null_mut();
    }
    
    // Determine buffer size - use a byte to determine size as percentage of max
    let size_percent = data[*cursor] as f32 / 255.0;
    *cursor += 1;
    
    // Size ranging from 4 bytes to 4KB
    let size = (4 + (size_percent * 4092.0)) as usize;
    
    // Actual available bytes
    let available = std::cmp::min(size, data.len() - *cursor);
    
    // Allocate memory for the buffer
    let buffer = unsafe { libc::malloc(size) as *mut libc::c_void };
    if buffer.is_null() {
        return std::ptr::null_mut();
    }
    
    // Copy available data
    unsafe {
        std::ptr::copy_nonoverlapping(
            data[*cursor..].as_ptr(),
            buffer as *mut u8,
            available
        );
        
        // Fill remaining space with a pattern
        if available < size {
            for i in available..size {
                *(buffer as *mut u8).add(i) = (i % 256) as u8;
            }
        }
    }
    
    // Register for cleanup
    resource_manager.track_allocation(buffer as usize, ResourceType::Buffer);
    
    *cursor += available;
    buffer
}

/// Extract a typed pointer from the data
fn extract_typed_pointer_from_data<T>(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut T {
    let void_ptr = extract_buffer_from_data(data, cursor, resource_manager);
    void_ptr as *mut T
}

/// Extract a struct with specific field extractor
fn extract_struct_from_data<T>(
    data: &[u8], 
    cursor: &mut usize, 
    resource_manager: &mut ResourceManager,
    field_extractors: &[fn(&[u8], &mut usize, &mut ResourceManager, *mut T)]
) -> *mut T {
    // Skip if no data
    if *cursor >= data.len() {
        return std::ptr::null_mut();
    }
    
    // Allocate memory for the struct
    let struct_size = std::mem::size_of::<T>();
    let buffer = unsafe { libc::malloc(struct_size) as *mut T };
    if buffer.is_null() {
        return std::ptr::null_mut();
    }
    
    // Initialize with zeros
    unsafe {
        std::ptr::write_bytes(buffer as *mut u8, 0, struct_size);
    }
    
    // Extract each field using its extractor
    for extractor in field_extractors {
        extractor(data, cursor, resource_manager, buffer);
    }
    
    // Register for cleanup
    resource_manager.track_allocation(buffer as usize, ResourceType::Object);
    
    buffer
}
"#.to_string()
}