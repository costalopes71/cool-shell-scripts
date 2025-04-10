# Boot Security Monitor

Este projeto configura um sistema de monitoramento automático que é executado a cada boot do sistema operacional Linux. O objetivo é registrar (via foto e áudio) possíveis acessos não autorizados, com detecção facial para ignorar o registro quando o usuário autorizado estiver presente.

## Funcionalidades
- Tira uma foto usando a webcam com brilho, contraste e nitidez ajustados para maior nitidez
- Compara a imagem com uma foto de referência do usuário autorizado usando reconhecimento facial
- Se o rosto não for reconhecido, grava 30 segundos de áudio e salva a foto do usuário que está tentando entrar na máquina
- Salva os arquivos com timestamp no nome
- Roda automaticamente no boot, independentemente do usuário logado

## Requisitos
- Testado no Ubuntu 24.04 mas provavelmente funciona em qualquer outra versão e distro
- Python 3
- `pip`
- Webcam e microfone funcionais

## Alterar script para utilizar o diretório escolhido
Dentro do script safe-login altere as duas variáveis `[YOUR_FOLDER_HERE]` pelo nome do diretório que você deseja salvar a foto e aúdio do intruso.

## Instalação das dependências

```bash
sudo apt update
sudo apt install -y python3 python3-pip cmake g++ build-essential libopenblas-dev liblapack-dev libx11-dev libgtk-3-dev libboost-python-dev ffmpeg alsa-utils

pip3 install --break-system-packages dlib face_recognition opencv-python
```

## Captura da imagem de referência (do usuário autorizado)

Tire uma foto sua para servir de referência para o reconhecimento facial. Caso queria você pode utilizar o comando abaixo para tirar uma foto do seu rosto.
```bash
ffmpeg -f v4l2 -video_size 640x480 -i /dev/video0 -frames:v 1 -vf eq=brightness=0.2:contrast=1.2,unsharp=5:5:1.0:5:5:0.0 ~/photo_reference.jpg
```

## Estrutura de diretórios

- cria a pasta onde o programa deve estar localizado (/opt/security)
- essa pasta deve contar os 3 arquivos necessários para a execução do programa: safe-login, face_check.py e sua foto de referência com o nome de photo_reference.jpg
- dê permissão de execução para o script safe-login
```bash
sudo mkdir -p /opt/security
sudo cp safe-login /opt/security/
sudo cp face_check.py /opt/security/
# mova ou copie sua foto de referência para a pasta /opt/security
sudo cp ~/photo_reference.jpg /opt/security/
sudo chmod +x /opt/security/safe-login
```

Crie a pasta onde os registros do possível atacante serão salvos:

```bash
mkdir -p ~/security
```

## Criar serviço systemd

Copie o arquivo boot-security-monitor.service para a pasta do systemd:
```bash
sudo cp boot-security-monitor.service /etc/systemd/system/
```

Ative o serviço:
```bash
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
