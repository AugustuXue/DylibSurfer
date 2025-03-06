//! 函数代码模板

/// 生成extern "C"函数声明
pub fn generate_ffi_function(name: &str, params: &[(String, String)], return_type: &str) -> String {
    let params_str = params.iter()
        .map(|(name, ty)| format!("{}: {}", name, ty))
        .collect::<Vec<_>>()
        .join(", ");
    format!(
        "extern \"C\" {{\n    pub fn {}({}) -> {};\n}}\n",
        name, params_str, return_type
    )
}

/// 为不安全的FFI函数生成安全的Rust封装
pub fn generate_safe_wrapper(unsafe_name: &str, safe_name: &str, params: &[(String, String)], return_type: &str, body: &str) -> String {
    let params_str = params.iter()
        .map(|(name, ty)| format!("{}: {}", name, ty))
        .collect::<Vec<_>>()
        .join(", ");
    format!(
        "/// Safe wrapper for {}\npub fn {}({}) -> {} {{\n    {}\n}}\n",
        unsafe_name, safe_name, params_str, return_type, body
    )
}