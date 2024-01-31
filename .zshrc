# Profiling https://htr3n.github.io/2018/07/faster-zsh/
zmodload zsh/zprof

[ -n "$PS1" ] && sh ~/.nightshell/strawberry-light

#cat /etc/motd
# my own little implementation of fortune
function fortune
{
    echo "\n"
    sort -R ~/.fortunes | head -n1 | fold -s -w 72 | sed 's/^/    /'
}
fortune

# Path to your oh-my-zsh installation.
export ZSH=/home/luna/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Tab complete with ls colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Usage order
zstyle ':completion:*' file-sort modification

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

HISTSIZE=999999999
SAVEHIST=999999999

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions)

# Antigen
# ????????????
# also i had to do nix-shell -p antigen even though it's in my cfg????
source `nix eval --raw --impure --expr '(import <nixpkgs> {}).antigen.outPath'`/share/antigen/antigen.zsh

antigen use oh-my-zsh

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm
antigen bundle git
antigen bundle common-aliases
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme avit

antigen apply

autoload zmv

# my zsh theme is getting messed up somehow. i think the typeset is getting
# unset. so putting these here sets them again so they work
typeset +H _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%} "
typeset +H _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
typeset +H _hist_no="%{$fg[grey]%}%h%{$reset_color%}"

# User configuration

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -t'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

eval `dircolors ~/.nightshell/dircolors`

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

setopt histignorespace

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ssh or foreign machines(?) have trouble with xterm-kitty for whatever reason
alias ssh="TERM=xterm ssh"
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias vi="nvim"
#function k() {
#    # each directory will have its own session now
#    name=`echo "$PWD" | tr -d / | tail -c 8`
#    if ! pgrep -f "kak -s $name" > /dev/null; then
#        echo "$name" > /tmp/last-kak
#        # you might be inclined to use kak's -d alone, but it hangs terminals!!
#        daemon -D "$PWD" -- kak -s "$name" -d
#    fi
#    kak -c "$name" "$@"
#}
alias k=kak
# connect to the last opened session
function kk() {
    name=`cat /tmp/last-kak`
    kak -c "$name" "$@"
}
alias e=editor
alias doot="echo thanks mr skeltal"
alias aoeu="echo what is the problem you are trying to solve"
alias aoeuhtns=aoeu
# For my dotfiles git
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# I don't want to have to sudo for all the power instructions!
alias poweroff /sbin/poweroff
alias reboot /sbin/reboot
# Shortcuts
alias x=exit
alias vimrc="vi ~/.vimrc"
# fd is fedi not find
alias fdd='find . -type d -name'
alias wprog='watch grep -e Dirty: -e Writeback: /proc/meminfo'
# oh hell yeah
alias gpl='curl https://www.gnu.org/licenses/gpl-3.0.txt > LICENSE'
alias agpl='curl https://www.gnu.org/licenses/agpl-3.0.txt > LICENSE'
unalias fd
alias mocha="./node_modules/mocha/bin/mocha"
alias gat="cb ~/github-access-token"
alias emu="emulator -avd Nexus_5X_API_27_x86 -gpu host"
alias noblur='pkill compton; compton -i1.0 -b'
# the nitrogen means blur can be used to undo `gray`
alias compnorm='pkill picom; picom --experimental-backends -b; nitrogen --restore &'
alias blur='compnorm'
alias compzoom='pkill compton; compton --config ~/.config/compton-zoom.conf -b'
alias ck='cargo check --all-targets --color=always LL'
alias kmm='k /tmp/hmm'
alias eljs='node ~/src/ElementaryJS/eval/eval.js'
alias tryrs='k /tmp/test.rs; rustc /tmp/test.rs -o /tmp/test-rust && /tmp/test-rust'
alias tryc='k /tmp/test.c; gcc /tmp/test.c -o /tmp/test-c && /tmp/test-c'
alias clear='clear && fortune'
# warp here
alias wh='echo "$PWD" > /tmp/zsh-warp'
# warp now
alias wn='cd `cat /tmp/zsh-warp`'
alias gray='~/Documents/gray.sh'
alias cfg='sudoedit /etc/nixos/configuration.nix; echo sudo nixos-rebuild switch'
alias slow='PROMPT='"'"'${_current_dir}%{%(!.${fg[red]}.${fg[white]})%}▶%{$reset_color%} '"'"
# Function aliases
function bwvid() { curl https://billwurtz.com/videos.html | grep '<A' | shuf | grep -oP 'HREF="\K([^"]*)(?=")' | xargs -d'\n' printf 'https://billwurtz.com/%b\n' | xargs -d'\n' vlc }
function tooslow() {
    export PROMPT='${_current_dir}%{%(!.${fg[red]}.${fg[white]})%}▶%{$reset_color%} '
    export RPROMPT='${_return_status}'
}
function teljs() {
    eljs "$@" 1
}
function cs() {
    cd $1 && ls
}
function mcd() {
    mkdir $1 && cd $1
}
# Open MarkDown
function omd() {
    out=/tmp/md.html
    echo '<body style="max-width: 700px; padding: 30px;">' > $out
    markdown $1 >> $out
    echo '</body>' >> $out
    firefox $out
}
function swp()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
function cb
{
    cat "$@" | xclip -sel clip
}
function insomnia
{
    systemd-inhibit sh -c 'echo "press enter to allow sleep. "; read _'
}
function tv
{
    setup-watch
    x11vnc -forever &
    # Combines not going to sleep with a read prompt
    systemd-inhibit sh -c "$*"
    teardown-watch
}
function setup-watch
{
    # Make sure the TV is working
    xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1
    # Compton fanciness is in the way. But we still need compton for vsync
    noblur
    # Use HDMI audio
    pacmd set-card-profile 0 output:hdmi-stereo
}
function teardown-watch
{
    # Restart these nice services
    daemon redshift
    # Reset compton to look nice again
    blur
    # TODO: Do we need an xrandr set? I think it's fine for now
    pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo
}
function game
{
    setup-watch
    # And, go!
    steam -bigpicture
    # Automatically switch sound back when steam is exited
    teardown-watch
}

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
