#!/usr/bin/env bash

function ok() {
    echo  "[ok] "$1
}

function bot() {
    echo  "\n_.]/ - "$1
}

function running() {
    echo " ⇒ 1": "
}

function action() {
    echo "\n]:\n ⇒ $1..."
}

function warn() {
    echo -e "[warning] "$1
}

function error() {
    echo -e "[error] "$1
}

###
# convienience methods for requiring installed software
###

function require_cask() {
    running "brew install $1 --cask"
    brew cask list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $1 $2 --cask"
        brew install $1 --cask
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function require_brew() {
    running "brew $1 $2"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $1 $2"
        brew install $1 $2
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function require_node(){
    running "node -v"
    node -v
    if [[ $? != 0 ]]; then
        action "node not found, installing via homebrew"
        brew install node
    fi
    ok
}

function require_npm() {
    sourceNVM
    nvm use stable
    running "npm $*"
    npm list -g --depth 0 | grep $1@ > /dev/null
    if [[ $? != 0 ]]; then
        action "npm install -g $*"
        npm install -g $@
    fi
    ok
}
