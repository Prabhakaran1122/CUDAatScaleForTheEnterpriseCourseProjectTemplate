#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>
#include <iostream>

// CUDA Kernel: Parallel Bitwise Encryption
__global__ void encryptKernel(unsigned char* data, int size, unsigned int key) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < size) {
        // A simple but effective parallel XOR cipher
        // The key shifts based on the pixel index to prevent simple frequency analysis
        unsigned char localKey = (unsigned char)((key ^ idx) % 256);
        data[idx] = data[idx] ^ localKey;
    }
}

void checkCUDAError(const char *msg) {
    cudaError_t err = cudaGetLastError();
    if (cudaSuccess != err) {
        fprintf(stderr, "CUDA ERROR: %s: %s\n", msg, cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

int main(int argc, char** argv) {
    // 1024x1024 image size for demonstration (1MB of data)
    const int width = 1024;
    const int height = 1024;
    const int size = width * height;
    const size_t bytes = size * sizeof(unsigned char);
    const unsigned int encryptionKey = 0xABCDE123; // Your secret key

    // Host memory
    unsigned char *h_data = (unsigned char*)malloc(bytes);
    
    // Initialize "Image" with dummy data (e.g., a gradient)
    for (int i = 0; i < size; i++) h_data[i] = (unsigned char)(i % 256);

    printf("Starting GPU Encryption Project...\n");
    printf("Image Size: %d x %d\n", width, height);

    // Device memory
    unsigned char *d_data;
    cudaMalloc(&d_data, bytes);
    cudaMemcpy(d_data, h_data, bytes, cudaMemcpyHostToDevice);

    // Execution Configuration
    int threadsPerBlock = 256;
    int blocksPerGrid = (size + threadsPerBlock - 1) / threadsPerBlock;

    // --- ENCRYPTION PHASE ---
    printf("Encrypting data on GPU...\n");
    encryptKernel<<<blocksPerGrid, threadsPerBlock>>>(d_data, size, encryptionKey);
    cudaDeviceSynchronize();
    checkCUDAError("Encryption Kernel");

    // Copy encrypted data back to verify
    cudaMemcpy(h_data, d_data, bytes, cudaMemcpyDeviceToHost);
    printf("First 5 Encrypted Pixels: %02X %02X %02X %02X %02X\n", 
            h_data[0], h_data[1], h_data[2], h_data[3], h_data[4]);

    // --- DECRYPTION PHASE ---
    printf("Decrypting data on GPU...\n");
    encryptKernel<<<blocksPerGrid, threadsPerBlock>>>(d_data, size, encryptionKey);
    cudaDeviceSynchronize();

    cudaMemcpy(h_data, d_data, bytes, cudaMemcpyDeviceToHost);
    printf("First 5 Decrypted Pixels (should match original): %d %d %d %d %d\n", 
            h_data[0], h_data[1], h_data[2], h_data[3], h_data[4]);

    // Cleanup
    cudaFree(d_data);
    free(h_data);
    printf("Project Execution Complete.\n");

    return 0;
}
