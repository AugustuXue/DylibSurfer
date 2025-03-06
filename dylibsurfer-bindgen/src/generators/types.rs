//! 类型定义生成器

use crate::mapping::engine::MappingEngine;
use dylibsurfer_ir::{FunctionSignature, ResolvedType, TypeResolveError, ThreadSafeTypeResolver, TypeInfo};
use std::collections::HashSet;
use thiserror::Error;

/// 将类型生成错误 (`TypeGenError`) 转换为可读的错误信息。
///
/// 该枚举类型用于表示类型生成过程中可能发生的错误，包括类型解析错误和类型映射错误。
/// 每个错误变体都包含详细的错误信息，可以通过 `Display` trait 格式化为用户友好的错误消息。
///
/// # 参数
/// - `TypeResolutionError`: 类型解析错误，包含底层的 `TypeResolveError` 作为错误来源。
/// - `MappingError`: 类型映射错误，包含一个 `String` 类型的错误描述。
///
/// # 返回值
/// - 实现了 `std::error::Error` trait，可以通过 `?` 操作符传播错误。
/// - 通过 `Display` trait 可以格式化为用户友好的错误消息。
#[derive(Error, Debug)]
pub enum TypeGenError {
    #[error("Type resolution error: {0}")]
    TypeResolutionError(#[from] TypeResolveError),
    
    #[error("Type mapping error: {0}")]
    MappingError(String),
}

/// 类型定义生成器，负责从IR 解析的类型和函数签名生成rust类型定义
pub struct TypeGenerator<'a> {
    /// 映射引擎，用于将解析的类型映射到 Rust 类型
    mapping_engine: &'a MappingEngine,
    /// 类型解析器，用于解析和缓存类型信息
    type_resolver: ThreadSafeTypeResolver,
    /// 已生成的类型集合，避免重复生成
    generated_types: HashSet<String>,
}

impl<'a> TypeGenerator<'a> {
    /// 创建新的类型定义生成器实例
    pub fn new(mapping_engine: &'a MappingEngine) -> Self {
        Self {
            mapping_engine,
            type_resolver: ThreadSafeTypeResolver::new(),
            generated_types: HashSet::new(),
        }
    }
    
/// 生成所有依赖的类型定义代码。
///
/// 该方法遍历函数签名列表，收集所有依赖的类型（如结构体、联合体等），并生成对应的类型定义代码。
/// 生成过程中会避免重复生成已处理过的类型。
///
/// # 参数
/// - `signatures`: 函数签名列表，类型为 `&[FunctionSignature]`。每个函数签名包含函数名、返回类型和参数列表。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的所有类型定义代码字符串。
/// - `Err(FfiError)`: 如果生成过程中出现错误（如类型解析失败、映射失败等），返回错误信息。
    pub fn generate_all_types(&mut self, signatures: &[FunctionSignature]) -> Result<String, TypeGenError> {
        let mut code = String::new();
        
        //# todo 这里仅仅收集了类型名称，但没有触发类型解析
        // 收集所有需要生成的类型
        let mut types_to_generate = HashSet::new();
        for sig in signatures {
            self.collect_type_dependencies(&sig.return_type, &mut types_to_generate);
            for param in &sig.parameters {
                self.collect_type_dependencies(&param.ty, &mut types_to_generate);
            }
        }
        
        // 生成类型定义
        for type_name in types_to_generate {
            if self.generated_types.contains(&type_name) {
                continue;
            }
            
            // 根据类型名称生成类型定义
            if let Some(type_def) = self.generate_type_definition(&type_name)? {
                code.push_str(&type_def);
                code.push_str("\n\n");
                self.generated_types.insert(type_name);
            }
        }
        
        Ok(code)
    }
    
/// 生成单个类型定义,具体来说是为给定的类型名称生成 Rust 类型定义。
///
/// 该函数尝试使用类型解析器解析提供的类型名称。如果找到类型，则使用映射引擎将其映射为 Rust 类型。
/// 如果未找到类型或类型为内置类型，则不生成定义。
///
/// # 参数
///
/// * `type_name` - 需要生成定义的类型名称。
///
/// # 返回值
///
/// - `Ok(Some(String))`：如果成功生成 Rust 类型定义，返回生成的定义字符串。
/// - `Ok(None)`：如果不需要生成定义（例如内置类型），返回 `None`。
/// - `Err(FfiError)`：如果在类型解析或映射过程中发生错误，返回错误信息。
///
/// # 错误
///
/// 该函数可能返回 `FfiError` 的情况包括：
/// - 类型解析器无法解析类型。
/// - 映射引擎无法将解析的类型映射为 Rust 类型。
    pub fn generate_type_definition(&self, type_name: &str) -> Result<Option<String>, TypeGenError> {
        // 从类型解析器中查找类型
        if let Some(resolved) = self.type_resolver.lookup_type(type_name) {
            // 使用映射引擎将解析的类型映射到 Rust 类型
            let rust_type = self.mapping_engine.map_type(&resolved)
                .map_err(|e| TypeGenError::MappingError(e.to_string()))?;
            return Ok(Some(rust_type));
        }
        
        // If it's a built-in type, no additional definition may be needed
        Ok(None)
    }
    
/// 递归收集类型依赖，将复杂类型（如结构体、指针）的名称添加到 `types` 集合中。
///
/// 该方法遍历类型信息（`TypeInfo`），如果类型是结构体或指针，则递归收集其依赖的类型名称，
/// 并将其添加到 `types` 集合中。基本类型（如 `Int`、`Float`）不需要额外处理。
///
/// # 参数
/// - `type_info`: 需要收集依赖的类型信息，类型为 `&TypeInfo`。
/// - `types`: 用于存储类型名称的集合，类型为 `&mut HashSet<String>`。
    pub fn collect_type_dependencies(&self, type_info: &TypeInfo, types: &mut HashSet<String>) {
        match type_info {
            TypeInfo::Struct { name, fields } => {
                types.insert(name.clone());
                for field in fields {
                    self.collect_type_dependencies(field, types);
                }
            }
            TypeInfo::Pointer(inner) => {
                self.collect_type_dependencies(inner, types);
            }
            _ => {} // 基本类型不需要额外定义
        }
    }
    
    /// 将 TypeInfo 解析为 ResolvedType
    pub fn resolve_type_info(&self, type_info: &TypeInfo) -> Result<ResolvedType, TypeResolveError> {
        self.type_resolver.resolve_type(type_info)
    }
}
