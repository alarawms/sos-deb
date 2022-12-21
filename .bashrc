# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## bash history file location
HISTFILE="$HOME/.config/bash/bash_history"
## don't duplicate lines in history file
HISTCONTROL=ignoreboth:erasedups

## append to the history file, don't overwrite it

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control
shopt -s histappend ## append to the history file, don't overwrite it


## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

## check the window size after each command and update values for columns
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# color prompt enable/disable
color_prompt=yes

# set PS1 prompt and make it pretty
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\
[\[\033[01;92m\]\u\
\[\033[01;31m\]  \
\[\033[01;94m\]\h\
\[\033[01;00m\]:\
\[\033[01;33m\]\w\
\[\033[00m\]]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions file
[ -e ~/.config/aliasrc ] && . ~/.config/aliasrc


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
## exports
#export EDITOR=nvim
export TERMINAL="kitty"
export ALTERNATE_EDITOR=""                        # setting for emacsclient
export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
export BROWSER="firefox-esr"
export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"

export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '^[[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '^[[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '^[[0m')"
export LESS_TERMCAP_so="$(printf '%b' '^[[1;44;33m')"
export LESS_TERMCAP_us="$(printf '%b' '^[[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '^[[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"
# vi mode
set -o vi

## make delete key work in st terminal
tput smkx

# set fetcher for debian or devuan
distro="$(grep ^NAME /etc/os-release | cut -d'=' -f2 | awk '{print $1}' | sed 's/"//g')"

if [ "$distro" = Devuan ]; then
    fetcher=dvfetch
else
    fetcher=dfetch
fi

$fetcher


#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
