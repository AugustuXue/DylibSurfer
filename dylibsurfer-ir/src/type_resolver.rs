use std::collections::HashMap;
use std::sync::Arc;
use parking_lot::RwLock;
use thread_local::ThreadLocal;
use std::cell::RefCell;
use crate::TypeInfo;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum TypeResolveError {
    //检测到类型定义的循环依赖（解析结构体发现直接或间接引用自己，导致无法完成解析）
    #[error("Circular type definition detected: {0}")]
    CircularDependency(String),
    //未知类型
    #[error("Unknown type: {0}")]
    UnknownType(String),
    //类型定义无效（如解析一个整数类型时，发现其位宽不支持（如 128 位整数））
    #[error("Invalid type definition: {0}")]
    InvalidType(String),
    //类型的内存布局计算失败
    #[error("Layout error: {0}")]
    LayoutError(String),
}

/// 表示完全解析后的类型信息，目的是将 C 语言中的类型（包括基本类型、指针、数组、结构体、联合体和类型别名）映射到 Rust 中的相应类型表示
//PartialEq：使枚举可以进行比较（判断是否相等）
#[derive(Debug, Clone, PartialEq)]
pub enum ResolvedType {
    Void,
    //基本类型
    Primitive(PrimitiveType),
    Pointer(Box<ResolvedType>),
    //数组类型
    Array {
        element_type: Box<ResolvedType>,
        length: usize,
    },
    Struct {
        //结构体名称
        name: String,
        //结构体字段列表
        fields: Vec<StructField>,
        //结构体大小
        size: usize,
        //结构体对齐要求（以字节为单位）
        alignment: usize,
    },
    //联合体类型
    Union {
        name: String,
        variants: Vec<StructField>,
        size: usize,
        alignment: usize,
    },
    //类型别名
    Typedef {
        name: String,
        //类型别名实际指向的类型
        actual_type: Box<ResolvedType>,
    },
}

//表示结构体或联合体中的单个字段，用于描述复杂类型（如结构体和联合体）的字段信息
//考虑到多线程的可能，为每个线程使用独立的typeresolver实例
#[derive(Debug, Clone, PartialEq)]
pub struct StructField {
    pub name: String,
    //字段的类型
    pub ty: ResolvedType,
    //字段在结构体或联合体中的偏移量，描述字段在内存中的位置，用于计算结构体的布局
    pub offset: usize,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum PrimitiveType {
    Void,
    Bool,
    Char,
    SChar,
    UChar,
    Short,
    UShort,
    Int,
    UInt,
    Long,
    ULong,
    LongLong,
    ULongLong,
    Float,
    Double,
    LongDouble,
}

impl PrimitiveType {
    fn size(&self) -> usize {
        match self {
            PrimitiveType::Void => 0,
            PrimitiveType::Bool => 1,
            PrimitiveType::Char | PrimitiveType::SChar | PrimitiveType::UChar => 1,
            PrimitiveType::Short | PrimitiveType::UShort => 2,
            PrimitiveType::Int | PrimitiveType::UInt => 4,
            PrimitiveType::Long | PrimitiveType::ULong => 8,
            PrimitiveType::LongLong | PrimitiveType::ULongLong => 8,
            PrimitiveType::Float => 4,
            PrimitiveType::Double => 8,
            PrimitiveType::LongDouble => 16,
        }
    }

    //返回该基本类型的对齐要求
    fn alignment(&self) -> usize {
        match self {
            PrimitiveType::Void => 1,
            PrimitiveType::Bool => 1,
            PrimitiveType::Char | PrimitiveType::SChar | PrimitiveType::UChar => 1,
            PrimitiveType::Short | PrimitiveType::UShort => 2,
            PrimitiveType::Int | PrimitiveType::UInt => 4,
            PrimitiveType::Long | PrimitiveType::ULong => 8,
            PrimitiveType::LongLong | PrimitiveType::ULongLong => 8,
            PrimitiveType::Float => 4,
            PrimitiveType::Double => 8,
            PrimitiveType::LongDouble => 16,
        }
    }
}

//解析和缓存类型信息
pub struct ThreadSafeTypeResolver {
    // 使用 Arc<RwLock> 实现线程安全的类型缓存
    //类型缓存，用于存储已解析的类型，避免重复解析相同的类型，提高解析效率；支持类型别名的解析（通过查找缓存中的实际类型）
    type_cache: Arc<RwLock<HashMap<String, ResolvedType>>>,
    // 使用 ThreadLocal 为每个线程维护独立的进度栈
    //正在解析的类型栈，用于跟踪当前正在解析的类型
    in_progress: ThreadLocal<RefCell<Vec<String>>>,
}

impl Default for ThreadSafeTypeResolver {
    fn default() -> Self {
        Self::new()
    }
}

impl ThreadSafeTypeResolver {
    pub fn new() -> Self {
        Self {
            type_cache: Arc::new(RwLock::new(HashMap::new())),
            in_progress: ThreadLocal::new(),
        }
    }

    //将 TypeInfo（从 LLVM IR 解析出的类型信息）转换为 ResolvedType（完全解析后的类型信息）
    pub fn resolve_type(&self, type_info: &TypeInfo) -> Result<ResolvedType, TypeResolveError> {
        match type_info {
            TypeInfo::Void => Ok(ResolvedType::Void),
            TypeInfo::Int(bits) => {
                let primitive = match *bits {
                    8 => ResolvedType::Primitive(PrimitiveType::Char),
                    16 => ResolvedType::Primitive(PrimitiveType::Short),
                    32 => ResolvedType::Primitive(PrimitiveType::Int),
                    64 => ResolvedType::Primitive(PrimitiveType::Long),
                    _ => return Err(TypeResolveError::InvalidType(
                        format!("Unsupported integer size: {} bits", bits)
                    )),
                };
                Ok(primitive)
            },
            TypeInfo::Float => Ok(ResolvedType::Primitive(PrimitiveType::Float)),
            TypeInfo::Pointer(inner) => {
                let resolved_inner = self.resolve_type(inner)?;
                Ok(ResolvedType::Pointer(Box::new(resolved_inner)))
            },
            TypeInfo::Struct { name, fields } => self.resolve_struct(name, fields),
        }
    }

    //将 TypeInfo 中的结构体信息转换为 ResolvedType::Struct，同时计算结构体的内存布局（大小和对齐）
    fn resolve_struct(&self, name: &str, fields: &[TypeInfo]) -> Result<ResolvedType, TypeResolveError> {
        // 获取当前线程的进度栈
        let in_progress = self.in_progress.get_or(|| RefCell::new(Vec::new()));
        
        // 检查循环依赖
        if in_progress.borrow().contains(&name.to_string()) {
            return Err(TypeResolveError::CircularDependency(name.to_string()));
        }

        // 检查类型缓存
        {
            let cache = self.type_cache.read();
            if let Some(cached) = cache.get(name) {
                return Ok(cached.clone());
            }
        }

        // 将当前类型加入进度栈
        in_progress.borrow_mut().push(name.to_string());

        // 解析字段
        //存储解析后的字段信息
        let mut resolved_fields = Vec::new();
        //当前字段起始偏移量
        let mut current_offset = 0;
        //结构体最大对齐要求
        let mut max_alignment = 1;

        for (index, field_type) in fields.iter().enumerate() {
            //为字段生成默认名称（field_0、field_1）
            let field_name = format!("field_{}", index);
            //将 TypeInfo 转换为 ResolvedType
            let resolved_type = self.resolve_type(field_type)?;
            
            //获取字段大小跟对齐
            let (size, alignment) = self.get_type_layout(&resolved_type)?;
            //更新结构体的最大对齐
            max_alignment = max_alignment.max(alignment);
            
            //对齐字段的偏移量
            current_offset = align_to(current_offset, alignment);
            
            //存储字段信息，将解析后的字段信息存入 resolved_fields 列表
            resolved_fields.push(StructField {
                name: field_name,
                ty: resolved_type,
                offset: current_offset,
            });
            
            //将 current_offset 增加字段的大小，为下一个字段的偏移量做准备
            current_offset += size;
        }

        //将结构体的总大小对齐到结构体的最大对齐要求
        let total_size = align_to(current_offset, max_alignment);

        //生成 ResolvedType::Struct
        let resolved = ResolvedType::Struct {
            name: name.to_string(),
            fields: resolved_fields,
            size: total_size,
            alignment: max_alignment,
        };

        // 将解析结果加入缓存
        {
            let mut cache = self.type_cache.write();
            cache.insert(name.to_string(), resolved.clone());
        }

        // 从进度栈中移除当前类型
        in_progress.borrow_mut().pop();

        Ok(resolved)
    }

    //计算给定 ResolvedType 的内存布局，即类型的大小（size）和对齐要求（alignment）
    pub fn get_type_layout(&self, ty: &ResolvedType) -> Result<(usize, usize), TypeResolveError> {
        match ty {
            ResolvedType::Void => Ok((0, 1)),
            ResolvedType::Primitive(p) => Ok((p.size(), p.alignment())),
            //64位系统返回固定值(8, 8)，32位待适配 #todo
            ResolvedType::Pointer(_) => Ok((8, 8)),
            //数组的大小等于元素的大小乘以数组的长度
            ResolvedType::Array { element_type, length } => {
                let (elem_size, elem_align) = self.get_type_layout(element_type)?;
                Ok((elem_size * length, elem_align))
            },
            ResolvedType::Struct { size, alignment, .. } => Ok((*size, *alignment)),
            ResolvedType::Union { size, alignment, .. } => Ok((*size, *alignment)),
            ResolvedType::Typedef { actual_type, .. } => self.get_type_layout(actual_type),
        }
    }

    //将一个已解析的类型（ResolvedType）注册到类型缓存中
    pub fn register_type(&self, name: String, ty: ResolvedType) {
        let mut cache = self.type_cache.write();
        cache.insert(name, ty);
    }

    //从类型缓存中查找指定名称的类型，并返回其对应的已解析类型（ResolvedType）
    pub fn lookup_type(&self, name: &str) -> Option<ResolvedType> {
        let cache = self.type_cache.read();
        cache.get(name).cloned()
    }
}

//将一个值（value）对齐到指定的对齐要求（alignment）
fn align_to(value: usize, alignment: usize) -> usize {
    (value + alignment - 1) & !(alignment - 1)
}

#[cfg(test)]
mod tests {
    use std::thread;

    use super::*;

    #[test]
    fn test_primitive_resolution() {
        let resolver = ThreadSafeTypeResolver::new();
        let int32_type = TypeInfo::Int(32);
        
        let resolved = resolver.resolve_type(&int32_type).unwrap();
        assert_eq!(resolved, ResolvedType::Primitive(PrimitiveType::Int));
    }

    #[test]
    fn test_pointer_resolution() {
        let resolver = ThreadSafeTypeResolver::new();
        let ptr_type = TypeInfo::Pointer(Box::new(TypeInfo::Int(32)));

        let resolved = resolver.resolve_type(&ptr_type).unwrap();
        match resolved {
            ResolvedType::Pointer(inner) => {
                assert_eq!(*inner, ResolvedType::Primitive(PrimitiveType::Int));
            },
            _ => panic!("Expected pointer type"),
        }
    }

    #[test]
    fn test_struct_resolution() {
        let resolver = ThreadSafeTypeResolver::new();
        let struct_type = TypeInfo::Struct {
            name: "Point".to_string(),
            fields: vec![
                TypeInfo::Int(32),
                TypeInfo::Int(32),
            ],
        };
        
        let resolved = resolver.resolve_type(&struct_type).unwrap();
        match resolved {
            ResolvedType::Struct { name, fields, size, alignment } => {
                assert_eq!(name, "Point");
                assert_eq!(fields.len(), 2);
                assert_eq!(size, 8);
                assert_eq!(alignment, 4);
            },
            _ => panic!("Expected struct type"),
        }
    }

    #[test]
    fn test_circular_dependency_detection() {
        let resolver = ThreadSafeTypeResolver::new();
        let circular_struct = TypeInfo::Struct {
            name: "Circular".to_string(),
            fields: vec![
                TypeInfo::Struct {
                    name: "Circular".to_string(),
                    fields: vec![],
                },
            ],
        };
        
        assert!(matches!(
            resolver.resolve_type(&circular_struct),
            Err(TypeResolveError::CircularDependency(_))
        ));
    }

    #[test]
    fn test_concurrent_resolution() {
        let resolver = Arc::new(ThreadSafeTypeResolver::new());
        let mut handles = vec![];

        for i in 0..10 {
            let resolver_clone = resolver.clone();
            let handle = thread::spawn(move || {
                let struct_type = TypeInfo::Struct {
                    name: format!("TestStruct_{}", i),
                    fields: vec![
                        TypeInfo::Int(32),
                        TypeInfo::Int(64),
                    ],
                };
                resolver_clone.resolve_type(&struct_type).unwrap()
            });
            handles.push(handle);
        }

        for handle in handles {
            handle.join().unwrap();
        }
    }
}
