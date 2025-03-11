//! Harness 生成的文件系统工具

use std::fs;
use std::path::{Path, PathBuf};
use crate::error::HarnessError;

/// 创建路径中的所有目录
/// 
/// # 参数
/// * `path` - 要创建的路径
/// 
/// # 返回值
/// * `Ok(())` - 目录创建成功
/// * `Err(HarnessError)` - 创建目录失败时的错误
pub fn create_dirs(path: &Path) -> Result<(), HarnessError> {
    if !path.exists() {
        fs::create_dir_all(path)?;
    }
    
    Ok(())
}

/// 在目录中查找匹配模式的文件
/// 
/// # 参数
/// * `dir` - 要搜索的目录
/// * `extension` - 要匹配的文件扩展名
/// 
/// # 返回值
/// * `Ok(Vec<PathBuf>)` - 匹配的文件
/// * `Err(HarnessError)` - 搜索文件失败时的错误
pub fn find_files(dir: &Path, extension: &str) -> Result<Vec<PathBuf>, HarnessError> {
    let mut files = Vec::new();
    
    if !dir.exists() || !dir.is_dir() {
        return Ok(files);
    }
    
    for entry in fs::read_dir(dir)? {
        let entry = entry?;
        let path = entry.path();
        
        if path.is_file() {
            if let Some(ext) = path.extension() {
                if ext == extension {
                    files.push(path);
                }
            }
        } else if path.is_dir() {
            let mut subdir_files = find_files(&path, extension)?;
            files.append(&mut subdir_files);
        }
    }
    
    Ok(files)
}

/// 创建具有给定内容的文件
/// 
/// # 参数
/// * `path` - 文件路径
/// * `content` - 文件内容
/// 
/// # 返回值
/// * `Ok(())` - 文件创建成功
/// * `Err(HarnessError)` - 创建文件失败时的错误
pub fn create_file(path: &Path, content: &str) -> Result<(), HarnessError> {
    // 如果父目录不存在，创建它
    if let Some(parent) = path.parent() {
        create_dirs(parent)?;
    }
    
    // 将内容写入文件
    fs::write(path, content)?;
    
    Ok(())
}
