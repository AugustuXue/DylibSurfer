//! Harness 生成上下文

use std::collections::HashMap;
use std::path::PathBuf;

/// Harness 生成上下文
pub struct GenerationContext {
    /// 输出目录
    pub output_dir: PathBuf,
    
    /// 库名称
    pub lib_name: String,
    
    /// 库模块路径
    pub lib_module: String,
    
    /// 生成所需的额外数据
    pub data: HashMap<String, String>,
}

impl GenerationContext {
    /// 创建新的生成上下文
    pub fn new(output_dir: PathBuf, lib_name: &str) -> Self {
        Self {
            output_dir,
            lib_name: lib_name.to_string(),
            lib_module: format!("{}_ffi", lib_name),
            data: HashMap::new(),
        }
    }
    
    /// 向上下文添加数据
    pub fn with_data(mut self, key: &str, value: &str) -> Self {
        self.data.insert(key.to_string(), value.to_string());
        self
    }
}
