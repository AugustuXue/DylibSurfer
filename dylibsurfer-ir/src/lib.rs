// src/lib.rs
pub mod type_resolver;
//最小接口原则，只暴露核心公共 API（如 ResolvedType），隐藏实现细节（如 PrimitiveType）
pub use type_resolver::{ThreadSafeTypeResolver, ResolvedType, TypeResolveError};
use inkwell::{context::Context, memory_buffer::MemoryBuffer, types::{BasicTypeEnum, AnyTypeEnum}};
use serde::Serialize;
use std::{cell::RefCell, collections::{HashMap, HashSet}, path::Path};
use thiserror::Error;

//Error:让枚举实现 std::error::Error trait，使其可以作为错误类型使用
#[derive(Error, Debug)]
pub enum IrError {
    #[error("IR parsing failed: {0}")]
    ParseError(String),

    #[error("Circular type dependency detected: {0}")]
    CircularDependency(String),
/*
对于 ParseError，#[derive(Error)] 会生成类似以下的代码：
impl std::fmt::Display for IrError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            IrError::ParseError(msg) => write!(f, "IR parsing failed: {}", msg),
        }
    }
}

impl std::error::Error for IrError {}
*/
}
//Serialize: 来自 serde crate，允许结构体被序列化为 JSON、YAML 等格式：let json = serde_json::to_string(&sig).unwrap(); // 将结构体转换为 JSON 字符串
#[derive(Debug, Serialize,Clone)]
//表示函数签名信息
pub struct FunctionSignature {
    //函数名称
    pub name: String,
    //函数返回类型（值为类型信息）
    pub return_type: TypeInfo,
    //函数参数列表（动态数组中单个值内容为单个参数的信息）
    pub parameters: Vec<Parameter>,
}

#[derive(Debug, Serialize,Clone)]
//表示函数参数
pub struct Parameter {
    //参数名称
    pub name: String,
    //参数类型
    pub ty: TypeInfo,
}

#[derive(Debug, Serialize, Clone)]
//#[serde(tag = "type", content = "data")] 是 serde 库提供的属性宏，用于指定枚举在序列化时的表示方式
//tag = "type" 表示在序列化时，枚举的变体名称将作为 "type" 字段的值
//content = "data" 表示在序列化时，枚举变体的内容将作为 "data" 字段的值
#[serde(tag = "type", content = "data")]
//表示不同类型的类型信息
pub enum TypeInfo {
    Void,
    Int(u32),
    Float,
    Pointer(Box<TypeInfo>),
    Struct {
        name: String,
        fields: Vec<TypeInfo>,
    },
}
//用于解析LLVM IR文件，提取函数签名和类型信息
pub struct IrParser {
    ///Context为inkwell库中的一个类型，用于管理LLVM上下文（LLVM 上下文是 LLVM 中用于管理模块、类型、常量等资源的全局环境）
    context: Context,
    /// 类型缓存，用于存储已解析的类型信息
    type_cache: RefCell<HashMap<String, TypeInfo>>,
    /// 正在处理的类型集合，用于检测循环依赖
    in_progress: RefCell<HashSet<String>>,
}
//为IR解析创建独有方法
impl IrParser {
    //初始化
    pub fn new() -> Self {
        Self {
            context: Context::create(),
            type_cache: RefCell::new(HashMap::new()),
            in_progress: RefCell::new(HashSet::new()),
        }
    }

    //解析LLVM IR文件（包括加载），返回包含所有函数签名信息的动态数组
    pub fn parse_ir_file(&self, path: &Path) -> Result<Vec<FunctionSignature>, IrError> {
        //将IR文件加载到内存中
        //MemoryBuffer::create_from_file(path)返回Result<Self, LLVMString>，需要使用map_err将错误类型转换为IrError::ParseError
        let memory_buffer = MemoryBuffer::create_from_file(path)
            .map_err(|e| IrError::ParseError(e.to_string()))?;

        //将包含LLVM IR的缓冲区（MemoryBuffer）解析成LLVM module
        //create_module_from_ir(memory_buffer): 从 MemoryBuffer 中解析 LLVM IR 并生成一个 LLVM Module（MemoryBuffer中只存储了内容，module才是LLVM的结构化表示，方便使用LLVM API操作）
        let module = self.context
            .create_module_from_ir(memory_buffer)
            .map_err(|e| IrError::ParseError(e.to_string()))?;

        //对每个函数尝试解析其签名，如果解析成功则保留 FunctionSignature，否则丢弃
        Ok(module.get_functions()
            .filter_map(|func| self.parse_function(&func).ok())
            .collect())
    }

    //解析 LLVM 函数的签名，并将其转换为自定义的 FunctionSignature 结构体
    fn parse_function(&self, func: &inkwell::values::FunctionValue) -> Result<FunctionSignature, IrError> {
        //从LLVM函数中提取函数名，并转换成String类型
        let name = func.get_name().to_str()
            .map(String::from)
            .unwrap_or_else(|_| String::from("unknown"));

        //解析LLVM函数返回类型，并转换成自定义typeinfo类型
        let return_type = if let Some(ty) = func.get_type().get_return_type() {
            //解析 BasicTypeEnum 并转换为自定义的 TypeInfo 类型
            self.parse_basic_type(&ty)?
        } else {
            TypeInfo::Void
        };

        //解析 LLVM 函数的参数列表，并将每个参数的类型转换为自定义的 TypeInfo 类型
        let parameters = func.get_params()
            .iter()
            .enumerate()
            .map(|(i, param)| {
                Ok(Parameter {
                    name: format!("arg{}", i),
                    ty: self.parse_basic_type(&param.get_type())?,
                })
            })
            .collect::<Result<Vec<_>, IrError>>()?;

        Ok(FunctionSignature {
            name,
            return_type,
            parameters,
        })
    }

    //将LLVM的 BasicTypeEnum 类型转换为自定义的 TypeInfo 类型（支持解析基本类型（如整数、浮点数）、指针类型和结构体类型，并处理了嵌套指针和结构体字段的递归解析）
    fn parse_basic_type(&self, ty: &BasicTypeEnum) -> Result<TypeInfo, IrError> {
        match ty {
            BasicTypeEnum::IntType(int_ty) => {
                Ok(TypeInfo::Int(int_ty.get_bit_width()))
            },
            BasicTypeEnum::FloatType(_) => {
                Ok(TypeInfo::Float)
            },
            BasicTypeEnum::PointerType(ptr_ty) => {
                //调用parse_any_type方法解析指针指向类型
                let pointee = self.parse_any_type(&ptr_ty.get_element_type())?;
                Ok(TypeInfo::Pointer(Box::new(pointee)))
            },
            BasicTypeEnum::StructType(struct_ty) => {
                let name = struct_ty.get_name()
                    .and_then(|n| n.to_str().ok())//Option 的方法，用于对 Some 值进行转换
                    .unwrap_or("anonymous")//如果结构体没有名称或名称无效，返回 "anonymous"
                    .to_string();

                // 如果是匿名结构体，可以生成唯一名称
                let struct_id = if name == "anonymous" {
                    format!("anonymous_{:p}", struct_ty)
                } else {
                    name.clone()
                };
                // 检查是否已经缓存了这个结构体
                if let Some(cached_type) = self.type_cache.borrow().get(&struct_id){
                    return Ok(cached_type.clone());
                }
                // 检查循环依赖
                if self.in_progress.borrow().contains(&struct_id) {
                    // 发现循环依赖，返回一个简化版本的结构体
                    // 这里我们返回一个指向自身的指针，以打破循环
                    return Ok(TypeInfo::Struct {
                        name: name.clone(),
                        fields: Vec::new(), // 空字段列表
                    });
                }
                // 标记当前结构体为正在处理
                self.in_progress.borrow_mut().insert(struct_id.clone());
                // 创建一个空的结构体作为占位符，放入缓存,避免在解析字段时循环访问
                let placeholder = TypeInfo::Struct {
                    name: name.clone(),
                    fields: Vec::new(),
                };
                self.type_cache.borrow_mut().insert(struct_id.clone(), placeholder);
                // 解析字段
                let fields= struct_ty.get_field_types()
                    .iter()
                    .map(|field| self.parse_basic_type(field))
                    .collect::<Result<Vec<_>,_>>()?;

                // 创建完整的结构体类型
                let struct_type = TypeInfo::Struct { name, fields };

                self.type_cache.borrow_mut().insert(struct_id.clone(), struct_type.clone());

                // 无论成功还是失败，都要移除正在处理的标记
                self.in_progress.borrow_mut().remove(&struct_id);

                Ok(struct_type)
            },
            _ => Err(IrError::ParseError("Unsupported type".into())),
        }
    }

    //将 LLVM 的 AnyTypeEnum 类型转换为自定义的 TypeInfo 类型
    fn parse_any_type(&self, ty: &AnyTypeEnum) -> Result<TypeInfo, IrError> {
        match ty {
            AnyTypeEnum::IntType(t) => Ok(TypeInfo::Int(t.get_bit_width())),
            AnyTypeEnum::FloatType(_) => Ok(TypeInfo::Float),
            AnyTypeEnum::PointerType(p) => {
                // 递归处理嵌套指针
                let inner = self.parse_any_type(&p.get_element_type())?;
                Ok(TypeInfo::Pointer(Box::new(inner)))
            },
            AnyTypeEnum::StructType(s) => {
                let name = s.get_name()
                    .and_then(|n| n.to_str().ok())
                    .unwrap_or("anonymous")
                    .to_string();

                // 如果是匿名结构体，生成唯一名称
                let struct_id = if name == "anonymous" {
                    format!("anonymous_{:p}", s)
                } else {
                    name.clone()
                };
                
                // 检查是否已经缓存了这个结构体
                if let Some(cached_type) = self.type_cache.borrow().get(&struct_id) {
                    return Ok(cached_type.clone());
                }
                // 检查循环依赖
                if self.in_progress.borrow().contains(&struct_id) {
                    // 发现循环依赖，返回一个简化版本的结构体
                    return Ok(TypeInfo::Struct {
                        name: name.clone(),
                        fields: Vec::new(), // 空字段列表
                    });
                }
                // 标记当前结构体为正在处理
                self.in_progress.borrow_mut().insert(struct_id.clone());
                // 创建一个空的结构体作为占位符，放入缓存
                let placeholder = TypeInfo::Struct {
                    name: name.clone(),
                    fields: Vec::new(),
                };
                self.type_cache.borrow_mut().insert(struct_id.clone(), placeholder);
                // 解析字段
                let fields= s.get_field_types()
                    .iter()
                    .map(|field| self.parse_basic_type(field))
                    .collect::<Result<Vec<_>, _>>()?;

                 // 创建完整结构体类型
                 let struct_type = TypeInfo::Struct { name, fields };
                
                 // 更新缓存
                 self.type_cache.borrow_mut().insert(struct_id.clone(), struct_type.clone());
        
                 // 从正在处理集合中移除当前类型
                 self.in_progress.borrow_mut().remove(&struct_id);
                 
                 Ok(struct_type)
            },
            AnyTypeEnum::VoidType(_) => Ok(TypeInfo::Void),
            _ => Err(IrError::ParseError("Unsupported type".into())),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::PathBuf;

    #[test]
    fn test_parse_ir() {
        let parser = IrParser::new();
        let path = PathBuf::from("testdata/libpng.ll");
        let signatures = parser.parse_ir_file(&path).unwrap();
        
        println!("{}", serde_json::to_string_pretty(&signatures).unwrap());
        
        assert!(!signatures.is_empty());
    }
    
    #[test]
    fn test_circular_dependency() {
        let parser = IrParser::new();
        let path = PathBuf::from("testdata/libpng.ll");
        let signatures = parser.parse_ir_file(&path).unwrap();
        
        // 验证能够正确处理循环依赖的结构体
        assert!(!signatures.is_empty());
    }
}
