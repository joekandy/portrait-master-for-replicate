# 🚀 INSTALLAZIONE PORTRAIT MASTER SU RUNPOD

## Link Corretti Verificati ✅

- **FOCUS Nodes**: https://github.com/DJ-Tribefull/Comfyui_FOCUS_nodes
- **Upscaler**: https://huggingface.co/libsgo/4x-FaceUpSharpDAT  
- **Skin Texture**: https://civitai.com/models/651043?modelVersionId=827325

---

## 📋 PROCEDURA RUNPOD

### 1. Carica lo script su RunPod
```bash
# Nel terminal di RunPod
cd /workspace/ComfyUI/
wget [URL_DEL_TUO_SCRIPT] -O RUNPOD_INSTALL_PORTRAIT_MASTER.sh
chmod +x RUNPOD_INSTALL_PORTRAIT_MASTER.sh
```

### 2. Esegui l'installazione automatica
```bash
./RUNPOD_INSTALL_PORTRAIT_MASTER.sh
```

### 3. Download manuale LoRA Skin Texture
```bash
# Opzione A - Con API Civitai (raccomandato)
cd /workspace/ComfyUI/models/loras/
wget --header='Authorization: Bearer TUA_API_KEY' \
     'https://civitai.com/api/download/models/827325' \
     -O FluxRealSkin-v2.0.safetensors
```

**Opzione B** - Download manuale dal browser:
1. Vai su: https://civitai.com/models/651043?modelVersionId=827325
2. Scarica il file
3. Carica su RunPod in `/workspace/ComfyUI/models/loras/`

### 4. Verifica modello FLUX principale
```bash
ls -la /workspace/ComfyUI/models/checkpoints/flux1-dev*
```

### 5. Riavvia ComfyUI
```bash
# Ferma ComfyUI se attivo
# Riavvia dal pannello RunPod
```

---

## 🔧 COSA INSTALLA LO SCRIPT

### Custom Nodes:
- ✅ FOCUS Nodes (link corretto)
- ✅ WaveSpeed FBCache  
- ✅ RGThree
- ✅ ComfyUI LayerStyle
- ✅ ComfyUI Impact Pack
- ✅ Ultimate SD Upscale
- ✅ ComfyUI Image Saver

### Modelli:
- ✅ T5XXL Text Encoder
- ✅ CLIP-L  
- ✅ VAE FLUX (ae.sft)
- ✅ 4xFaceUpSharpDAT Upscaler (link corretto)

### Dipendenze Python:
- segment-anything
- rembg
- opencv-python
- pillow

---

## ⚠️ IMPORTANTE

1. **Directory RunPod**: Lo script usa automaticamente `/workspace/ComfyUI/`
2. **Link aggiornati**: Tutti i link sono stati verificati e corretti
3. **Download manuale**: Solo FluxRealSkin-v2.0.safetensors richiede download manuale
4. **Riavvio necessario**: Riavvia ComfyUI dopo l'installazione

---

## 🎯 DOPO L'INSTALLAZIONE

1. Copia i workflow Portrait Master corretti in `/workspace/ComfyUI/`
2. Testa con `PortraitMaster_Flux1_Lite.json` (il più stabile)
3. Se tutto funziona, prova gli altri workflow

---

## 📞 TROUBLESHOOTING

**Errore FOCUS Nodes**: Link aggiornato ✅  
**Errore Upscaler**: Link HuggingFace corretto ✅  
**Errore VAE**: ae.sft scaricato automaticamente ✅

**Problema JoyCaption**: Usa `PortraitMaster_Flux1_Lite.json` invece di BatchGen 