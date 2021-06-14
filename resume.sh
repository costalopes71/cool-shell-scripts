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
#		$ resume tmux
#
# In the above examples, a resume of vi commands will be printed and a resume of top commands will be printed.
#
# -----------------------------------------------------#
# Changelog
#
#  v0.1 03/06/2021 - costalopes
#     - Add documentation
#     - Add vi, top and tmux commands
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

HELP="Usage: resume [command] [index] 

This program is intended to facilitate the resumes of my most used commands.

Supported commands: vi, top, tmux, linux

Usage example:
  $ resume vi
  $ resume vi 0 # index 0 always show an index with the content of that command
  $ resume top
  $ resume tmux
  $ resume tmux 3
  $ resume linux 0
"

CMD_VI_0="0. Index
1. Navegation
2. Insert text
3. Alter text
4. Cut text
5. Copy/Paste
6. Undo/Redo
7. Magic
"

CMD_VI_1="1. Navegacao:

j
    move o cursor uma linha para baixo

k
    move o cursor uma linha para cima

h
    move o cursor um caracter para tras

l
    move o cursor um caracter para frente

$
    move o cursor para o final da linha

0
    move o cursor para o comeco da linha

nG ou :n
    move o cursor para a linha n

G ou :$
    move o cursor para a ultima linha do arquivo

g ou :0
    move o cursor para a primeira linha do arquivo

w ou W
    move o cursor para a proxima palavra

b ou B
    move o cursor para a palavra anterior

e ou E
    move o cursor para o fim da palavra

M
    move o cursor para a linha do meio da tela

L
    move o cursor para a ultima linha da tela

H
    move o cursor para a primeira linha da tela"


CMD_VI_2="2. Insercao/Digitacao:

i
    insere texto antes do cursor

I
    insere texto no comeco da linha 

a
    insere texto depois do cursor

A
    insere texto no final da linha

o
    insere uma nova linha abaixo e adiciona texto

O
    insere uma nova linha acima e adiciona texto"


CMD_VI_3="3. Alteracao:

r 
    altera um unico caracter onde esta o cursor

R 
    altera caracteres comecando de onde esta o cursor ate terminar teclando esc

cw 
    faz o replace da palavra onde o cursor esta por um novo texto

cNw 
    faz o replace das palavras onde o cursor esta, sendo n o numero de palavras a fazer o replace

C 
    faz o replace da linha toda pelo texto que irei escrever

cc 
    nao entendi a diferenca do de cima

ncc 
    faz o replace de N linhas comecando pela linha atual"


CMD_VI_4="4. Recortar:

x
    recorta/deleta um caracter 

Nx
    recorta/deleta N caracteres

dw
    recorta/deleta a palavra toda

dNw
    recorta/deleta N palavras

D
    recorta/deleta o restante da linha a comecar do cursor

dd
    recorta/deleta a linha toda

Ndd
    recorta/deleta N linhas"


CMD_VI_5="5. Copiar/Colar:

yy
    copia a linha

Nyy
    copia N linhas

p
    cola"

CMD_VI_6="6. Undo/Redo:

u
    undo change

:u [or] :undo
    undo changes

ctrl + r
    redo

:redo
    redo"

CMD_VI_7="7. Bruxaria:

~ + barra_espaco
    altera o case de um caracter

~ + enter
    altera o case da linha toda

J
    junta as linhas (a do cursor com a debaixo)

>>
    shifta a linha para a direita

<<
    shifta a linha para a esquerda"

CMD_VI_ALL="$CMD_VI_0\n\n$CMD_VI_1\n\n$CMD_VI_2\n\n$CMD_VI_3\n\n$CMD_VI_4\n\n$CMD_VI_5\n\n$CMD_VI_6\n\n$CMD_VI_7"

CMD_TOP_ALL="Top

m
	exibe o valor de memoria usada usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha de memoria)

t
    exibe o valor de cpu em uso usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha da cpu)

P
    ordena por CPU

M
    ordena por memoria

T
    ordena por Tempo

N
    ordena por PID

c
    mostra o comando todo executado

n
    quantidade de linhas a serem exibidas

k
    matar um PID

u
    permite escolher os processos de um determinado usuario

1
    mostra os valores de cada CPU"

CMD_TMUX_0="0. Index
1. Sessions
2. Windows
3. Panels
4. Copy Mode
5. Misc
6. Help
7. Custom"

CMD_TMUX_1="1. Sessions:

tmux [or] tmux new [or] tmux new-session [or] :new
    start new

tmux new -s mysession [or] :new -s mysession
    start named

tmux kill-ses -t mysession [or] tmux kill-session -t mysession
    kill named

tmux kill-session -a
    kill all but current

tmux kill-session -a -t mysession
    kill all but named

ctrl+b $
    rename

ctrl+b d
    dettach

:attach -d
    attach

tmux ls [or] tmux list-sessions [or] ctrl+b s
    show all

tmux a [or] tmux at [or] tmux attach
    attach to last

tmux a -t mysession [or] tmux at -t mysession [or] tmux attach -t mysession
    attach to named

ctrl+b (
    move to previous

ctrl+b )
    move to next"

CMD_TMUX_2="2. Windows

ctrl+b c
    create

ctrl+b ,
    rename current

ctrl+b &
    close current

ctrl+b p
    previous

ctrl+b n
    next

ctrl+b 0..9
    select by number

:snap-window -s 2 -t 1
    reorder window swaping (src/dest)

:snap-window -t -1
    move current to left by n position

alt left/right
    move between windows"

CMD_TMUX_3="3. Panes

ctrl+b ;
    last active
    
ctrl+b %
	split vertically
    
ctrl+b \"
	split horizontally
    
ctrl+b {
	move left
    
ctrl+b }
	move right
    
ctrl+b up/down/left/right
	switch to pane
    
:setw synchronize-panes
	synchronize all
    
ctrl+b Spacebar
	toogle between layouts

ctrl+b o
    next

ctrl+b z
	zoom
    
ctrl+b !
	convert to window

hold ctrl+b up/down/left/right
	resize

 ctrl+b x
	close"

CMD_TMUX_4="4. Copy Mode

ctrl+b [
    enter copy mode

q
    quit mode

/
    search forward

?
    search backward

n
    next occurance

N
    previous occurance

spacebar
    start selection

esc
    clear selection

enter
    copy selection

ctrl+b ]
    paste contents of buffer_0

:show-buffer
    diplay buffer content

:capture-pane
    copy entire visible contents of pane to a buffer

:list-buffers
    list buffers

:save-buffer buf.txt
    save buffer to file"

CMD_TMUX_5="5. Misc

ctrl+b :
    enter command mode

:set -g OPTION
    set OPTION for all sessions

:setw -g OPTION
    set OPTION for all windows"

CMD_TMUX_6="6. Help

tmux info
    show every session, window, pane, etc

ctrl+b ?
    show shortcuts"

CMD_TMUX_7="7. Custom:

ctrl+g
    prefix tmux key instead of ctrl+b

ctrl+b q
    kill all sessions"

CMD_TMUX_ALL="$CMD_TMUX_0\n\n$CMD_TMUX_1\n\n$CMD_TMUX_2\n\n$CMD_TMUX_3\n\n$CMD_TMUX_4\n\n$CMD_TMUX_5\n\n$CMD_TMUX_6\n\n$CMD_TMUX_7"

CMD_LINUX_0="0. Index
1. File Permissions
2. Groups
3. Journal"

CMD_LINUX_1="1. File Permissions

chmod u+rw,g-rw,u-rwx example.txt
    add read and write permission for the onwer (user), drop read and write permission for groups and drop read write and execute permission for other

0 or ---
    no permissions

1 or --x
    execute

2 or -w-
    write

3 or -wx
    write and execute

4 or r--
    read

5 or r-x
    read and execute

6 or rw-
    read and write

7 or rwx
    read, write and execute

chown <user> <file>
    changes the owner of a file"

CMD_LINUX_2="2. Groups

cat /etc/passwd
    display primary user group

cat /etc/group
    display secondary user groups

groups
    display secondary user groups

groups <user>
    display all groups a user belongs (the first group is the primary group)

id <user>
    display user id (uid), the user's primary group (gid) and the user's secondary groups (groups)

id
    same as abose but for the current user

getent group <user>
    list all members of a group

sudo usermod -a -G groupname username
    adds an existing user to a group

sudo usermod -a -G group1,group2 username
    adds existing user to group1 and group2

sudo gpasswd -d username groupname
    remove a user from a group

sudo groupadd groupname
    create a new group

sudo groupdel groupname
    delete an existing group

sudo usermod -g groupname username
    change a user primary group

sudo useradd -g primarygroup -G group1,group2 joao
    create a new user named Joao with primary group and secodanry groups"

CMD_LINUX_3="3. Journal

journalctl          
    display all logs from initializations, services, initdr etc

journalctl -b
    display all logs from the last initialization

journalctl --utc
    display all logs with utc time

journalctl --list-boots
    display all initializations persisted

journalctl -b -33
    display logs from initialization 33

journalctl -b <hash>
    same as above

journalctl --since \"YYYY-MM-DD HH:MM:SS\" --until \"YYYY-MM-DD HH:MM:SS\"
    display logs between since and until

journalctl --since yesterday
    display logs since yesterday

journalctl --since 09:00 --until \"1 hour ago\"
    display logs from 9am until 1 hour ago

journalctl -u <service>
    display logs from that service (ex: journalctl -u ngnix.service

journalctl -u <service> --since today
    display logs from service from today

journalctl _PID=<pid>
    display logs from that pid

journalctl _UID=<uid>
    display logs only from that user

journalctl _GID=<gid>
    display logs only from that group

man systemd.journal-fields
    display all fields that we can use to filter

journalctl -F _UID
    display all uids that journal contains on its log

journalctl -F <field>
    same as above but for other field

journalctl --disk-usage
    display how much disk space its been used

journalctl --vacuum-size=500M
    delete logs until it reachs 500M

journalctl --vacuum-time=1years
    clean all logs but from 1 year

journalctl <executable_path>
    display logs from the executable. Example: journalctl /usr/bin/bash

journalctl -k
    display kernel messages from current initialization

journalctl -k -b -5
    display kernel messages from initialization 5

journalctl -p <log_level>
    display log messages only from that level and up
    log levels:
        0: emerg
        1: alert
        2: crit
        3: err
        4: warning
        5: notice
        6: info
        7: debug

journalctl --no-pager
    do not page the result

journalctl -o json
    display logs on json format

journalctl -o json-pretty
    display logs on json pretty format
    formats:
        cat: exibe apenas o campo de mensagem em si.
        export: um formato binário adequado para transferir e fazer um backup.
        json: JSON padrão com uma entrada por linha.
        json-pretty: JSON formatado para uma melhor legibilidade humana
        json-sse: saída formatada em JSON agrupada para tornar um evento enviado ao servidor compatível
        short: o estilo de saída padrão do syslog
        short-iso: o formato padrão aumentado para mostrar as carimbos de data/hora da ISO 8601.
        short-monotonic: o formato padrão com carimbos de data/hora monotônicos.
        short-precise: o formato padrão com precisão de microssegundos
        verbose: exibe todas os campos de diário disponíveis para a entrada, incluindo aqueles que geralmente estão escondidos internamente.

journalctl -n
    display last 10 logs

journalctl -n <number_of_lines>
    display N number of lines

journalctl -f
    keep monitoring the logs on real time"
	
CMD_LINUX_ALL="$CMD_LINUX_0\n\n$CMD_LINUX_1\n\n$CMD_LINUX_2\n\n$CMD_LINUX_3"

########################################################
# FUNCTIONS
########################################################

printViCommands() {
	case "$1" in
		0) echo "$CMD_VI_0" && exit 0         ;;
		1) echo "$CMD_VI_1" && exit 0         ;;
		2) echo "$CMD_VI_2" && exit 0         ;;
		3) echo "$CMD_VI_3" && exit 0         ;;
		4) echo "$CMD_VI_4" && exit 0         ;;
		5) echo "$CMD_VI_5" && exit 0         ;;
		6) echo "$CMD_VI_6" && exit 0         ;;
		7) echo "$CMD_VI_7" && exit 0         ;;
		*) echo -e "$CMD_VI_ALL" && exit 0    ;;
	esac
}

printTopCommands() {
	echo "$CMD_TOP_ALL"
}

printTmuxCommands()	{
	case "$1" in
		0) echo "$CMD_TMUX_0" && exit 0      ;;
		1) echo "$CMD_TMUX_1" && exit 0      ;;
		2) echo "$CMD_TMUX_2" && exit 0      ;;
		3) echo "$CMD_TMUX_3" && exit 0      ;;
		4) echo "$CMD_TMUX_4" && exit 0      ;;
		5) echo "$CMD_TMUX_5" && exit 0      ;;
		6) echo "$CMD_TMUX_6" && exit 0      ;;
		7) echo "$CMD_TMUX_7" && exit 0      ;;
		*) echo -e "$CMD_TMUX_ALL" && exit 0 ;;
	esac

}

printLinuxCommands() {
	case "$1" in
		0) echo "$CMD_LINUX_0" && exit 0       ;;
		1) echo "$CMD_LINUX_1" && exit 0       ;;
		2) echo "$CMD_LINUX_2" && exit 0       ;;
		3) echo "$CMD_LINUX_3" && exit 0       ;;
		*) echo -e "$CMD_LINUX_ALL" && exit 0  ;;
	esac
}

########################################################
# EXECUTION
########################################################

case "$1" in
	vi) printViCommands $2 && exit 0       ;;
	top) printTopCommands && exit 0        ;;
	tmux) printTmuxCommands $2 && exit 0   ;;
	linux) printLinuxCommands $2 && exit 0 ;;
	*) echo "$HELP" && exit 0              ;;
esac

