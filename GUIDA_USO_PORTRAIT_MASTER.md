# 🎨 GUIDA USO PORTRAIT MASTER FLUX SU RUNPOD

## 📋 Panoramica Setup Completato

Hai installato con successo **Portrait Master FLUX** su RunPod con i seguenti componenti:

### ✅ Modelli Installati
- **FLUX Dev FP8** (16GB) - Modello principale per generazione portrait
- **Stable Diffusion 1.5** (4GB) - Per workflow SD1.5 compatibili  
- **DreamShaper 8** (145MB) - Modello artistico alternativo
- **LoRA specializzati** (MoXinV1, BlindBox, PhotorealisticSkin)

### ✅ Custom Nodes Attivi
- ComfyUI-Custom-Scripts (controlli avanzati)
- ComfyUI_LayerStyle (effetti layer)
- rgthree-comfy (utilities)
- ComfyUI-Easy-Use (semplificazioni UI)
- UltimateSDUpscale (upscaling)
- Detail-Daemon (miglioramento dettagli)
- TinyTerra Nodes (nodi specializzati)

### ✅ Workflow Corretti Disponibili
- `PortraitMaster_Flux1_Core.json` - Workflow principale FLUX
- `PortraitMaster_Flux1_Lite.json` - Versione semplificata  
- `PortraitMaster_Flux1_Expression.json` - Focus espressioni
- `PortraitMaster_BatchGen.json` - Generazione batch

---

## 🚀 Come Iniziare

### 1. Avvio ComfyUI su RunPod
```bash
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
```

### 2. Accesso Interfaccia
- **Locale RunPod**: `http://localhost:8188`
- **Accesso esterno**: Usa ngrok o domain RunPod pubblico

### 3. Caricamento Workflow
1. Apri ComfyUI nell'interfaccia web
2. Clicca "Load" in alto a destra
3. Naviga alla cartella `WORKFLOW_CORRETTI/`
4. Seleziona uno dei workflow disponibili
5. Clicca "Load"

---

## 🎯 Workflow Raccomandati per Iniziare

### **Per Principianti: PortraitMaster_Flux1_Lite.json**
- Setup semplificato con parametri pre-configurati
- Meno nodi da gestire
- Perfetto per prime prove

### **Per Utenti Avanzati: PortraitMaster_Flux1_Core.json**  
- Controllo completo su tutti i parametri
- Integrazione LoRA avanzata
- Opzioni stile e espressione complete

### **Per Espressioni Specifiche: PortraitMaster_Flux1_Expression.json**
- Focus su controllo micro-espressioni
- Parametri emotivi avanzati
- Controllo illuminazione viso

---

## 🛠️ Parametri Chiave da Configurare

### **Prompt Engineering**
```
PROMPT PRINCIPALE:
"a professional portrait of a [age] [gender] [ethnicity], [expression], [style]"

ESEMPI:
- "a professional portrait of a 25 year old woman, gentle smile, studio lighting"
- "a professional portrait of a middle-aged man, serious expression, dramatic lighting"
- "a professional portrait of a young person, joyful expression, natural lighting"
```

### **Parametri FLUX Critici**
- **Steps**: 20-30 (bilanciamento qualità/velocità)
- **CFG Scale**: 7-12 (controllo aderenza prompt)
- **Sampler**: DPM++ 2M Karras (raccomandato)
- **Scheduler**: Karras (per risultati fluidi)

### **LoRA Weights**
- **PhotorealisticSkin**: 0.6-0.8 (realismo pelle)
- **MoXinV1**: 0.4-0.6 (dettagli artistici)
- **BlindBox**: 0.3-0.5 (stile anime/cartoon)

---

## 🎨 Tips per Risultati Professionali

### **Illuminazione**
- `studio lighting` - Illuminazione controllata
- `natural lighting` - Luce naturale morbida  
- `dramatic lighting` - Chiaroscuro artistico
- `soft box lighting` - Luce diffusa professionale

### **Stili Fotografici**
- `headshot photography` - Ritratto classico
- `corporate portrait` - Stile business
- `fashion portrait` - Stile moda
- `fine art portrait` - Stile artistico

### **Controllo Qualità**
- Usa sempre `high quality, detailed, sharp focus`
- Evita prompt negativi troppo aggressivi
- Sperimenta con diversi seed per variazioni
- Salva i parametri dei risultati migliori

---

## 🔧 Risoluzione Problemi Comuni

### **Errore "Missing Node Types"**
```bash
# Restart ComfyUI dopo installazione nodes
cd /workspace/ComfyUI
python main.py --force-fp16
```

### **Out of Memory (OOM)**
- Riduci batch size a 1
- Usa `--lowvram` flag all'avvio
- Chiudi altri processi GPU

### **Generazione Lenta**
- Verifica GPU utilization con `nvidia-smi`
- Usa modelli FP8 invece di FP16
- Riduci resolution di output

### **Qualità Bassa**
- Aumenta steps (25-35)
- Verifica che LoRA siano caricati
- Controlla CFG scale (non troppo alto)

---

## 📊 Benchmark Performance

**Su RTX 4090 (24GB VRAM):**
- **FLUX 1024x1024**: ~38-45 secondi
- **SD1.5 512x512**: ~8-12 secondi  
- **Upscale 2x**: ~15-20 secondi aggiuntivi

**Ottimizzazioni RunPod:**
- Pre-allocazione VRAM attiva
- Compilazione CUDA ottimizzata
- Cache modelli in memoria

---

## 📚 Risorse Aggiuntive

### **Community & Support**
- [ComfyUI Discord](https://discord.gg/comfyui)
- [Portrait Master Documentation](https://portraitmaster.ai/docs)
- [FLUX Model Guide](https://huggingface.co/black-forest-labs/flux.1-dev)

### **Modelli Alternativi da Provare**
- Flux1-Redux (per variazioni)
- SDXL-Lightning (per velocità)
- Realistic Vision (per fotorealismo)

### **Estensioni Utili**
- ComfyUI Manager (gestione automatica nodes)
- Efficiency Nodes (workflow ottimizzati)
- Impact Pack (post-processing avanzato)

---

## 🎉 Conclusione

Il tuo setup Portrait Master FLUX è ora **completamente operativo**! 

**Prossimi passi:**
1. Carica `PortraitMaster_Flux1_Lite.json`
2. Prova i prompt suggeriti sopra
3. Sperimenta con diversi LoRA weights
4. Salva le configurazioni vincenti

**Divertiti a creare portrait professionali! 🚀** 