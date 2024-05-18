# Use a CUDA base image with Python 3.11 support
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Get the latest version of the code
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/rhasspy/piper

# Update pip and install the required packages
RUN pip install --upgrade pip

# Set the working directory
WORKDIR /app/piper/src/python_run

# Install the package
RUN pip install -e .

# Install the requirements
RUN pip install -r requirements.txt

# Install GPU requirements
RUN pip install -r requirements_gpu.txt

# Install HTTP server requirements
RUN pip install -r requirements_http.txt

# Install wget pip package
RUN pip install wget

# Copy the run.py file into the container
COPY run.py /app
# Copy the download folder into the container
COPY download /app/download

# Expose the port 5000
EXPOSE 5000

# Create ENV that will be used in the run.py file to set the download link
ENV MODEL_DOWNLOAD_LINK="https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/high/en_US-lessac-high.onnx?download=true"

# Create ENV that will be used in the run.py file to set the target folder
ENV MODEL_TARGET_FOLDER="/app/models"

# Create ENV that will be used in the run.py file to set the speaker
ENV SPEAKER="0"

# Run the webserver with python run.py
CMD python3 /app/run.py $MODEL_DOWNLOAD_LINK $MODEL_TARGET_FOLDER $SPEAKER