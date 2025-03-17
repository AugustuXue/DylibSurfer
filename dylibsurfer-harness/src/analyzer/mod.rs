//! 函数分析和智能选择系统
//!
//! 该模块提供了分析库、构建依赖图、评估函数可测试性以及选择最有前途的函数进行模糊测试的功能。

mod graph;
mod testability;
// mod security;
// mod selection;
// mod visualization;

// // 重新导出主要组件
// pub use graph::{DependencyGraph, DependencyGraphBuilder, FunctionId, TypeId};
// pub use testability::{FunctionTestability, TypeGraph, ConstructibilityAnalyzer};
// pub use security::{SecurityInterestScorer, SecurityScore, VulnPattern};
// pub use selection::{FunctionSelector, FunctionBundle, SelectionConfig};