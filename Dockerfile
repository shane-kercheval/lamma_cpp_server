ARG UBUNTU_VERSION=22.04
# This needs to generally match the container host's environment.
ARG CUDA_VERSION=12.1.1
ARG BASE_CUDA_DEV_CONTAINER=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}
FROM ${BASE_CUDA_DEV_CONTAINER} as build
# FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

ARG CUDA_DOCKER_ARCH=all

# Install necessary packages for building the application
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    python3-pip

# set Python 3 as the default Python version
RUN ln -s /usr/bin/python3 /usr/bin/python
# upgrade pip
RUN python -m pip install --upgrade pip

ENV CUDA_HOME=/usr/local/cuda
ENV PATH=$PATH:/usr/local/cuda/bin

# Set the working directory
WORKDIR /llama.cpp
# Clone the repository
RUN git clone https://github.com/ggerganov/llama.cpp.git .
# Compile the application with CUDA support

# Set nvcc architecture
ENV CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH}
# Enable cuBLAS
ENV LLAMA_CUBLAS=1
RUN make

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN rm requirements.txt

CMD ["/bin/bash"]
