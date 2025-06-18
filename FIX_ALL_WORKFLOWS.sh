#!/bin/bash
echo "🔧 CORREZIONE WORKFLOW PORTRAIT MASTER ORIGINALI"
echo "================================================"

cd "/workspace/ComfyUI/"

# Lista dei 5 workflow da correggere
WORKFLOWS=(
    "PortraitMaster_Flux1_Lite.json"
    "PortraitMaster_Flux1_Core.json" 
    "PortraitMaster_Flux1_Expression.json"
    "PortraitMaster_Flux1_Lite_GGuF.json"
    "PortraitMaster_BatchGen.json"
)

for workflow in "${WORKFLOWS[@]}"; do
    if [ -f "$workflow" ]; then
        echo "🔧 Fixing $workflow..."
        
        # Backup originale
        cp "$workflow" "${workflow}.backup"
        
        # 1. Correggi VAE: ae.safetensors → ae.sft  
        sed -i 's/"ae\.safetensors"/"ae.sft"/g' "$workflow"
        
        # 2. Correggi DualCLIPLoader: primo campo clip_l → t5xxl_fp16
        sed -i 's/"clip_l\.safetensors",\s*"clip_l\.safetensors"/"t5xxl_fp16.safetensors", "clip_l.safetensors"/g' "$workflow"
        
        # 3. Abilita StyleModelLoader (mode: 4 → 0)
        sed -i '/"type": "StyleModelLoader"/,/"mode": [0-9]/ s/"mode": 4/"mode": 0/' "$workflow"
        
        # 4. Abilita CLIPVisionLoader (mode: 4 → 0) 
        sed -i '/"type": "CLIPVisionLoader"/,/"mode": [0-9]/ s/"mode": 4/"mode": 0/' "$workflow"
        
        echo "✅ Fixed $workflow"
    else
        echo "❌ $workflow not found"
    fi
done

echo ""
echo "✅ TUTTI I WORKFLOW CORRETTI!"
echo "📋 Backup salvati come *.backup"
echo "🎯 Ora puoi testare i workflow originali!" 