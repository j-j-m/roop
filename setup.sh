#!/bin/bash
set -e

echo "===== Setting up roop with CUDA GPU support ====="

# Check for CUDA (nvcc)
if ! command -v nvcc &> /dev/null; then
    echo "ERROR: CUDA Toolkit not found."
    echo "Please install CUDA Toolkit 11.8 and cuDNN for CUDA 11.x."
    echo "Visit https://developer.nvidia.com/cuda-toolkit for installation instructions."
    exit 1
else
    echo "CUDA detected:"
    nvcc --version
fi

# Update pip
echo "Updating pip..."
python3 -m pip install --upgrade pip

# Uninstall existing onnxruntime packages if present
echo "Uninstalling onnxruntime and onnxruntime-gpu (if installed)..."
pip uninstall -y onnxruntime onnxruntime-gpu || true

# Install the required onnxruntime-gpu version
echo "Installing onnxruntime-gpu==1.15.1..."
pip install onnxruntime-gpu==1.15.1

# Create folder structure for files outside the current folder
BASE_FOLDER="/workspace/files"
echo "Creating folder structure at $BASE_FOLDER..."
mkdir -p "$BASE_FOLDER/face_image" "$BASE_FOLDER/video_input" "$BASE_FOLDER/video_output"

echo "===== Setup complete ====="
echo "Now, run your roop command separately. For example:"
echo "python3 run.py --execution-provider cuda -s $BASE_FOLDER/face_image/rdj.png -t \"$BASE_FOLDER/video_input/Gjovani - Kalaja e Ulqinit.mp4\" -o $BASE_FOLDER/video_output/output.mp4"
