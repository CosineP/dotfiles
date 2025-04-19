# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[ -n "$PS1" ] && sh ~/.nightshell/strawberry-light

# my own little implementation of fortune
function fortune
{
    echo
    echo
    sort -R ~/.fortunes | head -n1 | fold -s -w 72 | sed 's/^/    /'
}
fortune

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
complete="yes"
if [ "$complete" == "yes" ]; then
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi

alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function cs() {
  cd "$@" && ls
}

function mkcd() {
  mkdir "$@" && cd "$@"
}

function just() {
  NIXPKGS_ALLOW_UNFREE=1 nix-shell -p $1 --run "$@"
}

alias gst='git status'
alias cfg='sudoedit /etc/nixos/configuration.nix; echo sudo nixos-rebuild switch'

export EDITOR='code --wait'
export TERM=xterm

source "$(fzf-share)/key-bindings.bash"
source "$(fzf-share)/completion.bash"
