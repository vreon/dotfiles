###########################################################
# zsh config

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e            # emacs-style bindings
setopt nobeep         # no beeps plz
setopt noflowcontrol  # make C-s and C-q do nothing
setopt appendhistory  # don't clobber history files

# Enable completion
zstyle :compinstall filename '/home/vreon/.zshrc'
autoload -Uz compinit
compinit

# When completion lists directory contents, use colors
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors`"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    LS_COLORS=
fi

zstyle ':completion:*' menu select

# Enable vcs_info, for git branch
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ':%b'
precmd () { vcs_info }

###########################################################
# Key bindings

bindkey '^[[Z' reverse-menu-complete  # Shift-Tab
bindkey '^R' history-incremental-search-backward
bindkey '^Z' undo

###########################################################
# virtualenvwrapper

if [ -f /usr/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

###########################################################
# Functions and aliases

# Colorize all the things
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Shortcuts and common actions
alias sys='sudo systemctl'
alias wk='workon'
alias usage='du -h --max-depth=0 * | sort -hr'
alias pyclean="find -regex '.*\.pyc\|.*__pycache__' -delete"
alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias thr="docker run -it --rm"
alias k='kwrapper'
function whichpr {
    git log $1..master --ancestry-path --merges --oneline | tail -n 1
}

# For git
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gds='git diff --staged'
alias gfop='git fetch origin --prune'
alias gl='git log --pretty=fancy --date=short --no-merges'
alias gla='git log --pretty=fancy --date=short'
alias gnvm='git reset . && git checkout . && git checkout master'
alias gp='git pull'
alias grmb='git branch --merged | grep -v master | xargs git branch -d'
alias gs='git status -sb'
alias gspf='git stash show -p | git apply && git stash drop'
alias gfer='git for-each-repo'

###########################################################
# Environment

if command -v nvim > /dev/null; then
    export EDITOR=$(which nvim)
    export NVIM_LISTEN_ADDRESS=/tmp/nvim
    alias vim='nvim'
else
    export EDITOR=$(which vim)
fi

export PROJECT_HOME=$HOME/Projects
export PYTHONSTARTUP=$HOME/.pythonrc.py
export BROWSER=google-chrome-unstable
export BROWSER_PRIVATE='google-chrome-unstable --incognito'
export BSPWM_USE_PANEL=true
export HOSTCOLOR=7

export PATH=${PATH}:~/.bin                                # Local bins
export PATH=${PATH}:~/.gem/ruby/2.0.0/bin                 # Ruby gems
export PATH=${PATH}:/opt/android-sdk/platform-tools       # android
export GOPATH=${PROJECT_HOME}/go                          # go path
export PATH=${PATH}:${GOPATH}/bin                         # go bins
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib  # rust
export CLOUDSDK_PYTHON=$(which python2)                   # gcloud

if [ -d "$HOME/.gcloud" ]; then
    source ~/.gcloud/google-cloud-sdk/completion.zsh.inc
    source ~/.gcloud/google-cloud-sdk/path.zsh.inc
fi

###########################################################
# Prompt

setopt prompt_subst
if [ -n "$MINIMAL_PROMPT" ]; then
    PROMPT='%F{${HOSTCOLOR}}>%f '
else
    PROMPT='%F{${HOSTCOLOR}}[%n@%m %~]${vcs_info_msg_0_}$%f '
fi

###########################################################
# Per-host configuration

source ~/.zshrc_local
