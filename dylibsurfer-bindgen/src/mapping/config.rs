// mapping/config.rs 配置解析器
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Deserialize, Serialize)]
pub struct MappingConfig {
    pub primitives: HashMap<String, String>,
    pub type_rules: TypeRules,
    pub preprocessing: PreprocessingRules,
    pub imports: ImportConfig,
    pub safety: SafetyConfig,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TypeRules {
    pub pointer: PointerRules,
    #[serde(rename = "struct")]
    pub struct_: StructRules,
    pub array: ArrayRules,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct PointerRules {
    pub template: String,
    pub special_cases: Vec<SpecialCase>,
    pub smart_ptr: Option<SmartPtrRules>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SpecialCase {
    #[serde(alias = "match")]  // 添加别名映射
    pub match_: String,
    pub map_to: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SmartPtrRules {
    pub enabled: bool,
    pub rules: Vec<SpecialCase>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct StructRules {
    pub attributes: Vec<String>,
    pub field_handling: FieldHandling,
    pub layout: LayoutConfig,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct FieldHandling {
    pub naming: String,
    pub visibility: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct LayoutConfig {
    pub respect_alignment: bool,
    pub pack_value: Option<u32>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ArrayRules {
    pub fixed_size: String,
    pub dynamic: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct PreprocessingRules {
    pub type_names: Vec<TypeNameRule>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TypeNameRule {
    pub pattern: String,
    pub action: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ImportConfig {
    pub default: Vec<String>,
    pub conditional: HashMap<String, ConditionalImport>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ConditionalImport {
    pub types: Vec<String>,
    pub import: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SafetyConfig {
    pub unsafe_fn: UnsafeFnConfig,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct UnsafeFnConfig {
    pub add_unsafe: bool,
    pub wrapper_template: String,
}

impl MappingConfig {
    pub fn load_from_file(path: &str) -> Result<Self, Box<dyn std::error::Error>> {
        let config_str = std::fs::read_to_string(path)?;
        let config = serde_yaml::from_str(&config_str)?;
        Ok(config)
    }

    pub fn get_primitive_mapping(&self, primitive_type: &str) -> Option<&String> {
        self.primitives.get(primitive_type)
    }
}
