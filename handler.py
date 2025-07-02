#!/usr/bin/env python3
"""
Portrait Master V1 - RunPod Serverless Handler
Gestisce richieste API per generazione ritratti con FLUX/SD1.5
"""

import json
import os
import sys
import time
import subprocess
import logging
from pathlib import Path
from typing import Dict, Any, Optional, List
import requests
import tempfile
import base64
from io import BytesIO

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Paths
COMFYUI_PATH = "/workspace/ComfyUI"
MODELS_PATH = f"{COMFYUI_PATH}/models"
WORKFLOWS_PATH = "/workspace/workflows"

class PortraitMasterHandler:
    def __init__(self):
        """Inizializza l'handler e verifica il setup"""
        self.comfyui_server = "http://127.0.0.1:8188"
        self.models_loaded = False
        self.setup_comfyui()
        
    def setup_comfyui(self):
        """Setup automatico ComfyUI se non è già attivo"""
        try:
            # Verifica se ComfyUI è già attivo
            response = requests.get(f"{self.comfyui_server}/system_stats", timeout=5)
            if response.status_code == 200:
                logger.info("✅ ComfyUI già attivo")
                return True
                
        except requests.exceptions.RequestException:
            logger.info("🚀 Avvio ComfyUI...")
            
        # Avvia ComfyUI in background
        try:
            # Cambia nella directory ComfyUI
            os.chdir(COMFYUI_PATH)
            
            # Avvia ComfyUI con parametri ottimizzati per serverless
            cmd = [
                sys.executable, "main.py",
                "--listen", "127.0.0.1",
                "--port", "8188",
                "--force-fp16",
                "--disable-xformers",
                "--dont-upcast-attention",
                "--lowvram",
                "--cpu-vae"
            ]
            
            # Avvia in background
            subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                env=dict(os.environ, **{
                    "CUDA_VISIBLE_DEVICES": "0",
                    "PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:512",
                    "COMFYUI_DISABLE_FP8": "1"
                })
            )
            
            # Attendi che ComfyUI sia pronto
            max_wait = 120  # 2 minuti max
            start_time = time.time()
            
            while time.time() - start_time < max_wait:
                try:
                    response = requests.get(f"{self.comfyui_server}/system_stats", timeout=5)
                    if response.status_code == 200:
                        logger.info("✅ ComfyUI avviato con successo")
                        return True
                except requests.exceptions.RequestException:
                    pass
                    
                time.sleep(3)
                
            raise Exception("❌ Timeout avvio ComfyUI")
            
        except Exception as e:
            logger.error(f"❌ Errore setup ComfyUI: {e}")
            return False
    
    def load_workflow(self, workflow_type: str = "flux_base") -> Dict[str, Any]:
        """Carica workflow JSON"""
        workflow_files = {
            "flux_base": "flux_portrait_base.json",
            "flux_advanced": "flux_portrait_advanced.json", 
            "sd15": "sd15_portrait.json"
        }
        
        workflow_file = workflow_files.get(workflow_type, workflow_files["flux_base"])
        workflow_path = Path(WORKFLOWS_PATH) / workflow_file
        
        if not workflow_path.exists():
            # Fallback su workflow nella directory corrente
            workflow_path = Path(f"flux_portrait_CUBLAS_FIXED.json")
            
        if not workflow_path.exists():
            raise FileNotFoundError(f"❌ Workflow non trovato: {workflow_file}")
            
        with open(workflow_path, 'r') as f:
            return json.load(f)
    
    def update_workflow_params(self, workflow: Dict[str, Any], params: Dict[str, Any]) -> Dict[str, Any]:
        """Aggiorna parametri del workflow"""
        
        # Parametri comuni
        prompt = params.get("prompt", "portrait of a beautiful woman, professional photography")
        negative_prompt = params.get("negative_prompt", "")
        width = params.get("width", 1024)
        height = params.get("height", 1024)
        steps = params.get("steps", 15)
        cfg = params.get("cfg", 1.5)
        seed = params.get("seed", -1)
        
        # Cerca e aggiorna nodi nel workflow
        for node_id, node in workflow.get("nodes", {}).items():
            node_type = node.get("class_type", "")
            
            # Text encoding nodes
            if node_type == "CLIPTextEncode":
                if "positive" in str(node.get("inputs", {})):
                    node["inputs"]["text"] = prompt
                elif "negative" in str(node.get("inputs", {})):
                    node["inputs"]["text"] = negative_prompt
                    
            # Empty latent image
            elif node_type == "EmptyLatentImage":
                node["inputs"]["width"] = width
                node["inputs"]["height"] = height
                
            # Sampler
            elif node_type == "KSampler":
                node["inputs"]["steps"] = steps
                node["inputs"]["cfg"] = cfg
                if seed > 0:
                    node["inputs"]["seed"] = seed
                    
            # Flux Guidance
            elif node_type == "FluxGuidance":
                node["inputs"]["guidance"] = cfg
        
        return workflow
    
    def queue_prompt(self, workflow: Dict[str, Any]) -> Optional[str]:
        """Invia workflow a ComfyUI e restituisce prompt_id"""
        try:
            response = requests.post(
                f"{self.comfyui_server}/prompt",
                json={"prompt": workflow},
                timeout=30
            )
            
            if response.status_code == 200:
                result = response.json()
                return result.get("prompt_id")
            else:
                logger.error(f"❌ Errore queue prompt: {response.status_code} - {response.text}")
                return None
                
        except Exception as e:
            logger.error(f"❌ Errore invio prompt: {e}")
            return None
    
    def wait_for_completion(self, prompt_id: str, timeout: int = 300) -> Optional[Dict[str, Any]]:
        """Attende completamento generazione"""
        start_time = time.time()
        
        while time.time() - start_time < timeout:
            try:
                # Controlla history
                response = requests.get(f"{self.comfyui_server}/history/{prompt_id}")
                
                if response.status_code == 200:
                    history = response.json()
                    
                    if prompt_id in history:
                        result = history[prompt_id]
                        
                        # Controlla se completato
                        if result.get("status", {}).get("completed", False):
                            return result
                            
                        # Controlla errori
                        elif "error" in result.get("status", {}):
                            logger.error(f"❌ Errore generazione: {result['status']['error']}")
                            return None
                            
                time.sleep(2)
                
            except Exception as e:
                logger.error(f"❌ Errore controllo completamento: {e}")
                time.sleep(5)
                
        logger.error("❌ Timeout generazione")
        return None
    
    def get_output_images(self, result: Dict[str, Any]) -> List[str]:
        """Estrae immagini risultato come base64"""
        images = []
        
        try:
            outputs = result.get("outputs", {})
            
            for node_id, node_output in outputs.items():
                if "images" in node_output:
                    for image_info in node_output["images"]:
                        filename = image_info.get("filename")
                        subfolder = image_info.get("subfolder", "")
                        
                        if filename:
                            # Costruisci path immagine
                            image_path = Path(COMFYUI_PATH) / "output"
                            if subfolder:
                                image_path = image_path / subfolder
                            image_path = image_path / filename
                            
                            # Leggi e converti in base64
                            if image_path.exists():
                                with open(image_path, "rb") as f:
                                    image_data = f.read()
                                    image_b64 = base64.b64encode(image_data).decode()
                                    images.append(image_b64)
                                    
        except Exception as e:
            logger.error(f"❌ Errore estrazione immagini: {e}")
            
        return images

def handler(event: Dict[str, Any]) -> Dict[str, Any]:
    """Handler principale RunPod serverless"""
    try:
        logger.info("🚀 Avvio Portrait Master V1")
        
        # Inizializza handler
        pm = PortraitMasterHandler()
        
        # Estrai parametri input
        input_data = event.get("input", {})
        
        workflow_type = input_data.get("workflow", "flux_base")
        
        # Carica e configura workflow
        logger.info(f"📋 Caricamento workflow: {workflow_type}")
        workflow = pm.load_workflow(workflow_type)
        workflow = pm.update_workflow_params(workflow, input_data)
        
        # Avvia generazione
        logger.info("🎨 Avvio generazione...")
        prompt_id = pm.queue_prompt(workflow)
        
        if not prompt_id:
            return {"error": "❌ Errore invio prompt a ComfyUI"}
            
        # Attendi completamento
        logger.info(f"⏳ Attesa completamento (ID: {prompt_id})...")
        result = pm.wait_for_completion(prompt_id)
        
        if not result:
            return {"error": "❌ Errore o timeout generazione"}
            
        # Estrai immagini
        logger.info("🖼️ Estrazione immagini...")
        images = pm.get_output_images(result)
        
        if not images:
            return {"error": "❌ Nessuna immagine generata"}
            
        logger.info(f"✅ Generazione completata - {len(images)} immagini")
        
        return {
            "images": images,
            "prompt_id": prompt_id,
            "workflow_type": workflow_type,
            "parameters": input_data
        }
        
    except Exception as e:
        logger.error(f"❌ Errore handler: {e}")
        return {"error": f"❌ Errore interno: {str(e)}"}

# Per testing locale
if __name__ == "__main__":
    test_input = {
        "input": {
            "prompt": "portrait of a young woman, professional photography, high quality",
            "width": 1024,
            "height": 1024,
            "steps": 15,
            "cfg": 1.5,
            "workflow": "flux_base"
        }
    }
    
    result = handler(test_input)
    print(json.dumps(result, indent=2)) 