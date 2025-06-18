# Risoluzione Errore ComfyUI - FLUX1 Setup

## 🚨 Problema Identificato

L'errore `Value not in list: ckpt_name: 'v1-5-pruned-emaonly-fp16.safetensors' not in []` indica che stai cercando di utilizzare un workflow per **Stable Diffusion 1.5** su un sistema configurato per **FLUX1**.

## 🔧 Soluzioni Disponibili

### Opzione 1: Usa il Workflow FLUX1 Semplificato (Raccomandato)

Ho creato `flux_portrait_simple.json` che utilizza i modelli FLUX1 disponibili nel tuo sistema:

**Modelli richiesti:**
- `flux1-dev-fp8.safetensors` (UNET)
- `t5xxl_fp16.safetensors` (CLIP T5)
- `clip_l.safetensors` (CLIP L)
- `ae.safetensors` (VAE)

**Caratteristiche:**
- Risoluzione: 1024x1024 pixel
- Sampler: Euler con scheduler simple
- CFG: 3.5 (ottimale per FLUX1)
- 20 step di generazione

### Opzione 2: Usa i Workflow Portrait Master Avanzati

Il progetto include workflow professionali nella cartella `Precision Portraits with AI/Portrait Master 1.1/Workflow/`:

- `PortraitMaster_Flux1_Lite.json` - Versione leggera
- `PortraitMaster_Flux1_Core.json` - Versione completa
- `PortraitMaster_Flux1_Expression.json` - Focus espressioni
- `PortraitMaster_BatchGen.json` - Generazione batch

### Opzione 3: Modifica il Tuo Workflow Originale

Per convertire il tuo workflow da SD1.5 a FLUX1, sostituisci:

**DA:**
```json
"CheckpointLoaderSimple" con "v1-5-pruned-emaonly-fp16.safetensors"
```

**A:**
```json
"UNETLoader" con "flux1-dev-fp8.safetensors"
"DualCLIPLoader" con "t5xxl_fp16.safetensors" + "clip_l.safetensors"
"VAELoader" con "ae.safetensors"
```

## 📋 Parametri Ottimali per FLUX1

- **CFG Scale:** 1.0-4.0 (raccomandato 3.5)
- **Sampler:** euler, dpmpp_2m
- **Scheduler:** simple, normal
- **Steps:** 20-30
- **Risoluzione:** 1024x1024 o multipli di 64

## 🚀 Come Iniziare

1. **Carica il workflow semplificato:**
   - Apri ComfyUI
   - Carica `flux_portrait_simple.json`
   - Modifica il prompt in italiano se desiderato

2. **Verifica i modelli:**
   - Assicurati che tutti i file `.safetensors` siano nelle cartelle corrette di ComfyUI
   - Controlla che i nomi dei file corrispondano esattamente

3. **Esegui il test:**
   - Premi "Queue Prompt"
   - Il workflow dovrebbe funzionare senza errori

## 📝 Note Importanti

- FLUX1 è molto più potente di SD1.5 per i ritratti
- I tempi di generazione potrebbero essere diversi
- La qualità dell'output è generalmente superiore
- I modelli FLUX1 richiedono più VRAM

## 🛠️ Risoluzione Problemi

Se riscontri ancora errori:

1. **Controlla i nomi dei file** nei loader nodes
2. **Verifica la presenza dei modelli** nelle cartelle di ComfyUI
3. **Assicurati di avere VRAM sufficiente** (raccomandato 12GB+)
4. **Controlla i log di ComfyUI** per errori specifici

## 📞 Supporto

Se hai bisogno di ulteriore assistenza, fornisci:
- Log completo di ComfyUI
- Lista dei modelli disponibili nelle cartelle
- Specifiche del tuo hardware (GPU, VRAM) 