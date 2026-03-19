Capstone Project: High-Performance GPU-Accelerated Image Cryptography
Project Overview:This project implements a high-performance image encryption and decryption system using CUDA C++.
The core objective is to demonstrate how massively parallel GPU architectures can be utilized to secure data at a scale that far exceeds traditional CPU-based serial processing.
Technical Implementation:I developed a custom CUDA kernel that performs a bitwise XOR cipher combined with an index-based key-shifting algorithm. 
This ensures that even with a static 32-bit key, the encryption pattern remains non-linear across the image.
By assigning one GPU thread per pixel, the application achieves $O(1)$ complexity per pixel in parallel. The project handles a $1024 \times 1024$ image matrix, executing millions of cryptographic operations in milliseconds.
Key Achievements:Parallel Efficiency: Utilized a grid-block execution configuration to maximize occupancy on NVIDIA hardware.Data Integrity: Implemented a full encryption-decryption lifecycle to verify 100% data recovery.
Optimized Memory Management: Managed host-to-device and device-to-host memory transfers to minimize latency during the cryptographic process.Why this project?This work combines the high-performance computing principles learned in this specialization with my personal interest in Cybersecurity and Network Security. 
It serves as a foundation for building real-time encrypted video streaming or high-speed disk encryption tools.
