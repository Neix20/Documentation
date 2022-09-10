# Windows:

echo "Now Installing Packages In Windows: "

scoop install lsd
scoop install grep
scoop install gcc

scoop install openssh
scoop install cmake
scoop install make

scoop install clang
scoop install python
scoop install nodejs

scoop install openjdk
scoop install lua
scoop install dotnet-sdk

scoop install neovim
scoop install fzf
scoop install silversearcher-ag
scoop install universal-ctags

# Clone Packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim C:/Users/txen2/AppData/Local/nvim-data/site/pack/packer/start/packer.nvim

echo "Completed Installing Packages"
