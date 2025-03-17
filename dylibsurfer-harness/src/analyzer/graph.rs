//! 依赖图分析系统
//!
//! 构建并分析库中函数和类型之间的关系

use std::collections::{HashMap, HashSet};
use petgraph::graph::{DiGraph, NodeIndex};
use petgraph::Direction;
use dylibsurfer_ir::{FunctionSignature, TypeInfo};
use crate::error::HarnessError;

/// 函数标识符
pub type FunctionId = String;

/// 类型标识符
pub type TypeId = String;

/// 依赖图中的边类型
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum EdgeKind {
    /// 函数生成此类型（分配/创建）
    Produces,
    /// 函数消费此类型（作为输入）
    Consumes,
    /// 函数修改此类型（改变状态）
    Modifies,
    /// 函数调用另一个函数
    Calls,
    /// 类型包含另一个类型（字段/元素）
    Contains,
}

/// 库函数和类型的依赖图
pub struct DependencyGraph {
    /// 连接函数和类型的图结构
    graph: DiGraph<NodeData, EdgeKind>,
    /// 从函数ID到图节点索引的映射
    function_nodes: HashMap<FunctionId, NodeIndex>,
    /// 从类型ID到图节点索引的映射
    type_nodes: HashMap<TypeId, NodeIndex>,
    /// 生成特定类型的函数
    type_producers: HashMap<TypeId, Vec<FunctionId>>,
    /// 消费/使用特定类型的函数
    type_consumers: HashMap<TypeId, Vec<FunctionId>>,
    /// 修改特定类型的函数
    type_modifiers: HashMap<TypeId, Vec<FunctionId>>,
}

/// 依赖图中的节点数据
#[derive(Debug, Clone)]
pub enum NodeData {
    /// 函数节点
    Function(FunctionSignature),
    /// 类型节点
    Type(TypeInfo),
}

impl DependencyGraph {
    /// 创建一个新的空依赖图
    pub fn new() -> Self {
        Self {
            graph: DiGraph::new(),
            function_nodes: HashMap::new(),
            type_nodes: HashMap::new(),
            type_producers: HashMap::new(),
            type_consumers: HashMap::new(),
            type_modifiers: HashMap::new(),
        }
    }
    
    /// 添加一个函数到图中
    pub fn add_function(&mut self, signature: FunctionSignature) -> NodeIndex {
        let function_id = signature.name.clone();
        // 如果函数已存在，返回其节点索引
        if let Some(&node_idx) = self.function_nodes.get(&function_id) {
            return node_idx;
        }
        // 添加函数节点到图中
        let node_idx = self.graph.add_node(NodeData::Function(signature));
        self.function_nodes.insert(function_id, node_idx);
        node_idx
    }
    
    /// 添加一个类型到图中
    pub fn add_type(&mut self, type_info: TypeInfo) -> NodeIndex {
        let type_id = Self::get_type_id(&type_info);
        // 如果类型已存在，返回其节点索引
        if let Some(&node_idx) = self.type_nodes.get(&type_id) {
            return node_idx;
        }
        // 添加类型节点到图中
        let node_idx = self.graph.add_node(NodeData::Type(type_info));
        self.type_nodes.insert(type_id, node_idx);
        node_idx
    }
    
    /// 连接一个函数到它生成的一个类型
    pub fn add_produces_edge(&mut self, function_id: &FunctionId, type_id: &TypeId) {
        let function_node = self.function_nodes.get(function_id);
        let type_node = self.type_nodes.get(type_id);
        if let (Some(&f_node), Some(&t_node)) = (function_node, type_node) {
            self.graph.add_edge(f_node, t_node, EdgeKind::Produces);
            // 更新类型生成者映射
            self.type_producers
                .entry(type_id.clone())
                .or_default()
                .push(function_id.clone());
        }
    }
    
    /// 连接一个函数到它消费的一个类型
    pub fn add_consumes_edge(&mut self, function_id: &FunctionId, type_id: &TypeId) {
        let function_node = self.function_nodes.get(function_id);
        let type_node = self.type_nodes.get(type_id);
        if let (Some(&f_node), Some(&t_node)) = (function_node, type_node) {
            self.graph.add_edge(t_node, f_node, EdgeKind::Consumes);
            // 更新类型消费者映射
            self.type_consumers
                .entry(type_id.clone())
                .or_default()
                .push(function_id.clone());
        }
    }
    
    /// 连接一个函数到它修改的一个类型
    pub fn add_modifies_edge(&mut self, function_id: &FunctionId, type_id: &TypeId) {
        let function_node = self.function_nodes.get(function_id);
        let type_node = self.type_nodes.get(type_id);
        if let (Some(&f_node), Some(&t_node)) = (function_node, type_node) {
            self.graph.add_edge(f_node, t_node, EdgeKind::Modifies);
            // 更新类型修改者映射
            self.type_modifiers
                .entry(type_id.clone())
                .or_default()
                .push(function_id.clone());
        }
    }
    
    /// 获取所有生成给定类型的函数
    pub fn get_producers_for_type(&self, type_id: &TypeId) -> Vec<FunctionId> {
        self.type_producers.get(type_id).cloned().unwrap_or_default()
    }

    /// 获取所有消费给定类型的函数
    pub fn get_consumers_for_type(&self, type_id: &TypeId) -> Vec<FunctionId> {
        self.type_consumers.get(type_id).cloned().unwrap_or_default()
    }

    /// 获取所有修改给定类型的函数
    pub fn get_modifiers_for_type(&self, type_id: &TypeId) -> Vec<FunctionId> {
        self.type_modifiers.get(type_id).cloned().unwrap_or_default()
    }
    
    /// 查找为目标函数设置参数所需的所有先决条件函数调用
    pub fn find_prerequisite_calls(&self, target: &FunctionId) -> Vec<FunctionId> {
        // 获取函数节点
        let function_node = match self.function_nodes.get(target) {
            Some(&node) => node,
            None => return Vec::new(),
        };
        // 获取函数签名
        let signature = match &self.graph[function_node] {
            NodeData::Function(sig) => sig,
            _ => return Vec::new(),
        };
        let mut prerequisites = HashSet::new();
        let mut visited = HashSet::new();
        // 对于每个参数，查找生成它的函数
        for param in &signature.parameters {
            self.find_producers_for_type(&param.ty, &mut prerequisites, &mut visited);
        }
        // 转换为Vec并移除目标函数（如果存在）
        prerequisites.iter().filter(|&id| id != target).cloned().collect()
    }
    
    /// 递归查找可以生成给定类型值的函数
    fn find_producers_for_type(
        &self,
        type_info: &TypeInfo,
        prerequisites: &mut HashSet<FunctionId>,
        visited: &mut HashSet<TypeId>,
    ) {
        let type_id = Self::get_type_id(type_info);
        // 避免循环
        if visited.contains(&type_id) {
            return;
        }
        visited.insert(type_id.clone());
        // 添加直接生成者
        if let Some(producers) = self.type_producers.get(&type_id) {
            for producer in producers {
                prerequisites.insert(producer.clone());
            }
        }
        // 对于复杂类型，递归查找其组件的生成者
        match type_info {
            TypeInfo::Pointer(inner) => {
                self.find_producers_for_type(inner, prerequisites, visited);
            }
            TypeInfo::Struct { fields, .. } => {
                for field in fields {
                    self.find_producers_for_type(field, prerequisites, visited);
                }
            }
            _ => {}
        }
    }
    
    /// 检查函数的参数是否可以使用可用的API函数构建
    pub fn is_constructible(&self, func_id: &FunctionId) -> bool {
        // 获取函数节点
        let function_node = match self.function_nodes.get(func_id) {
            Some(&node) => node,
            None => return false,
        };
        // 获取函数签名
        let signature = match &self.graph[function_node] {
            NodeData::Function(sig) => sig,
            _ => return false,
        };
        // 检查每个参数
        for param in &signature.parameters {
            if !self.is_type_constructible(&param.ty) {
                return false;
            }
        }
        true
    }
    
    /// 检查类型是否可以使用可用的API函数构建
    fn is_type_constructible(&self, type_info: &TypeInfo) -> bool {
        let type_id = Self::get_type_id(type_info);
        // 如果我们有生成此类型的函数，则它是可构建的
        if !self.get_producers_for_type(&type_id).is_empty() {
            return true;
        }
        // 对于复杂类型，检查其组件是否可构建
        match type_info {
            // 基本类型可以构建
            TypeInfo::Int(_) | TypeInfo::Float | TypeInfo::Void => true,
            // 指针需要其指向的类型可构建
            TypeInfo::Pointer(inner) => self.is_type_constructible(inner),
            // 结构体需要所有字段可构建
            TypeInfo::Struct { fields, .. } => fields.iter().all(|field| self.is_type_constructible(field)),
        }
    }
    
    /// 获取类型的字符串标识符
    pub fn get_type_id(type_info: &TypeInfo) -> TypeId {
        match type_info {
            TypeInfo::Void => "void".to_string(),
            TypeInfo::Int(bits) => format!("int{}", bits),
            TypeInfo::Float => "float".to_string(),
            TypeInfo::Pointer(inner) => format!("ptr_{}", Self::get_type_id(inner)),
            TypeInfo::Struct { name, .. } => {
                if name.is_empty() {
                    // 处理匿名结构体
                    "anonymous_struct".to_string()
                } else {
                    format!("struct_{}", name)
                }
            }
        }
    }
}

/// 库依赖图的构建器
pub struct DependencyGraphBuilder {
    // 可以在此添加配置选项 #todo
}


impl DependencyGraphBuilder {
    /// 创建一个新的依赖图构建器
    pub fn new() -> Self {
        Self {}
    }
    
    /// 从函数签名构建依赖图
    pub fn build(&self, functions: &[FunctionSignature]) -> Result<DependencyGraph, HarnessError> {
        let mut graph = DependencyGraph::new();
        // 第一遍：将所有函数和类型添加到图中
        for function in functions {
            // 添加函数节点
            let func_node = graph.add_function(function.clone());
            // 添加返回类型
            let ret_type_node = graph.add_type(function.return_type.clone());
            // 连接函数到返回类型（生成）
            if !matches!(function.return_type, TypeInfo::Void) {
                let ret_type_id = DependencyGraph::get_type_id(&function.return_type);
                graph.add_produces_edge(&function.name, &ret_type_id);
            }
            // 添加参数类型
            for param in &function.parameters {
                let param_type_node = graph.add_type(param.ty.clone());
                // 连接函数到参数类型（消费）
                let param_type_id = DependencyGraph::get_type_id(&param.ty);
                graph.add_consumes_edge(&function.name, &param_type_id);
                // 如果参数是指针，它可能会被修改
                if let TypeInfo::Pointer(_) = param.ty {
                    graph.add_modifies_edge(&function.name, &param_type_id);
                }
            }
        }
        // 第二遍：分析函数名称以推断关系
        for function in functions {
            self.analyze_function_name(&mut graph, function);
        }
        Ok(graph)
    }
    
    /// 分析函数名称以推断关系?是否不严谨
    fn analyze_function_name(&self, graph: &mut DependencyGraph, function: &FunctionSignature) {
        let name = &function.name;
        // 生成者函数的常见模式
        if name.contains("create") || name.contains("alloc") || name.contains("new") || name.contains("init") || name.contains("open") {
            // 假设函数生成其返回类型
            if !matches!(function.return_type, TypeInfo::Void) {
                let type_id = DependencyGraph::get_type_id(&function.return_type);
                graph.add_produces_edge(&function.name, &type_id);
            }
        }
        // 消费者/销毁者函数的常见模式
        if name.contains("free") || name.contains("destroy") || name.contains("delete") || name.contains("close") || name.contains("release") {
            // 假设函数消费其第一个参数
            if !function.parameters.is_empty() {
                let type_id = DependencyGraph::get_type_id(&function.parameters[0].ty);
                graph.add_consumes_edge(&function.name, &type_id);
            }
        }
        // 修改者函数的常见模式
        if name.contains("set") || name.contains("update") || name.contains("modify") || name.contains("write") {
            // 假设函数修改其第一个参数
            if !function.parameters.is_empty() {
                let type_id = DependencyGraph::get_type_id(&function.parameters[0].ty);
                graph.add_modifies_edge(&function.name, &type_id);
            }
        }
    }
}
