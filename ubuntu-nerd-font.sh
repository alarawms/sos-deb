#!/bin/bash
# use doas if installed

[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# install wget and unzip if not installed
[ -x "$(command -v wget)" ] || $ld apt install wget -yy
[ -x "$(command -v unzip)" ] || $ld apt install unzip -yy

nfdir="$HOME/.local/share/fonts/nerdfonts"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip

mkdir -p $nfdir/ubuntu
unzip Ubuntu.zip
mv *.ttf $nfdir/ubuntu/
rm Ubuntu.zip
rm README.md

https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/UbuntuMono.zip
mkdir -p $ndfir/ubuntumono
unzip UbuntuMono.zip
mv *.ttf $nfdir/ubuntumono
rm UbuntuMono.zip
rm README.md

fc-cache -f -v
