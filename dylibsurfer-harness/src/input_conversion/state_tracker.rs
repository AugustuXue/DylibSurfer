//! 用于跨多个函数调用管理状态的状态跟踪系统
//! 不是运行时组件！！！而是在代码生成时分析函数依赖关系
//!
//! 本模块提供在函数调用间维护状态、跟踪对象生命周期、并确保正确函数调用顺序的机制

use std::collections::HashMap;
use super::resource_manager::ResourceId;
use crate::error::HarnessError;

/// 函数调用的状态信息
#[derive(Debug, Clone)]
pub struct FunctionState {
    /// 函数名称
    pub function_name: String,
    /// 创建对象的资源ID
    pub created_resources: Vec<ResourceId>,
    /// 消费对象的资源ID
    pub consumed_resources: Vec<ResourceId>,
    /// 修改对象的资源ID
    pub modified_resources: Vec<ResourceId>,
    /// 函数特定的状态值
    pub state_values: HashMap<String, String>,
    /// 返回值作为资源ID（如果适用）
    pub return_value: Option<ResourceId>,
}

impl FunctionState {
    /// 为指定函数创建新的FunctionState
    pub fn new(function_name: &str) -> Self {
        Self {
            function_name: function_name.to_string(),
            created_resources: Vec::new(),
            consumed_resources: Vec::new(),
            modified_resources: Vec::new(),
            state_values: HashMap::new(),
            return_value: None,
        }
    }
    
    /// 添加创建的资源
    pub fn add_created_resource(&mut self, resource_id: ResourceId) {
        self.created_resources.push(resource_id);
    }
    
    /// 添加消费的资源
    pub fn add_consumed_resource(&mut self, resource_id: ResourceId) {
        self.consumed_resources.push(resource_id);
    }
    
    /// 添加修改的资源
    pub fn add_modified_resource(&mut self, resource_id: ResourceId) {
        self.modified_resources.push(resource_id);
    }
    
    /// 设置状态值
    pub fn set_state(&mut self, key: &str, value: &str) {
        self.state_values.insert(key.to_string(), value.to_string());
    }
    
    /// 设置返回值
    pub fn set_return_value(&mut self, resource_id: ResourceId) {
        self.return_value = Some(resource_id);
    }
}

/// 跨多个函数调用跟踪状态
#[derive(Debug)]
pub struct StateTracker {
    /// 按执行顺序记录的函数调用状态
    function_states: Vec<FunctionState>,
    /// 资源ID到创建该资源的函数的映射
    resource_creators: HashMap<ResourceId, usize>,
    /// 资源ID到消费该资源的所有函数的映射
    resource_consumers: HashMap<ResourceId, Vec<usize>>,
    /// 全局状态值
    global_state: HashMap<String, String>,
}

impl StateTracker {
    /// 创建新的StateTracker
    pub fn new() -> Self {
        Self {
            function_states: Vec::new(),
            resource_creators: HashMap::new(),
            resource_consumers: HashMap::new(),
            global_state: HashMap::new(),
        }
    }
    
    /// 记录函数调用及其状态
    pub fn record_function_call(&mut self, state: FunctionState) -> usize {
        let function_idx = self.function_states.len();
        
        // 记录资源创建和消费
        for &resource_id in &state.created_resources {
            self.resource_creators.insert(resource_id, function_idx);
        }
        
        for &resource_id in &state.consumed_resources {
            self.resource_consumers
                .entry(resource_id)
                .or_default()
                .push(function_idx);
        }
        
        // 添加函数状态
        self.function_states.push(state);
        
        function_idx
    }
    
    /// 获取指定函数需要调用的所有前置函数
    pub fn get_prerequisite_functions(&self, function_idx: usize) -> Result<Vec<usize>, HarnessError> {
        if function_idx >= self.function_states.len() {
            return Err(HarnessError::GenerationError(
                format!("无效的函数索引: {}", function_idx)
            ));
        }
        
        let mut prerequisites = Vec::new();
        let function_state = &self.function_states[function_idx];
        
        // 查找本函数消费资源的创建者
        for &resource_id in &function_state.consumed_resources {
            if let Some(&creator_idx) = self.resource_creators.get(&resource_id) {
                if creator_idx != function_idx && !prerequisites.contains(&creator_idx) {
                    prerequisites.push(creator_idx);
                    
                    // 递归查找创建者的前置条件
                    let creator_prerequisites = self.get_prerequisite_functions(creator_idx)?;
                    for &prereq_idx in &creator_prerequisites {
                        if !prerequisites.contains(&prereq_idx) {
                            prerequisites.push(prereq_idx);
                        }
                    }
                }
            }
        }
        
        // 按函数索引排序以保持正确顺序
        prerequisites.sort();
        
        Ok(prerequisites)
    }
    
    /// 检查函数所需的所有资源是否可用
    pub fn can_call_function(&self, function_idx: usize) -> bool {
        if function_idx >= self.function_states.len() {
            return false;
        }
        
        let function_state = &self.function_states[function_idx];
        
        // 检查所有消费资源是否已创建
        for &resource_id in &function_state.consumed_resources {
            if !self.resource_creators.contains_key(&resource_id) {
                return false;
            }
        }
        
        true
    }
    
    /// 获取有效的函数调用序列
    pub fn get_valid_call_sequence(&self) -> Vec<usize> {
        let mut sequence = Vec::new();
        let mut available_resources = HashMap::new();
        let mut added = vec![false; self.function_states.len()];
        
        // 持续尝试添加函数直到无法添加
        loop {
            let mut added_any = false;
            
            for i in 0..self.function_states.len() {
                if added[i] {
                    continue;
                }
                
                let function_state = &self.function_states[i];
                let mut can_add = true;
                
                // 检查所有消费资源是否可用
                for &resource_id in &function_state.consumed_resources {
                    if !available_resources.contains_key(&resource_id) {
                        can_add = false;
                        break;
                    }
                }
                
                if can_add {
                    // 添加本函数到序列
                    sequence.push(i);
                    added[i] = true;
                    added_any = true;
                    
                    // 使其创建的资源可用
                    for &resource_id in &function_state.created_resources {
                        available_resources.insert(resource_id, i);
                    }
                    
                    // 如果有返回值也使其可用
                    if let Some(resource_id) = function_state.return_value {
                        available_resources.insert(resource_id, i);
                    }
                }
            }
            
            // 无法继续添加则结束
            if !added_any {
                break;
            }
        }
        
        sequence
    }
    
    /// 设置全局状态值
    pub fn set_global_state(&mut self, key: &str, value: &str) {
        self.global_state.insert(key.to_string(), value.to_string());
    }
    
    /// 获取全局状态值
    pub fn get_global_state(&self, key: &str) -> Option<&String> {
        self.global_state.get(key)
    }
    
    /// 获取所有函数状态
    pub fn get_function_states(&self) -> &[FunctionState] {
        &self.function_states
    }
    
    /// 获取特定函数状态
    pub fn get_function_state(&self, function_idx: usize) -> Option<&FunctionState> {
        self.function_states.get(function_idx)
    }
}

/// 生成状态跟踪工具的代码
pub fn generate_state_tracker_code() -> String {
    r#"
/// Tracks objects created during fuzzing for multi-function sequences
#[derive(Debug)]
pub struct ObjectTracker {
    /// Maps object identifiers to their memory addresses
    objects: std::collections::HashMap<u64, usize>,
    /// Tracks created object types
    object_types: std::collections::HashMap<u64, &'static str>,
    /// Next object ID to assign
    next_id: u64,
}

impl ObjectTracker {
    /// Create a new ObjectTracker
    pub fn new() -> Self {
        Self {
            objects: std::collections::HashMap::new(),
            object_types: std::collections::HashMap::new(),
            next_id: 1,
        }
    }
    
    /// Register an object with the tracker
    pub fn register_object(&mut self, ptr: usize, type_name: &'static str) -> u64 {
        if ptr == 0 {
            return 0; // NULL pointers aren't tracked
        }
        
        let id = self.next_id;
        self.next_id += 1;
        
        self.objects.insert(id, ptr);
        self.object_types.insert(id, type_name);
        
        id
    }
    
    /// Get an object by ID
    pub fn get_object(&self, id: u64) -> Option<usize> {
        self.objects.get(&id).copied()
    }
    
    /// Get an object's type by ID
    pub fn get_object_type(&self, id: u64) -> Option<&'static str> {
        self.object_types.get(&id).copied()
    }
    
    /// Remove an object from tracking
    pub fn remove_object(&mut self, id: u64) -> Option<usize> {
        let ptr = self.objects.remove(&id);
        self.object_types.remove(&id);
        ptr
    }
    
    /// Select a random object of the specified type
    pub fn select_object_of_type(&self, type_name: &str) -> Option<(u64, usize)> {
        let matches: Vec<_> = self.object_types.iter()
            .filter(|(_, &t)| t == type_name)
            .map(|(&id, _)| id)
            .collect();
        
        if matches.is_empty() {
            return None;
        }
        
        // In a real implementation, we would select randomly
        // For determinism, we'll take the first match
        let id = matches[0];
        let ptr = self.objects.get(&id).copied()?;
        
        Some((id, ptr))
    }
}

/// Manages state for multi-function fuzzing sequences
#[derive(Debug)]
pub struct FuzzState {
    /// Object tracker for managing created objects
    pub object_tracker: ObjectTracker,
    /// Resource manager for memory cleanup
    pub resource_manager: ResourceManager,
    /// Custom state values
    pub state_values: std::collections::HashMap<String, String>,
}

impl FuzzState {
    /// Create a new FuzzState
    pub fn new() -> Self {
        Self {
            object_tracker: ObjectTracker::new(),
            resource_manager: ResourceManager::new(),
            state_values: std::collections::HashMap::new(),
        }
    }
    
    /// Set a state value
    pub fn set_state(&mut self, key: &str, value: &str) {
        self.state_values.insert(key.to_string(), value.to_string());
    }
    
    /// Get a state value
    pub fn get_state(&self, key: &str) -> Option<&String> {
        self.state_values.get(key)
    }
    
    /// Clean up resources
    pub fn cleanup(&mut self) {
        self.resource_manager.cleanup_all();
    }
}

impl Drop for FuzzState {
    fn drop(&mut self) {
        self.cleanup();
    }
}
"#.to_string()
}