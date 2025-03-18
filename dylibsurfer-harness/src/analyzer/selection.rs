//! 函数选择系统
//!
//! 根据可测试性、安全关注度和其他标准选择最适合模糊测试的函数

use std::collections::{HashMap, HashSet};
use regex::Regex;
use dylibsurfer_ir::FunctionSignature;
use crate::analyzer::graph::{DependencyGraph, FunctionId};
use crate::analyzer::testability::{ConstructibilityAnalyzer, FunctionTestability};
use crate::analyzer::security::{SecurityInterestScorer, SecurityScore};
use crate::config::FunctionSelectionConfig;
use crate::error::HarnessError;

/// 需要Fuzzing harness的函数集合
#[derive(Debug, Clone)]
pub struct FunctionBundle {
    /// 需要Fuzz的主目标函数
    pub target: FunctionId,
    
    /// 构造参数所需的前置函数
    pub prerequisites: Vec<FunctionId>,
    
    /// 调用顺序（有序前置函数 + 目标函数）
    pub call_sequence: Vec<FunctionId>,
    
    /// 目标函数的安全评分
    pub security_score: u32,
    
    /// 构造复杂度评分
    pub complexity_score: u32,
}

/// 函数选择的配置参数
#[derive(Debug, Clone)]
pub struct SelectionConfig {
    /// 最低安全得分阈值 (0-100)
    pub min_security_score: u32,
    
    /// 最大构造复杂度 (0-100)
    pub max_complexity: u32,
    
    /// 包含函数名的正则表达式模式
    pub include_patterns: Vec<Regex>,
    
    /// 排除函数名的正则表达式模式
    pub exclude_patterns: Vec<Regex>,
    
    /// 最大选择函数数量
    pub max_functions: usize,
    
    /// 安全评分与复杂度的平衡因子
    /// 0 = 仅考虑安全评分
    /// 1 = 仅考虑复杂度（越容易构造）
    pub balance_factor: f32,
}

impl From<&FunctionSelectionConfig> for SelectionConfig {
    fn from(config: &FunctionSelectionConfig) -> Self {
        let include_patterns = config.include_patterns.iter()
            .filter_map(|p| Regex::new(p).ok())
            .collect();
            
        let exclude_patterns = config.exclude_patterns.iter()
            .filter_map(|p| Regex::new(p).ok())
            .collect();
            
        Self {
            min_security_score: (config.min_interest_score * 100.0) as u32,
            max_complexity: 80, // Default
            include_patterns,
            exclude_patterns,
            max_functions: 100, // Default
            balance_factor: 0.5, // Default balance
        }
    }
}

/// 函数选择器 for fuzzing targets
pub struct FunctionSelector {
    /// 依赖关系图
    dependency_graph: DependencyGraph,
    
    /// 安全关注度评分器
    security_scorer: SecurityInterestScorer,
    
    /// 可构造性分析器
    constructibility_analyzer: ConstructibilityAnalyzer,
}

impl FunctionSelector {
    /// 创建新的函数选择器
    pub fn new(
        dependency_graph: DependencyGraph,
        security_scorer: SecurityInterestScorer,
        constructibility_analyzer: ConstructibilityAnalyzer,
    ) -> Self {
        Self {
            dependency_graph,
            security_scorer,
            constructibility_analyzer,
        }
    }
    
    /// 选择最有潜力的函数进行模糊测试
    pub fn select_functions(
        &mut self,
        functions: &[FunctionSignature],
        config: &SelectionConfig,
    ) -> Result<Vec<FunctionBundle>, HarnessError> {
        // 根据名称模式过滤函数
        let filtered_functions = self.filter_functions_by_patterns(functions, config);
        
        // 计算函数安全兴趣评分
        let security_scores = self.security_scorer.score_functions(&filtered_functions);
        
        // 分析函数可测试性
        let testability_results = self.constructibility_analyzer.analyze_functions(&filtered_functions);
        
        // 创建候选集合
        let mut candidates = Vec::new();
        
        for function in &filtered_functions {
            let function_id = &function.name;
            
            // 获取安全评分
            let security_score = match security_scores.get(function_id) {
                Some(score) => score.total_score,
                None => 0,
            };
            
            // 跳过低安全评分函数
            if security_score < config.min_security_score {
                continue;
            }
            
            // 获取可测试性信息
            let testability = match testability_results.get(function_id) {
                Some(t) => t,
                None => continue,
            };
            
            // 跳过不可构造的函数
            if !testability.constructible {
                continue;
            }
            
            // 跳过复杂度过高的函数
            if testability.difficulty_score > config.max_complexity {
                continue;
            }
            
            // 查找前置依赖函数
            let prerequisites = self.dependency_graph.find_prerequisite_calls(function_id);
            
            // 创建调用序列（前置函数 + 目标函数）
            let mut call_sequence = prerequisites.clone();
            call_sequence.push(function_id.clone());
            
            // 创建函数集合
            candidates.push(FunctionBundle {
                target: function_id.clone(),
                prerequisites,
                call_sequence,
                security_score,
                complexity_score: testability.difficulty_score,
            });
        }
        
        // 按加权评分排序候选
        candidates.sort_by(|a, b| {
            let a_score = self.calculate_weighted_score(a, config.balance_factor);
            let b_score = self.calculate_weighted_score(b, config.balance_factor);
            b_score.partial_cmp(&a_score).unwrap() // Higher scores first
        });
        
        // 限制最大选择数量
        let selected = candidates.into_iter()
            .take(config.max_functions)
            .collect();
            
        Ok(selected)
    }
    
    /// 根据正则模式过滤函数
    fn filter_functions_by_patterns(
        &self,
        functions: &[FunctionSignature],
        config: &SelectionConfig,
    ) -> Vec<FunctionSignature> {
        functions.iter()
            .filter(|function| {
                let name = &function.name;
                
                // 如果匹配任意排除模式则跳过
                if config.exclude_patterns.iter().any(|pattern| pattern.is_match(name)) {
                    return false;
                }
                
                // 当包含模式为空时全包含，否则匹配包含模式
                if config.include_patterns.is_empty() ||
                   config.include_patterns.iter().any(|pattern| pattern.is_match(name)) {
                    return true;
                }
                
                false
            })
            .cloned()
            .collect()
    }
    
    /// 计算函数集合的加权评分
    fn calculate_weighted_score(&self, bundle: &FunctionBundle, balance_factor: f32) -> f32 {
        // 安全得分（越高越好）
        let security_component = bundle.security_score as f32;
        
        // 复杂度得分（越低越好）
        let complexity_component = 100.0 - bundle.complexity_score as f32;
        
        // 加权组合计算
        security_component * (1.0 - balance_factor) + complexity_component * balance_factor
    }
}
