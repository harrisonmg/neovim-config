#!/bin/bash
set -o errexit
cd "${0%/*}"

# install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

# install fd for fzf
wget --no-check-certificate https://github.com/sharkdp/fd/releases/download/v7.0.0/fd_7.0.0_amd64.deb
sudo dpkg -i fd_7.0.0_amd64.deb
rm fd_7.0.0_amd64.deb

# perform initial unpack
mkdir -p ~/.config/nvim/
./unpack.sh
echo -e "\" Dotfile for machine specific configurations\n" >> ~/.config/nvim/machine.vim

# install vim-plug
sudo apt-get install curl
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# add aliases, fixes, and fzf config
echo >> ~/.bashrc
echo >> ~/.bashrc
cat bashrc >> ~/.bashrc

# open neovim and install plugins
nvim -c PlugInstall
