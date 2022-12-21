# LD zsh config

# Enable colors and make prompt pretty
autoload -U colors && colors
PS1="%B[%{$fg[yellow]%}%n%{$fg[red]%}  %{$fg[blue]%}%M %{$fg[yellow]%}%~%{$reset_color%}]$%b "
setopt autocd
setopt interactive_comments

# Attempt at a pretty password prompt
export SUDO_PROMPT="$fg[red][sudo] $fg[yellow]password for $USER    :$fg[white]"

# History size
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.cache/zsh/history

# Tab auto-complete and tab-complete
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;  #block
        viins|main) echo -ne '\e[5 q';; #beam
    esac
}
zle -N zle-keymap-select
zle-line-init(){
    zle -K viins # initiate vi insert as keymap (can be removed if 'bindkey -v' has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # USE beam shape cursor for each new prompt

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# source aliasrc file
[ -e ~/.config/aliasrc ] && source ~/.config/aliasrc

#Colored man pages and stuff
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

distro="$(cat /etc/os-release | grep ^NAME | cut -d'=' -f2 | sed 's/"//g')"

if [ $distro = 'Devuan GNU/Linux' ]; then
    fetcher=dvfetch
else
    fetcher=dfetch
fi

$fetcher

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
