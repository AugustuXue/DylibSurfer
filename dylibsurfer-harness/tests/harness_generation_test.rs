// tests/harness_generation_test.rs

use dylibsurfer_harness::config::HarnessConfig;
use dylibsurfer_harness::generator::HarnessGenerator;
use dylibsurfer_ir::{FunctionSignature, TypeInfo, Parameter};
use tempfile::tempdir;

#[test]
fn test_basic_harness_generation() -> Result<(), Box<dyn std::error::Error>> {
    // 1. 创建临时目录用于输出
    let temp_dir = tempdir()?;
    let output_path = temp_dir.path().to_path_buf();
    
    // 2. 创建配置
    let config = HarnessConfig::default();
    
    // 3. 创建一个简单的函数签名
    let signature = FunctionSignature {
        name: "test_function".to_string(),
        return_type: TypeInfo::Int(32),
        parameters: vec![
            Parameter {
                name: "input".to_string(),
                ty: TypeInfo::Pointer(Box::new(TypeInfo::Int(8))),
            },
            Parameter {
                name: "length".to_string(),
                ty: TypeInfo::Int(32),
            },
        ],
    };
    
    // 4. 创建harness生成器并生成harness
    let generator = HarnessGenerator::new(&config);
    let harness_code = generator.generate_harness(&signature)?;
    // 5. 验证生成的代码包含关键元素
    assert!(harness_code.contains("fn harness_test_function"));
    assert!(harness_code.contains("extract_pointer_from_data"));
    assert!(harness_code.contains("extract_int_from_data"));
    
    // 6. 测试写入文件功能
    generator.generate_and_write(&[signature], &output_path)?;
    let expected_file = output_path.join(format!("{}_harness.rs", config.general.project_name));
    assert!(expected_file.exists());
    
    // 7. 验证生成的文件内容
    let file_content = std::fs::read_to_string(expected_file)?;
    assert!(file_content.contains("fn harness_test_function"));
    
    Ok(())
}
