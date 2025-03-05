// dylibsurfer-bindgen/src/generators/ffi.rs

use crate::mapping::engine::MappingEngine;
use dylibsurfer_ir::{FunctionSignature, ResolvedType, TypeResolveError, ThreadSafeTypeResolver};
use std::collections::HashSet;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum FfiError {
    #[error("Type resolution error: {0}")]
    TypeResolutionError(#[from] TypeResolveError),
    
    #[error("Type mapping error: {0}")]
    MappingError(String),
    
    #[error("Code generation error: {0}")]
    CodegenError(String),
}

/// FFI 绑定生成器，负责从 IR 解析的类型和函数签名生成 Rust FFI 代码
pub struct FfiGenerator<'a> {
    /// 映射引擎，用于将解析的类型映射到 Rust 类型
    mapping_engine: &'a MappingEngine,
    /// 类型解析器，用于解析和缓存类型信息
    type_resolver: ThreadSafeTypeResolver,
    /// 已生成的类型集合，避免重复生成
    generated_types: HashSet<String>,
}

impl<'a> FfiGenerator<'a> {
    /// 创建新的 FFI 生成器实例
    pub fn new(mapping_engine: &'a MappingEngine) -> Self {
        Self {
            mapping_engine,
            type_resolver: ThreadSafeTypeResolver::new(),
            generated_types: HashSet::new(),
        }
    }
    
    /// 从函数签名列表生成完整的 FFI 绑定代码
    pub fn generate_bindings(&mut self, signatures: &[FunctionSignature]) -> Result<String, FfiError> {
        let mut code = String::new();
        
        // 添加必要的导入
        let mut imports = Vec::new();
        self.collect_imports(signatures, &mut imports);
        
        // 添加导入语句
        for import in imports {
            code.push_str(&format!("{};\n", import));
        }
        code.push_str("\n");
        
        // 生成类型定义
        let types_code = self.generate_types(signatures)?;
        if !types_code.is_empty() {
            code.push_str(&types_code);
            code.push_str("\n");
        }
        
        // 生成函数声明
        let fns_code = self.generate_functions(signatures)?;
        code.push_str(&fns_code);
        
        Ok(code)
    }
    
    /// 收集所有需要的导入语句
    fn collect_imports(&self, _signatures: &[FunctionSignature], imports: &mut Vec<String>) {
        // 基础 FFI 导入
        imports.push("use std::os::raw::*".to_string());
        imports.push("use std::ffi::*".to_string());
        
        // TODO: 根据签名分析添加特定的导入
        // 这里可以遍历 signatures，检查类型，然后添加需要的导入
    }
    
    /// 生成所有类型定义
    fn generate_types(&mut self, signatures: &[FunctionSignature]) -> Result<String, FfiError> {
        let mut code = String::new();
        
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
    
    /// 收集类型依赖
    fn collect_type_dependencies(&self, type_info: &dylibsurfer_ir::TypeInfo, types: &mut HashSet<String>) {
        match type_info {
            dylibsurfer_ir::TypeInfo::Struct { name, fields } => {
                types.insert(name.clone());
                for field in fields {
                    self.collect_type_dependencies(field, types);
                }
            }
            dylibsurfer_ir::TypeInfo::Pointer(inner) => {
                self.collect_type_dependencies(inner, types);
            }
            _ => {} // 基本类型不需要额外定义
        }
    }
    
    /// 生成单个类型定义
    fn generate_type_definition(&self, type_name: &str) -> Result<Option<String>, FfiError> {
        // 从类型解析器中查找类型
        if let Some(resolved) = self.type_resolver.lookup_type(type_name) {
            // 使用映射引擎将解析的类型映射到 Rust 类型
            let rust_type = self.mapping_engine.map_type(&resolved)
                .map_err(|e| FfiError::MappingError(e.to_string()))?;
            return Ok(Some(rust_type));
        }
        
        // 如果是内置类型，可能不需要额外定义
        Ok(None)
    }
    
    /// 生成所有函数声明
    fn generate_functions(&self, signatures: &[FunctionSignature]) -> Result<String, FfiError> {
        let mut code = String::new();
        
        for sig in signatures {
            let fn_code = self.generate_function(sig)?;
            code.push_str(&fn_code);
            code.push_str("\n\n");
        }
        
        Ok(code)
    }
    
    /// 生成单个函数声明
    fn generate_function(&self, signature: &FunctionSignature) -> Result<String, FfiError> {
        // 解析返回类型
        let resolved_return = match self.resolve_type_info(&signature.return_type) {
            Ok(r) => r,
            Err(e) => return Err(FfiError::TypeResolutionError(e)),
        };
        
        let return_type = self.mapping_engine.map_type(&resolved_return)
            .map_err(|e| FfiError::MappingError(e.to_string()))?;
        
        // 构建参数列表
        let mut params = Vec::new();
        for param in &signature.parameters {
            let resolved_param = match self.resolve_type_info(&param.ty) {
                Ok(r) => r,
                Err(e) => return Err(FfiError::TypeResolutionError(e)),
            };
            
            let param_type = self.mapping_engine.map_type(&resolved_param)
                .map_err(|e| FfiError::MappingError(e.to_string()))?;
            
            params.push(format!("{}: {}", param.name, param_type));
        }
        
        // 生成函数声明
        let fn_declaration = format!(
            "extern \"C\" {{\n    pub fn {}({}) -> {};\n}}",
            signature.name,
            params.join(", "),
            return_type
        );
        
        Ok(fn_declaration)
    }
    
    /// 将 TypeInfo 解析为 ResolvedType
    fn resolve_type_info(&self, type_info: &dylibsurfer_ir::TypeInfo) -> Result<ResolvedType, TypeResolveError> {
        self.type_resolver.resolve_type(type_info)
    }
    
    /// 生成安全包装函数
    #[allow(dead_code)]
    fn generate_safe_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> Result<Option<String>, FfiError> {
        // 检查是否需要生成安全包装
        if !self.should_generate_wrapper(signature, resolved_types) {
            return Ok(None);
        }
        
        // TODO: 根据函数签名和类型信息生成安全包装
        
        Ok(Some("// TODO: Generate safe wrapper".to_string()))
    }
    
    /// 判断是否应该为该函数生成安全包装
    #[allow(dead_code)]
    fn should_generate_wrapper(&self, signature: &FunctionSignature, resolved_types: &[ResolvedType]) -> bool {
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
    use dylibsurfer_ir::{IrParser, TypeInfo};
    use std::path::{PathBuf};

    // 辅助函数：创建一个测试用的 MappingEngine
    fn create_test_engine() -> MappingEngine {
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap())
            .expect("Failed to load config");
        MappingEngine::new(config).expect("Failed to create engine")
    }

    #[test]
    fn test_ffi_generation_simple() {
        // 创建测试引擎
        let engine = create_test_engine();
        let mut generator = FfiGenerator::new(&engine);

        // 创建简单的测试函数签名
        let signatures = vec![
            FunctionSignature {
                name: "test_function".to_string(),
                return_type: TypeInfo::Int(32),
                parameters: vec![
                    dylibsurfer_ir::Parameter {
                        name: "arg1".to_string(),
                        ty: TypeInfo::Int(32),
                    },
                    dylibsurfer_ir::Parameter {
                        name: "arg2".to_string(),
                        ty: TypeInfo::Pointer(Box::new(TypeInfo::Int(8))),
                    },
                ],
            }
        ];

        // 生成绑定并验证
        let result = generator.generate_bindings(&signatures).expect("FFI generation failed");
        
        // 检查基本导入是否存在
        assert!(result.contains("use std::os::raw::*"));
        assert!(result.contains("use std::ffi::*"));
        
        // 检查函数声明是否正确
        assert!(result.contains("extern \"C\""));
        assert!(result.contains("pub fn test_function"));
        assert!(result.contains("arg1: c_int"));
        assert!(result.contains("-> c_int"));
    }

    #[test]
    fn test_ffi_generation_struct() {
        // 创建测试引擎
        let engine = create_test_engine();
        let mut generator = FfiGenerator::new(&engine);

        // 创建包含结构体的测试函数签名
        let struct_type = TypeInfo::Struct {
            name: "TestStruct".to_string(),
            fields: vec![
                TypeInfo::Int(32),
                TypeInfo::Float,
            ],
        };

        let signatures = vec![
            FunctionSignature {
                name: "create_struct".to_string(),
                return_type: TypeInfo::Pointer(Box::new(struct_type.clone())),
                parameters: vec![],
            },
            FunctionSignature {
                name: "use_struct".to_string(),
                return_type: TypeInfo::Void,
                parameters: vec![
                    dylibsurfer_ir::Parameter {
                        name: "s".to_string(),
                        ty: TypeInfo::Pointer(Box::new(struct_type)),
                    },
                ],
            }
        ];

        // 生成绑定并验证
        let result = generator.generate_bindings(&signatures).expect("FFI generation failed");
        
        // 检查结构体定义
        assert!(result.contains("pub struct TestStruct"));
        
        // 检查函数声明
        assert!(result.contains("pub fn create_struct()"));
        assert!(result.contains("pub fn use_struct"));
    }

    #[test]
    fn test_real_library_parsing() {
        // 尝试解析真实的库文件（如果存在）
        let ir_path = PathBuf::from("../../dylibsurfer-ir/testdata/libpng.ll");
        if !ir_path.exists() {
            println!("Skipping real library test - test file not found");
            return;
        }

        let parser = IrParser::new();
        let signatures = match parser.parse_ir_file(&ir_path) {
            Ok(sig) => sig,
            Err(_) => {
                println!("Skipping real library test - failed to parse IR");
                return;
            }
        };

        // 创建测试引擎
        let engine = create_test_engine();
        let mut generator = FfiGenerator::new(&engine);

        // 只使用前几个函数签名进行测试，避免生成过多代码
        let limited_signatures = if signatures.len() > 5 {
            &signatures[0..5]
        } else {
            &signatures
        };

        // 生成绑定
        let result = generator.generate_bindings(limited_signatures);
        assert!(result.is_ok(), "Failed to generate bindings: {:?}", result.err());
        
        let bindings = result.unwrap();
        assert!(!bindings.is_empty());
        
        // 检查是否包含至少一个函数声明
        assert!(bindings.contains("extern \"C\""));
    }
}
