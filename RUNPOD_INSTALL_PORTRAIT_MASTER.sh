#!/bin/bash

# =============================================================================
# PORTRAIT MASTER FLUX1 - INSTALLAZIONE RUNPOD COMPLETA
# =============================================================================

echo "🎨 PORTRAIT MASTER FLUX1 - INSTALLAZIONE RUNPOD"
echo "==============================================="

# Colori
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }

# =============================================================================
# FASE 1: INSTALLAZIONE COMFYUI BASE
# =============================================================================

log "📁 Preparazione ComfyUI su RunPod..."

cd /workspace

# Rimuovi installazioni precedenti incomplete
if [ -d "ComfyUI" ]; then
    warning "ComfyUI esistente trovato, backup in ComfyUI-backup"
    mv ComfyUI ComfyUI-backup-$(date +%Y%m%d-%H%M%S)
fi

# Clona ComfyUI ufficiale
log "Download ComfyUI ufficiale..."
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# Installa dipendenze base
log "Installazione dipendenze Python base..."
pip install -r requirements.txt
pip install safetensors aiohttp

success "ComfyUI base installato"

# =============================================================================
# FASE 2: INTEGRAZIONE PORTRAIT MASTER
# =============================================================================

log "📦 Download e integrazione Portrait Master FLUX1..."

# Scarica in directory temporanea
cd /tmp
rm -rf portrait-master-temp 2>/dev/null
git clone https://github.com/joekandy/portrait-master-flux1.git portrait-master-temp

# Copia file essenziali nella ComfyUI
cd portrait-master-temp
cp PORTRAIT_MASTER_COMPLETE_SETUP.sh /workspace/ComfyUI/
cp *.json /workspace/ComfyUI/
cp *.md /workspace/ComfyUI/
cp Portrait_Master_FLUX1_Setup.ipynb /workspace/ComfyUI/

success "File Portrait Master integrati"

# =============================================================================
# FASE 3: ESECUZIONE SETUP COMPLETO
# =============================================================================

cd /workspace/ComfyUI
chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh

log "🚀 Avvio installazione completa Portrait Master..."
./PORTRAIT_MASTER_COMPLETE_SETUP.sh

# =============================================================================
# FASE 4: CONFIGURAZIONE RUNPOD
# =============================================================================

log "⚙️  Configurazione specifiche RunPod..."

# Crea script di avvio
cat > start_comfyui.sh << 'EOF'
#!/bin/bash
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
EOF

chmod +x start_comfyui.sh

# Crea script tunnel ngrok
cat > start_tunnel.sh << 'EOF'
#!/bin/bash
cd /workspace/ComfyUI
./ngrok http 8188
EOF

chmod +x start_tunnel.sh

success "Script RunPod creati"

# =============================================================================
# RIEPILOGO FINALE
# =============================================================================

echo ""
echo "🎉 INSTALLAZIONE RUNPOD COMPLETATA!"
echo "=================================="
echo ""
echo "📋 Comandi per avviare:"
echo "  1. ComfyUI: ./start_comfyui.sh"
echo "  2. Tunnel:  ./start_tunnel.sh"
echo ""
echo "🌐 URL ComfyUI locale: http://localhost:8188"
echo ""
echo "📦 Download manuali richiesti:"
echo "   • flux1-dev.safetensors (12GB) → models/checkpoints/"
echo "   • flux1-redux-dev.safetensors → models/style_models/"
echo ""
echo "🔗 Link download:"
echo "   https://huggingface.co/black-forest-labs/FLUX.1-dev"
echo "   https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev"
echo ""
echo "💡 Ora puoi caricare i workflow Portrait Master JSON!"

cleanup() {
    cd /
    rm -rf /tmp/portrait-master-temp
}

cleanup 