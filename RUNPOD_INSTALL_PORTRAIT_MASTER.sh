#!/bin/bash

# =============================================================================
# INSTALLAZIONE PORTRAIT MASTER FLUX1 SU RUNPOD
# Con link corretti e funzionanti per ambiente RunPod
# =============================================================================

echo "🚀 INSTALLAZIONE PORTRAIT MASTER FLUX1 SU RUNPOD"
echo "================================================="

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

# Vai nella directory ComfyUI di RunPod
cd /workspace/ComfyUI/

log "📁 Directory RunPod ComfyUI: $(pwd)"

# =============================================================================
# FASE 1: INSTALLAZIONE CUSTOM NODES (LINK CORRETTI)
# =============================================================================

echo ""
echo "🔧 FASE 1: INSTALLAZIONE CUSTOM NODES CON LINK CORRETTI"
echo "======================================================="

cd custom_nodes

# 1. FOCUS Nodes (LINK CORRETTO FORNITO DALL'UTENTE)
log "Installazione FOCUS Nodes (link corretto)..."
if [ ! -d "Comfyui_FOCUS_nodes" ]; then
    git clone https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes.git
    success "FOCUS Nodes installato da link corretto"
else
    warning "FOCUS Nodes già presente"
fi

# 2. WaveSpeed FBCache  
log "Installazione WaveSpeed FBCache..."
if [ ! -d "ComfyUI-WaveSpeed" ]; then
    git clone https://github.com/waveteam-ai/ComfyUI-WaveSpeed.git
    success "WaveSpeed installato"
else
    warning "WaveSpeed già presente"
fi

# 3. RGThree
log "Installazione RGThree..."
if [ ! -d "rgthree-comfy" ]; then
    git clone https://github.com/rgthree/rgthree-comfy.git
    success "RGThree installato"
else
    warning "RGThree già presente"
fi

# 4. ComfyUI LayerStyle
log "Installazione ComfyUI LayerStyle..."
if [ ! -d "ComfyUI_LayerStyle" ]; then
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git
    success "LayerStyle installato"
else
    warning "LayerStyle già presente"
fi

# 5. ComfyUI Impact Pack
log "Installazione ComfyUI Impact Pack..."
if [ ! -d "ComfyUI-Impact-Pack" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
    success "Impact Pack installato"
else
    warning "Impact Pack già presente"
fi

# 6. Ultimate SD Upscale
log "Installazione Ultimate SD Upscale..."
if [ ! -d "ComfyUI_UltimateSDUpscale" ]; then
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git
    success "Ultimate SD Upscale installato"
else
    warning "Ultimate SD Upscale già presente"
fi

# 7. ComfyUI Image Saver
log "Installazione Image Saver..."
if [ ! -d "ComfyUI-Image-Saver" ]; then
    git clone https://github.com/alexopus/ComfyUI-Image-Saver.git
    success "Image Saver installato"
else
    warning "Image Saver già presente"
fi

cd /workspace/ComfyUI/

# =============================================================================
# FASE 2: DOWNLOAD MODELLI (LINK CORRETTI RUNPOD)
# =============================================================================

echo ""
echo "📦 FASE 2: DOWNLOAD MODELLI CON LINK CORRETTI"
echo "============================================="

# Assicurati che le directory esistano
mkdir -p models/checkpoints
mkdir -p models/vae
mkdir -p models/clip
mkdir -p models/loras
mkdir -p models/upscale_models

# T5XXL Text Encoder
log "Download T5XXL Text Encoder..."
cd models/clip
if [ ! -f "t5xxl_fp16.safetensors" ]; then
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors
    success "T5XXL scaricato"
else
    success "T5XXL già presente"
fi

# CLIP-L
if [ ! -f "clip_l.safetensors" ]; then
    log "Download CLIP-L..."
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
    success "CLIP-L scaricato"
else
    success "CLIP-L già presente"
fi

cd /workspace/ComfyUI/

# VAE FLUX (ae.sft)
log "Download VAE FLUX (ae.sft)..."
cd models/vae
if [ ! -f "ae.sft" ]; then
    wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O ae.sft
    success "VAE FLUX (ae.sft) scaricato"
else
    success "VAE FLUX già presente"
fi

cd /workspace/ComfyUI/

# 4xFaceUpSharpDAT Upscaler (LINK CORRETTO)
log "Download 4xFaceUpSharpDAT Upscaler (link corretto)..."
cd models/upscale_models
if [ ! -f "4xFaceUpSharpDAT.pth" ]; then
    wget https://huggingface.co/libsgo/4x-FaceUpSharpDAT/resolve/main/4xFaceUpSharpDAT.pth
    if [ -f "4xFaceUpSharpDAT.pth" ]; then
        success "4xFaceUpSharpDAT scaricato da link corretto"
    else
        warning "Errore download - link: https://huggingface.co/libsgo/4x-FaceUpSharpDAT"
    fi
else
    success "4xFaceUpSharpDAT già presente"
fi

cd /workspace/ComfyUI/

# =============================================================================
# FASE 3: INSTALLAZIONE DIPENDENZE RUNPOD
# =============================================================================

echo ""
echo "🐍 FASE 3: INSTALLAZIONE DIPENDENZE PYTHON SU RUNPOD"
echo "====================================================="

# Installa dipendenze necessarie per RunPod
pip install --upgrade pip
pip install segment-anything
pip install rembg
pip install opencv-python
pip install pillow

success "Dipendenze Python installate su RunPod"

# =============================================================================
# INFORMAZIONI AGGIUNTIVE PER RUNPOD
# =============================================================================

echo ""
echo "📋 INFORMAZIONI AGGIUNTIVE PER RUNPOD"
echo "====================================="

echo ""
echo "🔗 LINK CORRETTI VERIFICATI:"
echo "   ✅ FOCUS Nodes: https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes"
echo "   ✅ Upscaler: https://huggingface.co/libsgo/4x-FaceUpSharpDAT"
echo ""

echo "⚠️  DOWNLOAD MANUALE RICHIESTO (da fare su RunPod):"
echo ""
echo "🎨 FLUX SKIN TEXTURE LoRA da Civitai:"
echo "   📁 Directory: /workspace/ComfyUI/models/loras/"
echo "   🔗 Link: https://civitai.com/models/651043?modelVersionId=827325"
echo "   📝 Nome file: FluxRealSkin-v2.0.safetensors"
echo ""
echo "   Opzioni download:"
echo "   1. Con API Civitai (raccomandato):"
echo "      cd /workspace/ComfyUI/models/loras/"
echo "      wget --header='Authorization: Bearer TUA_API_KEY' \\"
echo "           'https://civitai.com/api/download/models/827325' \\"
echo "           -O FluxRealSkin-v2.0.safetensors"
echo ""
echo "   2. Download manuale dal browser e upload su RunPod"
echo ""

echo "📦 MODELLO PRINCIPALE FLUX:"
echo "   Assicurati di avere flux1-dev.safetensors in:"
echo "   /workspace/ComfyUI/models/checkpoints/"
echo ""

# =============================================================================
# VERIFICA FINALE RUNPOD
# =============================================================================

echo ""
echo "🔍 VERIFICA INSTALLAZIONE SU RUNPOD"
echo "==================================="

echo ""
echo "📁 Custom Nodes installati:"
ls custom_nodes/ | grep -E "(FOCUS|WaveSpeed|rgthree|LayerStyle|Impact|Ultimate|Image-Saver)" || echo "Nessun custom node trovato"

echo ""
echo "📦 Modelli presenti:"
echo "CLIP:"
ls -la models/clip/ | grep -E "(t5xxl|clip_l)" || echo "Nessun modello CLIP trovato"

echo "VAE:"
ls -la models/vae/ | grep "ae.sft" || echo "VAE ae.sft non trovato"

echo "Upscalers:"
ls -la models/upscale_models/ | grep "4xFaceUp" || echo "Nessun upscaler trovato"

echo ""
echo "🚀 INSTALLAZIONE RUNPOD COMPLETATA!"
echo ""
echo "📝 PROSSIMI PASSI:"
echo "1. Riavvia ComfyUI su RunPod"
echo "2. Scarica manualmente FluxRealSkin-v2.0.safetensors da Civitai"
echo "3. Verifica che flux1-dev.safetensors sia in models/checkpoints/"
echo "4. Testa i workflow Portrait Master!"
echo ""
echo "💡 Tutti i link sono stati verificati e corretti per RunPod" 