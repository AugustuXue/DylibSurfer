//! FFI 绑定生成器模块，负责将 IR 解析的类型和函数签名转换为 Rust FFI 代码。

pub mod ffi;
pub mod types;
pub mod safe_wrapper;
pub mod utils;

// 重新导出主要组件，便于外部使用
pub use ffi::FfiGenerator;
pub use types::TypeGenerator;
pub use safe_wrapper::SafeWrapperGenerator;

