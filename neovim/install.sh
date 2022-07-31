#/bin/bash
brew install lazygit zoxide ripgrep fd yarn lldb
brew install font-jetbrains-mono-nerd-font font-hack-nerd-font font-mononoki-nerd-font font-ubuntu-mono-nerd-font
brew install neovim

cd ~
git clone --depth=1 https://github.com/ayamir/nvimdots.git ~/.config/nvim
cd ~/.config/nvim/lua/core/
rm -rf pack.lua
wget -O pack.lua https://raw.githubusercontent.com/MoxiuHub/dotfiles_mac/main/neovim/replacement_pack.lua




