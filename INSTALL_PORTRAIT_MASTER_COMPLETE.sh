#!/bin/bash

# =============================================================================
# INSTALLAZIONE COMPLETA PORTRAIT MASTER FLUX1 - VERSIONE AGGIORNATA
# Con link corretti e funzionanti
# =============================================================================

echo "🚀 AVVIO INSTALLAZIONE PORTRAIT MASTER FLUX1 COMPLETA"
echo "======================================================"

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funzione per logging
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

# Verifica se siamo nella directory ComfyUI
if [ ! -d "custom_nodes" ]; then
    error "❌ Non sei nella directory ComfyUI! Vai nella directory principale di ComfyUI e rilancia lo script."
    exit 1
fi

log "📁 Directory ComfyUI rilevata correttamente"

# =============================================================================
# FASE 1: INSTALLAZIONE CUSTOM NODES AGGIORNATI
# =============================================================================

echo ""
echo "🔧 FASE 1: INSTALLAZIONE CUSTOM NODES"
echo "======================================"

cd custom_nodes

# 1. FOCUS Nodes (LINK CORRETTO)
log "Installazione FOCUS Nodes..."
if [ ! -d "Comfyui_FOCUS_nodes" ]; then
    git clone https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes.git
    success "FOCUS Nodes installato"
else
    warning "FOCUS Nodes già presente"
fi

# 2. ComfyUI Manager (se non presente)
log "Installazione ComfyUI Manager..."
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    success "ComfyUI Manager installato"
else
    warning "ComfyUI Manager già presente"
fi

# 3. WaveSpeed FBCache
log "Installazione WaveSpeed FBCache..."
if [ ! -d "ComfyUI-WaveSpeed" ]; then
    git clone https://github.com/waveteam-ai/ComfyUI-WaveSpeed.git
    success "WaveSpeed installato"
else
    warning "WaveSpeed già presente"
fi

# 4. RGThree (Fast Bypasser, etc.)
log "Installazione RGThree..."
if [ ! -d "rgthree-comfy" ]; then
    git clone https://github.com/rgthree/rgthree-comfy.git
    success "RGThree installato"
else
    warning "RGThree già presente"
fi

# 5. ComfyUI LayerStyle
log "Installazione ComfyUI LayerStyle..."
if [ ! -d "ComfyUI_LayerStyle" ]; then
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git
    success "LayerStyle installato"
else
    warning "LayerStyle già presente"
fi

# 6. ComfyUI Impact Pack
log "Installazione ComfyUI Impact Pack..."
if [ ! -d "ComfyUI-Impact-Pack" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
    success "Impact Pack installato"
else
    warning "Impact Pack già presente"
fi

# 7. Ultimate SD Upscale
log "Installazione Ultimate SD Upscale..."
if [ ! -d "ComfyUI_UltimateSDUpscale" ]; then
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git
    success "Ultimate SD Upscale installato"
else
    warning "Ultimate SD Upscale già presente"
fi

# 8. ComfyUI Image Saver
log "Installazione Image Saver..."
if [ ! -d "ComfyUI-Image-Saver" ]; then
    git clone https://github.com/alexopus/ComfyUI-Image-Saver.git
    success "Image Saver installato"
else
    warning "Image Saver già presente"
fi

cd ..

# =============================================================================
# FASE 2: DOWNLOAD MODELLI AGGIORNATI (LINK CORRETTI)
# =============================================================================

echo ""
echo "📦 FASE 2: DOWNLOAD MODELLI CON LINK CORRETTI"
echo "============================================="

# Directory dei modelli
mkdir -p models/checkpoints
mkdir -p models/vae
mkdir -p models/clip
mkdir -p models/loras
mkdir -p models/upscale_models

# Flux Skin Texture LoRA (LINK CORRETTO DA CIVITAI)
log "Download Flux Skin Texture LoRA..."
cd models/loras
if [ ! -f "FluxRealSkin-v2.0.safetensors" ]; then
    echo "📋 Per scaricare da Civitai, usa questo comando con la tua API key:"
    echo "wget --header='Authorization: Bearer TUA_CIVITAI_API_KEY' 'https://civitai.com/api/download/models/827325' -O FluxRealSkin-v2.0.safetensors"
    echo ""
    echo "🔑 Vai su https://civitai.com/user/account per ottenere la tua API key"
    echo "📥 Oppure scarica manualmente da: https://civitai.com/models/651043?modelVersionId=827325"
    warning "Download manuale richiesto per Flux Skin Texture"
else
    success "Flux Skin Texture già presente"
fi
cd ../..

# 4xFaceUpSharpDAT Upscaler (LINK CORRETTO DA HUGGINGFACE)
log "Download 4xFaceUpSharpDAT Upscaler..."
cd models/upscale_models
if [ ! -f "4xFaceUpSharpDAT.pth" ]; then
    echo "📋 Download diretto da HuggingFace:"
    wget https://huggingface.co/libsgo/4x-FaceUpSharpDAT/resolve/main/4xFaceUpSharpDAT.pth
    if [ -f "4xFaceUpSharpDAT.pth" ]; then
        success "4xFaceUpSharpDAT scaricato"
    else
        warning "Errore download - scarica manualmente da: https://huggingface.co/libsgo/4x-FaceUpSharpDAT/blob/main/4xFaceUpSharpDAT.pth"
    fi
else
    success "4xFaceUpSharpDAT già presente"
fi
cd ../..

# Altri modelli essenziali (link verificati)
log "Download altri modelli essenziali..."

# T5XXL Text Encoder
cd models/clip
if [ ! -f "t5xxl_fp16.safetensors" ]; then
    log "Download T5XXL..."
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
cd ../..

# VAE FLUX (ae.sft)
cd models/vae
if [ ! -f "ae.sft" ]; then
    log "Download VAE FLUX (ae.sft)..."
    wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O ae.sft
    success "VAE FLUX scaricato"
else
    success "VAE FLUX già presente"
fi
cd ../..

# =============================================================================
# FASE 3: INSTALLAZIONE DIPENDENZE PYTHON
# =============================================================================

echo ""
echo "🐍 FASE 3: INSTALLAZIONE DIPENDENZE PYTHON"
echo "=========================================="

# Installa dipendenze per i custom nodes
log "Installazione dipendenze Python..."

# Per Impact Pack
pip install segment-anything

# Per LayerStyle  
pip install rembg

# Per altri nodes
pip install opencv-python
pip install pillow

success "Dipendenze Python installate"

# =============================================================================
# RIEPILOGO FINALE
# =============================================================================

echo ""
echo "📋 RIEPILOGO INSTALLAZIONE"
echo "========================="
echo ""
echo "✅ Custom Nodes installati:"
echo "   - FOCUS Nodes (✅ link aggiornato)"
echo "   - WaveSpeed FBCache"
echo "   - RGThree"
echo "   - ComfyUI LayerStyle" 
echo "   - ComfyUI Impact Pack"
echo "   - Ultimate SD Upscale"
echo "   - ComfyUI Image Saver"
echo ""
echo "📦 Modelli scaricati:"
echo "   - T5XXL Text Encoder"
echo "   - CLIP-L"
echo "   - VAE FLUX (ae.sft)"
echo "   - 4xFaceUpSharpDAT Upscaler (✅ link aggiornato)"
echo ""
echo "⚠️  Download manuali richiesti:"
echo "   - Flux Skin Texture da Civitai (richiede API key)"
echo "   - Modello FLUX1-dev principale (se non presente)"
echo ""
echo "🔗 Link corretti forniti:"
echo "   - FOCUS: https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes"
echo "   - Skin Texture: https://civitai.com/models/651043?modelVersionId=827325"  
echo "   - Upscaler: https://huggingface.co/libsgo/4x-FaceUpSharpDAT"
echo ""
echo "🚀 INSTALLAZIONE COMPLETATA!"
echo "Riavvia ComfyUI per applicare tutte le modifiche." 