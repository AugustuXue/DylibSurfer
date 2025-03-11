use clap::{Parser, Subcommand};
use dylibsurfer_harness::{config::HarnessConfig, generate_harnesses};
use dylibsurfer_ir::IrParser;
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "harness-gen")]
#[command(about = "为 C/C++ 库生成模糊测试 harness")]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// 从 IR 文件生成 harness
    Generate {
        /// 要解析的 IR 文件
        #[arg(short, long)]
        ir_file: PathBuf,
        
        /// 输出目录
        #[arg(short, long)]
        output: PathBuf,
        
        /// 配置文件
        #[arg(short, long)]
        config: Option<PathBuf>,
    },
    
    /// 生成默认配置文件
    Config {
        /// 输出文件
        #[arg(short, long)]
        output: PathBuf,
    },
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 初始化日志记录器
    env_logger::init();
    
    // 解析命令行参数
    let cli = Cli::parse();
    
    match cli.command {
        Commands::Generate { ir_file, output, config } => {
            // 加载配置
            let config = if let Some(config_path) = config {
                HarnessConfig::from_file(&config_path)?
            } else {
                HarnessConfig::default()
            };
            
            // 解析 IR 文件
            let parser = IrParser::new();
            let signatures = parser.parse_ir_file(&ir_file)?;
            
            // 生成 harness
            generate_harnesses(&signatures, &config, &output)?;
            
            println!("成功为 {} 个函数生成了 harness", signatures.len());
        },
        Commands::Config { output } => {
            // 生成默认配置
            let config = HarnessConfig::default();
            config.to_file(&output)?;
            
            println!("成功在 {:?} 生成了默认配置", output);
        },
    }
    
    Ok(())
}