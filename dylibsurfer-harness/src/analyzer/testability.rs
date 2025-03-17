//! 可测试性分析系统
//!
//! 分析函数以确定它们是否可以被有效测试

use std::collections::{HashMap, HashSet};
use petgraph::graph::{DiGraph, NodeIndex};
use dylibsurfer_ir::{FunctionSignature, TypeInfo};
use crate::analyzer::graph::{DependencyGraph, TypeId, FunctionId};
use crate::error::HarnessError;

/// 用于分析复杂参数构建的类型图
pub struct TypeGraph {
    /// 连接类型及其组件的图结构
    graph: DiGraph<TypeNode, ()>,
    /// 从类型ID到图节点索引的映射
    type_nodes: HashMap<TypeId, NodeIndex>,
    /// 类型元数据信息
    type_metadata: HashMap<TypeId, TypeMetadata>,
}

/// 类型图中的节点
#[derive(Debug, Clone)]
struct TypeNode {
    /// 类型ID
    id: TypeId,
    /// 类型信息
    type_info: TypeInfo,
}

/// 关于类型的元数据
#[derive(Debug, Clone)]
pub struct TypeMetadata {
    /// 近似大小（字节）
    pub size: usize,
    /// 类型复杂度（0-100）
    pub complexity: u32,
    /// 类型是否可以直接构建
    pub directly_constructible: bool,
}

/// 函数可测试性分析
#[derive(Debug, Clone)]
pub struct FunctionTestability {
    /// 函数是否可测试（参数可以构建）
    pub constructible: bool,
    /// 平均参数构建复杂度（0-100）
    pub construction_complexity: u32,
    /// 参数构建所需的生成者函数
    pub required_producers: Vec<FunctionId>,
    /// 参数构建难度排名（0-100）
    /// 0 = 最容易构建（例如，所有基本类型）
    /// 100 = 最难构建（复杂的嵌套结构）
    pub difficulty_score: u32,
}

/// 分析函数的可构建性和参数复杂度
pub struct ConstructibilityAnalyzer {
    /// 用于组件分析的类型图
    type_graph: TypeGraph,
    /// 依赖图
    dependency_graph: DependencyGraph,
}

impl TypeGraph {
    /// 创建一个新的类型图
    pub fn new() -> Self {
        Self {
            graph: DiGraph::new(),
            type_nodes: HashMap::new(),
            type_metadata: HashMap::new(),
        }
    }
    
    /// 添加一个类型到图中并分析其组件
    pub fn add_type(&mut self, type_info: &TypeInfo) -> TypeId {
        let type_id = DependencyGraph::get_type_id(type_info);
        // 如果已经处理过此类型，返回其ID
        if self.type_nodes.contains_key(&type_id) {
            return type_id;
        }
        // 添加类型节点
        let node_idx = self.graph.add_node(TypeNode {
            id: type_id.clone(),
            type_info: type_info.clone(),
        });
        self.type_nodes.insert(type_id.clone(), node_idx);
        // 计算类型元数据
        let metadata = self.calculate_type_metadata(type_info);
        self.type_metadata.insert(type_id.clone(), metadata);
        // 处理组件类型并添加边
        match type_info {
            TypeInfo::Pointer(inner) => {
                let inner_id = self.add_type(inner);
                self.add_component_edge(&type_id, &inner_id);
            }
            TypeInfo::Struct { fields, .. } => {
                for field in fields {
                    let field_id = self.add_type(field);
                    self.add_component_edge(&type_id, &field_id);
                }
            }
            _ => {} // 基本类型没有组件
        }
        type_id
    }
    
    /// 添加从类型到组件类型的边
    fn add_component_edge(&mut self, parent_id: &TypeId, component_id: &TypeId) {
        if let (Some(&parent_node), Some(&component_node)) = (self.type_nodes.get(parent_id), self.type_nodes.get(component_id)) {
            self.graph.add_edge(parent_node, component_node, ());
        }
    }
    
    /// 计算类型的元数据
    fn calculate_type_metadata(&self, type_info: &TypeInfo) -> TypeMetadata {
        match type_info {
            TypeInfo::Void => TypeMetadata {
                size: 0,
                complexity: 0,
                directly_constructible: true,
            },
            TypeInfo::Int(_) => TypeMetadata {
                size: 4, // Approximate
                complexity: 10,
                directly_constructible: true,
            },
            TypeInfo::Float => TypeMetadata {
                size: 4,
                complexity: 10,
                directly_constructible: true,
            },
            TypeInfo::Pointer(inner) => {
                let inner_complexity = match self.get_type_metadata(inner) {
                    Some(metadata) => metadata.complexity,
                    None => 50, // Default if metadata not found
                };
                
                TypeMetadata {
                    size: 8, // 64-bit pointer
                    complexity: inner_complexity + 20,
                    directly_constructible: false,
                }
            },
            TypeInfo::Struct { fields, .. } => {
                let mut total_size = 0;
                let mut max_complexity = 0;
                
                for field in fields {
                    if let Some(metadata) = self.get_type_metadata(field) {
                        total_size += metadata.size;
                        max_complexity = max_complexity.max(metadata.complexity);
                    }
                }
                
                TypeMetadata {
                    size: total_size,
                    complexity: 30 + max_complexity.min(70), // Cap at 100
                    directly_constructible: false,
                }
            },
        }
    }
    
    /// 获取类型的元数据
    fn get_type_metadata(&self, type_info: &TypeInfo) -> Option<TypeMetadata> {
        let type_id = DependencyGraph::get_type_id(type_info);
        self.type_metadata.get(&type_id).cloned()
    }
}

impl ConstructibilityAnalyzer {
    /// 创建一个新的可构建性分析器
    pub fn new(dependency_graph: DependencyGraph) -> Self {
        Self {
            type_graph: TypeGraph::new(),
            dependency_graph,
        }
    }
    
    /// 分析函数的可测试性
    pub fn analyze_function(&mut self, function: &FunctionSignature) -> FunctionTestability {
        let mut parameter_complexity = 0;
        let mut total_parameters = 0;
        let mut directly_constructible = true;
        let mut required_producers = HashSet::new();
        
        // 分析每个参数
        for param in &function.parameters {
            total_parameters += 1;
            
            // 将类型添加到类型图中
            let type_id = self.type_graph.add_type(&param.ty);
            
            // 获取参数复杂度
            let metadata = self.type_graph.type_metadata.get(&type_id).cloned();
            if let Some(metadata) = metadata {
                parameter_complexity += metadata.complexity;
                
                if !metadata.directly_constructible {
                    // 查找生成者函数
                    let producers = self.dependency_graph.get_producers_for_type(&type_id);
                    if producers.is_empty() {
                        directly_constructible = false;
                    } else {
                        for producer in producers {
                            required_producers.insert(producer);
                        }
                    }
                }
            }
        }
        
        // 计算平均复杂度
        let avg_complexity = if total_parameters > 0 {
            parameter_complexity / total_parameters
        } else {
            0
        };
        
        // 根据复杂度和可构建性计算难度分数
        let difficulty_score = if !directly_constructible {
            90 // 如果不可直接构建，则难度非常高
        } else {
            (avg_complexity as f32 * 0.8) as u32 // 根据复杂度缩放
        };
        
        FunctionTestability {
            constructible: directly_constructible,
            construction_complexity: avg_complexity,
            required_producers: required_producers.into_iter().collect(),
            difficulty_score,
        }
    }
    
    /// 分析多个函数并返回排序后的结果
    pub fn analyze_functions(&mut self, functions: &[FunctionSignature]) 
        -> HashMap<FunctionId, FunctionTestability> {
        let mut results = HashMap::new();
        
        for function in functions {
            let testability = self.analyze_function(function);
            results.insert(function.name.clone(), testability);
        }
        
        results
    }
}
