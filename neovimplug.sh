#!/bin/bash
#use doas if installed

[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# Install neovim with apt
$ld apt install neovim
[ -x "$(command -v curl)" ] || $ld apt install curl -yy
# Install vim plug from github
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#  If you want to use my neovim config as a starting point or to get some ideas...
#  https://github.com/linuxdabbler/personal-dot-files
#  place init.vim in ~/.config/nvim then open it and run the next two commands
#  :so %
#  :PlugInstall
