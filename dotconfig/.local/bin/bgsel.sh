#!/bin/bash

# script requires sxiv and xwallpaper

#background directory
bgdir="$HOME/.local/share/backgrounds"

#current wallpaper so the lockscreen script will match
cbg="$HOME/.local/share/backgrounds/current-wallpaper.png"

#reads stdout of sxiv mark after quitting (Mark with m and q to quit)
#(currently reads last wallpaper selected no matter how many you select)
choice="$(sxiv -t -o -r $bgdir)"
choicenum="$(echo "$choice" | wc -l )"

# if no choice for wallpaper was made, it exits
[ -z "$choice" ] && exit 0
[ "$choicenum" == 1 ] && lastwp="$(echo "$choice")"
[ "$choicenum" -gt 1 ] && lastwp="$(echo "$choice" | tail -n1)"

[ -x "$(command -v xwallpaper)" ] && set="xwallpaper --zoom"

$set $lastwp && cat $lastwp > $cbg

