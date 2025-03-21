# DylibSurfer 输入转换系统使用指南

输入转换系统是 DylibSurfer 的核心组件，负责将模糊测试器提供的原始字节流转换为结构化函数参数。本指南将帮助您理解和使用这个系统。

## 功能概述

DylibSurfer 的输入转换系统提供以下功能：

- **字节解析**：安全地从字节流中提取各种数据类型
- **类型提取**：为基本类型和复杂结构体提供转换逻辑
- **资源管理**：自动跟踪和清理内存分配，防止资源泄漏
- **状态跟踪**：管理多函数调用之间的对象状态

## 基本使用

### 为单个函数生成参数提取代码

```rust
use dylibsurfer_harness::input_conversion::generate_extractor_code;
use dylibsurfer_ir::{TypeInfo, Parameter};

// 创建参数类型
let param_type = TypeInfo::Pointer(Box::new(TypeInfo::Int(8))); // char*
let param_name = "input_string";
let cursor_var = "cursor";

// 生成提取代码
match generate_extractor_code(&param_type, param_name, cursor_var) {
    Ok(extractor_code) => {
        println!("生成的代码: {}", extractor_code);
        // 输出: let input_string = extract_c_string_from_data(data, &mut cursor, resource_manager);
    },
    Err(e) => println!("生成代码失败: {:?}", e),
}
```

### 使用 HarnessGenerator 生成完整 Harness

当您使用 DylibSurfer 的 `HarnessGenerator` 时，输入转换系统已经集成其中。只需确保在配置中正确设置相关参数：

```rust
use dylibsurfer_harness::{HarnessConfig, HarnessGenerator};
use std::path::Path;

// 创建配置
let config = HarnessConfig::default();

// 创建生成器
let generator = HarnessGenerator::new(&config);

// 生成 harness 代码
let harness_code = generator.generate_harness(&function_signature)?;

// 或生成并写入文件
generator.generate_and_write(&signatures, Path::new("output_dir"))?;
```

生成的 harness 会自动包含输入转换系统的辅助函数和资源管理功能。

## 自定义配置

您可以通过 `InputConversionConfig` 自定义输入转换系统的行为：

```rust
use dylibsurfer_harness::input_conversion::InputConversionConfig;
use std::collections::HashMap;

// 创建自定义配置
let mut custom_handlers = HashMap::new();
custom_handlers.insert(
    "ComplexStruct".to_string(),
    "custom_extraction_logic".to_string()
);

let config = InputConversionConfig {
    max_buffer_size: 4096,         // 最大缓冲区大小
    max_allocations: 50,           // 最大分配数量
    deterministic_extraction: true, // 使用确定性提取
    custom_handlers,               // 自定义类型处理程序
};
```

## 主要数据类型转换

输入转换系统支持以下数据类型的转换：

| C/C++ 类型 | 对应 IR 类型 | 提取函数 |
|------------|---------------|-----------------|
| `int8_t`   | `TypeInfo::Int(8)` | `extract_i8_from_data` |
| `int16_t`  | `TypeInfo::Int(16)` | `extract_i16_from_data` |
| `int32_t`  | `TypeInfo::Int(32)` | `extract_i32_from_data` |
| `int64_t`  | `TypeInfo::Int(64)` | `extract_i64_from_data` |
| `float`    | `TypeInfo::Float` | `extract_float_from_data` |
| `char*`    | `TypeInfo::Pointer(Box::new(TypeInfo::Int(8)))` | `extract_c_string_from_data` |
| `void*`    | `TypeInfo::Pointer(Box::new(TypeInfo::Void))` | `extract_buffer_from_data` |
| `struct*`  | `TypeInfo::Pointer(Box::new(TypeInfo::Struct {...}))` | `extract_typed_pointer_from_data` |

## 资源管理

所有通过输入转换系统分配的内存都会被 `ResourceManager` 跟踪和管理：

```rust
// 生成的 harness 代码中创建资源管理器
let mut resource_manager = ResourceManager::new();

// 资源会在提取过程中自动跟踪
let buffer = extract_buffer_from_data(data, &mut cursor, &mut resource_manager);

// 在函数调用后清理所有资源
resource_manager.cleanup_all();
```

## 实际生成的 Harness 示例

下面是一个使用输入转换系统生成的完整 harness 示例：

```rust
fn harness_process_image(data: &[u8]) -> bool {
    // 检查最小数据大小
    if data.len() < 16 {
        return false;  
    }
    
    // 创建资源管理器
    let mut resource_manager = ResourceManager::new();
    
    // 初始化光标位置
    let mut cursor = 0;
    
    // 提取参数
    let image_data = extract_buffer_from_data(data, &mut cursor, &mut resource_manager);
    let width = extract_i32_from_data(data, &mut cursor);
    let height = extract_i32_from_data(data, &mut cursor);
    let format = extract_i32_from_data(data, &mut cursor);
    
    // 使用异常捕获执行目标函数
    let result = std::panic::catch_unwind(|| {
        unsafe {
            libimage::process_image(image_data, width, height, format)
        }
    });
    
    // 清理所有分配的资源
    resource_manager.cleanup_all();
    
    // 如果函数执行未崩溃，则返回true
    result.is_ok()
}
```

## 与 LibAFL 集成

生成的 harness 可以很容易地与 LibAFL 集成：

```rust
use libafl::prelude::*;

// 使用生成的 harness 作为目标函数
pub fn target(input: &[u8]) -> ExitKind {
    // 调用生成的 harness 函数
    let result = harness_target_function(input);
    
    if result {
        ExitKind::Ok
    } else {
        ExitKind::Crash
    }
}

// 在 LibAFL 模糊测试中使用此目标函数
fn main() {
    let mut fuzzer = ...;  // 配置 LibAFL 模糊器
    fuzzer.fuzz_loop(&mut executor, &mut state, &mut mgr)?;
}
```

## 多函数序列模糊测试

对于需要测试多个函数调用序列的场景，DylibSurfer 的输入转换系统提供了状态跟踪功能：

```rust
// 从原始数据中选择要调用的函数
let function_index = data[0] % funcs.len();
// 剩余数据用作函数参数
let param_data = &data[1..];

// 根据前一次调用的结果选择下一个函数
match function_index {
    0 => harness_init(&param_data, &mut state),
    1 => harness_process(&param_data, &mut state),
    2 => harness_cleanup(&param_data, &mut state),
    _ => false,
}
```

## 故障排除

如果生成的 harness 在执行时遇到问题，可以检查以下几点：

1. **数据不足**：确保模糊测试提供足够的数据来提取所有参数
2. **内存限制**：检查 `max_buffer_size` 和 `max_allocations` 是否设置得太小
3. **类型兼容性**：验证 IR 类型与实际库函数参数类型是否匹配
4. **资源清理**：确保 `resource_manager.cleanup_all()` 在函数返回前调用

## 下一步开发

DylibSurfer 的输入转换系统将继续改进，计划添加的功能包括：

- 更多复杂类型的支持
- 改进结构体嵌套处理
- 支持函数指针和回调
- 基于覆盖率的输入优化