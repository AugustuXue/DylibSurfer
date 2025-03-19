//! Example demonstrating how to use the analyzer components together

use std::path::Path;
use dylibsurfer_ir::IrParser;
use dylibsurfer_harness::{
    analyzer::{
        DependencyGraphBuilder,
        ConstructibilityAnalyzer,
        SecurityInterestScorer,
        FunctionSelector,
        SelectionConfig,
        generate_dependency_graph_dot,
        generate_security_heatmap_html,
        generate_analysis_report,
        write_visualization
    },
    error::HarnessError
};

fn main() -> Result<(), HarnessError> {
    // Parse the LLVM IR file
    let ir_path = Path::new("dylibsurfer-harness/tests/testdata/png.ll");
    let parser = IrParser::new();
    let signatures = parser.parse_ir_file(ir_path)?;
    let limited_signatures = if signatures.len() > 100 {
        &signatures[0..100]
    } else {
        &signatures
    };
    
    println!("Parsed {} function signatures", limited_signatures.len());
    
    // Build the dependency graph
    let graph_builder = DependencyGraphBuilder::new();
    let dependency_graph = graph_builder.build(&limited_signatures)?;
    
    println!("Built dependency graph with {} functions and {} types",
             dependency_graph.get_all_functions().len(),
             dependency_graph.get_all_types().len());
    
    // Analyze function testability
    let mut constructibility_analyzer = ConstructibilityAnalyzer::new(dependency_graph.clone());
    let testability_results = constructibility_analyzer.analyze_functions(&limited_signatures);
    
    println!("Analyzed testability for {} functions", testability_results.len());
    
    // Score functions for security interest
    let security_scorer = SecurityInterestScorer::new()?;
    let security_scores = security_scorer.score_functions(&limited_signatures);
    
    println!("Scored {} functions for security interest", security_scores.len());
    
    // Configure function selection
    let selection_config = SelectionConfig {
        min_security_score: 30,  // Only consider functions with score >= 50
        max_complexity: 85,      // Limit complexity to 80
        include_patterns: vec![
            regex::Regex::new("png_.*").unwrap(),  // Include all png_ functions
        ],
        exclude_patterns: vec![
            regex::Regex::new(".*_internal").unwrap(),  // Exclude internal functions
        ],
        max_functions: 20,       // Limit to top 20 functions
        balance_factor: 0.3,     // Favor security score over complexity
    };
    
    // Select the most promising functions
    let mut function_selector = FunctionSelector::new(
        dependency_graph.clone(),
        security_scorer,
        constructibility_analyzer
    );
    
    let selected_bundles = function_selector.select_functions(
        &limited_signatures, 
        &selection_config
    )?;
    
    println!("Selected {} function bundles for fuzzing", selected_bundles.len());
    
    // Extract the target functions from the bundles
    let selected_functions: Vec<_> = selected_bundles.iter()
        .map(|bundle| bundle.target.clone())
        .collect();
    
    // Generate visualizations
    let output_dir = Path::new("analysis_output");
    
    // Generate dependency graph visualization
    let graph_dot = generate_dependency_graph_dot(&dependency_graph);
    write_visualization(&graph_dot, output_dir, "dependency_graph.dot")?;
    println!("Generated dependency graph visualization");
    
    // Generate security heatmap
    let heatmap_html = generate_security_heatmap_html(&security_scores, &testability_results);
    write_visualization(&heatmap_html, output_dir, "security_heatmap.html")?;
    println!("Generated security heatmap");
    
    // Generate analysis report
    let report = generate_analysis_report(
        &dependency_graph,
        &security_scores,
        &testability_results,
        &selected_functions
    );
    write_visualization(&report, output_dir, "analysis_report.md")?;
    println!("Generated analysis report");
    
    // Print selected functions
    println!("\nTop functions for fuzzing:");
    for (i, function_id) in selected_functions.iter().enumerate() {
        let score = security_scores.get(function_id)
            .map(|s| s.total_score)
            .unwrap_or(0);
            
        let testability = testability_results.get(function_id)
            .map(|t| t.construction_complexity)
            .unwrap_or(0);
            
        println!("{}. {} (Security: {}, Complexity: {})", 
            i+1, function_id, score, testability);
    }
    
    Ok(())
}