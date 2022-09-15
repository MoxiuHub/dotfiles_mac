#!/bin/bash

brew install exa
apt -y install exa

rm -rf ~/.zshrc
rm -rf ~/.zsh
rm -rf ~/.zshenv
rm -rf ~/.zprofile
#rm -rf ~/.profile

mkdir -p ~/.zsh
ln -s ./zalias ~/zsh/.zalias
ln -s ./zprofile ~/.zprofile
ln -s ./zshenv ~/.zshenv
ln -s ./zshrc ~/.zshrc
#ln -s ./profile ~/zsh/.profile
# ln -s ./p10k.zsh ~/.p10k.zsh

