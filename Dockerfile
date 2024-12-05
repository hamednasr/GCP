# Use a lightweight base image with Python and CUDA for PyTorch compatibility
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Set environment variables for Python and CUDA
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    ffmpeg \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set Python 3.10 as default
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8083

# Set the command to run the Flask app
CMD ["python", "inference-flask.py"]