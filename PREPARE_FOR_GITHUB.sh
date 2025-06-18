#!/bin/bash

# =============================================================================
# PREPARA PORTRAIT MASTER FLUX1 PER GITHUB
# =============================================================================

echo "📦 PREPARAZIONE REPOSITORY GITHUB"
echo "================================="

# Colori
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

log "📁 Preparazione repository per GitHub"

# =============================================================================
# CREAZIONE .gitignore
# =============================================================================

log "Creazione .gitignore..."

cat > .gitignore << 'EOF'
# File di sistema
.DS_Store
Thumbs.db
*.tmp

# File Python
__pycache__/
*.py[cod]

# Modelli grandi (esclusi da GitHub)
models/checkpoints/*.safetensors
models/unet/*.gguf
models/vae/*.safetensors
models/clip/*.safetensors
models/clip_vision/*.safetensors
models/loras/*.safetensors
models/upscale_models/*.pth
models/impact/*.pth
*.bin
*.ckpt

# File temporanei
*.log
*.bak
output/
temp/

# Mantieni file LUT e struttura
!models/LUTs/*.cube
EOF

success ".gitignore creato"

echo ""
echo "🚀 ISTRUZIONI PER GITHUB:"
echo "========================"
echo ""
echo "1. Inizializza Git:"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Portrait Master FLUX1 completo'"
echo ""
echo "2. Crea repository GitHub 'portrait-master-flux1'"
echo ""
echo "3. Carica:"
echo "   git remote add origin https://github.com/TUO_USERNAME/portrait-master-flux1.git"
echo "   git push -u origin main"
echo ""
echo "4. Su RunPod usa:"
echo "   git clone https://github.com/TUO_USERNAME/portrait-master-flux1.git"
echo "   chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh"
echo "   ./PORTRAIT_MASTER_COMPLETE_SETUP.sh"

success "🎯 Repository pronto per GitHub!" 