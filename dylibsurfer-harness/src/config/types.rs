//! Harness 生成配置类型

use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// Harness 生成配置
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HarnessConfig {
    /// 通用设置
    #[serde(default)]
    pub general: GeneralConfig,
    
    /// 函数选择设置
    #[serde(default)]
    pub function_selection: FunctionSelectionConfig,
    
    /// 模板设置
    #[serde(default)]
    pub template: TemplateConfig,
    
    /// 类型处理设置
    #[serde(default)]
    pub type_handling: TypeHandlingConfig,
}

/// 通用设置
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GeneralConfig {
    /// 项目名称
    #[serde(default = "default_project_name")]
    pub project_name: String,
    
    /// 是否为不安全函数生成安全封装
    #[serde(default = "default_true")]
    pub generate_safe_wrappers: bool,
    
    /// 最大生成 harness 数量
    #[serde(default = "default_max_harnesses")]
    pub max_harnesses: usize,
}

/// 函数选择设置
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FunctionSelectionConfig {
    /// 包含的函数名称模式
    #[serde(default)]
    pub include_patterns: Vec<String>,
    
    /// 排除的函数名称模式
    #[serde(default)]
    pub exclude_patterns: Vec<String>,
    
    /// 函数选择的最小兴趣度分数
    #[serde(default = "default_min_interest_score")]
    pub min_interest_score: f32,
}

/// 模板设置
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TemplateConfig {
    /// 模板文件目录
    #[serde(default)]
    pub template_dir: Option<String>,
    
    /// 自定义模板（按名称）
    #[serde(default)]
    pub custom_templates: HashMap<String, String>,
    
    /// 是否格式化生成的代码
    #[serde(default = "default_true")]
    pub format_code: bool,
}

/// 类型处理设置
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TypeHandlingConfig {
    /// 动态大小类型的最大缓冲区大小
    #[serde(default = "default_max_buffer_size")]
    pub max_buffer_size: usize,
    
    /// 自定义类型处理器（按类型名称）
    #[serde(default)]
    pub custom_handlers: HashMap<String, String>,
    
    /// 是否使用智能指针进行内存管理
    #[serde(default = "default_true")]
    pub use_smart_pointers: bool,
}

// 配置默认值

fn default_project_name() -> String {
    "dylibsurfer_generated".to_string()
}

fn default_true() -> bool {
    true
}

fn default_max_harnesses() -> usize {
    100
}

fn default_min_interest_score() -> f32 {
    0.5
}

fn default_max_buffer_size() -> usize {
    4096
}

// 默认实现

impl Default for HarnessConfig {
    fn default() -> Self {
        Self {
            general: Default::default(),
            function_selection: Default::default(),
            template: Default::default(),
            type_handling: Default::default(),
        }
    }
}

impl Default for GeneralConfig {
    fn default() -> Self {
        Self {
            project_name: default_project_name(),
            generate_safe_wrappers: default_true(),
            max_harnesses: default_max_harnesses(),
        }
    }
}

impl Default for FunctionSelectionConfig {
    fn default() -> Self {
        Self {
            include_patterns: Vec::new(),
            exclude_patterns: Vec::new(),
            min_interest_score: default_min_interest_score(),
        }
    }
}

impl Default for TemplateConfig {
    fn default() -> Self {
        Self {
            template_dir: None,
            custom_templates: HashMap::new(),
            format_code: default_true(),
        }
    }
}

impl Default for TypeHandlingConfig {
    fn default() -> Self {
        Self {
            max_buffer_size: default_max_buffer_size(),
            custom_handlers: HashMap::new(),
            use_smart_pointers: default_true(),
        }
    }
}
