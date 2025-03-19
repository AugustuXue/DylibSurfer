//! 安全包装生成器，负责为不安全的 FFI 函数生成安全的 Rust 包装函数。

use crate::mapping::engine::MappingEngine;
use dylibsurfer_ir::{FunctionSignature, ResolvedType};
use thiserror::Error;

/// 安全包装生成器错误类型
#[derive(Error, Debug)]
pub enum WrapperError {
    #[error("Type mapping error: {0}")]
    MappingError(String),
    
    #[error("Code generation error: {0}")]
    CodegenError(String),
}

/// 安全包装生成器，负责为不安全的 FFI 函数生成安全的 Rust 包装函数
pub struct SafeWrapperGenerator<'a> {
    /// 映射引擎，用于将 ResolvedType 映射为 Rust 类型
    _mapping_engine: &'a MappingEngine,
}

impl<'a> SafeWrapperGenerator<'a> {
    /// 创建新的安全包装生成器实例
    pub fn new(mapping_engine: &'a MappingEngine) -> Self {
        Self {
            _mapping_engine: mapping_engine,
        }
    }
    
    /// 为给定的函数签名生成安全包装函数
    ///
    /// 该方法根据函数签名和解析的类型信息，生成安全的 Rust 包装函数。
    /// 如果函数不需要安全包装，则返回 None。
    ///
    /// # 参数
    /// - `signature`: 函数签名
    /// - `resolved_types`: 解析后的参数和返回类型
    ///
    /// # 返回值
    /// - `Ok(Some(String))`: 成功时返回生成的安全包装函数代码
    /// - `Ok(None)`: 如果函数不需要安全包装，返回 None
    /// - `Err(WrapperError)`: 如果生成过程中出现错误，返回错误信息
    pub fn generate_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> Result<Option<String>, WrapperError> {
        // 检查是否需要生成安全包装
        if !self.should_generate_wrapper(signature, resolved_types) {
            return Ok(None);
        }
        
        // TODO: 根据函数签名和类型信息生成安全包装
        // 此处应根据具体的安全包装规则生成代码
        
        // 暂时返回一个占位符
        Ok(Some(format!("// TODO: Safe wrapper for {}\n", signature.name)))
    }
    
    /// 判断是否需要为当前函数生成安全包装函数
    ///
    /// 根据函数签名和涉及的类型，判断是否需要在 FFI 声明之外生成额外的 Rust 安全包装。
    /// 当前判断逻辑基于以下启发式规则：
    /// 1. 函数涉及裸指针类型（`ResolvedType::Pointer`）
    /// 2. 函数名称包含内存管理相关关键词（alloc/free/create/destroy）
    ///
    /// # 参数
    /// - `signature`: 原始函数签名信息
    /// - `resolved_types`: 已解析的函数参数/返回类型列表
    ///
    /// # 返回值
    /// - `true`: 需要生成安全包装
    /// - `false`: 直接使用原始 FFI 声明即可
    pub fn should_generate_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> bool {
        // 检查是否包含需要特殊处理的类型 (如裸指针)
        for ty in resolved_types {
            match ty {
                ResolvedType::Pointer(_) => return true,
                _ => {}
            }
        }
        
        // 检查特殊函数名模式
        // 如 malloc, free 等内存管理函数
        if signature.name.contains("alloc") || 
           signature.name.contains("free") ||
           signature.name.contains("create") ||
           signature.name.contains("destroy") {
            return true;
        }
        
        false
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::mapping::{config::MappingConfig, engine::MappingEngine};
    use dylibsurfer_ir::{TypeInfo, Parameter};
    use std::path::PathBuf;
    
    #[test]
    fn test_should_generate_wrapper() {
        // 创建测试引擎
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap())
            .expect("Failed to load config");
        let engine = MappingEngine::new(config).expect("Failed to create engine");
        
        let generator = SafeWrapperGenerator::new(&engine);
        
        // 测试内存管理函数
        let alloc_sig = FunctionSignature {
            name: "test_alloc".to_string(),
            return_type: TypeInfo::Pointer(Box::new(TypeInfo::Void)),
            parameters: vec![
                Parameter {
                    name: "size".to_string(),
                    ty: TypeInfo::Int(32),
                },
            ],
        };
        
        // 这里只是简化测试，实际应该使用 resolved_types
        let needs_wrapper = generator.should_generate_wrapper(&alloc_sig, &[]);
        assert!(needs_wrapper, "Memory allocation functions should require wrapper");
    }
}