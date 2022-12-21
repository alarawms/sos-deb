#!/bin/bash
# Directory Variables
spectrcolors="$HOME/.config/spectrwm/colors"
spectrconf="$HOME/.config/spectrwm/spectrwm.conf"
spectrpid="$(ps -aux | awk '/spectrwm$/ {print $2}')"

stdir="$HOME/.local/src/suckless/st"
vifmdir="$HOME/.config/vifm/"
bgdir="$HOME/.local/share/backgrounds"

# Dmenu command
choice="$(/bin/ls $spectrcolors/ | cut -d'.' -f 1 | dmenu -l 5 -p "choose theme: ")"

# Exit if not choice
[ -z $choice ] && exit 0

# Original st color scheme
originalst="$(awk '/# include "colors/ {print $3}' $stdir/config.def.h | sed -e 's/"//g' -e 's|colors/||' -e 's/.h//')"

# Original vifm color scheme
originalvifm="$(awk '/colorscheme/ {print $2}' $vifmdir/vifmrc)"

# Separating colors from bar_color and bar_font_color lines
ogdarkgray="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 1)"
choicedarkgray="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 1)"

ogmidgray="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 2)"
choicemidgray="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 2)"

ogred="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 3)"
choicered="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 3)"

ogbrightred="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 4)"
choicebrightred="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 4)"

oggreen="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 5)"
choicegreen="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 5)"

oglightgreen="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 6)"
choicelightgreen="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 6)"

ogblue="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 7)"
choiceblue="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 7)"

oglightblue="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 8)"
choicelightblue="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 8)"

ogyellow="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 9)"
choiceyellow="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 9)"

ogbrightyellow="$(awk '/bar_color\[/ {print $3}' $spectrconf | cut -d',' -f 10)"
choicebrightyellow="$(awk '/bar_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 10)"

ogwhite1="$(awk '/bar_font_color\[/ {print $3}' $spectrconf | cut -d',' -f 1)"
choicewhite1="$(awk '/bar_font_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 1)"

ogwhite2="$(awk '/bar_font_color\[/ {print $3}' $spectrconf | cut -d',' -f 2)"
choicewhite2="$(awk '/bar_font_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 2)"

ogmagenta="$(awk '/bar_font_color\[/ {print $3}' $spectrconf | cut -d',' -f 7)"
choicemagenta="$(awk '/bar_font_color\[/ {print $3}' $spectrcolors/$choice.conf | cut -d',' -f 7)"

# Replace $og* with $choice*
sed -i "s|$ogdarkgray|$choicedarkgray|" $spectrconf && \
sed -i "s|$ogmidgray|$choicemidgray|" $spectrconf && \
sed -i "s|$ogred|$choicered|" $spectrconf && \
sed -i "s|$ogbrightred|$choicebrightred|" $spectrconf && \
sed -i "s|$oggreen|$choicegreen|" $spectrconf && \
sed -i "s|$oglightgreen|$choicelightgreen|" $spectrconf && \
sed -i "s|$ogblue|$choiceblue|" $spectrconf && \
sed -i "s|$oglightblue|$choicelightblue|" $spectrconf && \
sed -i "s|$ogyellow|$choiceyellow|" $spectrconf && \
sed -i "s|$ogbrightyellow|$choicebrightyellow|" $spectrconf && \
sed -i "s|$ogwhite1|$choicewhite1|" $spectrconf && \
sed -i "s|$ogwhite2|$choicewhite2|" $spectrconf && \
sed -i "s|$ogmagenta|$choicemagenta|" $spectrconf && \


# Rebuild st with new colorscheme
if [ -e "$stdir"/colors/"$choice".h ]; then
    sed -i "s|$originalst|$choice|" $stdir/config.def.h
    rm $stdir/config.h
    make --directory $stdir
else
    echo"unable to change st theme to $choice"
fi


# Change vifm colorscheme to new choice
if [ -e "$vifmdir"/colors/"$choice".vifm ]; then
    sed -i "s|$originalvifm|$choice|" $vifmdir/vifmrc
else
    echo "unable to change vifm colorscheme to $choice"
fi

# Set wallpaper based of choice
selection="$choice"
   case "$selection" in
       "gruvbox") bg="$(ls $bgdir/gruvbox/*.png | shuf -n1)" ;;
    "catppuccin") bg="$(ls $bgdir/catppuccin/*.png | shuf -n1)" ;;
    "onedark") bg="$(ls $bgdir/onedark/*.png | shuf -n1)" ;;
    "dracula") bg="$(ls $bgdir/dracula/*.png | shuf -n1)" ;;
    "nord") bg="$(ls $bgdir/nord/*.png | shuf -n1)" ;;
    "*") bg="ls -R $bgdir | shuf -n1" ;;
   esac

    xwallpaper --zoom $bg



kill -HUP $spectrpid
