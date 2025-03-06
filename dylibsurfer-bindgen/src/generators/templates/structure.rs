//! 结构体代码模板

/// 生成Rust结构体定义
pub fn generate_struct(name: &str, fields: &[(String, String)], attributes: &[&str]) -> String {
    let mut code = String::new();
    // 添加属性
    for attr in attributes {
        code.push_str(&format!("{}\n", attr));
    }
    // 添加结构体声明
    code.push_str(&format!("pub struct {} {{\n", name));
    // 添加字段
    for (field_name, field_type) in fields {
        code.push_str(&format!("    pub {}: {},\n", field_name, field_type));
    }
    code.push_str("}\n");
    code
}

/// 生成Rust联合体定义
pub fn generate_union(name: &str, variants: &[(String, String)], attributes: &[&str]) -> String {
    let mut code = String::new();
    // 添加属性
    for attr in attributes {
        code.push_str(&format!("{}\n", attr));
    }
    // 添加联合体声明
    code.push_str(&format!("pub union {} {{\n", name));
    // 添加变体
    for (variant_name, variant_type) in variants {
        code.push_str(&format!("    pub {}: {},\n", variant_name, variant_type));
    }
    code.push_str("}\n");
    code
}