# DylibSurfer

A dynamic library fuzzing framework focused on automated harness generation for efficient fuzzing of C/C++ libraries.

[中文版本](README.zh_CN.md)

## Overview

DylibSurfer is a comprehensive framework designed to simplify and enhance the process of fuzzing C/C++ dynamic libraries. It automates the tedious process of creating fuzz harnesses by analyzing LLVM IR and generating appropriate Rust bindings and harness code.

## Project Structure

DylibSurfer is composed of three main components:

- **dylibsurfer-ir**: IR parsing engine that extracts function signatures and type information from LLVM IR
- **dylibsurfer-bindgen**: Type system mapper that converts C/C++ types into Rust FFI bindings
- **dylibsurfer-harness**: Harness generator that automatically creates test harnesses for fuzzing

## Key Features

- 🔍 **Automatic Library Analysis**: Extract function signatures and dependencies directly from LLVM IR
- 🧠 **Smart Function Selection**: Identifies high-value fuzzing targets based on security metrics and constructibility
- 🔄 **Type Conversion**: Automated conversion from C/C++ types to Rust FFI bindings
- 🛠️ **Harness Generation**: Creates ready-to-use fuzzing harnesses with proper resource management
- 📊 **Visual Analysis**: Generates dependency graphs and security heatmaps for better understanding of library structure
- 🔌 **LibAFL Integration**: Designed for seamless integration with LibAFL (coming soon)

## Installation

```bash
# Clone the repository
git clone https://github.com/AugustuXue/DylibSurfer.git
cd DylibSurfer

# Build the project
cargo build --release
```

## Prerequisites

- Rust (2021 edition or newer)
- LLVM 14.0 toolchain (for generating IR files)
- Clang (for preprocessing C/C++ source)

## Getting Started

### 1. Generate LLVM IR from your target library

```bash
clang -S -emit-llvm -fno-discard-value-names -o library.ll library.c
```

### 2. Generate harnesses for the library

```bash
cargo run --bin harness-gen -- generate --ir-file library.ll --output ./output --config config.yaml
```

### 3. Explore the analysis results

```bash
# The tool generates various analysis files in the output directory:
# - dependency_graph.dot: Visualize function dependencies
# - security_heatmap.html: Heat map of security-critical functions
# - analysis_report.md: Detailed library analysis report
```

## Development Roadmap

- [x] Phase 1: Core Architecture - Basic structure, configuration system, and template engine
- [x] Phase 2: Function Selection System - Dependency analysis, testability analysis, and security scoring
- [x] Phase 3: Input Transformation System - Type extraction helpers, resource management, and state tracking
- [ ] Phase 4: Harness Generation System - Code generation, memory management, and error handling(In Progress)
- [ ] Phase 5: Testing and Optimization - Comprehensive testing and integration with LibAFL
