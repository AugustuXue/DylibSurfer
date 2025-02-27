// mapping/config.rs 配置解析器
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// MappingConfig 结构体用于配置映射规则。
///
/// 该结构体通过 `Deserialize` 和 `Serialize` trait 实现反序列化和序列化功能，
/// 使其可以从 JSON、YAML 等数据格式中解析或转换为这些格式。
#[derive(Debug, Deserialize, Serialize)]
pub struct MappingConfig {
    /// 基本类型映射表
    pub primitives: HashMap<String, String>,
    /// 复合类型处理规则
    pub type_rules: TypeRules,
    /// 预处理规则（类型名称转换）
    pub preprocessing: PreprocessingRules,
    /// 导入配置
    pub imports: ImportConfig,
    /// 安全配置
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
    /// 基础指针模板
    pub template: String,
    /// 特殊指针处理
    pub special_cases: Vec<SpecialCase>,
    /// 智能指针配置
    pub smart_ptr: Option<SmartPtrRules>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SpecialCase {
    /// 别名映射 YAML 的 match 字段
    #[serde(alias = "match")]
    /// 匹配模式
    pub match_: String,
    /// 映射目标
    pub map_to: String,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct SmartPtrRules {
    pub enabled: bool,
    pub rules: Vec<SpecialCase>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct StructRules {
    /// 结构体属性（如 #[repr(C)]）
    pub attributes: Vec<String>,
    /// 字段处理规则
    pub field_handling: FieldHandling,
    /// 内存布局控制
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
///- **功能**：定义 **类型名称的预处理规则集合**。
///- 字段：
///  - `type_names: Vec<TypeNameRule>`：存储多个预处理规则，每个规则是一个 `TypeNameRule`。
///- **设计目标**：通过正则表达式和动作的组合，对类型名称进行批量处理（如删除前缀/后缀）。
#[derive(Debug, Deserialize, Serialize)]
pub struct PreprocessingRules {
    pub type_names: Vec<TypeNameRule>,
}

///- **功能**：定义 **单个预处理规则**，包含正则表达式和对应的处理动作。
///- 字段：
///  - `pattern: String`：正则表达式字符串，用于匹配类型名称中的特定模式。
///  - `action: String`：指定对匹配内容的处理动作（如 `strip_suffix`、`strip_prefix`）。
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

    /// 在 self.primitives（HashMap<String, String>）中查找键对应的值
    pub fn get_primitive_mapping(&self, primitive_type: &str) -> Option<&String> {
        self.primitives.get(primitive_type)
    }
}
