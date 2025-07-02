# 🔧 GUIDA FIX ERRORE CUDA CUBLAS - RUNPOD

## ❌ PROBLEMA
Errore: `CUBLAS_STATUS_NOT_SUPPORTED when calling cublasLtMatmulAlgoGetHeuristic`

## 🎯 CAUSA
- Utilizzo di modelli **FP8** (`flux1-dev-fp8.safetensors`) 
- Dtype **fp8_e4m3fn** incompatibile con CUDA/CUBLAS
- PyTorch 2.5.1 con problemi CUBLAS

## ⚡ SOLUZIONE RAPIDA

### 1. ESEGUI FIX SUL RUNPOD
```bash
# Nel terminale RunPod:
cd /workspace
pkill -f main.py
bash FIX_CUDA_FP8_ERROR_RUNPOD.sh
```

### 2. RIAVVIA COMFYUI CON FIX
```bash
cd /workspace
./start_comfyui_cuda_fix.sh
```

### 3. MODIFICA WORKFLOW
Nel tuo workflow ComfyUI:

**🔧 UNETLoader (Nodo 1):**
- ❌ Da: `flux1-dev-fp8.safetensors` 
- ✅ A: `flux1-dev.safetensors`
- ❌ Da: `fp8_e4m3fn_fast`
- ✅ A: `default`

**🔧 FluxGuidance (Nodo 7):**
- ❌ Da: CFG `3.5`
- ✅ A: CFG `1.5`

**🔧 KSampler (Nodo 8):**
- ❌ Da: Steps `20`
- ✅ A: Steps `15`

## 📁 WORKFLOW CORRETTO
Usa il file: `flux_portrait_CUBLAS_FIXED.json`

## 🛠️ COSA FA IL FIX
1. **Disabilita FOCUS Nodes** (causano errori GlobalSeedFN)
2. **Scarica FLUX normale** (non-FP8)
3. **Downgrade PyTorch** a versione compatibile
4. **Configura variabili CUDA** per stabilità
5. **Crea script avvio** con fix applicati

## ✅ VERIFICA FUNZIONAMENTO
1. Nessun errore `CUBLAS_STATUS_NOT_SUPPORTED`
2. Modelli caricano correttamente
3. Generazione immagini completata

## 🚨 SE PERSISTE L'ERRORE
1. **Riduci risoluzione**: 768x768 invece di 1024x1024
2. **Aggiungi parametri**: `--lowvram --force-fp32`
3. **Usa solo modelli NON-FP8**
4. **Riavvia RunPod** completamente

## 🎯 PARAMETRI SICURI
- **Modello**: flux1-dev.safetensors (normale)
- **Dtype**: default o fp16
- **CFG**: 1.0-2.0
- **Steps**: 10-20
- **Sampler**: euler
- **Scheduler**: simple

## 📞 SE HAI ANCORA PROBLEMI
1. Controlla log ComfyUI per altri errori
2. Verifica spazio disco disponibile
3. Riavvia RunPod completamente
4. Usa modelli alternativi (SD 1.5, SDXL)

---
**💡 Ricorda**: I modelli FP8 sono più veloci ma instabili. I modelli normali sono più lenti ma stabili! 