//! 用于FFI函数的安全封装生成器

use crate::mapping::engine::MappingEngine;
use dylibsurfer_ir::{FunctionSignature, ResolvedType};
use thiserror::Error;

/// 安全封装生成的错误类型
#[derive(Error, Debug)]
pub enum WrapperError {
    #[error("类型映射错误: {0}")]
    MappingError(String),
    #[error("代码生成错误: {0}")]
    CodegenError(String),
}

/// 用于在FFI函数周围生成安全Rust封装的结构体
pub struct SafeWrapperGenerator<'a> {
    /// 映射引擎，用于类型转换
    mapping_engine: &'a MappingEngine,
}

impl<'a> SafeWrapperGenerator<'a> {
    /// 创建新的安全封装生成器
    pub fn new(mapping_engine: &'a MappingEngine) -> Self {
        Self { mapping_engine }
    }

    /// 为FFI函数生成安全封装
    pub fn generate_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> Result<Option<String>, WrapperError> {
        // 检查是否需要生成封装
        if !self.should_generate_wrapper(signature, resolved_types) {
            return Ok(None);
        }
        // 生成封装代码
        // TODO: 根据函数签名和类型信息生成安全包装
        Ok(Some("// TODO: Implement safe wrapper".to_string()))
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
    fn should_generate_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> bool {
        // 检查是否包含需要特殊处理的类型（如裸指针）
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