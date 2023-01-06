no terminal instale as seguintes dependencias (usando sudo):
sudo apt install fswebcam
sudo apt install mailutils ssmtp
Siga essa documentacao para configurar seu email no seu PC:
https://learnubuntu.com/send-emails-from-server/
na minha maquina a configuracao ficou dessa maneira para funfar:
root=joaocclopes71@gmail.com

mailhub=smtp.gmail.com:465

AuthUser=joaocclopes71@gmail.com
AuthPass=<minha_senha_gerada_na_doc_acima>
UseTLS=YES
UseSTARTTLS=NO

FromLineOverride=YES
Em algum local da sua maquina, crie o scritpt spycam.sh
#!/bin/bash

current_date=$(date +\%Y\%m\%d\%H\%M\%s)

fswebcam -d /dev/video0 --jpeg 85 -F 1 /tmp/spypic-${current_date}.jpeg &> /dev/null

echo "/tmp/spypic-${current_date}.jpeg" > /tmp/lastspypic.txt
De permissao de execucao para o script: sudo chmod +x spycam.sh
no terminal execute:
sudo crontab -e
no crontab do usuario root adicione na ultima linha esse crontab:
@reboot sh <full_path_to>/spycam.sh (ex: @reboot sh /home/developer/dev/my_scripts/spycam.sh)
teste:
reeboot seu PC
uma foto deve ter sido tirado logo no inicio da reinializacao e ela deve estar na pasta /tmp/spypic-<yyyy-mm-dd-timestamp>.jpeg
caso nao funcione pode ser pq seu device de camera esta em outra localizacao, vamos debugar:
execute: ls /dev/video*
tente executar o comando mvp /dev/video<number> , deve abrir uma tela mostrando a imagem da sua webcam, caso nao funcione, tente o outro device que foi listado. Um desses devices sera sua camera, ai eh soh alterar no script acima para usar o device correto, no script esta hardcoded como sendo o device 0 (/dev/video0) mas no seu PC pode ser o /dev/video1 por exemplo
Agora, para que o email seja enviado assim que houver uma conexao com a internet estabelecida, adicione esse script na pasta /etc/network/if-up.d com o nome de spycam
crie o arquivo abaixo usando sudo
NAO esquece de adicionar o email para onde voce quer que seja enviada a foto nesse script!! (na ultima linha)
 #!/bin/sh

picture=$(cat /tmp/lastspypic.txt)
flagfile=/var/run/spypic-already-done

case "$IFACE" in
        lo)
                exit 0
                ;;
        *)
                ;;
esac

if [ -e $flagfile ]; then
        exit 0;
else
        touch $flagfile
fi


echo "Seu PC-ubuntu foi bootado as $(date). Segue foto anexa da pessoa tentando bootar." | mail <EMAIL_PARA_ONDE_ENVIAR_A_FOTO> -A $picture --subject=loginattempt > /tmp/spycamlogs.txt 2>&1
de permissao de execucao para o script: sudo chmod +x spycam
teste:
reebot seu PC
uma nova imagem deve ter sido criada na pasta TMP
um email deve ter sido enviado com o assunto: loginattempt e a foto em anexo
