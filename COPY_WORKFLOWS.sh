#!/bin/bash
echo "📂 COPIA WORKFLOW PORTRAIT MASTER ALLA ROOT DI COMFYUI"
echo "====================================================="

# Copia i 5 workflow originali dalla cartella nested alla root di ComfyUI
cd /workspace/ComfyUI/

echo "📋 Copiando workflow originali..."

# Portrait Master 1.1 workflows
cp "Precision Portraits with AI/Portrait Master 1.1/Workflow/PortraitMaster_Flux1_Lite.json" ./
cp "Precision Portraits with AI/Portrait Master 1.1/Workflow/PortraitMaster_Flux1_Core.json" ./
cp "Precision Portraits with AI/Portrait Master 1.1/Workflow/PortraitMaster_Flux1_Expression.json" ./
cp "Precision Portraits with AI/Portrait Master 1.1/Workflow/PortraitMaster_Flux1_Lite_GGuF.json" ./
cp "Precision Portraits with AI/Portrait Master 1.1/Workflow/PortraitMaster_BatchGen.json" ./

# Copia anche le immagini di esempio
echo "🖼️ Copiando immagini di esempio..."
cp -r "Precision Portraits with AI/Portrait Master 1.1/IMG/" ./portrait_master_images/

echo ""
echo "✅ WORKFLOW COPIATI NELLA ROOT DI COMFYUI:"
ls -la PortraitMaster*.json

echo ""
echo "🎯 ORA PUOI:"
echo "1. Eseguire ./INSTALL_PORTRAIT_MASTER_COMPLETE.sh"
echo "2. Eseguire ./FIX_ALL_WORKFLOWS.sh" 
echo "3. Riavviare ComfyUI"
echo "4. Caricare PortraitMaster_Flux1_Lite.json per testare!" 