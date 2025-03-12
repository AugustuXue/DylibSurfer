//! Harness 生成模板引擎

use crate::error::HarnessError;
use handlebars::Handlebars;
use serde::Serialize;
use std::collections::HashMap;
use std::path::Path;

/// 模板渲染上下文
pub type TemplateContext = HashMap<String, serde_json::Value>;

/// Harness 生成模板引擎
pub struct TemplateEngine<'reg> {
    /// Handlebars 注册表，模板渲染引擎核心
    registry: Handlebars<'reg>,
    
    /// 内置模板
    built_in_templates: HashMap<String, String>,
}

impl<'reg> TemplateEngine<'reg> {
    /// 创建新的模板引擎
    pub fn new() -> Self {
        let mut engine = Self {
            registry: Handlebars::new(),
            built_in_templates: HashMap::new(),
        };
        
        // 注册内置模板
        engine.register_built_in_templates();
        
        engine
    }
    
    /// 从字符串注册模板
    /// 
    /// # 参数
    /// * `name` - 模板名称
    /// * `template` - 模板字符串
    /// 
    /// # 返回值
    /// * `Ok(())` - 模板注册成功
    /// * `Err(HarnessError)` - 注册模板失败时的错误
    pub fn register_template_string(&mut self, name: &str, template: &str) -> Result<(), HarnessError> {
        self.registry.register_template_string(name, template)
            .map_err(|e| HarnessError::TemplateError(format!("注册模板 '{}' 失败: {}", name, e)))?;
        
        Ok(())
    }
    
    /// 从目录注册模板
    /// 
    /// # 参数
    /// * `dir` - 包含模板文件的目录
    /// 
    /// # 返回值
    /// * `Ok(())` - 模板注册成功
    /// * `Err(HarnessError)` - 注册模板失败时的错误
    pub fn register_templates_dir(&mut self, dir: &Path) -> Result<(), HarnessError> {
        if !dir.exists() || !dir.is_dir() {
            return Err(HarnessError::TemplateError(format!("目录不存在或不是目录: {:?}", dir)));
        }
    
        // 手动遍历目录中的文件
        for entry in std::fs::read_dir(dir).map_err(|e| HarnessError::IoError(e))? {
            let entry = entry.map_err(|e| HarnessError::IoError(e))?;
            let path = entry.path();
        
            // 只处理 .hbs 文件
            if path.is_file() && path.extension().map_or(false, |ext| ext == "hbs") {
                let name = path.file_stem()
                    .and_then(|s| s.to_str())
                    .ok_or_else(|| HarnessError::TemplateError(format!("无效的文件名: {:?}", path)))?;
                
                let content = std::fs::read_to_string(&path)
                    .map_err(|e| HarnessError::IoError(e))?;
                
                self.register_template_string(name, &content)?;
            }
        }
        
        Ok(())
    }

    
    /// 渲染模板
    /// 
    /// # 参数
    /// * `name` - 模板名称
    /// * `context` - 模板上下文
    /// 
    /// # 返回值
    /// * `Ok(String)` - 渲染后的模板
    /// * `Err(HarnessError)` - 渲染模板失败时的错误
    pub fn render<T: Serialize>(&self, name: &str, context: &T) -> Result<String, HarnessError> {
        self.registry.render(name, context)
            .map_err(|e| HarnessError::TemplateError(format!("渲染模板 '{}' 失败: {}", name, e)))
    }
    
    /// 注册内置模板
    fn register_built_in_templates(&mut self) {
        // 基本 harness 模板
        self.built_in_templates.insert("basic_harness".to_string(), r#"
// 为 {{function_name}} 生成的 harness
fn harness_{{function_name}}(data: &[u8]) -> bool {
    if data.len() < {{min_data_size}} {
        return false;  // 数据不足
    }
    
    // 从数据中提取参数
    let mut cursor = 0;
    
    {{#each parameters}}
    // 提取 {{name}} ({{type}})
    {{#if is_pointer}}
    let {{name}} = extract_pointer_from_data(data, &mut cursor, {{size}});
    {{else}}
    let {{name}} = extract_{{type_name}}_from_data(data, &mut cursor);
    {{/if}}
    {{/each}}
    
    // 调用目标函数
    let result = unsafe {
        {{lib_name}}::{{function_name}}(
            {{#each parameters}}
            {{name}}{{#unless @last}},{{/unless}}
            {{/each}}
        )
    };
    
    // 清理资源（如果需要）
    {{#each parameters}}
    {{#if needs_cleanup}}
    cleanup_{{name}}({{name}});
    {{/if}}
    {{/each}}
    
    // 如果函数执行没有崩溃，返回 true
    true
}
"#.to_string());
    // 先收集所有需要注册的模板
    let templates_to_register: Vec<(String, String)> = self.built_in_templates
        .iter()
        .map(|(k, v)| (k.clone(), v.clone()))
        .collect();
    
    // 然后注册它们
    for (name, template) in templates_to_register {
        self.register_template_string(&name, &template)
            .expect("注册内置模板失败");
        }
    }
}

impl<'reg> Default for TemplateEngine<'reg> {
    fn default() -> Self {
        Self::new()
    }
}