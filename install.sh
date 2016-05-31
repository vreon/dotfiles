#!/bin/bash
# Install dotfiles on this host.

dotfiles=$HOME/.files

mkdir -p $HOME/.ssh
mkdir -p $HOME/.urxvt
mkdir -p $HOME/.virtualenvs

links=(
    .bin
    .config/user-dirs.dirs
    .config/colorschemes
    .config/bspwm
    .config/sxhkd
    .config/compton.conf
    .config/clight.yaml
    .gitignore_global
    .password-store
    .ssh/config
    .tmux.conf
    .urxvt/ext
    .vim
    .vimrc
    .XCompose
    .Xresources
    .xinitrc
    .zshrc
)

for link in "${links[@]}"; do
    ln -sT $dotfiles/$link $HOME/$link
done

ln -sT $dotfiles/.vim $HOME/.config/nvim
ln -sT $dotfiles/.vimrc $HOME/.config/nvim/init.vim

mkdir -p $HOME/.vim/tmp

mpd_home=$HOME/.config/mpd
if [ ! -d "$mpd_home" ]; then
    mkdir $mpd_home
    mkfifo $mpd_home/mpd.fifo
    ln -sT $dotfiles/.config/mpd/mpd.conf $mpd_home/mpd.conf
fi

if [ -n "$HAS_ARCHIVE" ]; then
    archive="/mnt/archive"
    ln -sT $archive/audio $HOME/Audio
fi

if [ -n "$HAS_DOCUMENTS" ]; then
    documents="$HOME/Documents"
    ln -sT $documents/Notes/TODO $HOME/TODO
else
    touch $HOME/TODO
fi

if command -v zsh; then
    chsh -s $(which zsh)
else
    echo "no zsh?"
fi
