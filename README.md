# Batch GPU Image Signal Processing

## Overview
This project demonstrates high-volume data processing using the **NVIDIA NPP (NVIDIA Performance Primitives)** library. The application processes a dataset of 100 image signals by applying a parallel 3x3 Box Filter (spatial smoothing). This highlights the GPU's efficiency in handling batch workloads at scale, moving beyond single-image processing to high-throughput enterprise scenarios.

## Code Organization
* **bin/**: Holds the compiled `batch_processor.exe`.
* **data/**: Contains `output_log.txt` showing the processing history of all 100 inputs.
* **lib/**: Placeholder for custom signal processing headers.
* **src/**: Contains the main source code `batch_processor.cu`.
* **INSTALL**: Build and execution instructions for peer reviewers.
* **Makefile**: Automated build script linking CUDA and NPP libraries.
* **run.sh**: Automation script to build, execute, and generate the proof of work.

## Technical Implementation
- **Data Volume**: Batch processing of 100 simulated 512x512 image signals.
- **GPU Acceleration**: Utilizes `nppiFilterBox_8u_C1R` for optimized image geometry operations.
- **Memory Management**: Iterative device allocation and cleanup to prevent memory fragmentation during high-volume processing.
