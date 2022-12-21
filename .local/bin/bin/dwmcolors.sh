#!/bin/bash

# This script automates the color changes of dwm, slstatus, and st in a dmenu script.
colorsdir="$HOME/.local/src/dwm/colors"
dwmdir="$HOME/.local/src/dwm"
stdir="$HOME/.local/src/st"
statusdir="$HOME/.local/src/slstatus"
dmenudir="$HOME/.local/src/dmenu/"
bgdir="$HOME/.local/share/backgrounds"
vifmdir="$HOME/.config/vifm"
dwmpid="$(ps -aux | awk '/dwm$/ {print $2}')"

# Exit if there's no colors directory
[ -z "$colorsdir" ] && echo "no colors directory found in $dwmdir" && exit 0

# Dmenu command
choice="$(/bin/ls $colorsdir | dmenu -l 5 -p "choose theme: ")"

# Exit if no choice is given
[ -z "$choice" ] && exit 0

# Original vifm colorscheme
originalvifm="$(awk '/colorscheme/ {print $NF}' $vifmdir/vifmrc)"

# Get rid of the .h at the end of the file name to work with vifm
vifmchoice="$(echo $choice | sed 's/.h//')"

# Change vifm colorscheme to new choice
if [ -e "$vifmdir"/colors/"$vifmchoice".vifm ]; then
    sed -i "s|$originalvifm|$vifmchoice|" $vifmdir/vifmrc
else
    echo "unable to change vifm colorscheme to $vifmchoice"
fi

# Original slstatus colors
originalstatus="$(awk '/# include "colors/ {print $3}' $statusdir/config.def.h | sed -e 's/"//g' -e 's|colors/||')"

# Replace original .h file sourced in config.def.h with the selected one and rebuild
if [ -e "$statusdir"/colors/"$choice" ]; then
    sed -i "s|$originalstatus|$choice|" $statusdir/config.def.h
    rm $statusdir/config.h &&\
    make --directory $statusdir
    pkill slstatus
else
    echo "unable to change slstatus theme to $choice"
fi

# Original st colors
originalst="$(awk '/# include "colors/ {print $3}' $stdir/config.def.h | sed -e 's/"//g' -e 's|colors/||')"

# Replace original .h file sourced in config.def.h with the selected one and rebuild
if [ -e "$stdir"/colors/"$choice" ]; then
    sed -i "s|$originalst|$choice|" $stdir/config.def.h
    rm $stdir/config.h &&\
    make --directory $stdir
else
    echo "unable to change st theme to $choice"
fi

# Original dmenu colors
originaldmenu="$(awk '/# include "colors/ {print $3}' $dmenudir/config.def.h | sed -e 's/"//g' -e 's|colors/||')"

# Replace original .h file sourced in config.def.h with the selected one and rebuild
if [ -e "$dmenudir"/colors/"$choice" ]; then
    sed -i "s|$originaldmenu|$choice|" $dmenudir/config.def.h
    rm $dmenudir/config.h &&\
    make --directory $dmenudir
else
    echo "unable to change dmenu theme to $choice"
fi

# Set an appropriate wallpaper for your new theme
selection="$choice"
   case "$selection" in
    "gruvbox.h") bg="$bgdir/gruvbox.png" ;;
    "catppuccin.h") bg="$bgdir/catppuccin.png" ;;
    "onedark.h") bg="$bgdir/onedark.png" ;;
    "dracula.h") bg="$bgdir/dracula.png" ;;
    "nord.h") bg="$bgdir/nord.png" ;;
    "*") bg="$bgdir/jrajala_steam_fog.png" ;;
   esac

    xwallpaper --zoom $bg

# Replace original .h file sourced in config.def.h with the selected one and rebuild
originaldwm="$(awk '/# include "colors/ {print $3}' $dwmdir/config.def.h | sed -e 's/"//g' -e 's|colors/||')"

if [ -e "$dwmdir"/colors/"$choice" ]; then
    sed -i "s|$originaldwm|$choice|" $dwmdir/config.def.h
    rm $dwmdir/config.h &&\
    make --directory $dwmdir
    kill -SIGHUP $dwmpid
    slstatus &
else
    echo "unable to change dwm theme  to $choice"
    exit 1
fi






