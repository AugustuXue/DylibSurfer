//! Harness 生成错误类型

use std::io;
use thiserror::Error;

/// Harness 生成过程中可能发生的错误
#[derive(Error, Debug)]
pub enum HarnessError {
    #[error("配置错误: {0}")]
    ConfigError(String),
    
    #[error("模板错误: {0}")]
    TemplateError(String),
    
    #[error("生成错误: {0}")]
    GenerationError(String),
    
    #[error("I/O 错误: {0}")]
    IoError(#[from] io::Error),
    
    #[error("类型错误: {0}")]
    TypeError(String),
    
    #[error("IR 解析错误: {0}")]
    IrError(#[from] dylibsurfer_ir::IrError),
}