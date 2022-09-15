#!/bin/bash

# 使用示例:
# echo "$(whichOS)"
whichOS() {
    os_platform="$(uname)"
    os_arch="$(uname -m)"
    if [ "$os_platform" == "Darwin" ]; then
        # macos 判断
        if [ "$os_arch" == 'arm64' ]; then
            echo "Apple" # Apple Silicon
            return 0
        elif [ "$os_arch" == 'x86_64' ]; then
            echo "Intel" # Intel
            return 0
        fi
    elif [ "$(os_platform)" == "Linux" ]; then
        linux_type="$(uname -a)"
        # Linux 判断
        if [[ $linux_type =~ "CentOS" ]]; then # CentOS
            echo "CentOS"
            return 0
        elif [[ $linux_type =~ "Ubuntu" ]]; then # Ubuntu
            echo "Ubuntu"
            return 0
        fi
    else
        echo "$os_platform"
        return 0
    fi
}

if isInstall exa; then
    echo "exa --version"
else
    if [ $(whichOS) = "Darwin" ]; then
        brew install exa
    fi

    if [ $(whichOS) = "Ubuntu" ]; then
        brew install exa
    fi
fi

rm -rf ~/.zshrc ~/.zsh ~/.zshenv ~/.zprofile ~/.profile ~/.p10k.zsh

ln -s $HOME/.dotfiles/zsh/zprofile ~/.zprofile
ln -s $HOME/.dotfiles/zsh/zshenv ~/.zshenv
ln -s $HOME/.dotfiles/zsh/zshrc ~/.zshrc
ln -s $HOME/.dotfiles/zsh/profile ~/.profile
ln -s $HOME/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/lukechilds/zsh-nvm.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H

