# 🎨 Portrait Master V1 - RunPod Serverless

Un sistema avanzato per la generazione di ritratti AI professionali utilizzando FLUX e Stable Diffusion, ottimizzato per deployment serverless su RunPod.

[![RunPod](https://img.shields.io/badge/RunPod-Serverless-blue)](https://runpod.io)
[![FLUX](https://img.shields.io/badge/FLUX-1.dev-orange)](https://github.com/black-forest-labs/flux)
[![ComfyUI](https://img.shields.io/badge/ComfyUI-Latest-green)](https://github.com/comfyanonymous/ComfyUI)

## 🚀 Caratteristiche

- ✅ **Serverless**: Pay-per-use, auto-scaling automatico
- ✅ **FLUX 1.dev**: Modello AI all'avanguardia per ritratti
- ✅ **Cold Start < 30s**: Avvio rapido ottimizzato
- ✅ **API REST**: Integrazione semplice e standard
- ✅ **Batch Processing**: Supporto generazione multipla
- ✅ **Error Recovery**: Gestione robusta degli errori
- ✅ **Cache Intelligente**: Modelli pre-caricati

## 📋 Requisiti

- Account RunPod con accesso serverless
- GPU NVIDIA con almeno 16GB VRAM (RTX 4090 consigliata)
- Docker per deployment

## 🔧 Setup Rapido

### 1. Clone Repository
```bash
git clone https://github.com/joekandy/portrait-master-v1.git
cd portrait-master-v1
```

### 2. Build Docker Image
```bash
docker build -t portrait-master-v1:latest .
```

### 3. Deploy su RunPod
1. Vai su [RunPod Serverless](https://runpod.io/serverless)
2. Clicca "New Endpoint"
3. Carica l'immagine Docker: `portrait-master-v1:latest`
4. Configura:
   - **Container Disk**: 50GB
   - **GPU**: RTX 4090 (24GB)
   - **Timeout**: 300s
   - **Concurrency**: 1

## 📡 API Usage

### Endpoint Base
```
POST https://api.runpod.ai/v2/{your_endpoint_id}/runsync
```

### Headers
```json
{
  "Authorization": "Bearer YOUR_RUNPOD_API_KEY",
  "Content-Type": "application/json"
}
```

### Request Body
```json
{
  "input": {
    "prompt": "portrait of a beautiful woman, professional photography, high quality",
    "negative_prompt": "blurry, low quality, distorted",
    "width": 1024,
    "height": 1024,
    "steps": 15,
    "cfg": 1.5,
    "seed": -1,
    "workflow": "flux_base"
  }
}
```

### Response
```json
{
  "status": "COMPLETED",
  "output": {
    "images": ["base64_encoded_image_1", "base64_encoded_image_2"],
    "prompt_id": "unique_generation_id",
    "workflow_type": "flux_base",
    "parameters": {...}
  }
}
```

## 🎨 Workflow Disponibili

| Workflow | Descrizione | Tempo | Qualità |
|----------|-------------|-------|---------|
| `flux_base` | FLUX base ottimizzato | ~60s | Alta |
| `flux_advanced` | FLUX con parametri avanzati | ~90s | Massima |
| `sd15` | Stable Diffusion 1.5 (fallback) | ~30s | Media |

## 🛠️ Parametri Configurabili

### Core Parameters
- `prompt` (string): Descrizione del ritratto desiderato
- `negative_prompt` (string): Elementi da evitare
- `width/height` (int): Dimensioni immagine (512-2048)
- `steps` (int): Passi denoising (10-50)
- `cfg` (float): Guidance scale (1.0-3.0)
- `seed` (int): Seed per riproducibilità (-1 = random)

### Advanced Parameters
- `workflow` (string): Tipo di workflow da utilizzare
- `batch_size` (int): Numero immagini da generare (1-4)
- `scheduler` (string): Scheduler del sampler
- `sampler` (string): Tipo di sampler

## 📊 Performance

| Metric | Valore |
|--------|--------|
| **Cold Start** | < 30 secondi |
| **Warm Generation** | 45-90 secondi |
| **Throughput** | 40-60 img/ora |
| **VRAM Usage** | 16-20GB |
| **Disk Space** | 45GB |

## 🔍 Testing Locale

### Setup Ambiente
```bash
# Installa dipendenze
pip install -r requirements.txt

# Download modelli
chmod +x scripts/download_models.sh
./scripts/download_models.sh

# Setup ComfyUI
chmod +x scripts/setup_comfyui.sh
./scripts/setup_comfyui.sh
```

### Test Handler
```bash
python handler.py
```

### Test API
```bash
curl -X POST http://localhost:8188/api/test \
  -H "Content-Type: application/json" \
  -d '{
    "input": {
      "prompt": "portrait of a young woman, professional photography",
      "width": 1024,
      "height": 1024
    }
  }'
```

## 🐛 Troubleshooting

### Errori Comuni

#### 1. CUDA Out of Memory
```json
{"error": "CUDA out of memory"}
```
**Soluzione**: Riduci `width`, `height` o aggiungi `--lowvram`

#### 2. Model Not Found
```json
{"error": "Model not found: flux1-dev.safetensors"}
```
**Soluzione**: Verifica download modelli con `./scripts/download_models.sh`

#### 3. Timeout Generation
```json
{"error": "Timeout generazione"}
```
**Soluzione**: Riduci `steps` o aumenta timeout RunPod

### Debug Logs
```bash
# Controlla logs ComfyUI
tail -f /workspace/ComfyUI/comfyui.log

# Controlla status sistema
curl http://localhost:8188/system_stats
```

## 📈 Ottimizzazioni

### Performance
- Usa `flux_base` per generazioni rapide
- Imposta `steps=15` per bilanciare qualità/velocità
- Usa batch processing per più immagini

### Costi
- Attiva solo quando necessario (serverless)
- Usa cache per modelli frequenti
- Monitora usage attraverso RunPod dashboard

## 🔧 Sviluppo

### Struttura Progetto
```
portrait-master-v1/
├── handler.py              # Handler serverless principale
├── Dockerfile              # Container definition
├── requirements.txt        # Python dependencies
├── workflows/              # Workflow ComfyUI
├── scripts/                # Setup e utility scripts
├── utils/                  # Utility functions
└── docs/                   # Documentazione
```

### Custom Workflows
1. Crea nuovo workflow in `workflows/`
2. Aggiorna `load_workflow()` in `handler.py`
3. Testa localmente
4. Rebuild Docker image

### Contribuire
1. Fork del repository
2. Crea feature branch
3. Commit con messaggi descrittivi
4. Apri Pull Request

## 📄 Licenza

MIT License - vedi [LICENSE](LICENSE) per dettagli.

## 🤝 Supporto

- 📧 Email: [support@portraitmaster.ai](mailto:support@portraitmaster.ai)
- 💬 Discord: [Portrait Master Community](https://discord.gg/portraitmaster)
- 📚 Docs: [docs.portraitmaster.ai](https://docs.portraitmaster.ai)
- 🐛 Issues: [GitHub Issues](https://github.com/joekandy/portrait-master-v1/issues)

## 🙏 Credits

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI) - Framework UI
- [FLUX](https://github.com/black-forest-labs/flux) - Modello AI
- [RunPod](https://runpod.io) - Infrastruttura serverless
- Community contributors

---

**Made with ❤️ for the AI Art Community** 