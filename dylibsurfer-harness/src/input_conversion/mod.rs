//! 用于将模糊测试字节转换为结构化参数的输入转换系统
//!
//! 该模块提供了从模糊测试器提供的原始字节数组中提取结构化数据的核心功能
//! 处理各种数据类型、内存管理以及多函数模糊测试场景中的状态跟踪

mod byte_parser;
mod type_extractor;
mod resource_manager;
mod state_tracker;
mod integration;

pub use byte_parser::ByteParser;
pub use type_extractor::{TypeExtractor, ExtractorContext};
pub use resource_manager::{ResourceManager, ResourceId, ResourceType};
pub use state_tracker::{StateTracker, FunctionState};

use crate::error::HarnessError;
use dylibsurfer_ir::TypeInfo;
use std::collections::HashMap;

/// 输入转换系统的配置选项
#[derive(Debug, Clone)]
pub struct InputConversionConfig {
    /// 分配内存的最大缓冲区大小（以字节为单位）
    pub max_buffer_size: usize,
    
    /// 每个测试工具允许的最大分配次数
    pub max_allocations: usize,
    
    /// 是否使用确定性随机数生成器来填充数据
    pub deterministic_extraction: bool,
    
    /// 针对特定类型的自定义处理器
    pub custom_handlers: HashMap<String, String>,
}

impl Default for InputConversionConfig {
    fn default() -> Self {
        Self {
            max_buffer_size: 8192,
            max_allocations: 100,
            deterministic_extraction: true, 
            custom_handlers: HashMap::new(),
        }
    }
}

/// 生成从输入数据中提取给定类型值的代码
pub fn generate_extractor_code(
    type_info: &TypeInfo, 
    var_name: &str, 
    cursor_var: &str
) -> Result<String, HarnessError> {
    match type_info {
        TypeInfo::Void => {
            Ok(format!("let {} = ();", var_name))
        },
        TypeInfo::Int(bits) => {
            let fn_name = match *bits {
                8 => "extract_i8_from_data",
                16 => "extract_i16_from_data",
                32 => "extract_i32_from_data",
                64 => "extract_i64_from_data",
                _ => "extract_i32_from_data", // fallback to i32 for unusual sizes
            };
            Ok(format!("let {} = {}(data, &mut {});", var_name, fn_name, cursor_var))
        },
        TypeInfo::Float => {
            Ok(format!("let {} = extract_float_from_data(data, &mut {});", var_name, cursor_var))
        },
        TypeInfo::Pointer(inner) => {
            // Handle different pointer types differently
            if let TypeInfo::Void = **inner {
                // void pointer
                Ok(format!(
                    "let {} = extract_buffer_from_data(data, &mut {}, resource_manager);", 
                    var_name, cursor_var
                ))
            } else if let TypeInfo::Int(8) = **inner {
                // Likely a string
                Ok(format!(
                    "let {} = extract_c_string_from_data(data, &mut {}, resource_manager);", 
                    var_name, cursor_var
                ))
            } else {
                // Generic pointer
                Ok(format!(
                    "let {} = extract_typed_pointer_from_data::<{}>(data, &mut {}, resource_manager);", 
                    var_name, 
                    inner_type_name(inner), 
                    cursor_var
                ))
            }
        },
        TypeInfo::Struct { name, .. } => {
            // For struct extraction we'll need more complex handling
            Ok(format!(
                "let {} = extract_struct_{}(data, &mut {}, resource_manager);", 
                var_name, sanitize_ident(name), cursor_var
            ))
        },
    }
}

/// 识别内部类
/// 将 TypeInfo 类型信息转换为对应的 Rust 类型名
fn inner_type_name(type_info: &TypeInfo) -> String {
    match type_info {
        TypeInfo::Void => "c_void".to_string(),
        TypeInfo::Int(bits) => {
            match *bits {
                8 => "i8".to_string(),
                16 => "i16".to_string(),
                32 => "i32".to_string(),
                64 => "i64".to_string(),
                _ => "i32".to_string(),
            }
        },
        TypeInfo::Float => "f32".to_string(),
        TypeInfo::Pointer(_) => "c_void".to_string(), // For double pointers
        TypeInfo::Struct { name, .. } => sanitize_ident(name),
    }
}

/// 转换标识符用于rust代码
fn sanitize_ident(name: &str) -> String {
    let sanitized = name.replace(|c: char| !c.is_alphanumeric() && c != '_', "_");
    if sanitized.chars().next().map_or(false, |c| c.is_numeric()) {
        format!("t_{}", sanitized)
    } else {
        sanitized
    }
}