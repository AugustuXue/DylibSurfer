//! 安全关注度评分系统
//!
//! 分析函数中使其成为安全导向模糊测试关注目标的特性

use std::collections::HashMap;
use regex::Regex;
use dylibsurfer_ir::{FunctionSignature, TypeInfo};
use crate::analyzer::graph::FunctionId;
use crate::error::HarnessError;

/// 漏洞模式权重配置
#[derive(Debug, Clone)]
pub enum VulnPattern {
    /// 内存相关模式
    Memory(String),
    /// 字符串处理模式
    String(String),
    /// 整数处理模式
    Integer(String),
    /// 资源处理模式
    Resource(String),
}
/// 函数的安全关注度评分
#[derive(Debug, Clone)]
pub struct SecurityScore {
    /// 总体安全评分（0-100）
    pub total_score: u32,
    
    /// 内存操作评分
    pub memory_score: u32,
    
    /// 指针操作评分
    pub pointer_score: u32,
    
    /// 字符串处理评分
    pub string_score: u32,
    
    /// 整数操作评分
    pub integer_score: u32,
    
    /// 资源处理评分
    pub resource_score: u32,
    
    /// 检测到的漏洞模式
    pub vulnerability_patterns: Vec<VulnPattern>,
}

/// Fuzzing关注度打分
pub struct SecurityInterestScorer {
    /// 内存相关函数名称的正则表达式
    memory_patterns: Vec<Regex>,
    
    /// 字符串相关函数名称的正则表达式
    string_patterns: Vec<Regex>,
    
    /// 整数相关函数名称的正则表达式
    integer_patterns: Vec<Regex>,
    
    /// 资源相关函数名称的正则表达式
    resource_patterns: Vec<Regex>,
}

impl SecurityInterestScorer {
    /// 创建一个新的安全关注度评分器
    pub fn new() -> Result<Self, HarnessError> {
        Ok(Self {
            memory_patterns: vec![
                Regex::new(r"mem(cpy|move|set|cmp)").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"str(cpy|cat|ncat)").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"alloc|realloc|calloc|malloc|free").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"buffer|copy|move|append").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
            ],
            
            string_patterns: vec![
                Regex::new(r"str[a-z]*").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"format|printf|sprintf|snprintf").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"parse|tokenize|split").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
            ],
            
            integer_patterns: vec![
                Regex::new(r"(add|sub|mul|div|mod)[a-z]*").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"int(to|from)|convert").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"atoi|itoa|strtol").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
            ],
            
            resource_patterns: vec![
                Regex::new(r"open|close|read|write").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"file|socket|connect|accept").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
                Regex::new(r"lock|unlock|mutex|semaphore").map_err(|e| HarnessError::ConfigError(e.to_string()))?,
            ],
        })
    }
    
    /// 为函数安全关注度打分
    pub fn score_function(&self, function: &FunctionSignature) -> SecurityScore {
        // 各方面打分
        let memory_score = self.score_memory_operations(function);
        let pointer_score = self.score_pointer_operations(function);
        let string_score = self.score_string_operations(function);
        let integer_score = self.score_integer_operations(function);
        let resource_score = self.score_resource_operations(function);
        
        // 检测漏洞模式
        let vuln_patterns = self.detect_vulnerability_patterns(function);
        
        // 使用适当的权重计算总分
        let total_score = 
            memory_score * 3 +   // Weight: 30%
            pointer_score * 3 +  // Weight: 30%
            string_score * 2 +   // Weight: 20%
            integer_score * 1 +  // Weight: 10%
            resource_score * 1;  // Weight: 10%
        
        // 归一化到0-100范围
        let total_score = total_score / 10;
        
        SecurityScore {
            total_score,
            memory_score,
            pointer_score,
            string_score,
            integer_score,
            resource_score,
            vulnerability_patterns: vuln_patterns,
        }
    }
    
    /// 为函数中的内存操作打分
    fn score_memory_operations(&self, function: &FunctionSignature) -> u32 {
        let mut score = 0;
        
        // 检查函数名称是否匹配内存模式
        for pattern in &self.memory_patterns {
            if pattern.is_match(&function.name) {
                score += 30;
                break;
            }
        }
        
        // 检查void*参数，通常表示内存操作
        for param in &function.parameters {
            if let TypeInfo::Pointer(inner) = &param.ty {
                if matches!(**inner, TypeInfo::Void) {
                    score += 20;
                }
            }
        }
        
        // 检查size_t或int参数，可能是缓冲区大小
        if function.parameters.iter().any(|p| matches!(p.ty, TypeInfo::Int(_))) {
            score += 10;
        }
        
        // 评分上限为100
        score.min(100)
    }
    
    /// 为函数中的指针操作打分
    fn score_pointer_operations(&self, function: &FunctionSignature) -> u32 {
        let mut score = 0;
        
        // 统计指针参数数量
        let ptr_count = function.parameters.iter()
            .filter(|p| matches!(p.ty, TypeInfo::Pointer(_)))
            .count();
        
        // 根据指针数量评分
        score += (ptr_count as u32) * 20;
        
        // 双指针额外加分
        let double_ptr_count = function.parameters.iter()
            .filter(|p| {
                if let TypeInfo::Pointer(inner) = &p.ty {
                    matches!(**inner, TypeInfo::Pointer(_))
                } else {
                    false
                }
            })
            .count();
        
        score += (double_ptr_count as u32) * 30;
        
        // 评分上限为100
        score.min(100)
    }
    
    /// 字符串评分
    fn score_string_operations(&self, function: &FunctionSignature) -> u32 {
        let mut score = 0;
        
        // Check function name against string patterns
        for pattern in &self.string_patterns {
            if pattern.is_match(&function.name) {
                score += 40;
                break;
            }
        }
        
        // Check for char* parameters which often indicate string operations
        for param in &function.parameters {
            if let TypeInfo::Pointer(inner) = &param.ty {
                if let TypeInfo::Int(bits) = **inner {
                    if bits == 8 {
                        score += 30;
                    }
                }
            }
        }
        
        // Cap score at 100
        score.min(100)
    }
    
    /// 整数操作评分
    fn score_integer_operations(&self, function: &FunctionSignature) -> u32 {
        let mut score = 0;
        
        // 检查函数名称是否匹配整数模式
        for pattern in &self.integer_patterns {
            if pattern.is_match(&function.name) {
                score += 30;
                break;
            }
        }
        
        // 检查多个整数参数
        let int_count = function.parameters.iter()
            .filter(|p| matches!(p.ty, TypeInfo::Int(_)))
            .count();
        
        score += (int_count as u32) * 15;
        
        // 整数返回值
        if matches!(function.return_type, TypeInfo::Int(_)) {
            score += 20;
        }
        
        // 评分上限100
        score.min(100)
    }
    
    /// 评分函数中的资源操作
    fn score_resource_operations(&self, function: &FunctionSignature) -> u32 {
        let mut score = 0;
        
        // 检查函数名称是否匹配资源模式
        for pattern in &self.resource_patterns {
            if pattern.is_match(&function.name) {
                score += 50;
                break;
            }
        }
        
        // 评分上限为100
        score.min(100)
    }
    
    /// 检测函数中的潜在漏洞模式
    fn detect_vulnerability_patterns(&self, function: &FunctionSignature) -> Vec<VulnPattern> {
        let mut patterns = Vec::new();
        
        // 内存漏洞模式
        if self.memory_patterns.iter().any(|p| p.is_match(&function.name)) {
            patterns.push(VulnPattern::Memory(function.name.clone()));
        }
        
        // 字符串漏洞模式
        if self.string_patterns.iter().any(|p| p.is_match(&function.name)) {
            patterns.push(VulnPattern::String(function.name.clone()));
        }
        
        // 整数漏洞模式
        if self.integer_patterns.iter().any(|p| p.is_match(&function.name)) {
            patterns.push(VulnPattern::Integer(function.name.clone()));
        }
        
        // 资源漏洞模式
        if self.resource_patterns.iter().any(|p| p.is_match(&function.name)) {
            patterns.push(VulnPattern::Resource(function.name.clone()));
        }
        
        patterns
    }
    
    /// 为多个函数评分并返回排序后的评分
    pub fn score_functions(&self, functions: &[FunctionSignature]) 
        -> HashMap<FunctionId, SecurityScore> {
        let mut scores = HashMap::new();
        
        for function in functions {
            let score = self.score_function(function);
            scores.insert(function.name.clone(), score);
        }
        
        scores
    }
}
