//! 输入转换系统的集成模块
//!
//! 本模块结合字节解析器、类型提取器、资源管理器和状态跟踪器，
//! 提供将模糊测试字节转换为结构化输入的完整解决方案

use std::collections::HashMap;
use dylibsurfer_ir::{FunctionSignature, TypeInfo, Parameter};
use crate::error::HarnessError;
use super::{
    byte_parser::generate_byte_parser_code,
    type_extractor::generate_type_extractor_code,
    resource_manager::generate_resource_manager_code,
    state_tracker::generate_state_tracker_code,
    InputConversionConfig, generate_extractor_code
};

/// 为测试工具生成完整的输入转换代码
#[allow(dead_code)]
pub fn generate_input_conversion_code(
    function: &FunctionSignature,
    config: &InputConversionConfig
) -> Result<String, HarnessError> {
    let mut code = String::new();
    
    // 添加所有模块的辅助函数
    code.push_str(&generate_byte_parser_code());
    code.push_str("\n\n");
    code.push_str(&generate_resource_manager_code());
    code.push_str("\n\n");
    code.push_str(&generate_type_extractor_code());
    code.push_str("\n\n");
    code.push_str(&generate_state_tracker_code());
    code.push_str("\n\n");
    
    // 为每个参数生成提取代码
    let mut param_extractors = Vec::new();
    for param in &function.parameters {
        let extractor = generate_parameter_extraction_code(param, config)?;
        param_extractors.push(extractor);
    }
    
    // 为复杂类型生成结构体提取器
    let struct_extractors = generate_struct_extractors(&function.parameters, config)?;
    if !struct_extractors.is_empty() {
        code.push_str(&struct_extractors);
        code.push_str("\n\n");
    }
    
    // 生成测试工具函数
    code.push_str(&generate_harness_function(function, &param_extractors, config)?);
    
    Ok(code)
}

/// 为参数生成提取代码
fn generate_parameter_extraction_code(
    param: &Parameter,
    _config: &InputConversionConfig
) -> Result<String, HarnessError> {
    // 使用提取代码生成器
    generate_extractor_code(&param.ty, &param.name, "cursor")
}

/// 为参数中使用的结构体类型生成提取器
fn generate_struct_extractors(
    parameters: &[Parameter],
    config: &InputConversionConfig
) -> Result<String, HarnessError> {
    let mut struct_types = HashMap::new();
    let mut code = String::new();
    
    // 收集所有结构体类型
    for param in parameters {
        collect_struct_types(&param.ty, &mut struct_types);
    }
    
    // 为每个结构体类型生成提取器
    for (name, fields) in struct_types {
        let extractor = generate_struct_extractor(&name, &fields, config)?;
        code.push_str(&extractor);
        code.push_str("\n\n");
    }
    
    Ok(code)
}

/// 递归收集参数类型中的结构体类型
fn collect_struct_types(type_info: &TypeInfo, structs: &mut HashMap<String, Vec<TypeInfo>>) {
    match type_info {
        TypeInfo::Struct { name, fields } => {
            // 仅当未处理过时添加
            if !structs.contains_key(name) {
                structs.insert(name.clone(), fields.clone());
                
                // 递归处理字段类型
                for field in fields {
                    collect_struct_types(field, structs);
                }
            }
        }
        TypeInfo::Pointer(inner) => {
            collect_struct_types(inner, structs);
        }
        _ => {}
    }
}

/// 为结构体类型生成提取器
fn generate_struct_extractor(
    name: &str,
    fields: &[TypeInfo],
    _config: &InputConversionConfig
) -> Result<String, HarnessError> {
    let sanitized_name = sanitize_struct_name(name);
    let mut code = format!("/// 从字节数据中提取 {} 结构体\n", sanitized_name);
    code.push_str(&format!("fn extract_struct_{}(data: &[u8], cursor: &mut usize, resource_manager: &mut ResourceManager) -> *mut {} {{\n", 
        sanitized_name, sanitized_name));
    
    // 如果无数据则跳过
    code.push_str("    if *cursor >= data.len() {\n");
    code.push_str("        return std::ptr::null_mut();\n");
    code.push_str("    }\n\n");
    
    // 分配结构体内存
    code.push_str(&format!("    // 为结构体分配内存\n"));
    code.push_str(&format!("    let obj = unsafe {{ libc::malloc(std::mem::size_of::<{}>()) as *mut {} }};\n", 
        sanitized_name, sanitized_name));
    code.push_str("    if obj.is_null() {\n");
    code.push_str("        return std::ptr::null_mut();\n");
    code.push_str("    }\n\n");
    
    // 初始化为零
    code.push_str("    // 初始化为零\n");
    code.push_str("    unsafe {\n");
    code.push_str(&format!("        std::ptr::write_bytes(obj as *mut u8, 0, std::mem::size_of::<{}>());\n", sanitized_name));
    code.push_str("    }\n\n");
    
    // 提取每个字段
    code.push_str("    // 提取字段\n");
    for (i, field_type) in fields.iter().enumerate() {
        let field_name = format!("field_{}", i);
        let extraction_code = generate_extractor_code(field_type, &field_name, "cursor")?;
        code.push_str(&format!("    // Field {}\n", i));
        code.push_str(&format!("    {}\n", extraction_code));
        
        // 将字段赋值给结构体
        code.push_str("    unsafe {\n");
        code.push_str(&format!("        (*(obj as *mut {})).{} = {};\n", 
            sanitized_name, field_name, field_name));
        code.push_str("    }\n\n");
    }
    
    // 注册清理
    code.push_str("    // 注册清理\n");
    code.push_str("    resource_manager.track_allocation(obj as usize, ResourceType::Object);\n\n");
    
    // 返回结构体指针
    code.push_str("    obj\n");
    code.push_str("}\n");
    
    Ok(code)
}

/// 生成完整的测试工具函数
fn generate_harness_function(
    function: &FunctionSignature,
    param_extractors: &[String],
    _config: &InputConversionConfig
) -> Result<String, HarnessError> {
    let mut code = String::new();
    
    // 函数签名
    code.push_str(&format!("/// Harness for {}\n", function.name));
    code.push_str(&format!("pub fn harness_{}(data: &[u8]) -> bool {{\n", function.name));
    
    // 最小数据大小检查（至少为每个参数分配 1 字节加上一些额外开销）
    let min_size = function.parameters.len().max(1) * 4;
    code.push_str(&format!("    // Ensure we have enough data\n"));
    code.push_str(&format!("    if data.len() < {} {{\n", min_size));
    code.push_str("        return false;\n");
    code.push_str("    }\n\n");
    
    // 创建资源管理器
    code.push_str("    // 创建用于内存追踪的资源管理器\n");
    code.push_str("    let mut resource_manager = ResourceManager::new();\n\n");
    
    // 初始化字节游标
    code.push_str("    // 初始化字节游标\n");
    code.push_str("    let mut cursor = 0;\n\n");
    
    // 添加参数提取
    code.push_str("    // 参数提取\n");
    for extractor in param_extractors {
        code.push_str(&format!("    {}\n", extractor));
    }
    code.push_str("\n");
    
    // 使用 try-catch 块调用函数
    code.push_str("    // 使用提取的参数调用目标函数\n");
    code.push_str("    let result = std::panic::catch_unwind(|| {\n");
    code.push_str("        unsafe {\n");
    
    // 函数调用
    let param_names = function.parameters.iter()
        .map(|p| p.name.clone())
        .collect::<Vec<_>>()
        .join(", ");
    
    code.push_str(&format!("            {}({})\n", function.name, param_names));
    code.push_str("        }\n");
    code.push_str("    });\n\n");
    
    // 处理结果并清理资源
    code.push_str("    //  清理资源\n");
    code.push_str("    resource_manager.cleanup_all();\n\n");
    
    // 如果未发生崩溃则返回成功
    code.push_str("    // 如果函数执行未崩溃则返回 true\n");
    code.push_str("    result.is_ok()\n");
    code.push_str("}\n");
    
    Ok(code)
}

/// 为 Rust 代码清理结构体名称
fn sanitize_struct_name(name: &str) -> String {
    let sanitized = name.replace(|c: char| !c.is_alphanumeric() && c != '_', "_");
    if sanitized.chars().next().map_or(false, |c| c.is_numeric()) {
        format!("t_{}", sanitized)
    } else {
        sanitized
    }
}

/// 为多个函数生成带状态跟踪的测试工具代码
#[allow(dead_code)]
pub fn generate_multi_function_harness(
    functions: &[FunctionSignature],
    config: &InputConversionConfig
) -> Result<String, HarnessError> {
    let mut code = String::new();
    
    // 添加所有模块的辅助函数
    code.push_str(&generate_byte_parser_code());
    code.push_str("\n\n");
    code.push_str(&generate_resource_manager_code());
    code.push_str("\n\n");
    code.push_str(&generate_type_extractor_code());
    code.push_str("\n\n");
    code.push_str(&generate_state_tracker_code());
    code.push_str("\n\n");
    
    // 生成单个测试工具函数
    for function in functions {
        let function_harness = generate_input_conversion_code(function, config)?;
        code.push_str(&function_harness);
        code.push_str("\n\n");
    }
    
    // 生成多函数调度器
    code.push_str("/// 多函数测试工具入口点\n");
    code.push_str("pub fn harness_multi_function(data: &[u8]) -> bool {\n");
    code.push_str("    if data.len() < 2 {\n");
    code.push_str("        return false;\n");
    code.push_str("    }\n\n");
    
    // 创建共享状态
    code.push_str("    // 创建共享的fuzzing state\n");
    code.push_str("    let mut fuzz_state = FuzzState::new();\n\n");
    
    // 根据第一个字节选择函数
    code.push_str("    // 根据输入数据选择函数\n");
    code.push_str("    let function_selector = data[0] as usize % ");
    code.push_str(&format!("{};\n\n", functions.len()));
    
    // 分发到适当的函数
    code.push_str("    // 分发到选定的函数\n");
    code.push_str("    let result = match function_selector {\n");
    
    for (i, function) in functions.iter().enumerate() {
        code.push_str(&format!("        {} => harness_{}(&data[1..]),\n", i, function.name));
    }
    
    code.push_str("        _ => false,\n");
    code.push_str("    };\n\n");
    
    // 清理资源
    code.push_str("    // 清理资源\n");
    code.push_str("    fuzz_state.cleanup();\n\n");
    
    // 返回结果
    code.push_str("    result\n");
    code.push_str("}\n");
    
    Ok(code)
}