# perform initial unpack
mkdir -p ~/AppData/Local/nvim/
./winunpack.sh

# install vim-plug
PowerShell -NoProfile -ExecutionPolicy unrestricted -File 'wininstall.ps1'
