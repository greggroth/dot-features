#!/usr/bin/env bash


VERSION=${1:-"latest"}
PACKAGE_MANAGER=${2:-"none"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo "Installing NVIM"
wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb

if command -v pip3  &> /dev/null; then
    echo "pip3 found! Installing python neovim package"
    pip3 install neovim
else
    echo "pip3 not found. Skipping neovim python package"
fi

if [ "${PACKAGE_MANAGER}" == "vim-plug" ]; then
    nvim --headless +PlugInstall +qa
    nvim --headless +UpdateRemotePlugins +qa
fi
