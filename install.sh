#!/bin/bash
if ! [ -x "$(command -v wget)" ]; then
  sudo apt install wget -y
fi

if ! [ -x "$(command -v fzf)" ]; then
  sudo apt install fzf -y
fi

if ! [ -x "$(command -v git)" ]; then
  sudo apt install git -y
fi

if ! [ -x "$(command -v gawk)" ]; then
  sudo apt install gawk -y
fi

if bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" "" --unattended; then
    echo "Oh My Bash installed !"
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    mkdir -p ~/.oh-my-bash/custom/themes/bigyls
    cp $PWD/bigyls.theme.sh ~/.oh-my-bash/custom/themes/bigyls
    yes | cp -rf $PWD/bashrc ~/.bashrc

    echo -e "\n\n\033[0;31m Pealse logout/login to finish the installation \033[0m"
else
    echo "Oh My Bash already installed !"
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    mkdir -p ~/.oh-my-bash/custom/themes/bigyls
    cp $PWD/bigyls.theme.sh ~/.oh-my-bash/custom/themes/bigyls
    yes | cp -rf $PWD/bashrc ~/.bashrc

    echo -e "\n\n\033[0;31m Pealse logout/login to finish the installation \033[0m"
fi
