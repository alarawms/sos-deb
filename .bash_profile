# bash profile to be added to the home directory

# source ~/.profile
[ -e "$HOME/.profile" ] && . "$HOME/.profile"

#autostart spectrwm if logging in from TTY1
[[ "$tty" = "/dev/tty1" ]] && pgrep spectrwm || startx

# export ~/.local/bin to the PATH
export PATH="$PATH:$HOME/.local/bin"
