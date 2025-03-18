//! 分析可视化工具
//!
//! 提供依赖关系图和分析结果的可视化工具

use std::collections::HashMap;
use std::fs::File;
use std::io::Write;
use std::path::Path;

use crate::analyzer::graph::{DependencyGraph, FunctionId, TypeId};
use crate::analyzer::security::SecurityScore;
use crate::analyzer::testability::FunctionTestability;
use crate::error::HarnessError;

/// 生成依赖关系图的DOT图表示
pub fn generate_dependency_graph_dot(graph: &DependencyGraph) -> String {
    let mut dot = String::from("digraph G {\n");
    dot.push_str("  rankdir=LR;\n");
    dot.push_str("  node [shape=box style=filled];\n\n");
    
    // 添加函数节点
    dot.push_str("  // 函数节点\n");
    for function_id in graph.get_all_functions() {
        dot.push_str(&format!("  \"{}\" [fillcolor=lightblue];\n", function_id));
    }
    
    // 添加类型节点
    dot.push_str("\n  // 类型节点\n");
    for type_id in graph.get_all_types() {
        dot.push_str(&format!("  \"{}\" [fillcolor=lightgreen];\n", type_id));
    }
    
    // 添加边关系
    dot.push_str("\n  // 边关系\n");
    for (function_id, type_id) in graph.get_produces_edges() {
        dot.push_str(&format!("  \"{}\" -> \"{}\" [color=green label=\"produces\"];\n", 
            function_id, type_id));
    }
    
    for (function_id, type_id) in graph.get_consumes_edges() {
        dot.push_str(&format!("  \"{}\" -> \"{}\" [color=red label=\"consumes\"];\n", 
            function_id, type_id));
    }
    
    for (function_id, type_id) in graph.get_modifies_edges() {
        dot.push_str(&format!("  \"{}\" -> \"{}\" [color=blue label=\"modifies\"];\n", 
            function_id, type_id));
    }
    
    dot.push_str("}\n");
    dot
}

/// 生成类型层次结构的DOT图表示
pub fn generate_type_hierarchy_dot(type_dependencies: &HashMap<TypeId, Vec<TypeId>>) -> String {
    let mut dot = String::from("digraph TypeHierarchy {\n");
    dot.push_str("  rankdir=TB;\n");
    dot.push_str("  node [shape=box style=filled fillcolor=lightgreen];\n\n");
    
    // 添加类型节点和依赖边
    for (type_id, dependencies) in type_dependencies {
        for dep_type in dependencies {
            dot.push_str(&format!("  \"{}\" -> \"{}\";\n", type_id, dep_type));
        }
    }
    
    dot.push_str("}\n");
    dot
}

/// 生成函数安全评分的HTML热力图
pub fn generate_security_heatmap_html(
    scores: &HashMap<FunctionId, SecurityScore>,
    testability: &HashMap<FunctionId, FunctionTestability>
) -> String {
    let mut html = String::from(r#"<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Function Security Analysis</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .heatmap { border-collapse: collapse; width: 100%; }
        .heatmap th, .heatmap td { 
            border: 1px solid #ddd; 
            padding: 8px; 
            text-align: left; 
        }
        .heatmap tr:nth-child(even) { background-color: #f2f2f2; }
        .heatmap tr:hover { background-color: #ddd; }
        .heatmap th {
            padding-top: 12px;
            padding-bottom: 12px;
            background-color: #4CAF50;
            color: white;
        }
        .score-cell {
            width: 80px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Function Security Analysis</h1>
    <table class="heatmap">
        <tr>
            <th>Function</th>
            <th>Security Score</th>
            <th>Memory</th>
            <th>Pointer</th>
            <th>String</th>
            <th>Integer</th>
            <th>Resource</th>
            <th>Constructible</th>
            <th>Complexity</th>
        </tr>
"#);

    // 按安全评分降序排序
    let mut function_scores: Vec<(&FunctionId, &SecurityScore)> = scores.iter().collect();
    function_scores.sort_by(|a, b| b.1.total_score.cmp(&a.1.total_score));

    for (function_id, score) in function_scores {
        // 初始化默认测试信息
        let default_testability = FunctionTestability {
            constructible: false,
            construction_complexity: 0,
            required_producers: Vec::new(),
            difficulty_score: 100,
        };
        
        // 获取测试信息
        let testability_info = match testability.get(function_id) {
            Some(info) => info,
            None => &default_testability,
        };
        
        let color = get_score_color(score.total_score);
        let memory_color = get_score_color(score.memory_score);
        let pointer_color = get_score_color(score.pointer_score);
        let string_color = get_score_color(score.string_score);
        let integer_color = get_score_color(score.integer_score);
        let resource_color = get_score_color(score.resource_score);
        
        html.push_str(&format!(r#"
        <tr>
            <td>{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td class="score-cell" style="background-color: {}">{}</td>
            <td>{}</td>
            <td>{}</td>
        </tr>
"#,
            function_id,
            color, score.total_score,
            memory_color, score.memory_score,
            pointer_color, score.pointer_score,
            string_color, score.string_score,
            integer_color, score.integer_score,
            resource_color, score.resource_score,
            if testability_info.constructible { "Yes" } else { "No" },
            testability_info.construction_complexity
        ));
    }

    html.push_str(r#"
    </table>
</body>
</html>
"#);

    html
}

/// 将可视化内容写入文件
pub fn write_visualization(
    content: &str, 
    output_dir: &Path, 
    filename: &str
) -> Result<(), HarnessError> {
    // 创建输出目录
    if !output_dir.exists() {
        std::fs::create_dir_all(output_dir)?;
    }
    
    let output_path = output_dir.join(filename);
    let mut file = File::create(output_path)?;
    file.write_all(content.as_bytes())?;
    
    Ok(())
}

/// 获取评分颜色（红绿渐变，红色表示高风险）
fn get_score_color(score: u32) -> String {
    if score >= 80 {
        "#ff6666".to_string()  // // 高风险 - 红色
    } else if score >= 60 {
        "#ffcc66".to_string()  // 中高风险 - 橙色
    } else if score >= 40 {
        "#ffff66".to_string()  // 中风险 - 黄色
    } else if score >= 20 {
        "#99ff66".to_string()  // 中低风险 - 浅绿
    } else {
        "#66ff66".to_string()  // 低风险 - 绿色
    }
}

/// 生成Markdown格式的综合分析报告
pub fn generate_analysis_report(
    graph: &DependencyGraph,
    scores: &HashMap<FunctionId, SecurityScore>,
    testability: &HashMap<FunctionId, FunctionTestability>,
    selected_functions: &[FunctionId]
) -> String {
    let mut report = String::new();
    
    report.push_str("# 库分析报告\n\n");
    
    // Generate summary statistics
    report.push_str("## 统计摘要\n\n");
    report.push_str(&format!("- Total functions: {}\n", graph.get_all_functions().len()));
    report.push_str(&format!("- Total types: {}\n", graph.get_all_types().len()));
    report.push_str(&format!("- Selected functions for fuzzing: {}\n\n", selected_functions.len()));
    
    // List high-value targets
    report.push_str("## High-Value Fuzzing Targets\n\n");
    report.push_str("| Function | Security Score | Complexity | Constructible |\n");
    report.push_str("|----------|---------------|------------|---------------|\n");
    
    // 默认值处理
    let default_score = SecurityScore {
        total_score: 0,
        memory_score: 0,
        pointer_score: 0,
        string_score: 0,
        integer_score: 0,
        resource_score: 0,
        vulnerability_patterns: Vec::new(),
    };
    
    let default_testability = FunctionTestability {
        constructible: false,
        construction_complexity: 0,
        required_producers: Vec::new(),
        difficulty_score: 100,
    };
    
    for function_id in selected_functions {
        // Look up score, using default if missing
        let score = match scores.get(function_id) {
            Some(s) => s,
            None => &default_score,
        };
        
        // Look up testability, using default if missing
        let testability_info = match testability.get(function_id) {
            Some(t) => t,
            None => &default_testability,
        };
        
        report.push_str(&format!("| {} | {} | {} | {} |\n",
            function_id,
            score.total_score,
            testability_info.construction_complexity,
            if testability_info.constructible { "Yes" } else { "No" }
        ));
    }
    
    // 检测到的漏洞模式
    report.push_str("\n## 检测到的漏洞模式\n\n");
    
    let mut patterns_by_category: HashMap<String, Vec<String>> = HashMap::new();
    
    for (function_id, score) in scores {
        for pattern in &score.vulnerability_patterns {
            let (category, description) = match pattern {
                crate::analyzer::security::VulnPattern::Memory(desc) => 
                    ("Memory", desc),
                crate::analyzer::security::VulnPattern::String(desc) => 
                    ("String", desc),
                crate::analyzer::security::VulnPattern::Integer(desc) => 
                    ("Integer", desc),
                crate::analyzer::security::VulnPattern::Resource(desc) => 
                    ("Resource", desc),
            };
            
            let entry = patterns_by_category.entry(category.to_string()).or_insert_with(Vec::new);
            entry.push(format!("{}: {}", function_id, description));
        }
    }
    
    for (category, functions) in patterns_by_category {
        report.push_str(&format!("### {} Vulnerabilities\n\n", category));
        for function in functions {
            report.push_str(&format!("- {}\n", function));
        }
        report.push_str("\n");
    }
    
    report
}