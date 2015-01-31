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

autoload zkbd  # invoke `zkbd` for setup
source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

bindkey '^[[Z' reverse-menu-complete  # Shift-Tab
bindkey '^R' history-incremental-search-backward
bindkey '^Z' undo

bindkey "${key[Backspace]}" backward-delete-char
bindkey "${key[Delete]}" delete-char
bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey "${key[PageUp]}" up-line-or-history
bindkey "${key[PageDown]}" down-line-or-history
bindkey "${key[Up]}" up-line-or-search
bindkey "${key[Down]}" down-line-or-search
bindkey "${key[Left]}" backward-char
bindkey "${key[Right]}" forward-char

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
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# For common actions
alias sys='sudo systemctl'
alias wk='workon'
alias bp='/usr/bin/env python -m bpython.cli'
alias bp2='/usr/bin/env python2 -m bpython.cli'
alias usage='du -h --max-depth=0 * | sort -hr'
alias pyclean="find -regex '.*\.pyc\|.*__pycache__' -delete"
alias docker-clean-images="docker images | grep '^<none>' | awk '{print \$3}' | xargs docker rmi"
alias findpacnew="find /etc -regextype posix-extended -regex '.+\.pac(new|save|orig)' 2> /dev/null"
alias hc="herbstclient"
alias thr="docker run -it --rm"
function whichpr {
    git log $1..master --ancestry-path --merges --oneline | tail -n 1
}

# For git
alias gl='git log --pretty=fancy --date=short --no-merges'
alias gla='git log --pretty=fancy --date=short'
alias gp='git pull'
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias gfop='git fetch origin --prune'
alias gspf='git stash show -p | git apply && git stash drop'
alias grmb='git branch --merged | grep -v master | xargs git branch -d'

###########################################################
# Environment

export EDITOR=/usr/bin/vim
export PROJECT_HOME=$HOME/Projects
export PYTHONSTARTUP=$HOME/.pythonrc.py

export PATH=${PATH}:~/.bin                                # Local bins
export PATH=${PATH}:~/.gem/ruby/2.0.0/bin                 # Ruby gems
export PATH=${PATH}:/opt/android-sdk/platform-tools       # android
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib  # rust

###########################################################
# Prompt

case $HOST in
    slylandro) host_color=yellow ;;
    pollux) host_color=blue ;;
    chenjesu) host_color=magenta ;;
    atuin) host_color=cyan ;;
    kvothe) host_color=12 ;;  # bright blue
    *) host_color=gray ;;
esac

setopt prompt_subst
PROMPT='%F{${host_color}}[%n@%m %~]${vcs_info_msg_0_}$%f '
