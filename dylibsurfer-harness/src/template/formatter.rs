//! 生成的 harness 代码格式化器

use crate::error::HarnessError;
use regex::Regex;

/// 生成的 harness 代码格式化器
pub struct CodeFormatter {
    /// 缩进级别（空格数）
    indent_level: usize,
}

impl CodeFormatter {
    /// 创建新的代码格式化器
    pub fn new(indent_level: usize) -> Self {
        Self {
            indent_level,
        }
    }
    
    /// 格式化生成的代码
    /// 
    /// # 参数
    /// * `code` - 未格式化的代码
    /// 
    /// # 返回值
    /// * `Ok(String)` - 格式化后的代码
    /// * `Err(HarnessError)` - 格式化代码失败时的错误
    pub fn format(&self, code: &str) -> Result<String, HarnessError> {
        // 这是一个简单的格式化器，只处理缩进
        // 真实的格式化器应该使用合适的 Rust 解析器/格式化器
        
        let mut formatted = String::new();
        let mut current_indent: usize = 0;
        
        for line in code.lines() {
            let trimmed = line.trim();
            
            // 根据大括号调整缩进
            if trimmed.starts_with('}') {
                current_indent = current_indent.saturating_sub(1);
            }
            
            // 如果行不为空，添加缩进
            if !trimmed.is_empty() {
                let indent = " ".repeat(current_indent * self.indent_level);
                formatted.push_str(&format!("{}{}\n", indent, trimmed));
            } else {
                formatted.push('\n');
            }
            
            // 为下一行调整缩进
            if trimmed.ends_with('{') {
                current_indent += 1;
            }
        }
        
        // 移除连续的空行
        let empty_line_regex = Regex::new(r"\n\s*\n\s*\n").map_err(|e| {
            HarnessError::TemplateError(format!("创建正则表达式失败: {}", e))
        })?;
        
        let formatted = empty_line_regex.replace_all(&formatted, "\n\n").to_string();
        
        Ok(formatted)
    }
}

impl Default for CodeFormatter {
    fn default() -> Self {
        Self::new(4)
    }
}