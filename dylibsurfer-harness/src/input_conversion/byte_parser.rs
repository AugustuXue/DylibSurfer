//! 核心字节解析系统，用于从Fuzzer提供的字节数组中提取数据
//!
//! 此模块提供了从字节数组中安全提取各种基本数据类型的基本功能，同时管理光标位置跟边界检查

use std::convert::TryInto;
use crate::error::HarnessError;

/// 管理从字节数组中提取数据，带有光标跟踪和边界检查功能
#[derive(Debug)]
pub struct ByteParser<'a> {
    /// 正在解析的数据的引用
    data: &'a [u8],
    /// 数据中的当前位置
    cursor: usize,
    /// 最大读取位置（用于限制消耗）
    max_position: usize,
}

impl<'a> ByteParser<'a> {
    /// 从给定的数据切片创建一个新的 ByteParser
    pub fn new(data: &'a [u8]) -> Self {
        Self {
            data,
            cursor: 0,
            max_position: data.len(),
        }
    }
    
    /// 创建一个 ByteParser，限制可以消耗的数据量
    pub fn with_limit(data: &'a [u8], limit: usize) -> Self {
        let max_pos = data.len().min(limit);
        Self {
            data,
            cursor: 0,
            max_position: max_pos,
        }
    }
    
    /// 获取当前光标位置
    pub fn position(&self) -> usize {
        self.cursor
    }
    
    /// 检查是否还有更多数据可用
    pub fn has_remaining(&self) -> bool {
        self.cursor < self.max_position
    }
    
    /// 获取剩余的可用字节数
    pub fn remaining(&self) -> usize {
        self.max_position.saturating_sub(self.cursor)
    }
    
    /// 从数据中提取一个字节
    pub fn extract_u8(&mut self) -> Result<u8, HarnessError> {
        if !self.has_remaining() {
            return Err(HarnessError::GenerationError("已到达输入数据末尾".to_string()));
        }
        
        let value = self.data[self.cursor];
        self.cursor += 1;
        Ok(value)
    }
    
    /// 从数据中提取一个布尔值
    pub fn extract_bool(&mut self) -> Result<bool, HarnessError> {
        Ok(self.extract_u8()? != 0)
    }
    
    /// 以小端格式从数据中提取一个 u16 值
    pub fn extract_u16(&mut self) -> Result<u16, HarnessError> {
        if self.remaining() < 2 {
            return Err(HarnessError::GenerationError(
                "没有足够的数据来提取 u16".to_string()
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + 2];
        self.cursor += 2;
        
        let value = u16::from_le_bytes(bytes.try_into().unwrap());
        Ok(value)
    }
    
    /// 以小端格式从数据中提取一个 u32 值
    pub fn extract_u32(&mut self) -> Result<u32, HarnessError> {
        if self.remaining() < 4 {
            return Err(HarnessError::GenerationError(
                "Not enough data to extract u32".to_string()
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + 4];
        self.cursor += 4;
        
        let value = u32::from_le_bytes(bytes.try_into().unwrap());
        Ok(value)
    }
    
    /// 以小端格式从数据中提取一个 u64 值
    pub fn extract_u64(&mut self) -> Result<u64, HarnessError> {
        if self.remaining() < 8 {
            return Err(HarnessError::GenerationError(
                "Not enough data to extract u64".to_string()
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + 8];
        self.cursor += 8;
        
        let value = u64::from_le_bytes(bytes.try_into().unwrap());
        Ok(value)
    }
    
    /// 从数据中提取一个 i8 值
    pub fn extract_i8(&mut self) -> Result<i8, HarnessError> {
        Ok(self.extract_u8()? as i8)
    }
    
    /// 以小端格式从数据中提取一个 i16 值
    pub fn extract_i16(&mut self) -> Result<i16, HarnessError> {
        Ok(self.extract_u16()? as i16)
    }
    
    /// 以小端格式从数据中提取一个 i32 值
    pub fn extract_i32(&mut self) -> Result<i32, HarnessError> {
        Ok(self.extract_u32()? as i32)
    }
    
    /// 以小端格式从数据中提取一个 i64 值
    pub fn extract_i64(&mut self) -> Result<i64, HarnessError> {
        Ok(self.extract_u64()? as i64)
    }
    
    /// 以 IEEE 754 格式从数据中提取一个 f32 值
    pub fn extract_f32(&mut self) -> Result<f32, HarnessError> {
        if self.remaining() < 4 {
            return Err(HarnessError::GenerationError(
                "Not enough data to extract f32".to_string()
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + 4];
        self.cursor += 4;
        
        let value = f32::from_le_bytes(bytes.try_into().unwrap());
        Ok(value)
    }
    
    /// 以 IEEE 754 格式从数据中提取一个 f64 值
    pub fn extract_f64(&mut self) -> Result<f64, HarnessError> {
        if self.remaining() < 8 {
            return Err(HarnessError::GenerationError(
                "Not enough data to extract f64".to_string()
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + 8];
        self.cursor += 8;
        
        let value = f64::from_le_bytes(bytes.try_into().unwrap());
        Ok(value)
    }
    
    /// 提取一个指定大小的字节缓冲区
    pub fn extract_bytes(&mut self, length: usize) -> Result<&'a [u8], HarnessError> {
        if length == 0 {
            return Ok(&[]);
        }
        
        if self.remaining() < length {
            return Err(HarnessError::GenerationError(
                format!("Not enough data to extract {} bytes", length)
            ));
        }
        
        let bytes = &self.data[self.cursor..self.cursor + length];
        self.cursor += length;
        
        Ok(bytes)
    }
    
    /// 提取一个可变大小的字节缓冲区（长度由数据决定）
    pub fn extract_variable_bytes(&mut self, max_length: usize) -> Result<&'a [u8], HarnessError> {
        if !self.has_remaining() {
            return Ok(&[]);
        }
        
        // 第一个字节决定了长度为 max_length 的百分比
        let percentage = self.extract_u8()? as f32 / 255.0;
        let length = (percentage * max_length as f32).ceil() as usize;
        let actual_length = length.min(self.remaining());
        
        self.extract_bytes(actual_length)
    }
    
    /// 提取一个以 null 结尾的字符串（C 字符串）
    pub fn extract_c_string(&mut self, max_length: usize) -> Result<&'a [u8], HarnessError> {
        if !self.has_remaining() {
            return Ok(&[]);
        }
        
        let start = self.cursor;
        let mut end = start;
        let limit = (start + max_length).min(self.max_position);
        
        while end < limit {
            if self.data[end] == 0 {
                break;
            }
            end += 1;
        }
        
        // 如果有空间，始终包含 null 终止符
        if end < limit {
            end += 1;
        }
        
        let bytes = &self.data[start..end];
        self.cursor = end;
        
        Ok(bytes)
    }
    
    /// 在数据流中向前跳过
    pub fn skip(&mut self, count: usize) -> Result<(), HarnessError> {
        if self.remaining() < count {
            return Err(HarnessError::GenerationError(
                format!("Cannot skip {} bytes, only {} remaining", count, self.remaining())
            ));
        }
        
        self.cursor += count;
        Ok(())
    }
    
    /// 将光标对齐到指定的字节边界
    pub fn align_to(&mut self, alignment: usize) -> Result<(), HarnessError> {
        if alignment == 0 || alignment == 1 {
            return Ok(());
        }
        
        let misalignment = self.cursor % alignment;
        if misalignment > 0 {
            let padding = alignment - misalignment;
            self.skip(padding)?;
        }
        
        Ok(())
    }
    
    /// 通过缩放字节值来提取范围内的值
    pub fn extract_range<T>(&mut self, min: T, max: T) -> Result<T, HarnessError> 
    where 
        T: std::ops::Sub<Output = T> + std::ops::Add<Output = T> + std::ops::Mul<Output = T> + 
           Copy + From<f32>
    {
        let byte = self.extract_u8()? as f32;
        let factor = byte / 255.0;
        let range: T = max - min;
        let scaled = T::from(factor) * range;
        Ok(min + scaled)
    }
}

/// 生成 ByteParser 的代码
pub fn generate_byte_parser_code() -> String {
    r#"
/// 从数据中提取一个字节并推进光标
fn extract_u8_from_data(data: &[u8], cursor: &mut usize) -> u8 {
    if *cursor >= data.len() {
        return 0;
    }
    let value = data[*cursor];
    *cursor += 1;
    value
}

/// 从数据中提取一个 i8 并推进光标
fn extract_i8_from_data(data: &[u8], cursor: &mut usize) -> i8 {
    extract_u8_from_data(data, cursor) as i8
}

/// 从数据中提取一个布尔值并推进光标
fn extract_bool_from_data(data: &[u8], cursor: &mut usize) -> bool {
    extract_u8_from_data(data, cursor) != 0
}

/// 从数据中提取一个 u16 并推进光标
fn extract_u16_from_data(data: &[u8], cursor: &mut usize) -> u16 {
    if *cursor + 2 > data.len() {
        return 0;
    }
    let value = u16::from_le_bytes([
        data[*cursor],
        data[*cursor + 1],
    ]);
    *cursor += 2;
    value
}

/// 从数据中提取一个 i16 并推进光标
fn extract_i16_from_data(data: &[u8], cursor: &mut usize) -> i16 {
    extract_u16_from_data(data, cursor) as i16
}

/// 从数据中提取一个 u32 并推进光标
fn extract_u32_from_data(data: &[u8], cursor: &mut usize) -> u32 {
    if *cursor + 4 > data.len() {
        return 0;
    }
    let value = u32::from_le_bytes([
        data[*cursor],
        data[*cursor + 1],
        data[*cursor + 2],
        data[*cursor + 3],
    ]);
    *cursor += 4;
    value
}

/// 从数据中提取一个 i32 并推进光标
fn extract_i32_from_data(data: &[u8], cursor: &mut usize) -> i32 {
    extract_u32_from_data(data, cursor) as i32
}

/// 从数据中提取一个 u64 并推进光标
fn extract_u64_from_data(data: &[u8], cursor: &mut usize) -> u64 {
    if *cursor + 8 > data.len() {
        return 0;
    }
    let value = u64::from_le_bytes([
        data[*cursor],
        data[*cursor + 1],
        data[*cursor + 2],
        data[*cursor + 3],
        data[*cursor + 4],
        data[*cursor + 5],
        data[*cursor + 6],
        data[*cursor + 7],
    ]);
    *cursor += 8;
    value
}

/// 从数据中提取一个 i64 并推进光标
fn extract_i64_from_data(data: &[u8], cursor: &mut usize) -> i64 {
    extract_u64_from_data(data, cursor) as i64
}

/// 从数据中提取一个 f32 并推进光标
fn extract_float_from_data(data: &[u8], cursor: &mut usize) -> f32 {
    if *cursor + 4 > data.len() {
        return 0.0;
    }
    let value = f32::from_le_bytes([
        data[*cursor],
        data[*cursor + 1],
        data[*cursor + 2],
        data[*cursor + 3],
    ]);
    *cursor += 4;
    value
}

/// 从数据中提取一个 f64 并推进光标
fn extract_double_from_data(data: &[u8], cursor: &mut usize) -> f64 {
    if *cursor + 8 > data.len() {
        return 0.0;
    }
    let value = f64::from_le_bytes([
        data[*cursor],
        data[*cursor + 1],
        data[*cursor + 2],
        data[*cursor + 3],
        data[*cursor + 4],
        data[*cursor + 5],
        data[*cursor + 6],
        data[*cursor + 7],
    ]);
    *cursor += 8;
    value
}

/// 在数据流中跳过一些字节
fn skip_bytes(data: &[u8], cursor: &mut usize, count: usize) {
    let new_cursor = (*cursor + count).min(data.len());
    *cursor = new_cursor;
}

/// 将光标对齐到指定的字节边界
fn align_cursor(cursor: &mut usize, alignment: usize) {
    if alignment <= 1 {
        return;
    }
    let misalignment = *cursor % alignment;
    if misalignment > 0 {
        *cursor += alignment - misalignment;
    }
}
"#.to_string()
}