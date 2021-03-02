#!/bin/bash
set -o errexit
cd "${0%/*}"

# install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim -y

# install ripgrep for fzf and far
sudo apt install curl -y
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
rm ripgrep_12.1.1_amd64.deb

# add aliases, fixes, and fzf config
echo >> ~/.bashrc
echo "# custom config" >> ~/.bashrc
echo source ~/dotfiles/bashrc >> ~/.bashrc

# unpack terminal settings
./unpack.sh

# neovim config
mkdir -p ~/.config/nvim/
echo "\" Refer to version controller configuration" >> ~/.config/nvim/init.vim
echo "so ~/dotfiles/init.vim" >> ~/.config/nvim/init.vim
echo -e "\" Dotfile for machine specific configurations\n" >> ~/.config/nvim/machine.vim

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install linter and stuff
sudo apt install python3-pip -y
python3 -m pip install neovim-remote flake8 autopep8  # jedi

# open neovim and install plugins
nvim -c PlugInstall

# install YCM deps
sudo apt install build-essential cmake vim-nox python3-dev \
    mono-complete golang nodejs default-jdk npm g++-8 -y
sudo update-binfmts --disable cli

# build YCM
cd ~/.local/share/nvim/plugged/YouCompleteMe/
CXX=$(which gcc-8) ./install.py --all
