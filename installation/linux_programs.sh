# Linux:

echo "Now Installing Packages In Linux"

pkg install openssh
pkg install cmake
pkg install make

pkg install clang
pkg install python
pkg install nodejs

pkg install openjdk
pkg install lua53

pkg install neovim
pkg install fzf
pkg install silversearcher-ag
pkg install ctags

# Clone Packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Completed Installing Packages"
