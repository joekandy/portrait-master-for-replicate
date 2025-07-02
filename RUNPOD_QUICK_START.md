# 🚀 PORTRAIT MASTER SU RUNPOD - GUIDA VELOCE

## ⚡ INSTALLAZIONE ULTRA-RAPIDA (5 minuti)

### Su RunPod, copia e incolla questo comando:

```bash
cd /workspace && curl -sSL https://raw.githubusercontent.com/tuoUsername/portrait-master-flux1/main/QUICK_RUNPOD_LAUNCHER.sh | bash
```

**OPPURE** manuale:

```bash
cd /workspace
wget https://raw.githubusercontent.com/tuoUsername/portrait-master-flux1/main/QUICK_RUNPOD_LAUNCHER.sh
chmod +x QUICK_RUNPOD_LAUNCHER.sh
./QUICK_RUNPOD_LAUNCHER.sh
```

---

## 🎯 COSA FA QUESTO SCRIPT

✅ **Installa ComfyUI con Manager integrato**  
✅ **Scarica modelli base FLUX (CLIP, T5, VAE)**  
✅ **Configura tutto per RunPod**  
✅ **Crea script di gestione rapida**  

---

## 🚀 DOPO L'INSTALLAZIONE

### 1. Avvia ComfyUI
```bash
cd /workspace
./manage_comfyui.sh start
```

### 2. Apri il browser
- **URL**: `http://localhost:8188`
- **Interfaccia**: ComfyUI con Manager integrato

### 3. Installa nodi mancanti
```bash
./manage_comfyui.sh nodes
```

---

## 📦 DOWNLOAD MODELLI NECESSARI

### FLUX principale (11.9GB) - OBBLIGATORIO
```bash
cd /workspace/ComfyUI/models/checkpoints
wget "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
```

### LoRA Skin Texture (Opzionale)
- Vai su: https://civitai.com/models/651043?modelVersionId=827325
- Scarica in: `/workspace/ComfyUI/models/loras/`

---

## 🎨 CARICA WORKFLOW PORTRAIT MASTER

### Copia i tuoi file JSON in:
```bash
/workspace/ComfyUI/workflows/portrait-master/
```

### Workflow consigliati:
- **PortraitMaster_Flux1_Lite.json** ← Inizia con questo!
- **PortraitMaster_Flux1_Core.json** ← Versione completa
- **PortraitMaster_BatchGen.json** ← Per batch multiple

---

## 🔧 COMANDI UTILI

### Gestione ComfyUI
```bash
./manage_comfyui.sh start     # Avvia
./manage_comfyui.sh stop      # Ferma  
./manage_comfyui.sh restart   # Riavvia
./manage_comfyui.sh status    # Controlla stato
```

### Controlli Sistema
```bash
./manage_comfyui.sh gpu       # Info GPU
./manage_comfyui.sh models    # Info modelli
./manage_comfyui.sh nodes     # Installa custom nodes
```

---

## 🚨 RISOLUZIONE PROBLEMI

### ComfyUI non parte?
```bash
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --force-fp16 --lowvram
```

### Nodo mancante?
1. Vai su http://localhost:8188
2. Clicca **Manager** 
3. **Install Custom Nodes**
4. Cerca e installa il nodo
5. **Restart**

### Modello non trovato?
```bash
# Verifica percorsi
ls /workspace/ComfyUI/models/checkpoints/
ls /workspace/ComfyUI/models/loras/
ls /workspace/ComfyUI/models/vae/
```

---

## 💡 WORKFLOW OTTIMALE

### Setup (Una volta)
1. ✅ Esegui script installazione
2. ✅ Scarica flux1-dev.safetensors  
3. ✅ Installa nodi Portrait Master
4. ✅ Carica workflow Lite

### Uso quotidiano
1. `./manage_comfyui.sh start`
2. Vai su http://localhost:8188
3. Carica workflow
4. Genera!

---

## 🎉 VANTAGGI QUESTO SETUP

| Problema Vecchio | Soluzione Nuova |
|-------------------|-----------------|
| ❌ Errori custom nodes | ✅ Manager risolve tutto |
| ❌ Modelli mancanti | ✅ Download automatico |
| ❌ Configurazione complessa | ✅ Script tutto-in-uno |
| ❌ Dipendenze rotte | ✅ Ambiente controllato |

---

## 📞 SE QUALCOSA NON FUNZIONA

### Reset completo (ultima risorsa)
```bash
cd /workspace
rm -rf ComfyUI comfyui-launcher
./QUICK_RUNPOD_LAUNCHER.sh
```

### Controllo finale
```bash
./manage_comfyui.sh status
./manage_comfyui.sh gpu
```

---

## 🎯 TUTTO PRONTO!

**Ora hai:**
- ✅ ComfyUI ottimizzato per RunPod
- ✅ Manager per gestire tutto facilmente  
- ✅ Modelli base FLUX preinstallati
- ✅ Script di gestione automatica
- ✅ Ambiente pronto per Portrait Master

**🚀 Copia i tuoi workflow JSON e inizia a creare!** 