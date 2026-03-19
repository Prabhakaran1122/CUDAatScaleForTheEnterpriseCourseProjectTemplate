#!/usr/bin/env bash
# Build the project
make clean build

# Execute and save output to the data folder for submission
./bin/gpu_encryptor.exe > data/output_log.txt

# Display results to terminal
cat data/output_log.txt
