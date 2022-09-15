#!/bin/bash

brew install exa
apt -y install exa

mkdir -p ~/.zsh
ln -s ./zalias ~/zsh/.zalias
ln -s ./profile ~/zsh/.profile
ln -s ./zprofile ~/.zprofile
ln -s ./zshenv ~/.zshenv
ln -s ./zshrc ~/.zshrc
# ln -s ./p10k.zsh ~/.p10k.zsh

