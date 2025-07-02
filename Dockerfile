# Portrait Master V1 - RunPod Serverless
FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    unzip \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages first (better caching)
COPY requirements.txt /workspace/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

# Install ComfyUI dependencies
RUN cd /workspace/ComfyUI && \
    pip install --no-cache-dir -r requirements.txt

# Create models directories
RUN mkdir -p /workspace/ComfyUI/models/{checkpoints,vae,loras,embeddings,upscale_models,controlnet,clip_vision,style_models,unet,diffusion_models,text_encoders,clip}

# Copy project files
COPY . /workspace/

# Setup ComfyUI custom nodes directory
RUN mkdir -p /workspace/ComfyUI/custom_nodes

# Install essential custom nodes
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git || true

# Install custom nodes dependencies (with error handling)
RUN cd /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui && \
    pip install --no-cache-dir -r requirements.txt || true

# Make scripts executable
RUN chmod +x /workspace/scripts/*.sh || true

# Setup ComfyUI Manager without restrictions
RUN mkdir -p /workspace/ComfyUI/custom_nodes/ComfyUI-Manager && \
    echo '{"security_level": 0, "skip_update_check": true, "channel_url": "https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main", "share_option": "all", "bypass_ssl": true}' > /workspace/ComfyUI/custom_nodes/ComfyUI-Manager/config.ini

# Download essential models (with error handling)
RUN /workspace/scripts/download_models.sh || echo "Model download failed - will try at runtime"

# Setup environment variables
ENV PYTHONPATH="/workspace:/workspace/ComfyUI"
ENV COMFYUI_PATH="/workspace/ComfyUI"
ENV CUDA_VISIBLE_DEVICES=0
ENV PYTORCH_CUDA_ALLOC_CONF="max_split_size_mb:512,expandable_segments:True"
ENV CUBLAS_WORKSPACE_CONFIG=":16:8"
ENV COMFYUI_DISABLE_FP8=1

# Expose port (for local testing)
EXPOSE 8188

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8188/system_stats || exit 1

# Default command for RunPod serverless
CMD ["python", "-u", "handler.py"] 