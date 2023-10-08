#!/usr/bin/env bash

### Variáveis
set -e

#CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[1;0m'

PROGRAMAS_PARA_REMOVER=(
    firefox
    firefox-locale-ar
    firefox-locale-de
    firefox-locale-en
    firefox-locale-es
    firefox-locale-fr
    firefox-locale-it
    firefox-locale-ja
    firefox-locale-pt
    firefox-locale-ru
    firefox-locale-zh-hans
    firefox-locale-zh-hant
    geary
    libreoffice
    libreoffice-base-core
    libreoffice-common
    libreoffice-core
    libreoffice-help-common
    libreoffice-style-tango
    gnome-screenshot
)

# funcoes
apt_update() {
    sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y
}

system_clean() {
    apt_update -y
    flatpak update -y
    sudo apt autoclean -y
    sudo apt autoremove -y
    nautilus -q 
}

### Testes

# Internet conectando?
testes_internet() {
    if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
        echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede. ${SEM_COR}"
        exit 1
    else
        echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente. ${SEM_COR}"
    fi
}

### Pré-Execução
echo -e "${VERDE}[INFO] - Atualizando sistema. ${SEM_COR}"

apt_update

### Execução

## Remover programas no apt
echo -e "${VERDE}[INFO] - Removendo programas. ${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_REMOVER[@]}; do
    sudo apt remove "$nome_do_programa" -y
done

## Finalizar, atualizar e limpar
echo -e "${VERDE}[INFO] - Finalizando, atualizando e limpando. ${SEM_COR}"
system_clean

echo -e "${VERDE}[INFO] - Script finalizado. ${SEM_COR}"
