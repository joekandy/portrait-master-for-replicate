# 🚀 COMFYUI LAUNCHER SU RUNPOD - GUIDA COMPLETA

## Perché ComfyUI Launcher?

ComfyUI Launcher risolve automaticamente i problemi più comuni:
- ✅ **Gestione automatica dipendenze** - Non più errori di import
- ✅ **Installazione custom nodes semplificata** - Un click e tutto funziona  
- ✅ **Download modelli automatico** - Scarica solo quello che serve
- ✅ **Interfaccia moderna** - Più semplice da usare
- ✅ **Gestione errori intelligente** - Risolve conflitti automaticamente

---

## 📋 INSTALLAZIONE SU RUNPOD

### 1. Carica lo script su RunPod
```bash
# Nel terminal di RunPod
cd /workspace
wget https://raw.githubusercontent.com/joekandy/portrait-master-flux1/main/RUNPOD_COMFYUI_LAUNCHER_INSTALL.sh
chmod +x RUNPOD_COMFYUI_LAUNCHER_INSTALL.sh
```

### 2. Esegui l'installazione (10-15 minuti)
```bash
./RUNPOD_COMFYUI_LAUNCHER_INSTALL.sh
```

### 3. Avvia il launcher
```bash
cd /workspace/comfyui-launcher
./start_launcher.sh
```

---

## 🌐 ACCESSO ALLE INTERFACCE

### ComfyUI Launcher (Principale)
- **URL**: `http://localhost:3000`
- **Funzioni**: Gestione modelli, custom nodes, configurazione
- **Usa per**: Setup iniziale, installazione componenti

### ComfyUI Classico  
- **URL**: `http://localhost:8188`
- **Funzioni**: Workflow, generazione immagini
- **Usa per**: Lavoro quotidiano con Portrait Master

---

## 🔧 SETUP PORTRAIT MASTER CON LAUNCHER

### 1. **Primo avvio** (Automatico)
Il launcher installerà automaticamente:
- ComfyUI base
- Tutti i custom nodes necessari
- Modelli FLUX base (T5, CLIP, VAE)

### 2. **Download modelli principali**
Nel launcher web, vai su "Models" e scarica:
- `flux1-dev.safetensors` (11.9GB) - Modello principale
- `FluxRealSkin-v2.0.safetensors` - LoRA texture pelle

### 3. **Carica workflow Portrait Master**
```bash
# I workflow sono già nella directory
ls /workspace/comfyui-launcher/workflows/portrait-master/
```

---

## 📁 STRUTTURA DIRECTORY

```
/workspace/
├── comfyui-launcher/          # Launcher principale
│   ├── start_launcher.sh      # Avvia launcher
│   ├── start_comfyui_direct.sh # Avvia solo ComfyUI
│   ├── config/runpod.json     # Configurazione RunPod
│   └── workflows/portrait-master/ # Workflow PM
└── ComfyUI/                   # ComfyUI installato dal launcher
    ├── models/
    ├── custom_nodes/
    └── output/
```

---

## 🚀 COMANDI RAPIDI

### Gestione Launcher
```bash
# Avvia launcher (interfaccia web)
./start_launcher.sh

# Avvia solo ComfyUI
./start_comfyui_direct.sh

# Controlla stato sistema
./check_status.sh
```

### Controlli Sistema
```bash
# Verifica GPU
nvidia-smi

# Verifica processi
ps aux | grep -E "(launcher|comfyui)"

# Verifica porte
netstat -tuln | grep -E "(3000|8188)"
```

---

## 🎯 WORKFLOW DI LAVORO OTTIMALE

### Setup Iniziale (Una volta)
1. Esegui script installazione
2. Avvia launcher: `./start_launcher.sh`
3. Vai su http://localhost:3000
4. Scarica modelli tramite interfaccia
5. Installa eventuali custom nodes mancanti

### Uso Quotidiano
1. Avvia ComfyUI diretto: `./start_comfyui_direct.sh`
2. Vai su http://localhost:8188
3. Carica workflow Portrait Master
4. Genera le tue immagini

---

## 🔧 RISOLUZIONE PROBLEMI

### Launcher non si avvia
```bash
cd /workspace/comfyui-launcher
npm install
./start_launcher.sh
```

### ComfyUI non trova modelli
```bash
# Verifica percorsi
ls -la /workspace/ComfyUI/models/checkpoints/
ls -la /workspace/ComfyUI/models/loras/
```

### Custom node mancante
1. Vai su launcher web (http://localhost:3000)
2. Sezione "Custom Nodes"
3. Cerca e installa il nodo mancante
4. Riavvia ComfyUI

### Memoria GPU insufficiente
```bash
# Avvia con ottimizzazioni
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --force-fp16 --lowvram
```

---

## 🎨 TESTING PORTRAIT MASTER

### 1. Test Base (Lite)
```bash
# Usa workflow più leggero
PortraitMaster_Flux1_Lite.json
```

### 2. Test Completo (Core)  
```bash
# Workflow completo con tutte le features
PortraitMaster_Flux1_Core.json
```

### 3. Test Batch
```bash
# Generazione multipla
PortraitMaster_BatchGen.json
```

---

## 💡 VANTAGGI LAUNCHER VS INSTALLAZIONE TRADIZIONALE

| Aspetto | Tradizionale | Launcher |
|---------|--------------|----------|
| **Setup** | Manuale (2-3 ore) | Automatico (15 min) |
| **Errori** | Frequenti | Rari |
| **Aggiornamenti** | Manuali | Automatici |
| **Gestione modelli** | Complessa | Semplice |
| **Troubleshooting** | Difficile | Guidato |

---

## 🔄 BACKUP E RIPRISTINO

### Backup configurazione
```bash
cd /workspace
tar -czf launcher_backup.tar.gz comfyui-launcher/config/ ComfyUI/models/
```

### Ripristino rapido
```bash
# Se qualcosa si rompe
cd /workspace/comfyui-launcher
git pull
npm install
./start_launcher.sh
```

---

## 📞 TROUBLESHOOTING AVANZATO

### Log debugging
```bash
# Log launcher
cd /workspace/comfyui-launcher
npm run debug

# Log ComfyUI
cd /workspace/ComfyUI
python main.py --verbose
```

### Reset completo
```bash
# Solo se necessario
rm -rf /workspace/comfyui-launcher/
rm -rf /workspace/ComfyUI/
# Riesegui installazione
```

---

## 🎯 PROSSIMI PASSI

1. **Testa l'installazione** con workflow Lite
2. **Scarica modelli aggiuntivi** se necessario
3. **Configura i tuoi preset** preferiti
4. **Crea backup** della configurazione funzionante

🚀 **Il launcher gestisce tutto automaticamente - rilassati e crea!** 