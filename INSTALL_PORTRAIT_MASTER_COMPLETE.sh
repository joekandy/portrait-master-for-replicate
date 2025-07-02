#!/bin/bash

# =============================================================================
# INSTALLAZIONE COMPLETA PORTRAIT MASTER FLUX1 - VERSIONE AGGIORNATA
# Con link corretti e funzionanti
# =============================================================================

echo "🎨 Portrait Master FLUX Complete Installation"
echo "============================================"

# Vai nella directory ComfyUI
cd /workspace/ComfyUI

echo "📦 Step 1: Download FLUX Core Models..."

# CLIP Text Encoders
echo "📥 Downloading CLIP Text Encoders..."
wget -O models/clip/clip_l.safetensors "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
wget -O models/clip/t5xxl_fp16.safetensors "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"

# VAE FLUX
echo "📥 Downloading FLUX VAE..."
wget -O models/vae/ae.safetensors "https://huggingface.co/ffxvs/vae-flux/resolve/main/ae.safetensors"

# FLUX Redux Style Model
echo "📥 Downloading FLUX Redux Style Model..."
mkdir -p models/style_models
wget -O models/style_models/flux1-redux-dev.safetensors "https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev/resolve/main/flux1-redux-dev.safetensors"

# CLIP Vision per Redux
echo "📥 Downloading CLIP Vision for Redux..."
wget -O models/clip_vision/sigclip_vision_patch14_384.safetensors "https://huggingface.co/Comfy-Org/sigclip_vision_384/resolve/main/sigclip_vision_patch14_384.safetensors"

echo "🔧 Step 2: Install Required Custom Nodes..."

cd custom_nodes

# WaveSpeed FBCache
echo "📥 Installing WaveSpeed FBCache..."
git clone https://github.com/wavespeed-comfy/comfy_fbcache.git

# ComfyUI-portrait-master
echo "📥 Installing Portrait Master..."
git clone https://github.com/florestefano1975/comfyui-portrait-master.git

# ComfyUI-KJNodes
echo "📥 Installing KJNodes..."
git clone https://github.com/kijai/ComfyUI-KJNodes.git

# ComfyUI Easy Use
echo "📥 Installing Easy Use..."
git clone https://github.com/yolain/ComfyUI-Easy-Use.git

# ComfyUI-mxtoolkit
echo "📥 Installing MX Toolkit..."
git clone https://github.com/mixlabteam/ComfyUI-mxtoolkit.git

# LayerStyle 
echo "📥 Installing LayerStyle..."
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git

echo "🎭 Step 3: Install Portrait Enhancement LoRAs..."

cd ../models/loras

# LoRA per texture pelle (usando link diretti Civitai)
echo "📥 Downloading Skin Enhancement LoRAs..."

# Flux Skin Texture
curl -L -o flux_skin_texture.safetensors "https://civitai.com/api/download/models/651043?type=Model&format=SafeTensor"

# Photorealistic Skin
curl -L -o photorealistic_skin_no_plastic.safetensors "https://civitai.com/api/download/models/1157318?type=Model&format=SafeTensor"

# Skin Tone Glamour
curl -L -o skin_tone_glamour.safetensors "https://civitai.com/api/download/models/562884?type=Model&format=SafeTensor"

# Female Face Macro
curl -L -o female_face_macro.safetensors "https://civitai.com/api/download/models/1019792?type=Model&format=SafeTensor"

# Luscious Lips
curl -L -o luscious_lips.safetensors "https://civitai.com/api/download/models/951276?type=Model&format=SafeTensor"

# ESC Makeup
curl -L -o esc_makeup.safetensors "https://civitai.com/api/download/models/1060990?type=Model&format=SafeTensor"

echo "🌐 Step 4: Setup Gradio Interface..."

cd /workspace

# Install Gradio
pip install gradio requests Pillow numpy

# Clone Gradio API wrapper
cd ComfyUI/custom_nodes
git clone https://github.com/SharCodin/comfy-gradio-api.git

echo "✅ Installation Complete!"
echo ""
echo "🚀 To start ComfyUI with Gradio:"
echo "   cd /workspace/ComfyUI"
echo "   python main.py --listen 0.0.0.0 --port 8188"
echo ""
echo "🎯 Portrait Master workflows are ready!"
echo "📁 Location: ComfyUI/custom_nodes/comfyui-portrait-master/"
echo ""
echo "🔗 For Gradio web interface:"
echo "   cd custom_nodes/comfy-gradio-api"
echo "   python app.py" 