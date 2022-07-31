# NeoVim

### 参考文档

- 中文说明

https://zhuanlan.zhihu.com/p/382092667

- 原仓库地址

https://github.com/ayamir/nvimdots

### 安装字体

```bash
brew install font-jetbrains-mono-nerd-font font-hack-nerd-font font-mononoki-nerd-font font-ubuntu-mono-nerd-font
```

### 安装依赖

```bash
brew install lazygit zoxide ripgrep fd yarn lldb
```

### 安装 neovim

```bash
brew install neovim
```

### 安装插件

```bash
git clone --depth=1 https://github.com/ayamir/nvimdots.git ~/.config/nvim
cd ~/.config/nvim/lua/core/
rm -rf pack.lua
wget -O pack.lua https://raw.githubusercontent.com/MoxiuHub/dotfiles_mac/main/neovim/replacement_pack.lua
```

- 多次执行 `nvim +PackerSync` 或 打开 nvim， 输入 `:` ，多次执行 `PackerSync`

- 原因可能是网络存在异常，会导致安装错误


