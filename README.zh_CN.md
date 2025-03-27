# DylibSurfer

一个专注于自动化生成 C/C++ 库模糊测试 harness 的动态链接库模糊测试框架。
[English version](README.md)

## 概述

DylibSurfer 是一个综合性框架，旨在简化和增强 C/C++ 动态链接库的模糊测试过程。它通过分析 LLVM IR 并生成适当的 Rust 绑定和 harness 代码，自动化了创建模糊测试 harness 的繁琐过程。

## 项目结构

DylibSurfer 由三个主要组件组成：

- **dylibsurfer-ir**：IR 解析引擎，从 LLVM IR 中提取函数签名和类型信息
- **dylibsurfer-bindgen**：类型系统映射器，将 C/C++ 类型转换为 Rust FFI 绑定
- **dylibsurfer-harness**：Harness 生成器，自动创建用于模糊测试的测试 harness

## 主要特性

- 🔍 **自动库分析**：直接从 LLVM IR 中提取函数签名和依赖关系
- 🧠 **智能函数选择**：基于安全指标和可构造性识别高价值的模糊测试目标
- 🔄 **类型转换**：自动将 C/C++ 类型转换为 Rust FFI 绑定
- 🛠️ **Harness 生成**：创建具有适当资源管理的即用型模糊测试 harness
- 📊 **可视化分析**：生成依赖关系图和安全热图，以更好地理解库结构
- 🔌 **LibAFL 集成**：设计为与 LibAFL 无缝集成（即将推出）

## 安装

```bash
# 克隆仓库
git clone https://github.com/AugustuXue/DylibSurfer.git
cd DylibSurfer

# 构建项目
cargo build --release
```

## 前提条件

- Rust（2021 版或更新版本）
- LLVM 14.0 工具链（用于生成 IR 文件）
- Clang（用于预处理 C/C++ 源代码）

## 入门指南

### 1. 从目标库生成 LLVM IR

```bash
clang -S -emit-llvm -fno-discard-value-names -o library.ll library.c
```

### 2. 为库生成 harness

```bash
cargo run --bin harness-gen -- generate --ir-file library.ll --output ./output --config config.yaml
```

### 3. 探索分析结果

```bash
# 该工具在输出目录中生成各种分析文件：
# - dependency_graph.dot：可视化函数依赖关系
# - security_heatmap.html：安全关键函数的热图
# - analysis_report.md：详细的库分析报告
```

## 开发路线图

- [x] 第一阶段：核心架构 - 基本结构、配置系统和模板引擎
- [x] 第二阶段：函数选择系统 - 依赖分析、可测试性分析和安全评分
- [x] 第三阶段：输入转换系统 - 类型提取辅助工具、资源管理和状态跟踪
- [ ] 第四阶段：Harness 生成系统 - 代码生成、内存管理和错误处理（正在完成）
- [ ] 第五阶段：测试和优化 - 全面测试和与 LibAFL 集成