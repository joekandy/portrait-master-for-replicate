# 🎨 Portrait Master FLUX1 - Installazione Completa

**Installazione ufficiale completa per Portrait Master FLUX1 su ComfyUI**

## 📋 Contenuto Repository

- ✅ Script installazione automatica (`PORTRAIT_MASTER_COMPLETE_SETUP.sh`)
- ✅ Workflow Portrait Master FLUX1 corretti (5 varianti)
- ✅ Documentazione tecnica completa
- ✅ Istruzioni RunPod e installazione locale

## 🚀 Installazione Rapida

### Su RunPod
```bash
cd /workspace/ComfyUI
git clone https://github.com/TUO_USERNAME/portrait-master-flux1.git .
chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh
./PORTRAIT_MASTER_COMPLETE_SETUP.sh
```

### Installazione Locale
```bash
cd /path/to/ComfyUI
git clone https://github.com/TUO_USERNAME/portrait-master-flux1.git .
chmod +x PORTRAIT_MASTER_COMPLETE_SETUP.sh
./PORTRAIT_MASTER_COMPLETE_SETUP.sh
```

## 📦 Modelli Richiesti

### Auto-scaricati
- ✅ VAE FLUX (ae.sft)
- ✅ T5-XXL Text Encoder (9GB)
- ✅ CLIP-L
- ✅ SigCLIP Vision
- ✅ SAM, GroundingDINO, YOLO detectors

### Download Manuale
- 📥 `flux1-dev.safetensors` (12GB) → [HuggingFace](https://huggingface.co/black-forest-labs/FLUX.1-dev)
- 📥 `flux1-redux-dev.safetensors` → [HuggingFace](https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev)

## 🔧 Custom Nodes Installati

- **WaveSpeed FBCache** - Apply First Block Cache
- **DualCLIPLoader** - T5-XXL + CLIP-L 
- **ComfyUI LayerStyle** - Color grading
- **ComfyUI Impact Pack** - Auto-Detailer
- **Ultimate SD Upscale** - Upscaling
- **RGThree** - Fast Bypasser
- **JoyCaption** - Image captioning

## 🎯 Workflow Disponibili

| Nome | Complessità | VRAM | Scopo |
|------|-------------|------|-------|
| Lite | Bassa | 12GB+ | Portrait base |
| Core | Media | 16GB+ | Features avanzate |
| Expression | Alta | 20GB+ | Expression transfer |
| GGUF | Bassa | 8GB+ | Versione quantizzata |
| BatchGen | Molto Alta | 24GB+ | Batch + captioning |

## 🛠️ Troubleshooting

### Errori Comuni
- **OOM**: Riduci risoluzione a 1024x1024
- **Missing models**: Verifica download manuali
- **Node errors**: Riavvia ComfyUI dopo installazione

### Requirements
- **GPU**: RTX 3080+ (12GB VRAM min)
- **RAM**: 32GB+ raccomandati
- **Storage**: 100GB+ liberi
- **Python**: 3.10+

## 📚 Documentazione

Vedi `PortraitMaster_FLUX1_Documentation.txt` per:
- Specifiche tecniche complete
- Parametri ottimali per ogni modulo
- 24 preset expression editor
- Configurazione color grading

---

**Basato sulle specifiche ufficiali Portrait Master FLUX1** 