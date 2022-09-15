#!/bin/bash

brew install exa
apt -y install exa

rm -rf ~/.zshrc
rm -rf ~/.zsh
rm -rf ~/.zshenv
rm -rf ~/.zprofile
rm -rf ~/.profile
rm -rf ~/.p10k.zsh

mkdir -p ~/.zsh
ln -s ~/.zprofile ./.zprofile
ln -s ~/.zshenv ./.zshenv
ln -s ~/.zshrc ./.zshrc
ln -s ~/.profile ./.profile
ln -s ~/.p10k.zsh ./.p10k.zsh

