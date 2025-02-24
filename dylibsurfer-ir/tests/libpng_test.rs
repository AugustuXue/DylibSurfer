use dylibsurfer_ir::*;
use std::path::Path;
use dylibsurfer_ir::{IrParser, type_resolver::ThreadSafeTypeResolver};

#[test]
fn test_parse_libpng() {
    let parser = IrParser::new();
    let sigs = parser.parse_ir_file(Path::new("testdata/libpng.ll")).unwrap();
    
    let json = serde_json::to_string_pretty(&sigs).unwrap();
    std::fs::write("output.json", json).unwrap();

    // 验证关键函数
    let read_row = sigs.iter().find(|f| f.name == "png_read_row").unwrap();
    assert!(matches!(read_row.parameters[0].ty, TypeInfo::Pointer(_)));
}

#[test]
fn test_resolve_png_struct() {
    let parser = IrParser::new();
    let path = std::path::PathBuf::from("testdata/libpng.ll");
    let signatures = parser.parse_ir_file(&path).unwrap();
    
    let resolver = ThreadSafeTypeResolver::new();
    
    // 找到png_struct的签名
    let png_struct = signatures.iter()
        .find(|s| s.name == "png_read_row")
        .unwrap()
        .parameters[0].ty.clone();
    
    let resolved = resolver.resolve_type(&png_struct).unwrap();
    
    // 验证内存布局
    if let type_resolver::ResolvedType::Struct { size, alignment, .. } = resolved {
        assert!(size >= 12); // 根据实际结构体定义调整
        assert_eq!(alignment, 8); // 64位系统指针对齐
    } else {
        panic!("Expected struct type");
    }
}