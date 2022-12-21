[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" || . $HOME/.xprofile

#logout
#exec i3
#spectrwm
#slstatus & dwm
while :; do
   pkill dwmbloks; dwmbloks & dwm
done
