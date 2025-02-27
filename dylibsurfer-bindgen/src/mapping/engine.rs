// mapping/engine.rs 映射规则引擎
use super::config::MappingConfig;
use dylibsurfer_ir::{type_resolver::{PrimitiveType, StructField}, ResolvedType};
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
    /// 缓存已编译的正则表达式
    type_name_patterns: Vec<(Regex, String)>,
}

impl MappingEngine {
    /// 初始化 MappingEngine 实例
    /// 加载配置并预处理正则表达式规则
    pub fn new(config: MappingConfig) -> Result<Self, MappingError> {
        //加载正则表达式规则
        let type_name_patterns = config
            .preprocessing
            .type_names
            .iter()
            .map(|rule| {
                // 编译正则表达式
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
/// 将解析后的类型 (`ResolvedType`) 映射为目标语言（如 Rust）的代码。
///
/// 该方法根据 `ResolvedType` 的具体类型（如基本类型、指针、结构体等），
/// 调用对应的映射规则生成目标语言的代码字符串。
///
/// ## 参数
/// - `resolved_type`: 解析后的类型，表示需要映射的源类型。
///
/// ## 返回值
/// - `Ok(String)`: 成功时返回生成的目标语言代码字符串。
/// - `Err(MappingError)`: 映射失败时返回错误信息。
///
/// ## 支持的映射类型
/// - ​**基本类型**: 如 `Int` -> `c_int`
/// - ​**指针类型**: 如 `*mut c_int`
/// - ​**数组类型**: 如 `[c_int; 10]` 或 `Vec<c_int>`
/// - ​**结构体类型**: 如 `struct Point { x: c_int, y: c_int }`
/// - ​**联合体类型**: 如 `union Data { int: c_int, float: c_float }`
/// - ​**类型别名**: 如 `type MyInt = c_int`
///
/// ## 错误
/// 以下情况可能返回错误：
/// - 未定义的类型映射规则
/// - 无效的类型名称或格式
/// - 正则表达式编译失败（如预处理规则）
///
/// ## 性能
/// 该方法会在初始化阶段预编译所有正则表达式，
/// 因此运行时性能较高，适合多次调用。
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

/// 将基本类型 (`PrimitiveType`) 映射为目标语言（如 Rust）的代码。
///
/// 该方法根据 `PrimitiveType` 的具体类型（如 `Int`、`Float` 等），
/// 从配置中查找对应的目标语言类型并返回。
///
/// # 参数
/// - `primitive`: 需要映射的基本类型，类型为 `PrimitiveType`。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回目标语言代码字符串。
/// - `Err(MappingError)`: 如果未找到映射规则，返回 `MappingError::TypeMappingError`。
    fn map_primitive(&self, primitive: PrimitiveType) -> Result<String, MappingError> {
        //将 PrimitiveType 枚举转换为字符串表示
        let type_name = format!("{:?}", primitive);
        self.config
            .get_primitive_mapping(&type_name)
            .cloned()
            .ok_or_else(|| MappingError::TypeMappingError(format!("Unknown primitive type: {:?}", primitive)))
    }

/// 将指针类型 (`ResolvedType::Pointer`) 映射为目标语言（如 Rust）的代码。
///
/// 该方法根据指针指向的类型（`inner`）和配置中的规则，生成相应的指针类型代码。
/// 如果指针指向的类型匹配配置中的特殊规则，则直接返回特殊规则的映射结果；
/// 否则，使用配置中的基本模板生成指针类型代码。
///
/// # 参数
/// - `inner`: 指针指向的类型，类型为 `&ResolvedType`。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的目标语言代码字符串。
/// - `Err(MappingError)`: 如果指针指向的类型映射失败，返回错误信息。
    fn map_pointer(&self, inner: &ResolvedType) -> Result<String, MappingError> {
        let inner_type = self.map_type(inner)?;
        
        // 检查特殊情况
        //遍历配置中的特殊指针规则（special_cases），检查 inner_type 是否匹配某个特殊规则
        for case in &self.config.type_rules.pointer.special_cases {
            if case.match_ == inner_type {
                return Ok(case.map_to.clone());
            }
        }

        // 如果未找到特殊规则，则使用配置中的基本指针模板生成指针类型代码
        Ok(self.config.type_rules.pointer.template.replace("{inner}", &inner_type))
    }

/// 将数组类型 (`ResolvedType::Array`) 映射为目标语言（如 Rust）的代码。
///
/// 该方法根据数组元素类型（`element_type`）和数组长度（`length`），
/// 生成相应的数组类型代码。如果数组长度为 0，则生成动态数组（如 `Vec<T>`）；
/// 否则，生成固定大小的数组（如 `[T; N]`）。
///
/// # 参数
/// - `element_type`: 数组元素类型，类型为 `&ResolvedType`。
/// - `length`: 数组长度，类型为 `usize`。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的目标语言代码字符串。
/// - `Err(MappingError)`: 如果数组元素类型映射失败，返回错误信息。
    fn map_array(&self, element_type: &ResolvedType, length: usize) -> Result<String, MappingError> {
        let inner_type = self.map_type(element_type)?;
        
        //如果数组长度为 0，表示这是一个动态数组
        if length == 0 {
            //模板替换，将动态数组模板中的 "{inner}" 替换为 inner_type
            Ok(self.config.type_rules.array.dynamic.replace("{inner}", &inner_type))
        } else {
            //如果数组长度大于 0，表示这是一个固定大小的数组
            Ok(self.config.type_rules.array.fixed_size
                .replace("{inner}", &inner_type)
                .replace("{size}", &length.to_string()))
        }
    }

/// 将结构体类型 (`ResolvedType::Struct`) 映射为目标语言（如 Rust）的代码。
///
/// 该方法根据结构体名称和字段信息，生成相应的结构体定义代码。
///
/// # 参数
/// - `name`: 结构体名称，类型为 `&str`。
/// - `fields`: 结构体字段列表，类型为 `&[StructField]`。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的目标语言代码字符串。
/// - `Err(MappingError)`: 如果字段类型映射失败，返回错误信息。
    fn map_struct(&self, name: &str, fields: &[StructField]) -> Result<String, MappingError> {
        //调用 preprocess_type_name 方法，对结构体名称进行预处理
        let processed_name = self.preprocess_type_name(name);
        //创建空字符串，用于存储生成的结构体代码
        let mut rust_struct = String::new();

        // 添加属性
        for attr in &self.config.type_rules.struct_.attributes {
            rust_struct.push_str(&format!("{}\n", attr));
        }

        // 添加结构体定义,包括结构体名称
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
    use crate::mapping::config::MappingConfig; // 使用绝对路径
    use dylibsurfer_ir::{ResolvedType, type_resolver::PrimitiveType};

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