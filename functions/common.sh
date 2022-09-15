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

# 使用示例:
# if isInstall node; then
#     echo '开始安装 xxx'
# fi
isInstall() {
    # 判断是否安装了node
    if ! type "$1" >/dev/null 2>&1; then
        echo "$1 未安装, 准备安装 $1"
        return 0
    else
        echo "$1 已安装"
        return 1
    fi
}
