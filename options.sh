#!/bin/bash
###### 使用示例 ######
# 1.密码：echo $USER_PASSWD | sudo -S Command_executed
# 2.获取系统类型：echo "$(whichOS)"
# 3.判断软件是否安装：
#   if isInstall node; then
#       echo '开始安装 xxx'
#   fi
# 4.添加环境变量
# addEnv "xxxxx"
#####################

echo -n "请输入管理员用户密码:"
read -r USER_PASSWD
# or
# USER_PASSWD="xxxxxx"
# 判断当前系统，返回： M / I / C / U / L ，即：Apple M系列 / Intel系列 / CentOS / Ubuntu / 其他Linux
whichOS() {
    os_platform="$(uname)"
    os_arch="$(uname -m)"
    if [ "$os_platform" == "Darwin" ]; then
        # macos 判断
        if [ "$os_arch" == 'arm64' ]; then
            echo "M" # Apple Silicon
            return 0
        elif [ "$os_arch" == 'x86_64' ]; then
            echo "I" # Intel
            return 0
        fi
    elif [ "$(os_platform)" == "Linux" ]; then
        linux_type="$(uname -a)"
        # Linux 判断
        if [[ $linux_type =~ "CentOS" ]]; then # CentOS
            echo "C"
            return 0
        elif [[ $linux_type =~ "Ubuntu" ]]; then # Ubuntu
            echo "U"
            return 0
        else
            echo "L"
            return 0
        fi
    else
        echo "$os_platform"
        return 0
    fi
}

# 判断macOS类型
whichMac() {
    os_platform="$(uname)"
    os_arch="$(uname -m)"
    if [ "$os_platform" == "Darwin" ]; then
        # macos 判断
        if [ "$os_arch" == 'arm64' ]; then
            echo "M" # Apple Silicon
            return 0
        elif [ "$os_arch" == 'x86_64' ]; then
            echo "I" # Intel
            return 0
        fi
    else
        echo "$os_platform"
        return 0
    fi
}

addEnv() {
    # 判断是否安装了node
    if [[ $(test -r ~/.zshenv) ]]; then
        echo "export $1" >>~/.zshenv
    fi
}
