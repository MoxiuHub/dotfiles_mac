## zsh 安装

### 文件说明

|安装文件|映射文件|
|----|----|
|zalias | .zalias |
|zprofile | .zprofile |
|zshenv | .zshenv |
|zshrc | .zshrc |
|profile | .profile |

### Install

```bash
bash ./install.sh
```

Install plugins

```bash
git clone --depth=1 https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-nvm
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/MoxiuHub/zsh-you-should-use.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
