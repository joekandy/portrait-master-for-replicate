# 🚀 COMFYUI SENZA RESTRIZIONI - GUIDA COMPLETA

## 🎯 PANORAMICA

Questa configurazione ti permette di usare **ComfyUI con ZERO restrizioni**, dandoti controllo completo su:
- ✅ **Installazione illimitata di custom nodes**
- ✅ **Nessuna restrizione di sicurezza**
- ✅ **Manager configurato liberamente** 
- ✅ **Prestazioni ottimizzate**
- ✅ **Modalità sviluppatore attiva**

---

## 🚀 SETUP INIZIALE (5 minuti)

### 1. Installa ComfyUI (se non lo hai)
```bash
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install -r requirements.txt
```

### 2. Configura tutto senza restrizioni
**Doppio click** su: `COMFYUI_NO_RESTRICTIONS_WINDOWS.bat`

Questo script:
- ✅ Configura Manager senza restrizioni
- ✅ Crea scripts di avvio potenziati
- ✅ Rimuove tutti i blocchi di sicurezza
- ✅ Ottimizza le prestazioni

---

## 📋 SCRIPTS CREATI

| Script | Funzione | Uso |
|--------|----------|-----|
| `START_COMFYUI_DEV_MODE.bat` | 🚀 Avvia modalità sviluppatore | Doppio click |
| `INSTALL_ANY_NODE.bat` | 🔌 Installa qualsiasi nodo | `INSTALL_ANY_NODE.bat <url>` |
| `CHECK_SYSTEM.bat` | 🔍 Controllo sistema completo | Doppio click |
| `INSTALL_COMFYUI_MANAGER.bat` | 🔧 Installa Manager libero | Doppio click |

---

## 🔌 COME INSTALLARE CUSTOM NODES

### Metodo 1: Via Script (CONSIGLIATO)
```cmd
INSTALL_ANY_NODE.bat https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
INSTALL_ANY_NODE.bat https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
INSTALL_ANY_NODE.bat https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git
```

### Metodo 2: Via Manager Web
1. Avvia ComfyUI: `START_COMFYUI_DEV_MODE.bat`
2. Vai su http://localhost:8188
3. Clicca **"Manager"**
4. **"Install Custom Nodes"**
5. Cerca e installa qualsiasi nodo
6. **"Restart"**

### Metodo 3: Manuale
```cmd
cd ComfyUI\custom_nodes
git clone https://github.com/repository/CustomNode.git
cd CustomNode
pip install -r requirements.txt
```

---

## 🌟 CARATTERISTICHE ATTIVE

### 🔓 Sicurezza Disabilitata
- **Security Level**: 0 (Massima libertà)
- **Security Mode**: Disattivato
- **SSL Bypass**: Abilitato
- **Safe Unpickle**: Disattivato

### ⚡ Prestazioni Ottimizzate
- **GPU Memory**: Gestione ottimizzata
- **Attention**: Split cross-attention
- **FP16**: Forzato per prestazioni
- **CORS**: Abilitato per accesso esterno

### 🔌 Nodi Senza Limiti
- **Installazione**: Qualsiasi repository GitHub
- **Dipendenze**: Auto-installazione
- **Aggiornamenti**: Senza blocchi
- **Configurazione**: Totalmente libera

---

## 💡 ESEMPI USO QUOTIDIANO

### Avvio Rapido
1. Doppio click: `START_COMFYUI_DEV_MODE.bat`
2. Apri: http://localhost:8188
3. Carica workflow
4. Genera!

### Installazione Nodi Popolari
```cmd
REM Nodi per ritratti e volti
INSTALL_ANY_NODE.bat https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
INSTALL_ANY_NODE.bat https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

REM Nodi per controllo avanzato
INSTALL_ANY_NODE.bat https://github.com/Fannovel16/comfyui_controlnet_aux.git
INSTALL_ANY_NODE.bat https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git

REM Nodi per animazioni
INSTALL_ANY_NODE.bat https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git
INSTALL_ANY_NODE.bat https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

REM Nodi utility
INSTALL_ANY_NODE.bat https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
INSTALL_ANY_NODE.bat https://github.com/chflame163/ComfyUI_LayerStyle.git
```

### Controllo Sistema
```cmd
CHECK_SYSTEM.bat
```
Ti mostra:
- 📊 Stato GPU e memoria
- 📁 Directory e modelli
- 🔌 Custom nodes installati
- 🚀 Processi attivi

---

## 🔧 RISOLUZIONE PROBLEMI

### ComfyUI non parte?
1. Controlla Python installato: `python --version`
2. Verifica dipendenze: `pip install -r ComfyUI\requirements.txt`
3. Prova modalità debug: Modifica `START_COMFYUI_DEV_MODE.bat` e aggiungi `--verbose`

### Nodo non si installa?
1. Verifica URL repository: Deve essere GitHub con `.git`
2. Controlla connessione internet
3. Prova installazione manuale:
   ```cmd
   cd ComfyUI\custom_nodes
   git clone <url-repository>
   ```

### Manager non funziona?
1. Reinstalla: `INSTALL_COMFYUI_MANAGER.bat`
2. Verifica configurazione: Apri `ComfyUI\custom_nodes\ComfyUI-Manager\config.ini`
3. Deve avere `security_level = 0`

### Errori GPU/CUDA?
1. Verifica driver NVIDIA aggiornati
2. Installa CUDA Toolkit
3. Reinstalla PyTorch:
   ```cmd
   pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
   ```

---

## 🌐 ACCESSO ESTERNO (Opzionale)

### Per accedere da altri dispositivi:
1. Trova il tuo IP locale: `ipconfig`
2. Accedi da: `http://TUO-IP:8188`
3. CORS è già abilitato

### Con Ngrok (per accesso internet):
1. Installa Ngrok: https://ngrok.com/download
2. Avvia tunnel: `ngrok http 8188`
3. Usa URL fornito da Ngrok

---

## ⚠️ IMPORTANTE - SICUREZZA

**Questa configurazione disabilita TUTTE le restrizioni di sicurezza!**

✅ **Vantaggi:**
- Installazione libera di qualsiasi nodo
- Nessun blocco o limitazione
- Prestazioni ottimizzate
- Controllo completo

⚠️ **Attenzioni:**
- Installa solo nodi da fonti fidate
- Non usare su server pubblici
- Fai backup regolari
- Usa solo in ambiente controllato

---

## 📞 SUPPORTO

### Se qualcosa non funziona:

1. **Controlla sistema**: `CHECK_SYSTEM.bat`
2. **Riavvia ComfyUI**: Chiudi e riapri `START_COMFYUI_DEV_MODE.bat`
3. **Reset configurazione**: Riesegui `COMFYUI_NO_RESTRICTIONS_WINDOWS.bat`
4. **Reinstalla Manager**: `INSTALL_COMFYUI_MANAGER.bat`

### Log di debug:
I file di log sono in: `ComfyUI\comfyui.log`

---

## 🎉 RISULTATO FINALE

Ora hai:
- ✅ **ComfyUI completamente libero**
- ✅ **Zero restrizioni di sicurezza**
- ✅ **Installazione nodi illimitata**
- ✅ **Manager configurato liberamente**
- ✅ **Scripts di gestione automatica**
- ✅ **Prestazioni ottimizzate**

**🚀 Puoi installare QUALSIASI custom node senza limitazioni!**

---

## 📚 RISORSE UTILI

### Repository Nodi Popolari:
- **Impact Pack**: https://github.com/ltdrdata/ComfyUI-Impact-Pack
- **IP Adapter**: https://github.com/cubiq/ComfyUI_IPAdapter_plus
- **ControlNet Aux**: https://github.com/Fannovel16/comfyui_controlnet_aux
- **AnimateDiff**: https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved
- **LayerStyle**: https://github.com/chflame163/ComfyUI_LayerStyle
- **Ultimate Upscale**: https://github.com/ssitu/ComfyUI_UltimateSDUpscale

### Documentazione:
- **ComfyUI Wiki**: https://github.com/comfyanonymous/ComfyUI/wiki
- **Manager Docs**: https://github.com/ltdrdata/ComfyUI-Manager
- **Custom Nodes List**: https://github.com/WASasquatch/comfyui-plugins

---

**🎯 Ora hai il controllo TOTALE su ComfyUI! Installa, sperimenta e crea senza limiti!** 