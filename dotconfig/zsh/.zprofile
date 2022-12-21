# Profile file that runs on login.
# Set environmental variables here or in zshenv file


# Automatically start X session when logging in on tty1
[[ "$(tty)" = "/dev/tty1" ]] && pgrep spectrwm || startx
