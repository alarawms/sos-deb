#!/bin/bash
# use doas if installed

[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# install wget and unzip if not installed
[ -x "$(command -v wget)" ] || $ld apt install wget -yy
[ -x "$(command -v unzip)" ] || $ld apt install unzip -yy

nfdir="$HOME/.local/share/fonts/nerdfonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraMono.zip

mkdir -p $nfdir/FuraMono
unzip FiraMono.zip
mv *Fura* $nfdir/FuraMono/
rm FiraMono.zip

fc-cache -f -v
