//! 类型定义生成器，负责生成 Rust 类型定义代码。

use crate::mapping::engine::MappingEngine;
use dylibsurfer_ir::{ResolvedType, TypeResolveError, ThreadSafeTypeResolver};
use std::collections::HashSet;
use thiserror::Error;

/// 类型生成器错误类型
#[derive(Error, Debug)]
pub enum TypeGenError {
    #[error("Type resolution error: {0}")]
    TypeResolutionError(#[from] TypeResolveError),
    
    #[error("Type mapping error: {0}")]
    MappingError(String),
}

/// 类型定义生成器，负责生成类型定义代码
pub struct TypeGenerator<'a> {
    /// 映射引擎，用于将 ResolvedType 映射为 Rust 类型定义
    mapping_engine: &'a MappingEngine,
    /// 类型解析器，用于解析和缓存类型信息
    type_resolver: ThreadSafeTypeResolver,
    /// 已生成的类型集合，避免重复生成
    generated_types: HashSet<String>,
}

impl<'a> TypeGenerator<'a> {
    /// 创建新的类型生成器实例
    pub fn new(mapping_engine: &'a MappingEngine) -> Self {
        Self {
            mapping_engine,
            type_resolver: ThreadSafeTypeResolver::new(),
            generated_types: HashSet::new(),
        }
    }
    
    /// 为给定的 ResolvedType 生成 Rust 类型定义
    ///
    /// 该方法根据 ResolvedType 的具体类型（结构体、联合体等），调用映射引擎生成相应的类型定义代码。
    ///
    /// # 参数
    /// - `resolved_type`: 已解析的类型信息
    ///
    /// # 返回值
    /// - `Ok(String)`: 成功时返回生成的类型定义代码
    /// - `Err(TypeGenError)`: 如果生成过程中出现错误，返回错误信息
    pub fn generate_type_definition(&self, resolved_type: &ResolvedType) -> Result<String, TypeGenError> {
        // 直接使用映射引擎将 ResolvedType 映射为 Rust 类型定义
        self.mapping_engine.map_type(resolved_type)
            .map_err(|e| TypeGenError::MappingError(e.to_string()))
    }
    
    /// 注册已生成的类型，避免重复生成
    pub fn register_generated_type(&mut self, type_name: String) {
        self.generated_types.insert(type_name);
    }
    
    /// 检查类型是否已生成
    pub fn is_type_generated(&self, type_name: &str) -> bool {
        self.generated_types.contains(type_name)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::mapping::{config::MappingConfig, engine::MappingEngine};
    use dylibsurfer_ir::type_resolver::PrimitiveType;
    use std::path::PathBuf;

    #[test]
    fn test_generate_primitive_type() {
        // 创建测试引擎
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap())
            .expect("Failed to load config");
        let engine = MappingEngine::new(config).expect("Failed to create engine");
        
        let generator = TypeGenerator::new(&engine);
        let int_type = ResolvedType::Primitive(PrimitiveType::Int);
        
        let result = generator.generate_type_definition(&int_type);
        assert!(result.is_ok());
        let type_def = result.unwrap();
        assert!(type_def.contains("c_int") || type_def.contains("i32"));
    }
}
