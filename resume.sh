#! /usr/bin/env bash

# resume.sh - Display my custom resumes about commands.
#
# Site: https://www.github.com/costalopes71
# Author: costalopes71
# Maintainer: costalopes71
#
# -----------------------------------------------------#
#
# This program is intended to facilitate the resumes of my most used commands.
# Usage example:
#   $ resume vi
#   $ resume top
#
# In the above examples, a resume of vi commands will be printed and a resume of top commands will be printed.
#
# -----------------------------------------------------#
# Changelog
#
#  v0.1 03/06/2021 - costalopes
#     - Add documentation
#
# -----------------------------------------------------#
# Tested with:
#   
#   - bash 5.0.17
# -----------------------------------------------------#

########################################################
# VARIABLES
########################################################

RED="\033[031;1m"
BLUE="\033[34;1m"
GREEN="\033[32;1m"
YELLOW="\033[33;1m"

HELP="This program is intended to facilitate the resumes of my most used commands.

Commands: vi, top
Subcommands: vi delete, vi alter, vi cut, vi copy, vi paste, vi navegate, vi insert

Usage example:
  $ resume vi
	$ resume top
	$ resume vi delete
"

CMD_VI_NAVEGATION="Navegacao:
j --> move o cursor uma linha para baixo
k --> move o cursor uma linha para cima
h --> move o cursor um caracter para tras
l --> move o cursor um caracter para frente
$ --> move o cursor para o final da linha
0 --> move o cursor para o comeco da linha
nG ou :n --> move o cursor para a linha n
G ou :$ --> move o cursor para a ultima linha do arquivo
g ou :0 --> move o cursor para a primeira linha do arquivo
w ou W --> move o cursor para a proxima palavra
b ou B --> move o cursor para a palavra anterior
e ou E --> move o cursor para o fim da palavra
M --> move o cursor para a linha do meio da tela
L --> move o cursor para a ultima linha da tela
H --> move o cursor para a primeira linha da tela"

CMD_VI_INSERT_TEXT="Insercao/Digitacao:
i --> insere texto antes do cursor
I --> insere texto no comeco da linha 
a --> insere texto depois do cursor
A --> insere texto no final da linha
o --> insere uma nova linha abaixo e adiciona texto
O --> insere uma nova linha acima e adiciona texto"

CMD_VI_ALTER="Alteracao:
r --> altera um unico caracter onde esta o cursor
R --> altera caracteres comecando de onde esta o cursor ate terminar teclando esc
cw --> faz o replace da palavra onde o cursor esta por um novo texto
cNw --> faz o replace das palavras onde o cursor esta, sendo n o numero de palavras a fazer o replace
C --> faz o replace da linha toda pelo texto que irei escrever
cc --> nao entendi a diferenca do de cima
ncc --> faz o replace de N linhas comecando pela linha atual"

CMD_VI_CUT="Recortar:
x   --> recorta/deleta um caracter 
Nx  --> recorta/deleta N caracteres
dw  --> recorta/deleta a palavra toda
dNw --> recorta/deleta N palavras
D   --> recorta/deleta o restante da linha a comecar do cursor
dd  --> recorta/deleta a linha toda
Ndd --> recorta/deleta N linhas"

CMD_VI_COPY_PASTE="Copiar/Colar:
yy --> copia a linha
Nyy --> copia N linhas
p --> cola"

CMD_VI_MAGIC="Bruxaria:
~ + barra_espaco --> altera o case de um caracter
~ + enter --> altera o case da linha toda
J --> junta as linhas (a do cursor com a debaixo)
>> --> shifta a linha para a direita
<< --> shifta a linha para a esquerda
"

CMD_VI_ALL="$CMD_VI_NAVEGATION\n\n$CMD_VI_INSERT_TEXT\n\n$CMD_VI_ALTER\n\n$CMD_VI_CUT\n\n$CMD_VI_COPY_PASTE"

CMD_TOP_ALL="m --> exibe o valor de memoria usada usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha de memoria)
t --> exibe o valor de cpu em uso usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha da cpu)
P --> ordena por CPU
M --> ordena por memoria
T --> ordena por Tempo
N --> ordena por PID
c --> mostra o comando todo executado
n --> quantidade de linhas a serem exibidas
k --> matar um PID
u --> permite escolher os processos de um determinado usuario
1 --> mostra os valores de cada CPU
"

########################################################
# FUNCTIONS
########################################################

printViCommands() {
	case "$1" in
		navegate) echo "$CMD_VI_NAVEGATION" && exit 0   ;;
		insert) echo "$CMD_VI_INSERT_TEXT" && exit 0    ;;
		alter) echo "$CMD_VI_ALTER" && exit 0           ;;
		delete) echo "$CMD_VI_CUT" && exit 0            ;;
		cut) echo "$CMD_VI_CUT" && exit 0               ;;
		copy) echo "$CMD_VI_COPY_PASTE" && exit 0       ;;
		paste) echo "$CMD_VI_COPY_PASTE" && exit 0      ;;
		*) echo -e "$CMD_VI_ALL" && exit 0              ;;
	esac
}

printTopCommands() {
	echo "$CMD_TOP_ALL"
}

########################################################
# EXECUTION
########################################################

case "$1" in
	vi) printViCommands $2 && exit 0       ;;
	top) printTopCommands && exit 0        ;;
	*) echo "$HELP" && exit 0              ;;
esac

