#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Change Debian to SID Branch
#cp /etc/apt/sources.list /etc/apt/sources.list.bak
#cp sources.list /etc/apt/sources.list

username=$(id -u -n 1000)
builddir=$(pwd)
src_dir=$builddir/.local/src
bin_dir=$builddir/.local/bin

# Update packages list and update system
sudo apt update
sudo apt upgrade -y

# Install nala
#apt install nala -y

# Let's install each package listed in the pkglist.txt file.
sudo xargs apt install -yy  < pkg.list || error "Failed to install required packages."

# Installing Other less important Programs
# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/.local
mkdir -p /home/$username/.local/share
mkdir -p /home/$username/.local/src
mkdir -p /usr/share/sddm/themes
cp -r .local/* /home/$username/.local
cp .Xresources /home/$username
cp .Xresources-hidpi /home/$username
cp .bashrc /home/$username
cp .zshenv /home/$username
cp .bash_profile /home/$username
cp .xinitrc /home/$username
cp .Xnord /home/$username
cp -R dotconfig/* /home/$username/.config/


cp user-dirs.dirs /home/$username/.config
cp user-dirs.locale /home/$username/.config
chown -R $username:$username /home/$username
cp doas.conf /etc/
#update user dirs
xdg-user-dirs-update

sudo systemctl enable tlp.service

# Download Nordic Theme
sudo mkdir -p /usr/share/themes
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir 
sudo apt  install fonts-font-awesome
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*

sudo cp dwm.desktop /usr/share/xsessions/

./fonts.sh
./inconsolata-nerd-font.sh
./ubuntu-nerd-font.sh
./zoom.sh
./fura-mono-nerd-font.sh
# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors


#genome-fallback as system management in addition to i3 as a WM
#cd /homes/$USER/git/debian-sos/i3gnome-flashback
#sudo make install

# install Zerotier 
#
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi


### dmenu tools
###
cd $HOME/.local/share/
git clone https://gitlab.com/dwt1/dmscripts.git
 cd dmscripts
 sudo make clean build
 sudo make install
