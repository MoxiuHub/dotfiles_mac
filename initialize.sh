#!/bin/bash
# >>>>>>>>>>>  该脚本仅适用于 macOS  <<<<<<<<<<<

# shellcheck source=/dev/null
source options.sh
# 前置安装
echo "请点击手动安装 xcode : https://apps.apple.com/cn/app/xcode/id497799835?mt=12"
echo "安装 Command Line Tools"
if isInstall xcode-select; then
    echo "$USER_PASSWD" | sudo -S xcode-select --install
fi

# 安装常用软件
brew install git 
# 安装 HomeBrew
if isInstall brew && isMacOS; then
    if [[ "$(whichMac)" = "M" || "$(whichMac)" = "I" ]]; then
        echo "开始安装 HomeBrew... 选择源类型"
        home_brew_mirrors=(
            "USTC"
            "TUNA"
            "NOT_INSTALL"
        )
        echo "开始安装 HomeBrew... 选择镜像源类型 :"
        select select_home_brew in "${home_brew_mirrors[@]}"; do
            if [ "$select_home_brew" = "USTC" ]; then
                export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
                export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
                export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
                /bin/bash -c "$(curl -fsSL https://github.com/Homebrew/install/raw/HEAD/install.sh)"
                echo "USTC 环境变量设置:"
                test -r ~/.zprofile && echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"' >>~/.zprofile # zsh
                test -r ~/.zprofile && echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"' >>~/.zprofile
                echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"' >>~/.zshrc
            elif [ "$select_home_brew" = "TUNA" ]; then
                export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
                export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
                export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
                cd ~ || exit
                git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
                /bin/bash brew-install/install.sh
                rm -rf ~/brew-install
                echo "TUNA 环境变量设置:"
                test -r ~/.zprofile && echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >>~/.zprofile # zsh
                test -r ~/.zprofile && echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >>~/.zprofile
                echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >>~/.zshrc
                # shellcheck source=/dev/null
                source "$HOME/.zprofile"
                # shellcheck source=/dev/null
                source "$HOME/.zshrc"

                # Apple Silicon CPU: M1/M2
                if [ "$(whichOS)" = "M" ]; then
                    test -r ~/.bash_profile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.bash_profile
                    test -r ~/.zprofile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
                elif [ "$(whichOS)" = "I" ]; then
                    echo ""
                fi
                # 针对 macOS 系统上的 Homebrew：
                export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
                for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
                    brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
                done
                brew update
                break
            elif [ "$select_home_brew" = "NOT_INSTALL" ]; then
                break
            else
                echo "选择错误! 请重试!"
                exit 1
            fi
        done
        brew update
        addEnv "HOMEBREW_NO_INSTALL_CLEANUP=1"
        echo "HomeBrew 安装完成!"
    fi
fi

# 安装 

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

# 挂载磁盘

# mkdir /data && mount /dev/sdb /data
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# sudo blkid /dev/sda2 query UUID
# /dev/dm-0    /        ext4    defaults    0    1
# /dev/sda2    /boot    ext4    defaults    0    1
# /swap.img    none     swap    sw          0    0
# /dev/sdb     /data    ext4    defaults    0    2

# sudo hostnamectl set-hostname eoysky.com
# sudo hostnamectl set-hostname "Jonny's Server" --pretty
# sudo hostnamectl set-hostname eoysky.com --static
# sudo hostnamectl set-hostname eoysky.com --transient
