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

    /// 将联合体类型 (`ResolvedType::Union`) 映射为目标语言的代码。
///
/// 该方法根据联合体名称和变体信息，生成相应的联合体定义代码。
///
/// # 参数
/// - `name`: 联合体名称，类型为 `&str`。
/// - `variants`: 联合体变体列表，类型为 `&[StructField]`。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的目标语言代码字符串。
/// - `Err(MappingError)`: 如果变体类型映射失败，返回错误信息。
    fn map_union(&self, name: &str, variants: &[StructField]) -> Result<String, MappingError> {
        // 调用 preprocess_type_name 方法，对联合体名称进行预处理（如删除前缀/后缀）
        let processed_name = self.preprocess_type_name(name);
        //创建空字符串 rust_union，存储生成的联合体代码
        let mut rust_union = String::new();

        //添加 #[repr(C)] 属性，确保联合体的内存布局与 C 语言兼容
        rust_union.push_str("#[repr(C)]\n");
        //添加联合体定义，包括联合体名称
        rust_union.push_str(&format!("pub union {} {{\n", processed_name));

        //添加变体
        for variant in variants {
            //调用 map_type 方法，递归映射变体类型
            let variant_type = self.map_type(&variant.ty)?;
            //调用 process_field_name 方法，处理变体名称（如转换为蛇形命名）
            let variant_name = self.process_field_name(&variant.name);
            //将变体定义添加到 rust_union 中
            rust_union.push_str(&format!("    pub {}: {},\n", variant_name, variant_type));
        }

        rust_union.push_str("}\n");
        Ok(rust_union)
    }

/// 将类型别名映射为 Rust 的 `type` 定义。
///
/// 此函数用于生成 `pub type {别名} = {实际类型};` 形式的 Rust 代码。
///
/// # 参数
/// - `name`: 原始类型别名（例如 C/C++ 中的 `typedef` 名称）。
/// - `actual_type`: 解析后的实际类型（通过 `ResolvedType` 表示）。
///
/// # 返回值
/// - `Ok(String)`: 成功时返回生成的 Rust 类型别名代码。
/// - `Err(MappingError)`: 如果实际类型无法映射到合法的 Rust 类型，返回错误。
///
/// # 流程
/// 1. ​**预处理类型名**: 调用 `preprocess_type_name` 处理原始别名，确保符合 Rust 命名规范。
/// 2. ​**映射实际类型**: 调用 `map_type` 将 `ResolvedType` 转换为 Rust 类型字符串。
/// 3. ​**生成代码**: 组合预处理后的别名和映射后的类型，生成 `pub type` 定义。
    fn map_typedef(&self, name: &str, actual_type: &ResolvedType) -> Result<String, MappingError> {
        //预处理类型别名
        let processed_name = self.preprocess_type_name(name);
        //将 ResolvedType 映射为 Rust 类型字符串（如 "u32" 或 "libc::c_int"）
        let actual_type_str = self.map_type(actual_type)?;
        
        // 生成最终的 `pub type` 定义代码
        Ok(format!("pub type {} = {};\n", processed_name, actual_type_str))
    }

/// 预处理类型名称，根据配置的模式和操作对名称进行修改。
///
/// 此函数用于处理原始类型名称（例如 C/C++ 中的类型名），
/// 根据 `self.type_name_patterns` 中定义的正则表达式模式和执行操作，
/// 对名称进行前缀或后缀的删除，以生成符合目标语言（如 Rust）规范的名称。
///
/// # 参数
/// - `name`: 原始类型名称（例如 C/C++ 中的类型名）。
///
/// # 返回值
/// - `String`: 处理后的类型名称。
///
/// # 处理流程
/// 1. 遍历 `self.type_name_patterns` 中的每个模式及其操作。
/// 2. 根据操作类型（如 `"strip_suffix"` 或 `"strip_prefix"`），
///    使用正则表达式匹配并删除名称中的前缀或后缀。
/// 3. 返回最终处理后的名称。
    fn preprocess_type_name(&self, name: &str) -> String {
        // 将原始名称转换为可修改的字符串
        let mut processed = name.to_string();
        
        // 遍历所有模式及其操作
        for (pattern, action) in &self.type_name_patterns {
            match action.as_str() {
                // 如果操作是删除后缀
                "strip_suffix" => {
                    // 使用正则表达式匹配后缀
                    if let Some(mat) = pattern.find(&processed) {
                        //删除后缀
                        processed = processed[..mat.start()].to_string();
                    }
                }
                // 如果操作是删除前缀，同上
                "strip_prefix" => {
                    if let Some(mat) = pattern.find(&processed) {
                        processed = processed[mat.end()..].to_string();
                    }
                }
                // 其他操作（暂不处理）
                _ => {}
            }
        }

        processed
    }

/// 处理结构体字段名称，根据配置的命名规则将其转换为目标格式。
///
/// 此函数用于将原始字段名称（例如 C/C++ 中的字段名）转换为符合目标语言（如 Rust）规范的命名格式。
/// 具体转换规则由 `self.config.type_rules.struct_.field_handling.naming` 配置决定。
///
/// # 参数
/// - `name`: 原始字段名称（例如 C/C++ 中的字段名）。
///
/// # 返回值
/// - `String`: 处理后的字段名称。
///
/// # 处理流程
/// 1. 检查配置中的命名规则（`naming`）。
/// 2. 如果规则为 `"snake_case"`，将原始名称转换为蛇形命名法（snake_case）。
/// 3. 否则，直接返回原始名称。
    fn process_field_name(&self, name: &str) -> String {
        // 获取配置中的命名规则
        match self.config.type_rules.struct_.field_handling.naming.as_str() {
            // 如果规则是蛇形命名法，调用 to_snake_case 函数进行转换
            "snake_case" => to_snake_case(name),
            // 其他情况，直接返回原始名称
            _ => name.to_string(),
        }
    }

/// 获取解析类型所需的导入项列表。
///
/// 此函数用于根据 `ResolvedType` 分析所需的导入项（如模块、库或类型），
/// 并结合配置中的默认导入项，返回完整的导入列表。
///
/// # 参数
/// - `resolved_type`: 解析后的类型（通过 `ResolvedType` 表示）。
///
/// # 返回值
/// - `Vec<String>`: 所需的导入项列表。
///
/// # 处理流程
/// 1. 复制配置中的默认导入项（`self.config.imports.default`）。
/// 2. 调用 `analyze_type_for_imports` 函数，根据 `resolved_type` 分析并添加条件导入项。
/// 3. 返回最终的导入项列表。
    pub fn get_required_imports(&self, resolved_type: &ResolvedType) -> Vec<String> {
        let mut imports = self.config.imports.default.clone();
        
        // 分析类型，添加条件导入
        self.analyze_type_for_imports(resolved_type, &mut imports);
        
        imports
    }

/// 分析解析类型，根据其结构添加必要的导入项。
///
/// 此函数用于递归地分析 `ResolvedType`，并根据其类型结构（如指针、数组、自定义类型等）
/// 添加所需的导入项到 `imports` 列表中。
///
/// # 参数
/// - `ty`: 解析后的类型（通过 `ResolvedType` 表示）。
/// - `imports`: 导入项列表，用于存储分析结果。
///
/// # 处理流程
/// 1. 匹配 `ResolvedType` 的具体类型。
/// 2. 根据类型结构添加必要的导入项。
/// 3. 递归分析嵌套类型（如指针指向的类型）。
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

/// 将字符串转换为蛇形命名法（snake_case）。
///
/// 此函数用于将驼峰命名法（CamelCase）或帕斯卡命名法（PascalCase）的字符串
/// 转换为蛇形命名法（snake_case）。例如：
/// - `MyVariable` → `my_variable`
/// - `userID` → `user_id`
///
/// # 参数
/// - `s`: 原始字符串（通常是驼峰或帕斯卡命名法的字符串）。
///
/// # 返回值
/// - `String`: 转换后的蛇形命名法字符串。
///
/// # 处理流程
/// 1. 初始化一个 `String` 用于存储结果，并预分配足够的容量。
/// 2. 使用 `chars().peekable()` 遍历字符串的每个字符。
/// 3. 对于每个大写字符：
///    - 如果它不是第一个字符，且下一个字符是小写字母，则在结果中添加下划线。
///    - 将大写字符转换为小写并添加到结果中。
/// 4. 对于其他字符，直接添加到结果中。
/// 5. 返回最终的蛇形命名法字符串。
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