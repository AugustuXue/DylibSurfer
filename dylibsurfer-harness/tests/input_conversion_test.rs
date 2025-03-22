use dylibsurfer_harness::input_conversion::{
    generate_extractor_code, InputConversionConfig, ResourceManager, ResourceType, ByteParser
};
use dylibsurfer_ir::TypeInfo;

#[test]
fn test_resource_manager_basic() {
    let mut manager = ResourceManager::new();
    
    // 测试资源注册
    let test_data = vec![10, 20, 30, 40, 50];
    let resource_id = manager.register_resource(test_data.clone(), ResourceType::Buffer);
    assert!(resource_id > 0, "资源ID应大于0");
    assert_eq!(manager.resource_count(), 1, "应该有一个资源被跟踪");
    
    // 测试数据检索
    let retrieved = manager.get_resource_data(resource_id).expect("应能检索资源数据");
    assert_eq!(retrieved, test_data, "检索的数据应与原始数据匹配");
    
    // 测试清理单个资源
    assert!(manager.cleanup_resource(resource_id), "清理应成功");
    assert_eq!(manager.resource_count(), 0, "清理后应无资源");
    
    // 测试非法ID
    assert!(!manager.cleanup_resource(999), "清理无效ID应返回false");
}

#[test]
fn test_resource_manager_multiple() {
    let mut manager = ResourceManager::new();
    
    // 注册多个资源
    let resources = vec![
        vec![1, 2, 3],
        vec![4, 5, 6],
        vec![7, 8, 9],
    ];
    
    let mut ids = Vec::new();
    for data in &resources {
        let id = manager.register_resource(data.clone(), ResourceType::Buffer);
        assert!(id > 0, "资源ID应大于0");
        ids.push(id);
    }
    
    assert_eq!(manager.resource_count(), 3, "应该有三个资源被跟踪");
    
    // 验证每个资源的数据
    for (i, id) in ids.iter().enumerate() {
        let retrieved = manager.get_resource_data(*id).expect("应能检索资源数据");
        assert_eq!(retrieved, resources[i], "检索的数据应与原始数据匹配");
    }
    
    // 测试自动清理（通过Drop）
    drop(manager);
    // 不能直接验证资源释放，但代码覆盖率会显示Drop被调用
}

#[test]
fn test_resource_manager_track_allocation() {
    let mut manager = ResourceManager::new();
    
    // 创建一个真实的内存分配，而不是使用假地址
    let real_memory = Box::into_raw(Box::new(42i32)) as usize;
    
    // 使用真实地址进行跟踪
    let id = manager.track_allocation(real_memory, ResourceType::Buffer);
    assert!(id > 0, "资源ID应大于0");
    
    let info = manager.get_resource(id).expect("应能获取资源信息");
    assert_eq!(info.address, real_memory, "地址应与提供的相匹配");
    assert_eq!(info.resource_type, ResourceType::Buffer, "类型应匹配");
    
    // 在调用cleanup_resource前手动释放内存，避免重复释放
    unsafe {
        // 转换为正确的指针类型并释放
        let _ = Box::from_raw(real_memory as *mut i32);
    }
    
    // 标记资源不拥有内存
    manager.set_resource_ownership(id, false);
    
    // 现在安全地调用cleanup_resource，因为它不会尝试释放内存
    assert!(manager.cleanup_resource(id), "清理API调用应成功");
    assert_eq!(manager.resource_count(), 0, "清理后应无资源");
}

#[test]
fn test_resource_manager_max_allocations() {
    let mut manager = ResourceManager::with_limit(2);
    
    // 注册两个资源（达到限制）
    let id1 = manager.register_resource(vec![1, 2, 3], ResourceType::Buffer);
    let id2 = manager.register_resource(vec![4, 5, 6], ResourceType::Buffer);
    
    assert!(id1 > 0 && id2 > 0, "前两个资源应注册成功");
    assert_eq!(manager.resource_count(), 2, "应跟踪两个资源");
    
    // 尝试注册第三个资源（超出限制）
    let id3 = manager.register_resource(vec![7, 8, 9], ResourceType::Buffer);
    assert_eq!(id3, 0, "超出限制时应返回0");
    assert_eq!(manager.resource_count(), 2, "资源数应保持不变");
}

#[test]
fn test_extractor_code_generation() {
    // 测试基本类型的提取代码生成
    let int_type = TypeInfo::Int(32);
    let code = generate_extractor_code(&int_type, "my_int", "pos")
        .expect("应该成功生成整数提取代码");
    assert!(code.contains("extract_i32_from_data"), "应使用正确的提取函数");
    assert!(code.contains("my_int"), "代码应包含变量名");
    
    // 测试指针类型的提取代码生成
    let ptr_type = TypeInfo::Pointer(Box::new(TypeInfo::Int(8)));
    let code = generate_extractor_code(&ptr_type, "str_ptr", "pos")
        .expect("应该成功生成字符串指针提取代码");
    assert!(code.contains("extract_c_string_from_data"), "应使用C字符串提取函数");
    assert!(code.contains("resource_manager"), "代码应使用资源管理器");
    
    // 测试结构体类型的提取代码生成
    let struct_type = TypeInfo::Struct {
        name: "TestStruct".to_string(),
        fields: vec![TypeInfo::Int(32), TypeInfo::Float],
    };
    let code = generate_extractor_code(&struct_type, "my_struct", "pos")
        .expect("应该成功生成结构体提取代码");
    assert!(code.contains("extract_struct_"), "应使用结构体提取函数");
    assert!(code.contains("resource_manager"), "代码应使用资源管理器");
}

#[test]
fn test_config_defaults() {
    let config = InputConversionConfig::default();
    assert_eq!(config.max_buffer_size, 8192, "默认缓冲区大小应为8192");
    assert_eq!(config.max_allocations, 100, "默认最大分配数应为100");
    assert!(config.deterministic_extraction, "默认应启用确定性提取");
    assert!(config.custom_handlers.is_empty(), "默认不应有自定义处理器");
}

#[test]
fn test_byte_parser() {
    let data = vec![1, 2, 3, 4, 5, 6, 7, 8];
    let mut parser = ByteParser::new(&data);
    
    // 测试基本提取
    assert_eq!(parser.extract_u8().unwrap(), 1);
    assert_eq!(parser.position(), 1);
    
    // 测试多字节提取
    assert_eq!(parser.extract_u16().unwrap(), 0x0302); // 小端序
    assert_eq!(parser.position(), 3);
    
    // 测试边界检查
    parser.skip(3).unwrap(); // 移动到位置6
    assert_eq!(parser.extract_u16().unwrap(), 0x0807);
    assert!(parser.extract_u8().is_err(), "到达数据末尾应返回错误");
    
    // 测试有限数据
    let mut limited_parser = ByteParser::with_limit(&data, 4);
    assert_eq!(limited_parser.extract_u32().unwrap(), 0x04030201);
    assert!(limited_parser.extract_u8().is_err(), "超出限制应返回错误");
}