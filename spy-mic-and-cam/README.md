# Boot Security Monitor

Este projeto configura um sistema de monitoramento automático que é executado a cada boot do sistema operacional Linux. O objetivo é registrar (via foto e áudio) possíveis acessos não autorizados, com detecção facial para ignorar o registro quando o usuário autorizado estiver presente.

## Funcionalidades
- Tira uma foto usando a webcam com brilho, contraste e nitidez ajustados
- Compara a imagem com uma foto de referência do usuário autorizado usando reconhecimento facial
- Se o rosto não for reconhecido, grava 1 minuto de áudio
- Salva os arquivos com timestamp no nome
- Roda automaticamente no boot, independentemente do usuário logado

## Requisitos
- Ubuntu 24.04 (ou similar)
- Python 3
- `pip`
- Webcam e microfone funcionais

## Instalação das dependências

```bash
sudo apt update
sudo apt install -y python3 python3-pip cmake g++ build-essential libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev libboost-python-dev ffmpeg alsa-utils

pip3 install --break-system-packages dlib face_recognition opencv-python
```

## Captura da imagem de referência (do usuário autorizado)

```bash
ffmpeg -f v4l2 -video_size 640x480 -i /dev/video0 -frames:v 1 -vf eq=brightness=0.2:contrast=1.2,unsharp=5:5:1.0:5:5:0.0 ~/photo_reference.jpg
```

## Estrutura de diretórios

```bash
sudo mkdir -p /opt/security
sudo cp boot_monitor.sh /opt/security/
sudo cp face_check.py /opt/security/
sudo cp ~/photo_reference.jpg /opt/security/
sudo chmod +x /opt/security/boot_monitor.sh
```

Crie a pasta onde os registros serão salvos:

```bash
mkdir -p ~/security
```

## Conteúdo do script `boot_monitor.sh`

```bash
#!/bin/bash

IMG_TEMP="/tmp/snapshot.jpg"
TIMESTAMP=$(date +"%Y%m%d_%H%M")
IMG_OUT="$HOME/security/snapshot_$TIMESTAMP.jpg"
AUDIO_OUT="$HOME/security/audio_$TIMESTAMP.wav"

# Tirar foto do invasor
ffmpeg -f v4l2 -video_size 640x480 -i /dev/video0 -frames:v 1 -vf eq=brightness=0.2:contrast=1.2,unsharp=5:5:1.0:5:5:0.0 "$IMG_TEMP"

# Verificar rosto
python3 /opt/security/face_check.py "$IMG_TEMP" /opt/security/photo_reference.jpg

if [ $? -ne 0 ]; then
    cp "$IMG_TEMP" "$IMG_OUT"
    arecord -f cd -d 60 "$AUDIO_OUT"
fi
```

## Conteúdo do script `face_check.py`

```python
import face_recognition
import sys

print("Carregando imagem de entrada...")
image = face_recognition.load_image_file(sys.argv[1])
chk_faces = face_recognition.face_encodings(image)
if len(chk_faces) == 0:
    print("❌ Nenhum rosto encontrado na imagem capturada.")
    exit(1)
chk_encoding = chk_faces[0]

print("Carregando imagem de referência...")
reference_image = face_recognition.load_image_file(sys.argv[2])
ref_encoding = face_recognition.face_encodings(reference_image)[0]

match = face_recognition.compare_faces([ref_encoding], chk_encoding, tolerance=0.5)[0]

if match:
    print("✅ Rosto reconhecido. Ação ignorada.")
    exit(0)
else:
    print("⚠️ Rosto não reconhecido. Iniciando gravação.")
    exit(1)
```

## Criar serviço systemd

Crie o arquivo:
```bash
sudo nano /etc/systemd/system/boot-security-monitor.service
```

Conteúdo:
```ini
[Unit]
Description=Boot Security Monitor (Photo + Audio + Face Detection)
DefaultDependencies=no
After=local-fs.target
Before=graphical.target

[Service]
Type=simple
ExecStart=/opt/security/boot_monitor.sh
Restart=no
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

Ative o serviço:
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable boot-security-monitor.service
```

## Testes manuais

- Executar manualmente:
```bash
sudo systemctl start boot-security-monitor.service
```

- Ver logs:
```bash
journalctl -u boot-security-monitor.service -b
```

---

Com isso, o sistema está pronto para capturar e registrar tentativas de acesso sempre que o sistema for iniciado. ✅

