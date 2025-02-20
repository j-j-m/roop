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

# Downgrade NumPy to a version below 2.0 for compatibility
echo "Installing numpy version < 2.0..."
pip install "numpy<2"

# Uninstall existing onnxruntime packages if present
echo "Uninstalling onnxruntime and onnxruntime-gpu (if installed)..."
pip uninstall -y onnxruntime onnxruntime-gpu || true

# Install the required onnxruntime-gpu version
echo "Installing onnxruntime-gpu==1.15.1..."
pip install onnxruntime-gpu==1.15.1

# Install TensorFlow
echo "Installing TensorFlow..."
pip install tensorflow

# Install customtkinter (required for the GUI module)
echo "Installing customtkinter..."
pip install customtkinter

# Install tkinterdnd2 (for drag-and-drop support in the GUI)
echo "Installing tkinterdnd2..."
pip install tkinterdnd2

# Install tkinter via the system package (python3-tk)
echo "Installing python3-tk..."
apt-get update && apt-get install -y python3-tk

# Install ffmpeg (required by roop)
echo "Installing ffmpeg..."
apt-get update && apt-get install -y ffmpeg

# Install OpenCV (using the headless package for headless environments)
echo "Installing OpenCV (headless)..."
pip install opencv-python-headless

# Install insightface (for face analysis functionality)
echo "Installing insightface..."
pip install insightface

# Install opennsfw2 (for NSFW detection functionality)
echo "Installing opennsfw2..."
pip install opennsfw2

# Create folder structure for files outside the current folder
BASE_FOLDER="/workspace/files"
echo "Creating folder structure at $BASE_FOLDER..."
mkdir -p "$BASE_FOLDER/face_image" "$BASE_FOLDER/video_input" "$BASE_FOLDER/video_output"

echo "===== Setup complete ====="
echo "Now, run your roop command separately. For example:"
echo "python3 run.py --execution-provider cuda -s \$BASE_FOLDER/face_image/rdj.png -t \"\$BASE_FOLDER/video_input/Gjovani - Kalaja e Ulqinit.mp4\" -o \$BASE_FOLDER/video_output/output.mp4"
