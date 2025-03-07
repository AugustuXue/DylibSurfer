//! 代码样式工具，用于格式化生成的代码。

/// 缩进代码块
///
/// 给定一个代码字符串和缩进级别，为每一行添加适当的缩进。
///
/// # 参数
/// - `code`: 需要缩进的代码字符串
/// - `indent`: 缩进级别（空格数量）
///
/// # 返回值
/// - 缩进后的代码字符串
pub fn indent_block(code: &str, indent: usize) -> String {
    let indent_str = " ".repeat(indent);
    code.lines()
        .map(|line| {
            if line.trim().is_empty() {
                String::from(line)
            } else {
                format!("{}{}", indent_str, line)
            }
        })
        .collect::<Vec<_>>()
        .join("\n")
}

/// 格式化文档注释
///
/// 将多行文本转换为 Rust 文档注释格式。
///
/// # 参数
/// - `comment`: 注释文本
/// - `max_width`: 最大行宽（超过此宽度的行将被换行）
///
/// # 返回值
/// - 格式化后的文档注释字符串
pub fn format_doc_comment(comment: &str, max_width: usize) -> String {
    let _ = max_width;
    let mut result = String::new();
    
    for line in comment.lines() {
        // 简单实现，实际应考虑根据 max_width 拆分长行
        result.push_str(&format!("/// {}\n", line));
    }
    
    result
}

/// 生成标准的 Rust 类型定义属性
///
/// 根据类型（结构体、联合体等）生成适当的属性（如 #[repr(C)]）。
///
/// # 参数
/// - `is_union`: 是否为联合体
///
/// # 返回值
/// - 属性字符串
pub fn rust_type_attributes(is_union: bool) -> String {
    if is_union {
        "#[repr(C)]\n#[derive(Copy, Clone)]\n".to_string()
    } else {
        "#[repr(C)]\n#[derive(Debug)]\n".to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_indent_block() {
        let code = "fn test() {\n    let x = 1;\n}";
        let indented = indent_block(code, 4);
        assert_eq!(indented, "    fn test() {\n        let x = 1;\n    }");
    }
    
    #[test]
    fn test_format_doc_comment() {
        let comment = "Test function.\nDoes something.";
        let formatted = format_doc_comment(comment, 80);
        assert_eq!(formatted, "/// Test function.\n/// Does something.\n");
    }
}
