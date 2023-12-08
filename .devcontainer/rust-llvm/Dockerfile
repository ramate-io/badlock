# Use Ubuntu as the base image
FROM ubuntu:latest

# Install required packages to add a new repository and curl for downloading rustup
RUN apt-get update && apt-get install -y wget lsb-release software-properties-common curl build-essential

# Add the LLVM repository
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 16

# Install LLVM 16
RUN apt-get install -y llvm-16 llvm-16-dev

# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust to the PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Optionally, clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm llvm.sh
