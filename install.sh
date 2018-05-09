# install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# perform initial unpack
mkdir -p ~/.config/nvim/
./unpack.sh

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# make alias
echo -e "\n\n# Adios vi\nalias nv='nvim'\nexport EDITOR='nvim'\nexport VTE_VERSION='100'" >> ~/.bashrc

# open neovim and install plugins
nvim -c PlugInstall
