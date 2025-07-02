#!/bin/bash
# 🚀 COMANDI RAPIDI PORTRAIT MASTER RUNPOD

echo "🎨 PORTRAIT MASTER FLUX - Comandi Rapidi RunPod"
echo "================================================"

# Funzione per avviare ComfyUI
start_comfyui() {
    echo "🚀 Avvio ComfyUI..."
    cd /workspace/ComfyUI
    python main.py --listen 0.0.0.0 --port 8188 --force-fp16
}

# Funzione per verificare modelli
check_models() {
    echo "🔍 Verifica modelli installati..."
    echo ""
    echo "CHECKPOINTS:"
    ls -lh /workspace/ComfyUI/models/checkpoints/*.safetensors 2>/dev/null || echo "Nessun checkpoint trovato"
    echo ""
    echo "LORAS:"
    ls -lh /workspace/ComfyUI/models/loras/*.safetensors 2>/dev/null || echo "Nessun LoRA trovato"
    echo ""
    echo "VAE:"
    ls -lh /workspace/ComfyUI/models/vae/*.safetensors 2>/dev/null || echo "Nessun VAE trovato"
}

# Funzione per verificare VRAM
check_gpu() {
    echo "🖥️  Stato GPU:"
    nvidia-smi --query-gpu=name,memory.total,memory.used,memory.free --format=csv,noheader,nounits
}

# Funzione per pulire cache
clean_cache() {
    echo "🧹 Pulizia cache..."
    rm -rf /tmp/comfyui_*
    rm -rf /workspace/ComfyUI/temp/*
    echo "Cache pulita!"
}

# Funzione per backup workflow
backup_workflows() {
    echo "💾 Backup workflow corretti..."
    cd /workspace/ComfyUI
    tar -czf "workflow_backup_$(date +%Y%m%d_%H%M%S).tar.gz" WORKFLOW_CORRETTI/
    echo "Backup creato!"
}

# Funzione per installare custom node mancante
install_custom_node() {
    if [ -z "$1" ]; then
        echo "❌ Uso: install_custom_node <url_github>"
        return 1
    fi
    
    echo "📦 Installazione custom node: $1"
    cd /workspace/ComfyUI/custom_nodes
    git clone "$1"
    echo "✅ Custom node installato. Riavvia ComfyUI."
}

# Funzione per scaricare modello da Hugging Face
download_hf_model() {
    if [ -z "$2" ]; then
        echo "❌ Uso: download_hf_model <repo/model> <categoria>"
        echo "Categorie: checkpoints, loras, vae, clip, clip_vision"
        return 1
    fi
    
    echo "⬇️  Download modello da Hugging Face..."
    cd "/workspace/ComfyUI/models/$2"
    wget "https://huggingface.co/$1/resolve/main/" -O "$(basename $1).safetensors"
}

# Funzione per test rapido
quick_test() {
    echo "🧪 Test rapido sistema..."
    echo "1. Verifica GPU:"
    nvidia-smi --query-gpu=name --format=csv,noheader
    echo ""
    echo "2. Verifica VRAM libera:"
    nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits
    echo ""
    echo "3. Verifica ComfyUI:"
    if pgrep -f "main.py" > /dev/null; then
        echo "✅ ComfyUI è in esecuzione"
    else
        echo "❌ ComfyUI non è in esecuzione"
    fi
}

# Menu principale
show_menu() {
    echo ""
    echo "📋 MENU COMANDI:"
    echo "1. start     - Avvia ComfyUI"
    echo "2. check     - Verifica modelli"
    echo "3. gpu       - Stato GPU"
    echo "4. clean     - Pulisci cache"
    echo "5. backup    - Backup workflow"
    echo "6. test      - Test rapido sistema"
    echo "7. install   - Installa custom node"
    echo "8. download  - Download modello HF"
    echo "9. help      - Mostra questo menu"
    echo ""
}

# Gestione argomenti
case "$1" in
    "start")
        start_comfyui
        ;;
    "check")
        check_models
        ;;
    "gpu")
        check_gpu
        ;;
    "clean")
        clean_cache
        ;;
    "backup")
        backup_workflows
        ;;
    "test")
        quick_test
        ;;
    "install")
        install_custom_node "$2"
        ;;
    "download")
        download_hf_model "$2" "$3"
        ;;
    "help"|"")
        show_menu
        ;;
    *)
        echo "❌ Comando non riconosciuto: $1"
        show_menu
        ;;
esac

# Esempi di uso
if [ "$1" = "help" ] || [ -z "$1" ]; then
    echo "💡 ESEMPI D'USO:"
    echo "bash COMANDI_RAPIDI_RUNPOD.sh start"
    echo "bash COMANDI_RAPIDI_RUNPOD.sh check"
    echo "bash COMANDI_RAPIDI_RUNPOD.sh install https://github.com/user/repo"
    echo "bash COMANDI_RAPIDI_RUNPOD.sh download black-forest-labs/flux.1-dev checkpoints"
fi 