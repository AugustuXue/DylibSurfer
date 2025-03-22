//! 输入转换系统使用示例
//! 演示如何使用DylibSurfer的输入转换系统生成harness

use dylibsurfer_harness::input_conversion::{
    InputConversionConfig,
    generate_extractor_code,
    ResourceManager, 
    ResourceType
};
use dylibsurfer_ir::{IrParser, FunctionSignature, TypeInfo, Parameter};
use std::path::Path;
use std::collections::HashMap;
use std::fs;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 1. 从IR文件中解析函数签名或使用示例函数
    println!("正在准备函数签名...");
    let ir_path = Path::new("dylibsurfer-harness/tests/testdata/png.ll");
    
    // 如果存在IR文件就解析，否则创建测试函数
    let signatures = if ir_path.exists() {
        let parser = IrParser::new();
        parser.parse_ir_file(ir_path)?
    } else {
        println!("找不到IR文件，使用示例函数签名...");
        create_example_signatures()
    };
    
    println!("准备了 {} 个函数签名", signatures.len());
    
    // 2. 创建输入转换配置
    let _config = InputConversionConfig {
        max_buffer_size: 4096,
        max_allocations: 50,
        deterministic_extraction: true,
        custom_handlers: HashMap::new(),
    };
    
    // 3. 演示资源管理器的功能
    let mut resource_manager = ResourceManager::new();
    let test_data = vec![1, 2, 3, 4, 5];
    let resource_id = resource_manager.register_resource(test_data.clone(), ResourceType::Buffer);
    println!("已注册资源，资源ID: {}", resource_id);
    
    // 演示数据检索功能
    if let Some(retrieved_data) = resource_manager.get_resource_data(resource_id) {
        println!("成功检索资源数据: {:?}", retrieved_data);
        assert_eq!(retrieved_data, test_data, "检索的数据应与原始数据匹配");
    } else {
        println!("无法检索资源数据");
    }
    
    // 演示资源清理
    println!("当前资源数量: {}", resource_manager.resource_count());
    resource_manager.cleanup_resource(resource_id);
    println!("清理后资源数量: {}", resource_manager.resource_count());
    
    // 4. 选择要生成提取代码的函数
    let target_function = if !signatures.is_empty() {
        // 选择第一个有参数的函数
        signatures.iter()
            .find(|sig| !sig.parameters.is_empty())
            .unwrap_or(&signatures[0])
            .clone()
    } else {
        // 如果没有签名，使用示例函数
        create_example_function()
    };
    
    println!("为函数 '{}' 的参数生成提取代码...", target_function.name);
    
    // 5. 生成所有参数的提取代码
    let mut param_extractors = Vec::new();
    
    for param in &target_function.parameters {
        match generate_extractor_code(&param.ty, &param.name, "cursor") {
            Ok(extractor) => {
                println!("成功生成参数 '{}' 的提取代码", param.name);
                param_extractors.push(extractor);
            },
            Err(e) => {
                println!("无法生成参数 '{}' 的提取代码: {:?}", param.name, e);
            }
        }
    }
    
    // 6. 保存生成的代码到输出目录
    let output_dir = Path::new("examples/output");
    fs::create_dir_all(output_dir)?;
    
    let extractors_path = output_dir.join("param_extractors.rs");
    fs::write(&extractors_path, param_extractors.join("\n\n"))?;
    println!("参数提取代码已保存至: {:?}", extractors_path);
    
    // 7. 创建一个示例harness函数并保存 - 注意大括号的转义
    let harness_code = format!(r#"
/// Harness for {}
fn harness_{}(data: &[u8]) -> bool {{
    // 确保有足够的数据
    if data.len() < {} {{
        return false;  
    }}
    
    // 创建资源管理器跟踪内存
    let mut resource_manager = ResourceManager::new();
    
    // 初始化字节解析光标
    let mut cursor = 0;
    
    // 提取参数
    {}
    
    // 使用异常处理调用目标函数
    let result = std::panic::catch_unwind(|| {{
        unsafe {{
            {}({})
        }}
    }});
    
    // 清理所有分配的资源
    resource_manager.cleanup_all();
    
    // 如果函数执行未崩溃，返回true
    println!("执行完成，清理了 {{}} 个资源", resource_manager.resource_count());
    
    result.is_ok()
}}
"#, 
        target_function.name,
        target_function.name,
        target_function.parameters.len() * 4,
        param_extractors.join("\n    "),
        target_function.name,
        target_function.parameters.iter().map(|p| p.name.clone()).collect::<Vec<_>>().join(", ")
    );
    
    let harness_path = output_dir.join("example_harness.rs");
    fs::write(&harness_path, harness_code)?;
    println!("示例harness已保存至: {:?}", harness_path);
    
    println!("示例运行完成!");
    Ok(())
}

/// 创建一组示例函数签名
fn create_example_signatures() -> Vec<FunctionSignature> {
    vec![
        create_example_function(),
        create_example_function_2(),
        create_example_function_3(),
    ]
}

/// 创建示例函数签名1：处理字符串
fn create_example_function() -> FunctionSignature {
    FunctionSignature {
        name: "example_string_func".to_string(),
        return_type: TypeInfo::Int(32),
        parameters: vec![
            Parameter {
                name: "str".to_string(),
                ty: TypeInfo::Pointer(Box::new(TypeInfo::Int(8))), // char*
            },
            Parameter {
                name: "len".to_string(),
                ty: TypeInfo::Int(32), // int
            },
        ],
    }
}

/// 创建示例函数签名2：处理结构体
fn create_example_function_2() -> FunctionSignature {
    // 创建一个简单的结构体类型
    let example_struct = TypeInfo::Struct {
        name: "ExampleStruct".to_string(),
        fields: vec![
            TypeInfo::Int(32),     // 第一个字段：int
            TypeInfo::Float,       // 第二个字段：float
            TypeInfo::Pointer(Box::new(TypeInfo::Int(8))), // 第三个字段：char*
        ],
    };
    
    FunctionSignature {
        name: "example_struct_func".to_string(),
        return_type: TypeInfo::Void,
        parameters: vec![
            Parameter {
                name: "obj".to_string(),
                ty: TypeInfo::Pointer(Box::new(example_struct)), // ExampleStruct*
            },
            Parameter {
                name: "flag".to_string(),
                ty: TypeInfo::Int(32), // int
            },
        ],
    }
}

/// 创建示例函数签名3：初始化/清理类函数
fn create_example_function_3() -> FunctionSignature {
    FunctionSignature {
        name: "example_init_func".to_string(),
        return_type: TypeInfo::Pointer(Box::new(TypeInfo::Void)), // void*
        parameters: vec![
            Parameter {
                name: "size".to_string(),
                ty: TypeInfo::Int(64), // size_t
            },
            Parameter {
                name: "init_val".to_string(),
                ty: TypeInfo::Int(32), // int
            },
        ],
    }
}