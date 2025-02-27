// mapping/config.rs 配置解析器
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

//Deserialize:为类型实现反序列化功能，使其可以从 JSON、YAML 等数据格式中解析
//Serialize:为类型实现序列化功能，使其可以转换为 JSON、YAML 等数据格式
#[derive(Debug, Deserialize, Serialize)]
pub struct MappingConfig {
    //基本类型映射表
    pub primitives: HashMap<String, String>,
    //复合类型处理规则
    pub type_rules: TypeRules,
    //预处理规则
    pub preprocessing: PreprocessingRules,
    //导入配置
    pub imports: ImportConfig,
    //安全配置
    pub safety: SafetyConfig,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct TypeRules {
    pub pointer: PointerRules,
    // 映射 YAML 的 struct 字段
    #[serde(rename = "struct")]
    pub struct_: StructRules,
    pub array: ArrayRules,
}

/*
    e.g.
    pointer:
        template: "*mut {inner}"
        special_cases:
            - match: "void*"
            map_to: "*mut c_void"
        smart_ptr:
            enabled: true
            rules: [...]
 */
#[derive(Debug, Deserialize, Serialize)]
pub struct PointerRules {
    // 基础指针模板
    pub template: String,
    // 特殊指针处理
    pub special_cases: Vec<SpecialCase>,
    // 智能指针配置
    pub smart_ptr: Option<SmartPtrRules>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SpecialCase {
    // 别名映射 YAML 的 match 字段
    #[serde(alias = "match")]
    // 匹配模式
    pub match_: String,
    // 映射目标
    pub map_to: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SmartPtrRules {
    pub enabled: bool,
    pub rules: Vec<SpecialCase>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct StructRules {
    // 结构体属性（如 #[repr(C)]）
    pub attributes: Vec<String>,
    // 字段处理规则
    pub field_handling: FieldHandling,
    // 内存布局控制
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
    //加载配置文件
    pub fn load_from_file(path: &str) -> Result<Self, Box<dyn std::error::Error>> {
        //读取文件内容
        let config_str = std::fs::read_to_string(path)?;
        //将 YAML 字符串反序列化为 MappingConfig 结构体
        let config = serde_yaml::from_str(&config_str)?;
        Ok(config)
    }

    //在 self.primitives（HashMap<String, String>）中查找键对应的值
    pub fn get_primitive_mapping(&self, primitive_type: &str) -> Option<&String> {
        self.primitives.get(primitive_type)
    }
}
