#!/bin/bash

# =============================================================================
# DOWNLOAD MODELLI CON LINK CORRETTI E FUNZIONANTI
# =============================================================================

echo "📥 DOWNLOAD MODELLI CON LINK CORRETTI"
echo "====================================="

# Colori per output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Verifica directory ComfyUI
if [ ! -d "models" ]; then
    echo "❌ Directory models non trovata! Esegui dalla directory principale di ComfyUI"
    exit 1
fi

echo "📁 Directory ComfyUI trovata"

# =============================================================================
# 1. FOCUS NODES (già nell'installazione principale)
# =============================================================================
echo ""
echo "🎯 FOCUS Nodes"
echo "Link: https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes"
echo "✅ Installato tramite script principale"

# =============================================================================
# 2. FLUX SKIN TEXTURE LORA (CIVITAI)
# =============================================================================
echo ""
echo "🎨 FLUX SKIN TEXTURE LoRA"
echo "========================="

cd models/loras

echo "📋 FLUX Skin Texture v2.0 da Civitai"
echo "🔗 Link: https://civitai.com/models/651043?modelVersionId=827325"
echo ""

if [ ! -f "FluxRealSkin-v2.0.safetensors" ]; then
    echo -e "${YELLOW}⚠️  DOWNLOAD MANUALE RICHIESTO${NC}"
    echo ""
    echo "🔑 OPZIONE 1 - Con API key Civitai:"
    echo "   1. Vai su https://civitai.com/user/account"
    echo "   2. Copia la tua API key"
    echo "   3. Esegui:"
    echo "      wget --header='Authorization: Bearer TUA_API_KEY' \\"
    echo "           'https://civitai.com/api/download/models/827325' \\"
    echo "           -O FluxRealSkin-v2.0.safetensors"
    echo ""
    echo "🌐 OPZIONE 2 - Download manuale:"
    echo "   1. Apri: https://civitai.com/models/651043?modelVersionId=827325"
    echo "   2. Clicca Download"
    echo "   3. Salva come: FluxRealSkin-v2.0.safetensors"
    echo "   4. Sposta in: models/loras/"
    echo ""
    read -p "Premi INVIO quando hai completato il download..."
else
    echo -e "${GREEN}✅ FluxRealSkin-v2.0.safetensors già presente${NC}"
fi

cd ../..

# =============================================================================
# 3. 4X FACEUPSHARP UPSCALER (HUGGINGFACE)
# =============================================================================
echo ""
echo "🔍 4X FACEUPSHARP UPSCALER"
echo "=========================="

cd models/upscale_models

echo "📋 4xFaceUpSharpDAT da HuggingFace"
echo "🔗 Link: https://huggingface.co/libsgo/4x-FaceUpSharpDAT"

if [ ! -f "4xFaceUpSharpDAT.pth" ]; then
    echo ""
    echo -e "${BLUE}📥 Download in corso...${NC}"
    
    # Prova download diretto
    wget https://huggingface.co/libsgo/4x-FaceUpSharpDAT/resolve/main/4xFaceUpSharpDAT.pth
    
    # Verifica successo
    if [ -f "4xFaceUpSharpDAT.pth" ]; then
        echo -e "${GREEN}✅ 4xFaceUpSharpDAT.pth scaricato con successo!${NC}"
    else
        echo -e "${YELLOW}⚠️  Download automatico fallito${NC}"
        echo ""
        echo "🌐 DOWNLOAD MANUALE:"
        echo "   1. Apri: https://huggingface.co/libsgo/4x-FaceUpSharpDAT/blob/main/4xFaceUpSharpDAT.pth"
        echo "   2. Clicca 'download'"
        echo "   3. Salva in: models/upscale_models/"
        echo ""
        read -p "Premi INVIO quando hai completato il download..."
    fi
else
    echo -e "${GREEN}✅ 4xFaceUpSharpDAT.pth già presente${NC}"
fi

cd ../..

# =============================================================================
# 4. ALTRI MODELLI ESSENZIALI
# =============================================================================
echo ""
echo "📦 ALTRI MODELLI ESSENZIALI"
echo "==========================="

# T5XXL Text Encoder
cd models/clip
if [ ! -f "t5xxl_fp16.safetensors" ]; then
    echo "📥 Download T5XXL Text Encoder..."
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors
    echo -e "${GREEN}✅ T5XXL scaricato${NC}"
else
    echo -e "${GREEN}✅ T5XXL già presente${NC}"
fi

# CLIP-L
if [ ! -f "clip_l.safetensors" ]; then
    echo "📥 Download CLIP-L..."
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
    echo -e "${GREEN}✅ CLIP-L scaricato${NC}"
else
    echo -e "${GREEN}✅ CLIP-L già presente${NC}"
fi
cd ../..

# VAE FLUX
cd models/vae
if [ ! -f "ae.sft" ]; then
    echo "📥 Download VAE FLUX..."
    wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors -O ae.sft
    echo -e "${GREEN}✅ VAE FLUX scaricato${NC}"
else
    echo -e "${GREEN}✅ VAE FLUX già presente${NC}"
fi
cd ../..

# =============================================================================
# RIEPILOGO FINALE
# =============================================================================
echo ""
echo "📋 RIEPILOGO DOWNLOAD"
echo "===================="
echo ""
echo "✅ Modelli con link corretti:"
echo "   - FOCUS Nodes: https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes"
echo "   - Skin Texture: https://civitai.com/models/651043?modelVersionId=827325"
echo "   - Upscaler: https://huggingface.co/libsgo/4x-FaceUpSharpDAT"
echo ""
echo "📁 Controllo file presenti:"
echo ""

# Verifica finale
echo "🔍 MODELLI TROVATI:"
[ -f "models/loras/FluxRealSkin-v2.0.safetensors" ] && echo "✅ FluxRealSkin-v2.0.safetensors" || echo "❌ FluxRealSkin-v2.0.safetensors"
[ -f "models/upscale_models/4xFaceUpSharpDAT.pth" ] && echo "✅ 4xFaceUpSharpDAT.pth" || echo "❌ 4xFaceUpSharpDAT.pth"
[ -f "models/clip/t5xxl_fp16.safetensors" ] && echo "✅ t5xxl_fp16.safetensors" || echo "❌ t5xxl_fp16.safetensors"
[ -f "models/clip/clip_l.safetensors" ] && echo "✅ clip_l.safetensors" || echo "❌ clip_l.safetensors"
[ -f "models/vae/ae.sft" ] && echo "✅ ae.sft" || echo "❌ ae.sft"

echo ""
echo "🚀 DOWNLOAD COMPLETATO!"
echo "💡 Ricorda di riavviare ComfyUI per caricare i nuovi modelli" 