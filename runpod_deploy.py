#!/usr/bin/env python3
"""
RunPod Serverless Deployment Script
Automatizza il deployment di Portrait Master V1 su RunPod
"""

import os
import sys
import json
import requests
import time
from typing import Dict, Any, Optional

class RunPodDeployer:
    def __init__(self, api_key: str):
        """Inizializza deployer RunPod"""
        self.api_key = api_key
        self.base_url = "https://api.runpod.ai/graphql"
        self.headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}"
        }
    
    def create_endpoint(self, config: Dict[str, Any]) -> Optional[str]:
        """Crea nuovo endpoint serverless"""
        
        mutation = """
        mutation CreateEndpoint($input: EndpointInput!) {
            createEndpoint(input: $input) {
                id
                name
                status
            }
        }
        """
        
        variables = {
            "input": {
                "name": config["name"],
                "dockerImage": config["docker_image"],
                "containerDiskInGb": config["disk_size"],
                "gpuTypes": config["gpu_types"],
                "networkVolumeId": config.get("network_volume_id"),
                "locations": config.get("locations", ["US"]),
                "scalerType": "QUEUE_DELAY",
                "scalerValue": 4,
                "workerCount": 0,
                "maxWorkers": config.get("max_workers", 3),
                "timeoutSeconds": config.get("timeout", 300),
                "retryPolicy": {
                    "maxRetryCount": 3,
                    "retryDelayMs": 1000
                }
            }
        }
        
        try:
            response = requests.post(
                self.base_url,
                json={"query": mutation, "variables": variables},
                headers=self.headers
            )
            
            if response.status_code == 200:
                data = response.json()
                if "errors" in data:
                    print(f"❌ Errore GraphQL: {data['errors']}")
                    return None
                    
                endpoint = data["data"]["createEndpoint"]
                print(f"✅ Endpoint creato: {endpoint['id']}")
                return endpoint["id"]
            else:
                print(f"❌ Errore HTTP: {response.status_code}")
                return None
                
        except Exception as e:
            print(f"❌ Errore richiesta: {e}")
            return None
    
    def get_endpoint_status(self, endpoint_id: str) -> Optional[Dict[str, Any]]:
        """Ottieni status endpoint"""
        
        query = """
        query GetEndpoint($endpointId: String!) {
            endpoint(id: $endpointId) {
                id
                name
                status
                gpuTypes
                dockerImage
                locations
                workers {
                    id
                    status
                    ready
                }
            }
        }
        """
        
        variables = {"endpointId": endpoint_id}
        
        try:
            response = requests.post(
                self.base_url,
                json={"query": query, "variables": variables},
                headers=self.headers
            )
            
            if response.status_code == 200:
                data = response.json()
                if "errors" in data:
                    return None
                return data["data"]["endpoint"]
            return None
            
        except Exception as e:
            print(f"❌ Errore status: {e}")
            return None
    
    def test_endpoint(self, endpoint_id: str) -> bool:
        """Testa endpoint con richiesta semplice"""
        
        test_payload = {
            "input": {
                "prompt": "test portrait of a woman",
                "width": 512,
                "height": 512,
                "steps": 5,
                "workflow": "flux_base"
            }
        }
        
        try:
            response = requests.post(
                f"https://api.runpod.ai/v2/{endpoint_id}/runsync",
                json=test_payload,
                headers=self.headers,
                timeout=60
            )
            
            if response.status_code == 200:
                result = response.json()
                if result.get("status") == "COMPLETED":
                    print("✅ Test endpoint riuscito")
                    return True
                else:
                    print(f"❌ Test fallito: {result}")
                    return False
            else:
                print(f"❌ Errore test: {response.status_code}")
                return False
                
        except Exception as e:
            print(f"❌ Errore test: {e}")
            return False

def main():
    """Funzione principale deployment"""
    
    print("🚀 PORTRAIT MASTER V1 - RUNPOD DEPLOYMENT")
    print("=========================================")
    
    # Verifica API key
    api_key = os.getenv("RUNPOD_API_KEY")
    if not api_key:
        print("❌ RUNPOD_API_KEY non trovata")
        print("Imposta la variabile: export RUNPOD_API_KEY='your_key_here'")
        sys.exit(1)
    
    # Configurazione endpoint
    config = {
        "name": "portrait-master-v1",
        "docker_image": "your_docker_registry/portrait-master-v1:latest",
        "disk_size": 50,  # GB
        "gpu_types": ["NVIDIA GeForce RTX 4090"],
        "max_workers": 3,
        "timeout": 300,  # secondi
        "locations": ["US", "EU"]
    }
    
    print("📋 Configurazione:")
    for key, value in config.items():
        print(f"   {key}: {value}")
    
    # Conferma deployment
    confirm = input("\n🤔 Procedere con il deployment? (y/N): ")
    if confirm.lower() != 'y':
        print("❌ Deployment annullato")
        sys.exit(0)
    
    # Inizializza deployer
    deployer = RunPodDeployer(api_key)
    
    # Crea endpoint
    print("\n🔧 Creazione endpoint...")
    endpoint_id = deployer.create_endpoint(config)
    
    if not endpoint_id:
        print("❌ Creazione endpoint fallita")
        sys.exit(1)
    
    print(f"✅ Endpoint ID: {endpoint_id}")
    
    # Attendi che l'endpoint sia pronto
    print("\n⏳ Attesa inizializzazione endpoint...")
    max_wait = 600  # 10 minuti
    start_time = time.time()
    
    while time.time() - start_time < max_wait:
        status = deployer.get_endpoint_status(endpoint_id)
        
        if status:
            print(f"📊 Status: {status.get('status', 'UNKNOWN')}")
            
            workers = status.get("workers", [])
            ready_workers = [w for w in workers if w.get("ready", False)]
            
            if ready_workers:
                print(f"✅ Workers pronti: {len(ready_workers)}")
                break
            else:
                print(f"⏳ Workers: {len(workers)} (nessuno pronto)")
        
        time.sleep(30)
    else:
        print("❌ Timeout inizializzazione endpoint")
        sys.exit(1)
    
    # Test endpoint
    print("\n🧪 Test endpoint...")
    if deployer.test_endpoint(endpoint_id):
        print("✅ Endpoint funzionante!")
    else:
        print("⚠️ Test endpoint fallito - verificare logs")
    
    # Informazioni finali
    print(f"\n🎉 DEPLOYMENT COMPLETATO!")
    print(f"=====================================")
    print(f"Endpoint ID: {endpoint_id}")
    print(f"API URL: https://api.runpod.ai/v2/{endpoint_id}/runsync")
    print(f"Dashboard: https://runpod.io/serverless")
    
    print(f"\n📡 ESEMPIO UTILIZZO:")
    print(f"""
curl -X POST https://api.runpod.ai/v2/{endpoint_id}/runsync \\
  -H "Authorization: Bearer {api_key}" \\
  -H "Content-Type: application/json" \\
  -d '{{
    "input": {{
      "prompt": "portrait of a beautiful woman, professional photography",
      "width": 1024,
      "height": 1024,
      "steps": 15,
      "cfg": 1.5
    }}
  }}'
""")

 