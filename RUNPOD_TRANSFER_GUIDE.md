# 🚀 GUIDA TRASFERIMENTO SU RUNPOD

**Come trasferire Portrait Master FLUX1 completo su RunPod**

---

## 📋 PREPARAZIONE PRE-TRASFERIMENTO

### 1. Carica tutto su GitHub
```bash
# Nella tua directory locale (Windows)
cd "C:\Users\dosca\Desktop\Precision Portraits with AI[1]"

# Inizializza repository Git
git init
git add .
git commit -m "Portrait Master FLUX1 - Setup completo"

# Crea repository su GitHub chiamato "portrait-master-flux1"
# Poi collega e pusha:
git remote add origin https://github.com/TUO_USERNAME/portrait-master-flux1.git
git branch -M main
git push -u origin main
```

### 2. Verifica contenuto repository
Il repository deve contenere:
```
├── PORTRAIT_MASTER_COMPLETE_SETUP.sh
├── README.md
├── RUNPOD_TRANSFER_GUIDE.md
├── Precision Portraits with AI/
│   └── Portrait Master 1.1/
│       ├── WORKFLOW_CORRETTI/
│       │   ├── PortraitMaster_Flux1_Lite.json
│       │   ├── PortraitMaster_Flux1_Core.json
│       │   ├── PortraitMaster_Flux1_Expression.json
│       │   ├── PortraitMaster_Flux1_Lite_GGuF.json
│       │   ├── PortraitMaster_BatchGen.json
│       │   └── PortraitMaster_FLUX1_Documentation.txt
│       └── [altri file originali]
└── [script aggiuntivi se creati]
```

---

## 🖥️ PROCEDURA COMPLETA RUNPOD

### Step 1: Avvia RunPod Pod
```
Template: ComfyUI
GPU: RTX 4090/A100 (24GB+ VRAM raccomandato)
Storage: 200GB+ (per tutti i modelli)
```

### Step 2: Connetti via SSH/Terminal
```bash
# Nel terminal di RunPod
cd /workspace/ComfyUI
```

### Step 3: Clone Repository Completo
```bash
# Sostituisci TUO_USERNAME con il tuo username GitHub
git clone https://github.com/TUO_USERNAME/portrait-master-flux1.git temp_repo

# Sposta tutto nella directory ComfyUI
cp -r temp_repo/* .
cp -r temp_repo/.* . 2>/dev/null || true
rm -rf temp_repo

# Verifica
ls -la
```

### Step 4: Esegui Installazione Automatica
```bash
chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh
./PORTRAIT_MASTER_COMPLETE_SETUP.sh
```

### Step 5: Download Modelli Manuali (ESSENZIALI)
```bash
# FLUX1-dev (12GB) - RICHIESTO
cd models/checkpoints
wget https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors

# FLUX1-Redux (1.4GB) - RICHIESTO
cd ../style_models
wget https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev/resolve/main/flux1-redux-dev.safetensors

# Torna alla root
cd /workspace/ComfyUI
```

### Step 6: Copia Workflow nella Directory ComfyUI
```bash
# Copia workflow corretti nella root di ComfyUI
cp "Precision Portraits with AI/Portrait Master 1.1/WORKFLOW_CORRETTI"/*.json .

# Verifica
ls -la *.json
```

### Step 7: Riavvia ComfyUI
```bash
# Ferma ComfyUI se attivo
pkill -f "python main.py"

# Riavvia
python main.py --listen 0.0.0.0 --port 8188 &
```

### Step 8: Configura ngrok (per accesso remoto)
```bash
# Installa e configura ngrok se necessario
cd /workspace
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar xvzf ngrok-v3-stable-linux-amd64.tgz
chmod +x ngrok

# Configura con la tua key
./ngrok config add-authtoken TUA_NGROK_KEY

# Avvia tunnel
./ngrok http 8188
```

---

## ✅ VERIFICA INSTALLAZIONE

### 1. Controlla Custom Nodes
```bash
ls custom_nodes/ | grep -E "(WaveSpeed|LayerStyle|Impact|Ultimate|rgthree|FOCUS|JoyCaption|Image-Saver)"
```

### 2. Controlla Modelli Core
```bash
echo "=== MODELLI CORE ==="
ls -la models/checkpoints/flux1-dev.safetensors
ls -la models/style_models/flux1-redux-dev.safetensors
ls -la models/vae/ae.sft
ls -la models/clip/t5xxl_fp16.safetensors
ls -la models/clip/clip_l.safetensors
ls -la models/clip_vision/sigclip_vision_patch14_384.safetensors
```

### 3. Controlla Modelli Detection
```bash
echo "=== MODELLI DETECTION ==="
ls -la models/impact/sam_vit_b_01ec64.pth
ls -la models/impact/GroundingDINO_SwinT_COG.pth
ls -la models/impact/bbox/
ls -la models/impact/segm/
```

### 4. Controlla Workflow
```bash
echo "=== WORKFLOW ==="
ls -la PortraitMaster_*.json
```

### 5. Test ComfyUI
- Apri l'URL ngrok nel browser
- Carica `PortraitMaster_Flux1_Lite.json`
- Verifica che tutti i nodi si carichino senza errori rossi

---

## 🎯 TEST FUNZIONALITÀ

### Test Base (PortraitMaster_Flux1_Lite)
1. Carica workflow Lite
2. Usa immagini Redux di esempio
3. Prompt semplice: "portrait of a beautiful woman, photorealistic"
4. Risoluzione: 1024x1024
5. Steps: 25, Guidance: 1.9
6. Queue Prompt → deve generare senza errori

### Test Avanzato (PortraitMaster_Flux1_Core)
1. Carica workflow Core
2. Abilita 1-2 LoRA (se scaricati)
3. Testa Auto-Detailer su face
4. Verifica upscaling funzioni

---

## 🛠️ TROUBLESHOOTING RUNPOD

### Errore "Out of Memory"
```bash
# Riduci batch size a 1
# Usa risoluzione 1024x1024
# Disabilita upscaler per test
```

### Errore "Node not found"
```bash
# Riavvia ComfyUI
pkill -f "python main.py"
python main.py --listen 0.0.0.0 --port 8188 &
```

### Modelli non trovati
```bash
# Verifica percorsi
find models/ -name "flux1-dev.safetensors"
find models/ -name "flux1-redux-dev.safetensors"
```

### Custom Nodes non caricati
```bash
# Reinstalla dipendenze
cd custom_nodes/ComfyUI_LayerStyle
pip install -r requirements.txt

cd ../ComfyUI-Impact-Pack  
pip install -r requirements.txt
```

---

## 📦 DOWNLOAD AGGIUNTIVI OPZIONALI

### LoRA Raccomandati (se desiderati)
```bash
cd models/loras

# Flux Skin Texture (da Civitai - richiede API key)
wget --header='Authorization: Bearer TUA_CIVITAI_API_KEY' \
     'https://civitai.com/api/download/models/651043' \
     -O flux_skin_texture.safetensors

# Altri LoRA... (vedi documentazione)
```

### Upscaler Aggiuntivi
```bash
cd models/upscale_models

# 4xFaceUpSharpDAT (raccomandato)
# Scarica manualmente da HuggingFace se non disponibile via wget

# 8x_NMKD-Faces (da Civitai)
# Scarica manualmente se necessario
```

---

## 🚀 AUTOMAZIONE COMPLETA

### Script One-Shot per RunPod
```bash
#!/bin/bash
# PORTRAIT_MASTER_RUNPOD_COMPLETE.sh

echo "🚀 INSTALLAZIONE COMPLETA PORTRAIT MASTER SU RUNPOD"

# Clone repository
cd /workspace/ComfyUI
git clone https://github.com/TUO_USERNAME/portrait-master-flux1.git temp_repo
cp -r temp_repo/* .
rm -rf temp_repo

# Esegui installazione
chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh
./PORTRAIT_MASTER_COMPLETE_SETUP.sh

# Download modelli principali
cd models/checkpoints
wget https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors &

cd ../style_models  
wget https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev/resolve/main/flux1-redux-dev.safetensors &

wait

# Copia workflow
cd /workspace/ComfyUI
cp "Precision Portraits with AI/Portrait Master 1.1/WORKFLOW_CORRETTI"/*.json .

# Riavvia ComfyUI
pkill -f "python main.py"
python main.py --listen 0.0.0.0 --port 8188 &

echo "✅ INSTALLAZIONE COMPLETATA!"
echo "🌐 Avvia ngrok per accesso remoto:"
echo "./ngrok http 8188"
```

---

## 📞 SUPPORTO

### Se qualcosa non funziona:
1. Controlla log ComfyUI: `tail -f ComfyUI.log`
2. Verifica spazio disco: `df -h`
3. Controlla VRAM: `nvidia-smi`
4. Riavvia pod se necessario

### Log Utili
```bash
# Log ComfyUI
tail -f /workspace/ComfyUI/*.log

# Processi attivi
ps aux | grep python

# Uso VRAM
watch nvidia-smi
```

---

**🎯 RISULTATO FINALE**
Dopo aver seguito questa guida avrai Portrait Master FLUX1 completamente funzionante su RunPod con:
- ✅ Tutti i custom nodes installati
- ✅ Modelli core scaricati e configurati  
- ✅ 5 workflow pronti per l'uso
- ✅ Accesso tramite ngrok
- ✅ Configurazione ottimale per rendering professionale

---

**Tempo stimato**: 30-60 minuti (a seconda della velocità di download) 