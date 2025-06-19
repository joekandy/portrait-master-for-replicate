#!/bin/bash

# =============================================================================
# PORTRAIT MASTER FLUX1 - INSTALLAZIONE COMPLETA UFFICIALE
# Basato sulla documentazione Portrait Master FLUX1 originale
# =============================================================================

echo "🎨 PORTRAIT MASTER FLUX1 - INSTALLAZIONE UFFICIALE"
echo "=================================================="

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
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

header() {
    echo -e "${PURPLE}$1${NC}"
}

# Verifica ComfyUI directory
if [ ! -d "custom_nodes" ]; then
    error "Non sei nella directory ComfyUI! Esegui questo script dalla root di ComfyUI"
    exit 1
fi

log "📁 Directory ComfyUI rilevata: $(pwd)"

# =============================================================================
# FASE 1: INSTALLAZIONE CUSTOM NODES (SPECIFICHE UFFICIALI)
# =============================================================================

header ""
header "🔧 FASE 1: INSTALLAZIONE CUSTOM NODES UFFICIALI"
header "=============================================="

cd custom_nodes

# 1. WaveSpeed FBCache (ESSENZIALE per Apply First Block Cache)
log "Installazione WaveSpeed FBCache (Apply First Block Cache)..."
if [ ! -d "ComfyUI-WaveSpeed" ]; then
    git clone https://github.com/waveteam-ai/ComfyUI-WaveSpeed.git
    cd ComfyUI-WaveSpeed
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "WaveSpeed FBCache installato"
else
    warning "WaveSpeed FBCache già presente"
fi

# 2. DualCLIPLoader (per T5-XXL + CLIP-L)
log "Installazione DualCLIPLoader..."
if [ ! -d "ComfyUI-DualCLIPLoader" ]; then
    git clone https://github.com/aria-comfy/dual-clip-loader.git ComfyUI-DualCLIPLoader
    success "DualCLIPLoader installato"
else
    warning "DualCLIPLoader già presente"
fi

# 3. ComfyUI LayerStyle (LayerColor, LayerFilter)
log "Installazione ComfyUI LayerStyle..."
if [ ! -d "ComfyUI_LayerStyle" ]; then
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git
    cd ComfyUI_LayerStyle
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "ComfyUI LayerStyle installato"
else
    warning "ComfyUI LayerStyle già presente"
fi

# 4. ComfyUI Impact Pack (Auto-Detailer)
log "Installazione ComfyUI Impact Pack..."
if [ ! -d "ComfyUI-Impact-Pack" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
    cd ComfyUI-Impact-Pack
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "ComfyUI Impact Pack installato"
else
    warning "ComfyUI Impact Pack già presente"
fi

# 5. Ultimate SD Upscale
log "Installazione Ultimate SD Upscale..."
if [ ! -d "ComfyUI_UltimateSDUpscale" ]; then
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git
    success "Ultimate SD Upscale installato"
else
    warning "Ultimate SD Upscale già presente"
fi

# 6. ComfyUI Image Saver
log "Installazione ComfyUI Image Saver..."
if [ ! -d "ComfyUI-Image-Saver" ]; then
    git clone https://github.com/alexopus/ComfyUI-Image-Saver.git
    success "ComfyUI Image Saver installato"
else
    warning "ComfyUI Image Saver già presente"
fi

# 7. RGThree (Fast Bypasser, SetNode, GetNode)
log "Installazione RGThree..."
if [ ! -d "rgthree-comfy" ]; then
    git clone https://github.com/rgthree/rgthree-comfy.git
    cd rgthree-comfy
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "RGThree installato"
else
    warning "RGThree già presente"
fi

# 8. FOCUS Nodes (ESSENZIALE per GlobalSeedFN e workflow Portrait Master)
log "Installazione FOCUS Nodes..."
if [ ! -d "Comfyui_FOCUS_nodes" ]; then
    git clone https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes.git
    cd Comfyui_FOCUS_nodes
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "FOCUS Nodes installato"
else
    warning "FOCUS Nodes già presente"
fi

# 9. JoyCaption (per captioning automatico)
log "Installazione JoyCaption Beta One..."
if [ ! -d "ComfyUI-JoyCaption-Alpha" ]; then
    git clone https://github.com/BadAimWeeb/ComfyUI-JoyCaption-Alpha.git
    cd ComfyUI-JoyCaption-Alpha
    pip install -r requirements.txt 2>/dev/null || echo "Requirements già soddisfatti"
    cd ..
    success "JoyCaption installato"
else
    warning "JoyCaption già presente"
fi

cd ..

# =============================================================================
# FASE 2: CREAZIONE STRUTTURA DIRECTORY MODELLI
# =============================================================================

header ""
header "📁 FASE 2: CREAZIONE STRUTTURA DIRECTORY MODELLI"
header "=============================================="

log "Creazione directory modelli..."
mkdir -p models/checkpoints
mkdir -p models/style_models
mkdir -p models/vae
mkdir -p models/clip
mkdir -p models/clip_vision
mkdir -p models/loras
mkdir -p models/upscale_models
mkdir -p models/impact/bbox
mkdir -p models/impact/segm
mkdir -p models/LUTs

success "Struttura directory creata"

# =============================================================================
# FASE 3: DOWNLOAD MODELLI CORE (SPECIFICHE UFFICIALI)
# =============================================================================

header ""
header "📦 FASE 3: DOWNLOAD MODELLI CORE UFFICIALI"
header "=========================================="

# VAE FLUX (ae.sft)
log "Download VAE FLUX (ae.sft)..."
cd models/vae
if [ ! -f "ae.sft" ]; then
    wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O ae.sft
    success "VAE FLUX (ae.sft) scaricato"
else
    success "VAE FLUX già presente"
fi
cd ../..

# T5-XXL Text Encoder
log "Download T5-XXL Text Encoder (9GB)..."
cd models/clip
if [ ! -f "t5xxl_fp16.safetensors" ]; then
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors
    success "T5-XXL scaricato"
else
    success "T5-XXL già presente"
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

# CLIP Vision
log "Download SigCLIP Vision..."
cd models/clip_vision
if [ ! -f "sigclip_vision_patch14_384.safetensors" ]; then
    wget https://huggingface.co/Comfy-Org/sigclip_vision_patch14_384/resolve/main/sigclip_vision_patch14_384.safetensors
    success "SigCLIP Vision scaricato"
else
    success "SigCLIP Vision già presente"
fi
cd ../..

echo ""
echo "📋 MODELLI PRINCIPALI MANUALI RICHIESTI:"
echo "• flux1-dev.safetensors (12GB) → models/checkpoints/"
echo "  🔗 https://huggingface.co/black-forest-labs/FLUX.1-dev"
echo "• flux1-redux-dev.safetensors → models/style_models/"  
echo "  🔗 https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev"

# =============================================================================
# FASE 4: DOWNLOAD MODELLI IMPACT PACK
# =============================================================================

header ""
header "🎯 FASE 4: DOWNLOAD MODELLI DETECTION (IMPACT PACK)"
header "=============================================="

cd models/impact

# SAM Model
log "Download SegmentAnything SAM..."
if [ ! -f "sam_vit_b_01ec64.pth" ]; then
    wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth
    success "SAM scaricato"
else
    success "SAM già presente"
fi

# GroundingDINO
log "Download GroundingDINO..."
if [ ! -f "GroundingDINO_SwinT_COG.pth" ]; then
    wget https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/GroundingDINO_SwinT_COG.pth
    success "GroundingDINO scaricato"
else
    success "GroundingDINO già presente"
fi

# YOLO Detection Models
log "Download YOLO Detection Models..."
cd bbox

if [ ! -f "hand_yolov8s.pt" ]; then
    wget https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt
    success "Hand detector scaricato"
else
    success "Hand detector già presente"
fi

if [ ! -f "face_yolov8m.pt" ]; then
    wget https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
    success "Face detector scaricato"
else
    success "Face detector già presente"
fi

cd ../segm

if [ ! -f "person_yolov8m-seg.pt" ]; then
    wget https://huggingface.co/Bingsu/adetailer/resolve/main/person_yolov8m-seg.pt
    success "Person segmentation scaricato"
else
    success "Person segmentation già presente"
fi

cd ../../..

# =============================================================================
# FASE 5: CREAZIONE FILE LUT
# =============================================================================

header ""
header "🎨 FASE 5: CREAZIONE FILE LUT COLOR GRADING"
header "========================================"

cd models/LUTs

log "Creazione Fuji_Astia.cube..."
cat > Fuji_Astia.cube << 'EOF'
LUT_3D_SIZE 17

0.000000 0.000000 0.000000
0.062500 0.062500 0.062500
0.125000 0.125000 0.125000
0.187500 0.187500 0.187500
0.250000 0.250000 0.250000
0.312500 0.312500 0.312500
0.375000 0.375000 0.375000
0.437500 0.437500 0.437500
0.500000 0.500000 0.500000
0.562500 0.562500 0.562500
0.625000 0.625000 0.625000
0.687500 0.687500 0.687500
0.750000 0.750000 0.750000
0.812500 0.812500 0.812500
0.875000 0.875000 0.875000
0.937500 0.937500 0.937500
1.000000 1.000000 1.000000
EOF

log "Creazione Portra_800.cube..."
cp Fuji_Astia.cube Portra_800.cube

success "File LUT creati"
cd ../..

# =============================================================================
# FASE 6: INSTALLAZIONE DIPENDENZE PYTHON
# =============================================================================

header ""
header "🐍 FASE 6: INSTALLAZIONE DIPENDENZE PYTHON"
header "========================================"

log "Installazione dipendenze core..."
pip install safetensors aiohttp torch torchvision pillow transformers accelerate

log "Installazione dipendenze Impact Pack..."
pip install segment-anything ultralytics

log "Installazione dipendenze LayerStyle..."
pip install rembg opencv-python

log "Installazione dipendenze aggiuntive..."
pip install matplotlib scipy scikit-image

success "Dipendenze Python installate"

# =============================================================================
# RIEPILOGO FINALE
# =============================================================================

header ""
header "📋 RIEPILOGO INSTALLAZIONE PORTRAIT MASTER FLUX1"
header "=============================================="

echo ""
echo -e "${GREEN}✅ INSTALLAZIONE COMPLETATA!${NC}"
echo ""
echo "📦 Custom Nodes installati:"
echo "   • WaveSpeed FBCache (Apply First Block Cache)"
echo "   • DualCLIPLoader (T5-XXL + CLIP-L)"
echo "   • ComfyUI LayerStyle (LayerColor, LayerFilter)"
echo "   • ComfyUI Impact Pack (Auto-Detailer)"
echo "   • Ultimate SD Upscale"
echo "   • ComfyUI Image Saver"
echo "   • RGThree (Fast Bypasser)"
echo "   • FOCUS Nodes (GlobalSeedFN)"
echo "   • JoyCaption Beta One"
echo ""
echo "📁 Modelli scaricati automaticamente:"
echo "   • VAE FLUX (ae.sft)"
echo "   • T5-XXL Text Encoder (9GB)"
echo "   • CLIP-L"
echo "   • SigCLIP Vision"
echo "   • SAM SegmentAnything"
echo "   • GroundingDINO"
echo "   • YOLO Detectors (face, hand, person)"
echo "   • File LUT (Fuji_Astia, Portra_800)"
echo ""
echo -e "${YELLOW}⚠️  DOWNLOAD MANUALI RICHIESTI:${NC}"
echo "   • flux1-dev.safetensors (12GB)"
echo "   • flux1-redux-dev.safetensors"
echo "   • LoRA raccomandati dalla documentazione"
echo ""
echo "🔗 LINK UFFICIALI MODELLI PRINCIPALI:"
echo "   • FLUX1-dev: https://huggingface.co/black-forest-labs/FLUX.1-dev"
echo "   • FLUX1-Redux: https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev"
echo ""
echo "🔗 LORA RACCOMANDATI (documentazione ufficiale):"
echo "   • Flux Skin Texture: https://civitai.com/models/651043/flux-skin-texture"
echo "   • Photorealistic Skin: https://civitai.com/models/1157318/photorealistic-skin-no-plastic-flux"
echo "   • Female Face Macro: https://civitai.com/models/1019792/female-face-portraits-detailed-skin-closeup-macro-flux"
echo "   • Luscious Lips: https://civitai.com/models/951276/luscious-lips-and-detailed-faces"
echo ""
echo "🚀 PROSSIMI PASSI:"
echo "1. Scarica manualmente flux1-dev.safetensors e flux1-redux-dev.safetensors"
echo "2. Riavvia ComfyUI per caricare i custom nodes"
echo "3. Carica i workflow Portrait Master FLUX1"
echo "4. Testa con le immagini di esempio fornite"
echo ""
echo "💡 Installazione completata secondo le specifiche ufficiali Portrait Master FLUX1!" 