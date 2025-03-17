//! DylibSurfer 的模糊测试 harness 生成器
//! 
//! 本 crate 提供基于 LLVM IR 解析的 C/C++ 库函数自动 harness 生成功能。
//! 生成的 harness 可以与 LibAFL 集成用于模糊测试。

pub mod error;
pub mod config;
pub mod template;
pub mod generator;
pub mod utils;
pub mod analyzer;

use dylibsurfer_ir::FunctionSignature;
use std::path::Path;

use crate::config::HarnessConfig;
use crate::generator::HarnessGenerator;

/// 为给定的库函数生成模糊测试 harness
/// 
/// # 参数
/// * `signatures` - 要生成 harness 的函数签名列表
/// * `config` - harness 生成配置
/// * `output_dir` - 生成 harness 的输出目录
/// 
/// # 返回值
/// * `Ok(())` - harness 生成成功
/// * `Err(error::HarnessError)` - 生成过程中发生错误
pub fn generate_harnesses(
    signatures: &[FunctionSignature],
    config: &HarnessConfig,
    output_dir: &Path,
) -> Result<(), error::HarnessError> {
    let generator = HarnessGenerator::new(config);
    generator.generate_and_write(signatures, output_dir)
}
