#!/bin/bash
# active window manager
wm="$(grep -v "\#" $HOME/.xinitrc | tail -n1 | awk '{print $NF}')"

# declare colors
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# dwm directory
dwmdir="$HOME/.local/src/dwm"

# dwm process id
dwmpid="$(ps -aux | awk '/dwm$/ {print $2}')"

currentgapvalue="$(awk '/gappx/ {print $7}' $dwmdir/config.def.h | sed 's/;//')"
nogapvalue="0"

currentgap="$(awk '/gappx/ {print $5" "$6" "$7 $8}' $dwmdir/config.def.h)"
nogap="gappx = 0;"
gap="gappx = 12;"

if [ $wm = 'dwm' ] && [ "$currentgapvalue" -gt "$nogapvalue" ]; then
    printf "${yellow} removing gaps and rebuilding $wm ${nc}\n"
    sed -i "s|$currentgap|$nogap|" $dwmdir/config.def.h
    rm $dwmdir/config.h
    make --directory $dwmdir >> /tmp/toggle-gaps.log
    kill -SIGHUP $dwmpid
else
    printf "${yellow} returning gaps to normal and rebuilding $wm ${nc}\n"
    sed -i "s|$currentgap|$gap|" $dwmdir/config.def.h
    rm $dwmdir/config.h
    make --directory $dwmdir >> /tmp/toggle-gaps.log
    kill -SIGHUP $dwmpid
fi



