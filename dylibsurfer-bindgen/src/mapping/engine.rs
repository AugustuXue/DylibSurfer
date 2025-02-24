// mapping/engine.rs 映射规则引擎
use super::config::MappingConfig;
use dylibsurfer_ir::{ResolvedType, PrimitiveType};
use regex::Regex;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum MappingError {
    #[error("Failed to map type: {0}")]
    TypeMappingError(String),
    #[error("Configuration error: {0}")]
    ConfigError(String),
}

pub struct MappingEngine {
    config: MappingConfig,
    // 缓存已编译的正则表达式
    type_name_patterns: Vec<(Regex, String)>,
}

impl MappingEngine {
    pub fn new(config: MappingConfig) -> Result<Self, MappingError> {
        let type_name_patterns = config
            .preprocessing
            .type_names
            .iter()
            .map(|rule| {
                let regex = Regex::new(&rule.pattern).map_err(|e| {
                    MappingError::ConfigError(format!("Invalid regex pattern: {}", e))
                })?;
                Ok((regex, rule.action.clone()))
            })
            .collect::<Result<Vec<_>, MappingError>>()?;

        Ok(Self {
            config,
            type_name_patterns,
        })
    }

    pub fn map_type(&self, resolved_type: &ResolvedType) -> Result<String, MappingError> {
        match resolved_type {
            ResolvedType::Void => Ok("()".to_string()),
            ResolvedType::Primitive(p) => self.map_primitive(*p),
            ResolvedType::Pointer(inner) => self.map_pointer(inner),
            ResolvedType::Array { element_type, length } => self.map_array(element_type, *length),
            ResolvedType::Struct { name, fields, .. } => self.map_struct(name, fields),
            ResolvedType::Union { name, variants, .. } => self.map_union(name, variants),
            ResolvedType::Typedef { name, actual_type } => self.map_typedef(name, actual_type),
        }
    }

    fn map_primitive(&self, primitive: PrimitiveType) -> Result<String, MappingError> {
        let type_name = format!("{:?}", primitive);
        self.config
            .get_primitive_mapping(&type_name)
            .cloned()
            .ok_or_else(|| MappingError::TypeMappingError(format!("Unknown primitive type: {:?}", primitive)))
    }

    fn map_pointer(&self, inner: &ResolvedType) -> Result<String, MappingError> {
        let inner_type = self.map_type(inner)?;
        
        // 检查特殊情况
        for case in &self.config.type_rules.pointer.special_cases {
            if case.match_ == inner_type {
                return Ok(case.map_to.clone());
            }
        }

        // 使用基本模板
        Ok(self.config.type_rules.pointer.template.replace("{inner}", &inner_type))
    }

    fn map_array(&self, element_type: &ResolvedType, length: usize) -> Result<String, MappingError> {
        let inner_type = self.map_type(element_type)?;
        
        if length == 0 {
            Ok(self.config.type_rules.array.dynamic.replace("{inner}", &inner_type))
        } else {
            Ok(self.config.type_rules.array.fixed_size
                .replace("{inner}", &inner_type)
                .replace("{size}", &length.to_string()))
        }
    }

    fn map_struct(&self, name: &str, fields: &[StructField]) -> Result<String, MappingError> {
        let processed_name = self.preprocess_type_name(name);
        let mut rust_struct = String::new();

        // 添加属性
        for attr in &self.config.type_rules.struct_.attributes {
            rust_struct.push_str(&format!("{}\n", attr));
        }

        // 添加结构体定义
        rust_struct.push_str(&format!("pub struct {} {{\n", processed_name));

        // 添加字段
        for field in fields {
            let field_type = self.map_type(&field.ty)?;
            let field_name = self.process_field_name(&field.name);
            rust_struct.push_str(&format!("    {}: {},\n", field_name, field_type));
        }

        rust_struct.push_str("}\n");
        Ok(rust_struct)
    }

    fn map_union(&self, name: &str, variants: &[StructField]) -> Result<String, MappingError> {
        // 将联合体映射为带有 repr(C) 的结构体
        let processed_name = self.preprocess_type_name(name);
        let mut rust_union = String::new();

        rust_union.push_str("#[repr(C)]\n");
        rust_union.push_str(&format!("pub union {} {{\n", processed_name));

        for variant in variants {
            let variant_type = self.map_type(&variant.ty)?;
            let variant_name = self.process_field_name(&variant.name);
            rust_union.push_str(&format!("    pub {}: {},\n", variant_name, variant_type));
        }

        rust_union.push_str("}\n");
        Ok(rust_union)
    }

    fn map_typedef(&self, name: &str, actual_type: &ResolvedType) -> Result<String, MappingError> {
        let processed_name = self.preprocess_type_name(name);
        let actual_type_str = self.map_type(actual_type)?;
        
        Ok(format!("pub type {} = {};\n", processed_name, actual_type_str))
    }

    fn preprocess_type_name(&self, name: &str) -> String {
        let mut processed = name.to_string();
        
        for (pattern, action) in &self.type_name_patterns {
            match action.as_str() {
                "strip_suffix" => {
                    if let Some(mat) = pattern.find(&processed) {
                        processed = processed[..mat.start()].to_string();
                    }
                }
                "strip_prefix" => {
                    if let Some(mat) = pattern.find(&processed) {
                        processed = processed[mat.end()..].to_string();
                    }
                }
                _ => {}
            }
        }

        processed
    }

    fn process_field_name(&self, name: &str) -> String {
        match self.config.type_rules.struct_.field_handling.naming.as_str() {
            "snake_case" => to_snake_case(name),
            _ => name.to_string(),
        }
    }

    pub fn get_required_imports(&self, resolved_type: &ResolvedType) -> Vec<String> {
        let mut imports = self.config.imports.default.clone();
        
        // 分析类型，添加条件导入
        self.analyze_type_for_imports(resolved_type, &mut imports);
        
        imports
    }

    fn analyze_type_for_imports(&self, ty: &ResolvedType, imports: &mut Vec<String>) {
        match ty {
            ResolvedType::Pointer(inner) => {
                // 检查是否需要导入 std::ptr
                if !imports.contains(&"use std::ptr".to_string()) {
                    imports.push("use std::ptr".to_string());
                }
                self.analyze_type_for_imports(inner, imports);
            }
            // 添加其他类型的分析...
            _ => {}
        }
    }
}

// 辅助函数：将 CamelCase 转换为 snake_case
fn to_snake_case(s: &str) -> String {
    let mut result = String::with_capacity(s.len());
    let mut chars = s.chars().peekable();
    
    while let Some(c) = chars.next() {
        if c.is_uppercase() {
            if !result.is_empty() && chars.peek().map_or(false, |next| next.is_lowercase()) {
                result.push('_');
            }
            result.push(c.to_lowercase().next().unwrap());
        } else {
            result.push(c);
        }
    }
    
    result
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::PathBuf;

    #[test]
    fn test_load_config() {
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap()).unwrap();
        
        // 验证基本类型映射
        assert_eq!(config.get_primitive_mapping("Int"), Some(&"c_int".to_string()));
    }

    #[test]
    fn test_map_primitive() {
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap()).unwrap();
        let engine = MappingEngine::new(config).unwrap();
        
        let result = engine.map_type(&ResolvedType::Primitive(PrimitiveType::Int)).unwrap();
        assert_eq!(result, "c_int");
    }

    #[test]
    fn test_map_pointer() {
        let config_path = PathBuf::from("config/default.yaml");
        let config = MappingConfig::load_from_file(config_path.to_str().unwrap()).unwrap();
        let engine = MappingEngine::new(config).unwrap();
        
        let ptr_type = ResolvedType::Pointer(Box::new(ResolvedType::Primitive(PrimitiveType::Int)));
        let result = engine.map_type(&ptr_type).unwrap();
        assert_eq!(result, "*mut c_int");
    }
}