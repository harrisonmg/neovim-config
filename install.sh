# install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# install fd for fzf
wget https://github.com/sharkdp/fd/releases/download/v7.0.0/fd_7.0.0_amd64.deb
sudo dpkg -i fd_7.0.0_amd64.deb
rm fd_7.0.0_amd64.deb

# perform initial unpack
mkdir -p ~/.config/nvim/
./unpack.sh

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# add aliases, fixes, and fzf config
echo >> ~/.bashrc
echo -e "# Adios vi" >> ~/.bashrc
echo -e "alias nv='nvim'" >> ~/.bashrc
echo -e "export EDITOR='nvim'" >> ~/.bashrc
echo -e "export VTE_VERSION='100'" >> ~/.bashrc
echo -e "export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'" >> ~/.bashrc
echo -e "export FZF_CTRL_T_COMMAND=\"$FZF_DEFAULT_COMMAND\"" >> ~/.bashrc

# open neovim and install plugins
nvim -c PlugInstall
