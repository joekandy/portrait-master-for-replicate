# 🚀 GUIDA COMPLETA RUNPOD SERVERLESS

## 📋 STEP 1: COMMIT E PUSH MODIFICHE

Prima committiamo le modifiche al Dockerfile e requirements.txt:

```bash
# Nel terminale del progetto
git add .
git commit -m "🔧 Fix Dockerfile e requirements.txt per RunPod"
git push origin main
```

## 📋 STEP 2: CREARE ENDPOINT SU RUNPOD

### 2.1 Accedi a RunPod
1. Vai su https://runpod.io
2. Fai login al tuo account
3. Clicca su **"Serverless"** nel menu

### 2.2 Nuovo Endpoint
1. Clicca **"+ New Endpoint"**
2. Compila i campi:

#### Template Settings
- **Endpoint Name**: `portrait-master-v1`
- **Docker Image**: `joekandy/portrait-master-v1:latest` (useremo GitHub)

#### Container Configuration
- **Container Disk**: `50 GB`
- **Container Registry Credentials**: Lascia vuoto per GitHub pubblico

#### Serverless Configuration
- **GPU Types**: Seleziona **H100 SXM** (48GB) che hai scelto
- **Max Workers**: `3`
- **Idle Timeout**: `5` secondi
- **Flash Boot**: ✅ Abilitato
- **Scale Down Delay**: `10` secondi

#### Advanced
- **Environment Variables**:
  ```
  CUDA_VISIBLE_DEVICES=0
  PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512
  COMFYUI_DISABLE_FP8=1
  ```

### 2.3 Deploy
1. Clicca **"Deploy"**
2. Attendi che mostri "Building..." poi "Active"

## 📋 STEP 3: ALTERNATIVA - USA IMMAGINE PRE-BUILT

Se il build da GitHub fallisce, usiamo un'immagine Docker diretta:

### 3.1 Build in Locale (Opzionale)
```bash
# Solo se vuoi testare in locale
git clone https://github.com/joekandy/portrait-master-v1.git
cd portrait-master-v1
docker build -t portrait-master-v1:latest .
```

### 3.2 Usa Template RunPod Esistente
Nel creare l'endpoint, invece di GitHub, usa:
- **Docker Image**: `runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04`
- Poi aggiungeremo il nostro codice via volume

## 📋 STEP 4: CONFIGURAZIONE RAPIDA

Se vuoi la configurazione più semplice possibile:

### Configurazione Minima
```yaml
Endpoint Name: portrait-master-v1
Docker Image: ghcr.io/joekandy/portrait-master-v1:latest
Container Disk: 50GB
GPU: H100 (48GB)
Max Workers: 1
Timeout: 300s
```

### Environment Variables Essenziali
```bash
COMFYUI_DISABLE_FP8=1
CUDA_VISIBLE_DEVICES=0
```

## 📋 STEP 5: TEST ENDPOINT

### 5.1 Ottieni API Key
1. Vai su RunPod Settings
2. Copia la tua **API Key**

### 5.2 Test con cURL
```bash
curl -X POST https://api.runpod.ai/v2/{ENDPOINT_ID}/runsync \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "input": {
      "prompt": "portrait of a beautiful woman",
      "width": 1024,
      "height": 1024,
      "steps": 10
    }
  }'
```

### 5.3 Test con Python
```python
import requests
import json

endpoint_id = "YOUR_ENDPOINT_ID"
api_key = "YOUR_API_KEY"

response = requests.post(
    f"https://api.runpod.ai/v2/{endpoint_id}/runsync",
    headers={"Authorization": f"Bearer {api_key}"},
    json={
        "input": {
            "prompt": "portrait of a young woman, professional photography",
            "width": 1024,
            "height": 1024,
            "steps": 15,
            "cfg": 1.5
        }
    }
)

result = response.json()
print(json.dumps(result, indent=2))
```

## 🔧 TROUBLESHOOTING

### Errore "Build Failed"
**Soluzione**: Usa immagine base e installa runtime:
```yaml
Docker Image: runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04
Container Disk: 50GB
```

### Errore "Model Not Found"
**Soluzione**: I modelli si scaricheranno al primo run (cold start più lungo)

### Errore "CUDA Out of Memory" 
**Soluzione**: 
- Riduci resolution: `"width": 512, "height": 512`
- Riduci steps: `"steps": 10`

### Errore "Timeout"
**Soluzione**: Aumenta timeout a 600s

## 📊 COSTI STIMATI

### H100 (48GB)
- **Costo**: ~$4.89/ora
- **Per immagine**: ~$0.15-0.25
- **Cold start**: 60-120 secondi

### RTX 4090 (24GB) - ALTERNATIVA
- **Costo**: ~$1.89/ora  
- **Per immagine**: ~$0.05-0.10
- **Cold start**: 30-60 secondi

## 🎯 RACCOMANDAZIONE

**Per iniziare**, usa questa configurazione semplice:

```yaml
Endpoint Name: portrait-master-v1
Docker Image: runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04
Container Disk: 40GB
GPU: RTX 4090 (24GB)  # Più economico per testing
Max Workers: 1
Timeout: 300s
Environment:
  COMFYUI_DISABLE_FP8: 1
```

Poi aggiungeremo il nostro handler manualmente una volta che funziona! 