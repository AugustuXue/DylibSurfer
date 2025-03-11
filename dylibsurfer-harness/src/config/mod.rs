//! Harness 生成配置

mod types;

pub use types::*;

use crate::error::HarnessError;
use std::fs;
use std::path::Path;

impl HarnessConfig {
    /// 从 YAML 文件加载配置
    /// 
    /// # 参数
    /// * `path` - YAML 文件路径
    /// 
    /// # 返回值
    /// * `Ok(HarnessConfig)` - 加载的配置
    /// * `Err(HarnessError)` - 加载配置失败时的错误
    pub fn from_file(path: &Path) -> Result<Self, HarnessError> {
        let contents = fs::read_to_string(path)
            .map_err(|e| HarnessError::IoError(e))?;
        
        Self::from_yaml(&contents)
    }
    
    /// 从 YAML 字符串加载配置
    /// 
    /// # 参数
    /// * `yaml` - YAML 字符串
    /// 
    /// # 返回值
    /// * `Ok(HarnessConfig)` - 加载的配置
    /// * `Err(HarnessError)` - 解析 YAML 失败时的错误
    pub fn from_yaml(yaml: &str) -> Result<Self, HarnessError> {
        serde_yaml::from_str(yaml)
            .map_err(|e| HarnessError::ConfigError(format!("YAML 解析失败: {}", e)))
    }
    
    /// 将配置保存到 YAML 文件
    /// 
    /// # 参数
    /// * `path` - YAML 文件路径
    /// 
    /// # 返回值
    /// * `Ok(())` - 配置保存成功
    /// * `Err(HarnessError)` - 保存配置失败时的错误
    pub fn to_file(&self, path: &Path) -> Result<(), HarnessError> {
        let yaml = serde_yaml::to_string(self)
            .map_err(|e| HarnessError::ConfigError(format!("配置序列化失败: {}", e)))?;
        
        fs::write(path, yaml)
            .map_err(|e| HarnessError::IoError(e))?;
        
        Ok(())
    }
}
