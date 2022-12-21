# Dotfiles

### These are my personal dotfiles for my various linux installs

---

#### Files with a dot "." before are supposed to be hidden files in the home directory

---

* **.bashrc** - my customized bashrc for Debian
* **.xinitrc** - sources ~/.config/x11/xprofile if it exists, if not, source ~/.xprofile then start window manager
* **.zshenv** - export ~/.local/bin to PATH, set default programs and XDG paths, set zsh config location.
* **config** - files that are supposed to go in my ~/.config directory
    * aliasrc - I use this with both bash and zsh
    * fish - fish shell config
    * kitty - kitty terminal config
    * nvim - neovim config
    * qtile - qtile config
    * spectrwm - spectrwm config
    * vifm - vifm config (my terminal file manager of choice)
    * vimrc - vim config (I mainly use neovim these days)
    * x11 - .Xresources and xprofile are stored here
    * zsh - zshell config <p>&nbsp;</p>
* **rootscripts** - several scripts that need to be in root's PATH
    * bootsnapshot - dmenuscript for booting into root or home snapshots (takes arguments)
    * snapctl - create, list, and delete snapshots of root or home subvolumes (saves in @snapshots subvolume) (keeps assigned number of snapshots. default is 10)
    * vmctl - dmenu script that starts, stops, clones and deltes virtual machines
* **.local/bin** - several scripts I have written over the years that I like to keep in ~/.local/bin
    * aptsearch - terminal fuzzy-find search script with apt-show descriptions
    * bar.sh - my updated bar script for spectrwm
    * bgbar.sh - same as bar.sh but with backround colors
    * bgbartoggle.sh - change from bar.sh to bgbar.sh
    * bgsel - use sxiv in defined pictures directory and set wallpapers with xwallpaper
    * bmenu - dmenu script for my bookmarks list (opens in $BROWSER or firefox-esr)
    * bookmarkthis.sh - uses xclip to print highlighted text into a bookmark file
    * deb-fetch - custom terminal fetcher (debian specific) faster than neofetch
    * dev-fetch - custom terminal fetcher (devuan specific) faster than neofetch
    * dfetch - even faster (debian specific) terminal fetcher... WICKED FAST!
    * dmclose - dmenu script that shows active process and kills selected with pkill (close)
    * dmeditconfigs.sh - dmenu script for opening and editing configuration files
    * dmkill - dmenu script that shows active process and kill -9 selected (halts)
    * dmradio - dmenu script that lists defined (in the script) radio stations and plays selected in mpv
    * dvfetch - even faster (devuan specific) terminal fetcher... WICKED FAST!
    * dwm-keys.sh - script to show dwm keybindings from its config.h file
    * dwm-toggle-gaps.sh - toggle gaps value in config.def.h, rm config.h, make, and reload dwm without patch
           - (best to have dwm in a loop in ~/.xinitrc for full effect)
    * dwmbar - dwm xsetroot bar script without icons similar to baraction.sh
    * dwmcolors.sh - dmenu script for changing colorscheme of dwm, st, dmenu, slstatus, and vifm
    * fastscrolling.sh - sets  xset r rate to increase scrolling speed
    * fehbg - set current wallpaper with feh
    * ld-exit - uses yad to create an exit menu to shutdown, logout, reboot, or lock the screen
    * lfcleaner - cleaner script for lf with ueberzug image previews
    * lfscope - wrapper script with conditionals for ueberzug image previews
    * lfub - launch lf file manager with ueberzug image support
    * lok - takes a screenshot (scrot), blurs with imagemagick, and sets it as i3lock background
    * mobo.sh - test script to print out model of motherboard installed in computer
    * nohop - fun little bash script that prints out how it has been since you distro hopped. (requires dateutils)
    * pmenu - dmenu logout script (lists spectrwm, but easily changed to another WM or DE)
    * scratch.sh - scratchpad script for spectrwm using xdo and xdotool (takes arguments)
    * spectrcolors.sh - change spectrwm color scheme with dmenu script
    * spectrgaps.sh - change gap value in spectrwm.conf and reload for "on the fly" changes
    * spectrwm-binding.sh - prints out keybindings from spectrwm.conf to terminal
    * spectrwm-keys.sh - prints keybindings from spectrwm.conf to yad box (requires yad)
    * typethis.sh - dmenu script for typing strings from a bookmark file
    * vifmimg - wrapper script for vifm to use ueberzug image previews
    * vifmrun - launch vifm with ueberzug support
    * volctl - control volume via alsa-utils/pulseaudio (takes arguments)
    * vpn-select - select vpn location from pia .ovpn list (not functional/currently testing)
    * wal - wallpaper shuffler (requires feh)
    * weather.sh - pulls weather information from wttr.in (requires curl)
    * wifictl - dmenu script for connecting and disconnecting to wifi networks (takes arguments)
    * xwal - wallpaper shuffler (requires xwallpaper)
    * xwp - set current wallpaper (requires xwallpaper) <p>&nbsp;</p>

* **.local/share/backgrounds** - nice collection of wallpapers organized into folders for my most used color schemes
    * catppuccin - 4 wallpapers
    * dracula - 6 wallpapers
    * gruvbox - 22 wallpapers
    * nord - 5 wallpapers
    * onedark - 3 wallpapers

* **super-user** - customized permissions for "mike" to add to /etc/sudoers or to /etc/doas.conf


