//! 命名工具，用于处理标识符命名转换。

/// 将字符串转换为蛇形命名法（snake_case）
///
/// 将驼峰命名法（CamelCase）或帕斯卡命名法（PascalCase）的字符串
/// 转换为蛇形命名法。
///
/// # 参数
/// - `s`: 原始字符串
///
/// # 返回值
/// - 转换后的蛇形命名法字符串
pub fn to_snake_case(s: &str) -> String {
    let mut result = String::with_capacity(s.len());
    let mut chars = s.chars().peekable();
    
    while let Some(c) = chars.next() {
        if c.is_uppercase() {
            if !result.is_empty() && chars.peek().map_or(false, |next| next.is_lowercase()) {
                result.push('_');
            }
            result.push(c.to_lowercase().next().unwrap());
        } else {
            result.push(c);
        }
    }
    
    result
}

/// 将字符串转换为驼峰命名法（camelCase）
///
/// 将蛇形命名法（snake_case）的字符串转换为驼峰命名法。
///
/// # 参数
/// - `s`: 原始字符串
///
/// # 返回值
/// - 转换后的驼峰命名法字符串
pub fn to_camel_case(s: &str) -> String {
    let mut result = String::new();
    let mut capitalize_next = false;
    
    for c in s.chars() {
        if c == '_' {
            capitalize_next = true;
        } else if capitalize_next {
            result.push(c.to_uppercase().next().unwrap());
            capitalize_next = false;
        } else {
            result.push(c);
        }
    }
    
    result
}

/// 将字符串转换为帕斯卡命名法（PascalCase）
///
/// 将蛇形命名法（snake_case）的字符串转换为帕斯卡命名法。
///
/// # 参数
/// - `s`: 原始字符串
///
/// # 返回值
/// - 转换后的帕斯卡命名法字符串
pub fn to_pascal_case(s: &str) -> String {
    let camel = to_camel_case(s);
    
    if camel.is_empty() {
        return camel;
    }
    
    let mut result = String::new();
    let first_char = camel.chars().next().unwrap();
    result.push(first_char.to_uppercase().next().unwrap());
    result.push_str(&camel[first_char.len_utf8()..]);
    
    result
}

/// 获取合法的 Rust 标识符
///
/// 确保字符串是合法的 Rust 标识符，处理保留关键字和非法字符。
///
/// # 参数
/// - `name`: 原始标识符名称
///
/// # 返回值
/// - 合法的 Rust 标识符
pub fn sanitize_rust_identifier(name: &str) -> String {
    // Rust 关键字列表
    const RUST_KEYWORDS: &[&str] = &[
        "as", "break", "const", "continue", "crate", "else", "enum", "extern",
        "false", "fn", "for", "if", "impl", "in", "let", "loop", "match", "mod",
        "move", "mut", "pub", "ref", "return", "self", "Self", "static", "struct",
        "super", "trait", "true", "type", "unsafe", "use", "where", "while", "async",
        "await", "dyn", "abstract", "become", "box", "do", "final", "macro", "override",
        "priv", "typeof", "unsized", "virtual", "yield", "try"
    ];
    
    // 如果是关键字，添加下划线后缀
    if RUST_KEYWORDS.contains(&name) {
        return format!("{}_", name);
    }
    
    // 处理其他非法字符
    let mut result = String::new();
    
    // 处理第一个字符
    let mut chars = name.chars();
    match chars.next() {
        Some(c) if c.is_alphabetic() || c == '_' => result.push(c),
        Some(_) => result.push('_'), // 如果第一个字符不是字母或下划线，添加前缀
        None => return "_empty".to_string(), // 空字符串
    }
    
    // 处理剩余字符
    for c in chars {
        if c.is_alphanumeric() || c == '_' {
            result.push(c);
        } else {
            result.push('_');
        }
    }
    
    result
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_to_snake_case() {
        assert_eq!(to_snake_case("helloWorld"), "hello_world");
        assert_eq!(to_snake_case("HelloWorld"), "hello_world");
        assert_eq!(to_snake_case("hello_world"), "hello_world");
        assert_eq!(to_snake_case("hello"), "hello");
    }
    
    #[test]
    fn test_to_camel_case() {
        assert_eq!(to_camel_case("hello_world"), "helloWorld");
        assert_eq!(to_camel_case("hello"), "hello");
        assert_eq!(to_camel_case("HELLO_WORLD"), "hELLOWORLD");
    }
    
    #[test]
    fn test_sanitize_rust_identifier() {
        assert_eq!(sanitize_rust_identifier("type"), "type_");
        assert_eq!(sanitize_rust_identifier("123name"), "_123name");
        assert_eq!(sanitize_rust_identifier("name-with-hyphens"), "name_with_hyphens");
    }
}
