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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions)

# source $ZSH/oh-my-zsh.sh

# Antigen
source /usr/share/zsh-antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle common-aliases
antigen bundle debian
antigen bundle pip
antigen bundle python
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme avit

antigen apply

autoload zmv

# User configuration

eval $(thefuck --alias)

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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

[ -n "$PS1" ] && sh ~/.nightshell/strawberry-light
eval `dircolors ~/.nightshell/dircolors`

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias vi="nvim"
alias v=vi
alias doot="echo thanks mr skeltal"
alias aoeu="echo what is the problem you are trying to solve"
alias aoeuhtns=aoeu
# For my dotfiles git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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
alias noblur='pkill compton && compton --config ~/.config/compton-video.conf -b'
# Function aliases
function cs() {
    cd $1 && ls
}
function mcd() {
    mkdir $1 && cd $1
}
function mark() {
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

# Env variables
export EDITOR="nvim"
export LD_LIBRARY_PATH="/lib:/lib64:/usr/lib:/usr/lib64:$LD_LIBRARY_PATH:/usr/local/lib"
export TP_GAE="tpassing-175603"
export TP_GAE_SQL="tpassing-175603:us-central1:transpassing"
export TPASSING="ec2-13-58-183-86.us-east-2.compute.amazonaws.com"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

