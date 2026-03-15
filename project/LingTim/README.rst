# Fast Matrix Operations with C++ Backend for NumPy

## URL

https://github.com/LingTim/numpy-cpp-accelerator

## Author

GitHub Account: LingTim

## Introduction

Numerical computing in Python is commonly performed using the NumPy library.
Although NumPy provides efficient implementations for many operations, there are
still opportunities to explore performance optimization and understand how
low-level implementations interact with high-level languages.

The goal of this project is to implement several matrix operations in C++ and
expose them to Python as a module. This project aims to explore the integration
between low-level languages (C++) and high-level languages (Python), which is a
key topic in numerical software development.

## Motivation

High-performance numerical computation often requires optimized low-level
implementations. Python is convenient but slower for heavy computation when
loops are involved.

By implementing core numerical routines in C++ and connecting them to Python,
we can:

* Reduce computational overhead
* Explore memory layout and cache efficiency
* Understand the interaction between Python and C++

## Project Goals

The project aims to implement and analyze optimized matrix operations.

Planned operations include:

* Matrix multiplication
* Vector dot product
* Basic vector arithmetic

Different implementations will be explored:

* Naive implementation
* Cache-friendly implementation
* Possible SIMD optimization

## Method

The project will be implemented in the following structure:

1. Core numerical routines implemented in C++
2. Python bindings created using pybind11
3. Benchmark scripts written in Python

Performance will be compared against NumPy implementations to evaluate speed
and efficiency.

## Technologies

The following tools and technologies will be used:

* Python
* C++
* NumPy
* pybind11
* Git / GitHub

## Operations and Routines

The project will implement the following core operations as C++ extensions for Python:

1. **Basic Element-wise Operations:**
   * ``add(matrix_a, matrix_b)``: Element-wise addition of two matrices/vectors.
   * ``subtract(matrix_a, matrix_b)``: Element-wise subtraction.
   * ``multiply(matrix_a, matrix_b)``: Element-wise multiplication (Hadamard product).

2. **Linear Algebra Operations:**
   * ``dot(vector_a, vector_b)``: Inner product of two 1D vectors.
   * ``matmul(matrix_a, matrix_b)``: General matrix multiplication (GEMM).

3. **Optimized Implementations for Matrix Multiplication:**
   To explore performance tuning, ``matmul`` will be implemented in different versions:
   * ``matmul_naive(...)``: Standard $O(N^3)$ implementation as a performance baseline.
   * ``matmul_tile(...)``: Cache-friendly block/tiled matrix multiplication.
   * ``matmul_simd(...)``: Vectorized implementation utilizing SIMD (e.g., AVX/SSE) instructions.

4. **Utility & Data Management (via Pybind11):**
   * Memory mapping and seamless data conversion between NumPy ``ndarray`` and C++ data structures (e.g., ``std::vector`` or raw pointers) without unnecessary copying.

## Expected Outcome

The expected results include:

* A small Python module providing accelerated numerical operations
* Performance benchmarks comparing the implementation with NumPy
* Documentation explaining design choices and optimization techniques

This project will help demonstrate how high-level and low-level programming
languages can be combined to build efficient numerical software.

