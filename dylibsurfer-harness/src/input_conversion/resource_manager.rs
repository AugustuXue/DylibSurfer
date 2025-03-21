//! 资源管理器，负责跟踪和清理测试过程中创建的资源,例如内存缓冲区、字符串、文件指针等
//! 通过跟踪资源的分配和释放，确保在测试结束后资源被正确清理，同时支持自定义清理逻辑以适应不同的资源类型
use std::collections::HashMap;
use libc;

pub type ResourceId = u64;

/// 定义被测代码可能创建的资源类型枚举
/// 
/// 该枚举用于跟踪通过FFI边界分配的不同类型资源，确保正确的生命周期管理。
/// 在模糊测试过程中，当被测代码通过C API创建资源时，参数提取器需要标识资源类型，
/// 以便测试结束后执行正确的清理策略。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ResourceType {
    /// 内存缓冲区（如通过 malloc 分配的字节数组）
    Buffer,
    /// C 风格字符串（以 null 结尾）
    String,
    /// 通用对象指针
    Object,
    /// 文件指针（如 FILE*）
    File,
    /// 允许定义自定义资源类型，通过 u32 值区分
    Custom(u32),
}

/// 存储单个资源的元信息，用于跟踪和管理
#[derive(Debug, Clone)]
pub struct ResourceInfo {
    /// 资源在内存中的地址（通常是 malloc 返回的指针地址）
    pub address: usize,
    /// 资源的类型（如 Buffer 或 File）
    pub resource_type: ResourceType,
    /// 资源的大小（字节数，仅对某些类型如 Buffer 有意义）
    pub size: usize,
    /// 布尔值，表示 ResourceManager 是否负责释放内存
    pub owns_memory: bool,
    /// 可选的自定义清理函数名称（字符串形式），用于 Custom 类型资源
    pub custom_cleanup: Option<String>,
}

/// 核心资源管理器，负责存储和操作所有注册的资源
#[derive(Debug)]
pub struct ResourceManager {
    /// 存储所有资源信息
    resources: HashMap<ResourceId, ResourceInfo>,
    /// 下一个可用的资源 ID，递增分配
    next_id: ResourceId,
    /// 最大允许的资源分配数量，防止资源过多导致内存耗尽
    max_allocations: usize,
}

impl ResourceManager {
    /// 创建默认配置的 ResourceManager，最大分配数为 100
    pub fn new() -> Self {
        Self {
            resources: HashMap::new(),
            next_id: 1, 
            max_allocations: 100,
        }
    }

    /// 创建ResourceManager,允许用户指定最大分配数
    pub fn with_limit(max_allocations: usize) -> Self {
        Self {
            resources: HashMap::new(),
            next_id: 1,
            max_allocations,
        }
    }

    /// 从输入数据（如 Vec<u8>）注册一个新资源，分配内存并复制数据
    pub fn register_resource(&mut self, data: Vec<u8>, resource_type: ResourceType) -> ResourceId {
        // 检查是否达到分配上限或数据为空
        if self.resources.len() >= self.max_allocations {
            return 0;
        }

        let size = data.len();
        if size == 0 {
            return 0; // 不允许空资源
        }

        // 分配内存并存储数据
        let address = unsafe {
            let ptr = libc::malloc(size) as *mut u8;
            if ptr.is_null() {
                return 0; // 内存分配失败
            }
            
            // 复制数据到分配的内存
            std::ptr::copy_nonoverlapping(data.as_ptr(), ptr, size);
            ptr as usize
        };

        let id = self.next_id;
        self.next_id += 1;
        
        self.resources.insert(id, ResourceInfo {
            address,
            resource_type,
            size,
            owns_memory: true,
            custom_cleanup: None,
        });

        id
    }

    /// 跟踪已有内存地址的资源（如外部分配的指针），不负责分配内存
    pub fn track_allocation(&mut self, address: usize, resource_type: ResourceType) -> ResourceId {
        if self.resources.len() >= self.max_allocations || address == 0 {
            return 0;
        }

        let id = self.next_id;
        self.next_id += 1;
        
        self.resources.insert(id, ResourceInfo {
            address,
            resource_type,
            size: 0, // 外部分配，大小未知
            owns_memory: true,
            custom_cleanup: None,
        });
        
        id
    }

    /// 跟踪资源并指定大小和自定义清理函数，适用于需要特殊清理逻辑的资源
    pub fn track_resource(
        &mut self, 
        address: usize, 
        resource_type: ResourceType,
        size: usize,
        cleanup_function: &str
    ) -> ResourceId {
        if self.resources.len() >= self.max_allocations || address == 0 {
            return 0;
        }

        let id = self.next_id;
        self.next_id += 1;
        
        self.resources.insert(id, ResourceInfo {
            address,
            resource_type,
            size,
            owns_memory: true,
            custom_cleanup: Some(cleanup_function.to_string()),
        });
        
        id
    }

    /// 根据 ID 获取资源的 ResourceInfo，用于检查资源状态
    pub fn get_resource(&self, id: ResourceId) -> Option<&ResourceInfo> {
        self.resources.get(&id)
    }
    
    // 获取资源的数据内容（以 Vec<u8> 返回），仅对有大小的资源有效
    pub fn get_resource_data(&self, id: ResourceId) -> Option<Vec<u8>> {
        if let Some(info) = self.resources.get(&id) {
            if info.size > 0 && info.address != 0 {
                unsafe {
                    let mut data = Vec::with_capacity(info.size);
                    data.set_len(info.size);
                    std::ptr::copy_nonoverlapping(
                        info.address as *const u8,
                        data.as_mut_ptr(),
                        info.size
                    );
                    return Some(data);
                }
            }
        }
        None
    }

    /// 清理指定 ID 的资源，根据类型执行相应释放操作
    /// (当前 Custom 类型的清理逻辑未完全实现，仅调用 libc::free)
    pub fn cleanup_resource(&mut self, id: ResourceId) -> bool {
        if let Some(info) = self.resources.remove(&id) {
            if info.owns_memory && info.address != 0 {
                unsafe {
                    match info.resource_type {
                        ResourceType::Buffer | ResourceType::String | ResourceType::Object => {
                            libc::free(info.address as *mut libc::c_void);
                        },
                        ResourceType::File => {
                            libc::fclose(info.address as *mut libc::FILE);
                        },
                        ResourceType::Custom(_) => {
                            // 如果有自定义清理函数，应该在这里调用
                            if info.custom_cleanup.is_some() {
                                // 这里简化处理，实际应该查找并调用函数
                                libc::free(info.address as *mut libc::c_void);
                            } else {
                                libc::free(info.address as *mut libc::c_void);
                            }
                        },
                    }
                }
            }
            true
        } else {
            false
        }
    }

    /// 清理所有注册的资源，常用于测试结束时
    pub fn cleanup_all(&mut self) {
        let resources: Vec<ResourceId> = self.resources.keys().cloned().collect();
        for id in resources {
            self.cleanup_resource(id);
        }
    }

    /// 返回当前管理的资源数量
    pub fn resource_count(&self) -> usize {
        self.resources.len()
    }
    
    // 获取所有分配的内存总量,返回所有资源分配的总大小（字节数）
    pub fn total_allocated_size(&self) -> usize {
        self.resources.values().map(|info| info.size).sum()
    }
}

impl Drop for ResourceManager {
    /// 确保 ResourceManager 销毁时自动清理所有资源，防止内存泄漏
    fn drop(&mut self) {
        self.cleanup_all();
    }
}

/// 生成简化的 ResourceManager 代码字符串，用于嵌入到生成的 harness 中
/// 相比源码版本，使用 Vec 替代 HashMap，支持自定义清理函数指针
pub fn generate_resource_manager_code() -> String {
    r#"
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ResourceType {
    Buffer,
    String,
    Object,
    File,
    Custom(u32),
}

#[derive(Debug)]
pub struct ResourceManager {
    allocations: Vec<usize>,
    resource_types: Vec<ResourceType>,
    resource_sizes: Vec<usize>,
    custom_cleanups: Vec<Option<unsafe extern "C" fn(*mut libc::c_void)>>,
    max_allocations: usize,
}

impl ResourceManager {
    pub fn new() -> Self {
        Self {
            allocations: Vec::with_capacity(32),
            resource_types: Vec::with_capacity(32),
            resource_sizes: Vec::with_capacity(32),
            custom_cleanups: Vec::with_capacity(32),
            max_allocations: 100,
        }
    }
    
    pub fn track_allocation(&mut self, address: usize, resource_type: ResourceType) {
        if self.allocations.len() >= self.max_allocations {
            return;
        }
        self.allocations.push(address);
        self.resource_types.push(resource_type);
        self.resource_sizes.push(0); // 外部分配，大小未知
        self.custom_cleanups.push(None);
    }
    
    pub fn track_with_cleanup(
        &mut self,
        address: usize,
        resource_type: ResourceType,
        cleanup_fn: unsafe extern "C" fn(*mut libc::c_void)
    ) {
        if self.allocations.len() >= self.max_allocations {
            return;
        }
        self.allocations.push(address);
        self.resource_types.push(resource_type);
        self.resource_sizes.push(0);
        self.custom_cleanups.push(Some(cleanup_fn));
    }
    
    pub fn cleanup_all(&mut self) {
        for i in (0..self.allocations.len()).rev() {
            let address = self.allocations[i];
            let resource_type = self.resource_types[i];
            let custom_cleanup = self.custom_cleanups[i];
            
            if address == 0 {
                continue;
            }
            
            unsafe {
                if let Some(cleanup_fn) = custom_cleanup {
                    cleanup_fn(address as *mut libc::c_void);
                } else {
                    match resource_type {
                        ResourceType::Buffer | ResourceType::String | ResourceType::Object => {
                            libc::free(address as *mut libc::c_void);
                        },
                        ResourceType::File => {
                            libc::fclose(address as *mut libc::FILE);
                        },
                        ResourceType::Custom(_) => {
                            libc::free(address as *mut libc::c_void);
                        },
                    }
                }
            }
        }
        
        self.allocations.clear();
        self.resource_types.clear();
        self.resource_sizes.clear();
        self.custom_cleanups.clear();
    }
}

impl Drop for ResourceManager {
    fn drop(&mut self) {
        self.cleanup_all();
    }
}
"#.to_string()
}

// 为测试添加到ResourceManager实现中的方法
impl ResourceManager {
    // #[cfg(test)]
    pub fn set_resource_ownership(&mut self, id: ResourceId, owns_memory: bool) -> bool {
        if let Some(info) = self.resources.get_mut(&id) {
            info.owns_memory = owns_memory;
            true
        } else {
            false
        }
    }
}