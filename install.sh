#!/usr/bin/env bash

# include my library helpers for colorized echo and require_brew, etc
source ./bin/utils.sh

UserLocation=0
read -r -p "Are you a Chinese user? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  UserLocation=1
fi

# @see https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# ###########################################################
# Install non-brew various tools (PRE-BREW Installs)
# ###########################################################
bot "ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? ' XCode Command Line Tools Installed'

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

# ###########################################################
# install homebrew (CLI Packages)
# ###########################################################

running "checking homebrew..."
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  action "installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [[ $? != 0 ]]; then
    error "unable to install homebrew, script $0 abort!"
    exit 2
  fi
else
  ok
  bot "Homebrew"
  read -r -p "run brew update && upgrade? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    action "updating homebrew..."
    brew update
    ok "homebrew updated"
    action "upgrading brew packages..."
    brew upgrade
    ok "brews upgraded"
  else
    ok "skipped brew package upgrades."
  fi
fi

brew doctor

###########################################################
Git Config
###########################################################

# skip those GUI clients, git command-line all the way
action "install the latest version of git"
require_brew git

bot "OK, now I am going to update the .gitconfig for your user info:"

gitfile="$HOME/.gitconfig"
running "link .gitconfig"
if [ ! -f "gitfile" ]; then
  read -r -p "Seems like your gitconfig file exist,do you want delete it? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    rm -rf $HOME/.gitconfig
    action "cp ./git/.gitconfig ~/.gitconfig"
    sudo cp $HOME/.dotfiles/git/.gitconfig  $HOME/.gitconfig
    ln -s $HOME/.dotfiles/git/.gitignore  $HOME/.gitignore
    ok
  else
    ok "skipped"
  fi
fi
grep 'user = GITHUBUSER'  $HOME/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your git username? " githubuser

  fullname=`osascript -e "long user name of (system info)"`

  if [[ -n "$fullname" ]];then
    lastname=$(echo $fullname | awk '{print $2}');
    firstname=$(echo $fullname | awk '{print $1}');
  fi

  if [[ -z $lastname ]]; then
    lastname=`dscl . -read /Users/$(whoami) | grep LastName | sed "s/LastName: //"`
  fi
  if [[ -z $firstname ]]; then
    firstname=`dscl . -read /Users/$(whoami) | grep FirstName | sed "s/FirstName: //"`
  fi
  email=`dscl . -read /Users/$(whoami)  | grep EMailAddress | sed "s/EMailAddress: //"`

  if [[ ! "$firstname" ]]; then
    response='n'
  else
    echo  "I see that your full name is $firstname $lastname"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]]; then
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
  fi
  fullname="$firstname $lastname"

  bot "Great $fullname, "

  if [[ ! $email ]]; then
    response='n'
  else
    echo  "The best I can make out, your email address is $email"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]]; then
    read -r -p "What is your email? " email
    if [[ ! $email ]];then
      error "you must provide an email to configure .gitconfig"
      exit 1
    fi
  fi


  running "replacing items in .gitconfig with your info ($fullname, $email, $githubuser)"

  # test if gnu-sed or MacOS sed

  sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./git/.gitconfig > /dev/null 2>&1 | true
  if [[ ${PIPESTATUS[0]} != 0 ]]; then
    echo
    running "looks like you are using MacOS sed rather than gnu-sed, accommodating"
    sed -i '' "s/GITHUBFULLNAME/$firstname $lastname/"  $HOME/.gitconfig
    sed -i '' 's/GITHUBEMAIL/'$email'/'  $HOME/.gitconfig
    sed -i '' 's/GITHUBUSER/'$githubuser'/'  $HOME/.gitconfig
    ok
  else
    echo
    bot "looks like you are already using gnu-sed. woot!"
    sed -i 's/GITHUBEMAIL/'$email'/'  $HOME/.gitconfig
    sed -i 's/GITHUBUSER/'$githubuser'/'  $HOME/.gitconfig
  fi
fi

# ###########################################################
bot "zsh setup"
# ###########################################################

require_brew zsh

# symslink zsh config
ZSHRC="$HOME/.zshrc"
running "Configuring zsh"
if [ ! -f "ZSHRC" ]; then
  read -r -p "Seems like your zshrc file exist,do you want delete it? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    rm -rf $HOME/.zshrc
    rm -rf $HOME/.zshenv
    action "link zsh/.zshrc and zsh/.zshenv"
    ln -s  $HOME/.dotfiles/zsh/.zshenv $HOME/.zshenv
    ln -s  $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
    ln -s  $HOME/.dotfiles/zsh/.p10k-evilball.zsh $HOME/.p10k-evilball.zsh
  else
    ok "skipped"
  fi
fi

# ###########################################################
bot "Install fonts"
# ###########################################################
read -r -p "Install fonts? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  bot "installing fonts"
  # need fontconfig to install/build fonts
  require_brew fontconfig
  sh ./fonts/install.sh
  brew tap homebrew/cask-fonts
  require_cask font-aurulent-sans-mono-nerd-font
  ok
fi

# ###########################################################
bot " Install Develop Tools"
# ###########################################################
require_brew ripgrep
require_brew bat
require_brew findutils
require_brew make
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
require_brew tmux
require_brew grip
require_brew fd
require_brew tree
require_brew fzf
/usr/local/opt/fzf/install
brew install jesseduffield/lazygit/lazygit
require_brew lsd
require_cask docker

## llvm with cland
require_brew llvm

action "link tmux conf"
ln -s  $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
ok

action "link .rgignore"
ln -s  $HOME/.dotfiles/.rgignore $HOME/.rgignore
ok

action "Install tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ok "when you open tmux,you must type prefix {default: Ctrl+space } + I to install tmux plugins"

require_brew node
require_brew yarn

require_brew lua
require_brew ninja
ok

action "Install yabai and skhd"
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
sudo yabai --install-sa
sudo yabai --load-sa
ln -s "${HOME}/.dotfiles/yabai/yabairc" "${HOME}/.yabairc"
ln -s "${HOME}/.dotfiles/yabai/skhdrc" "${HOME}/.skhdrc"
brew services start skhd
brew services start koekeishiya/formulae/yabai

if [[ $UserLocation =~ 1 ]];then
  running "Config npm use taobao"
  npm config set registry https://registry.npm.taobao.org
fi

require_brew golang
mkdir -p ~/.go
# for chinese user use proxy to get golang package which on google server
export GO111MODULE="on"
export GOPATH="$HOME/.go"
if [[ $UserLocation =~ 1 ]];then
  export GOPROXY=https://goproxy.io
fi
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/segmentio/golines@latest

require_brew rust

bot "Install neovim"
require_brew  luajit --HEAD
require_brew neovim --HEAD
running "Configruation nvim"
git clone https://github.com/glepnir/nvim ~/.config/nvim
ok
running "Install vim plugins"
cd ~/.config/nvim
cd -

bot "Install emacs"
require_brew tap d12frosted/emacs-plus
require_brew install emacs-plus@28 --with-no-titlebar --with-native-comp --with-modern-doom3-icon
running "Link emacs config"
ln -s ~/.dotfiles/config/emacs ~/.config/emacs


# ###########################################################
bot " Install Gui Applications"
# ###########################################################

read -r -p "Do you want install wezterm? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  brew tap wez/wezterm
  require_cask wez/wezterm/wezterm-nightly
else
  ok "skipped"
fi
running "Configuration wezterm settings"
ln -s $HOME/.dotfiles/config/wezterm  $HOME/.config/wezterm
ok

require_cask licecap

read -r -p "Do you want install google-chrome? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  require_cask google-chrome
else
  ok "skipped"
fi

read -r -p "Do you want install vscode? [y|N] " response
if [[ $response =~ (y|yes|Y) ]];then
  require_cask visual-studio-code
else
  ok "skipped"
fi

if [[ $UserLocation =~ 1 ]];then
  read -r -p "Do you want install QQ? [y|N] " qqresponse
  if [[ $qqresponse =~ (y|yes|Y) ]];then
    require_cask qq
  else
    ok "skipped"
  fi
  read -r -p "Do you want install wechat? [y|N] " wxresponse
  if [[ $wxresponse =~ (y|yes|Y) ]];then
    require_cask wechat
  else
    ok "skipped"
  fi
fi

brew update && brew upgrade && brew cleanup

bot "All done"
