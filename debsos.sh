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

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
#apt install nala -y

# Let's install each package listed in the pkglist.txt file.
sudo apt install -yy  < pkglist.txt || error "Failed to install required packages."

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
cp .bashrc /home/$username
cp .bash_profile /home/$username
cp .xinitrc /home/$username
cp .Xnord /home/$username
cp -R dotconfig/* /home/$username/.config/
cp bg.jpg /home/$username/Pictures/


mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

sudo systemctl enable tlp.service

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir 
nala install fonts-font-awesome
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*


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

cd /homes/$USER/git/debian-sos/i3gnome-flashback
sudo make install 

# install Zerotier 
#
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi



sudo nala install fd-find findutils ripgrep