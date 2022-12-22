#!/bin/bash
# use doas if installed

[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# install unzip if it is not
[ -x "$(command -v unzip)" ] || $ld apt install unzip

# install microsoft fonts
$ld apt install ttf-mscorefonts-installer

#font folders
ubufonts="$HOME/.local/share/fonts/truetype/ubuntu-fonts/"
ysfont="$HOME/.local/share/fonts/truetype/yosemite-san-francisco/"
pwrlnfont="$HOME/.local/share/fonts/powerline/"

# make an ubuntu font folder
mkdir -p $ubufonts

# make a mac-OS yosemite san francisco font folder
mkdir -p $ysfont

# make a powerline font folder
mkdir -p $pwrlnfont

# download ubuntu font family
wget https://assets.ubuntu.com/v1/fad7939b-ubuntu-font-family-0.83.zip

#unzip downloaded file
unzip *.zip

# change directories into unzipped ubuntu font folder
cd ubuntu-font-family*

# move everything ending in ".ttf"  into the ubuntu font folder we created earlier
$ld mv *.ttf $ubufonts

# change directories back to home
cd ..

# remove all files ending in ".zip"
rm *.zip

# remove all folders beginning with "ubuntu-font-family"
rm -r ubuntu-font-family*

# clone yosemite san francisco font from github
git clone https://github.com/supermarin/YosemiteSanFranciscoFont

# change directories into the font folder we just downloaded
cd YosemiteSanFranciscoFont/

# move everything ending in ".ttf" into the yosemite san fransisco folder we created earlier
$ld mv *.ttf $ysfont

# change directory back to home
cd ..

# remove sanfransisco font folder we downloaded from github
$ld rm -r YosemiteSanFranciscoFont/

# clone powerline fonts from github
git clone https://github.com/powerline/fonts

# change directories into the fonts folder created by cloning powerline from github
cd fonts

# Run installation script for powerline fonts
./install.sh

# copy powerline fonts into the powerline folder we created earlier
$ld mv /home/$USER/.local/share/fonts/*Powerline* $pwrlnfont

