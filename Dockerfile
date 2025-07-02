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

# Clone ComfyUI first
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

# Copy project files
COPY . /workspace/

# Install Python packages (without torch conflicts)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    transformers>=4.25.1 \
    tokenizers>=0.13.3 \
    sentencepiece \
    safetensors>=0.4.2 \
    aiohttp \
    accelerate \
    pyyaml \
    Pillow \
    scipy \
    tqdm \
    psutil \
    opencv-python==4.10.0.84 \
    opencv-contrib-python==4.10.0.84 \
    numpy==1.26.4 \
    matplotlib \
    imageio \
    imageio-ffmpeg \
    requests \
    fastapi \
    uvicorn \
    websockets \
    aiofiles \
    huggingface-hub \
    diffusers \
    compel \
    python-multipart \
    python-dotenv \
    typing-extensions \
    runpod \
    bitsandbytes \
    optimum \
    einops \
    librosa \
    soundfile \
    gitpython \
    wget

# Install ComfyUI dependencies
RUN cd /workspace/ComfyUI && \
    pip install --no-cache-dir -r requirements.txt || echo "ComfyUI requirements skipped"

# Create models directories
RUN mkdir -p /workspace/ComfyUI/models/{checkpoints,vae,loras,embeddings,upscale_models,controlnet,clip_vision,style_models,unet,diffusion_models,text_encoders,clip}

# Setup ComfyUI custom nodes directory
RUN mkdir -p /workspace/ComfyUI/custom_nodes

# Install essential custom nodes
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true

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