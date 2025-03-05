// dylibsurfer-bindgen/src/lib.rs

pub mod mapping;
pub mod generators;

use mapping::config::MappingConfig;
use mapping::engine::MappingEngine;
use generators::ffi::FfiGenerator;
use dylibsurfer_ir::FunctionSignature;
use std::path::Path;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum BindgenError {
    #[error("Config error: {0}")]
    ConfigError(String),
    
    #[error("Mapping engine error: {0}")]
    MappingError(String),
    
    #[error("FFI generation error: {0}")]
    FfiError(String),
    
    #[error("IO error: {0}")]
    IoError(#[from] std::io::Error),
}

/// Bindgen 模块的主入口，负责协调整个绑定生成过程
#[allow(dead_code)]
pub struct Bindgen {
    config: MappingConfig,
    engine: MappingEngine,
}

impl Bindgen {
    /// 从指定路径加载配置并初始化 Bindgen
    pub fn from_config_file(path: &Path) -> Result<Self, BindgenError> {
        let config = MappingConfig::load_from_file(path.to_str().unwrap())
            .map_err(|e| BindgenError::ConfigError(e.to_string()))?;
        
        let engine = MappingEngine::new(config.clone())
            .map_err(|e| BindgenError::MappingError(e.to_string()))?;
        
        Ok(Self { config, engine })
    }
    
    /// 使用默认配置初始化 Bindgen
    pub fn with_default_config() -> Result<Self, BindgenError> {
        let config_path = Path::new("config/default.yaml");
        Self::from_config_file(config_path)
    }
    
    /// 从函数签名生成 FFI 绑定代码
    pub fn generate_bindings(&self, signatures: &[FunctionSignature]) -> Result<String, BindgenError> {
        let mut generator = FfiGenerator::new(&self.engine);
        
        generator.generate_bindings(signatures)
            .map_err(|e| BindgenError::FfiError(e.to_string()))
    }
    
    /// 生成绑定并写入文件
    pub fn generate_bindings_to_file(&self, signatures: &[FunctionSignature], output_path: &Path) -> Result<(), BindgenError> {
        let bindings = self.generate_bindings(signatures)?;
        std::fs::write(output_path, bindings)?;
        Ok(())
    }
}

