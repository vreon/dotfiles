#!/bin/sh

# Source files from xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

redshift &  # Prevent self from going blind

# Fix keyboard
setxkbmap -option "compose:rwin"
setxkbmap -option "caps:swapescape"

# xfce4
# setxkbmap -option "altwin:swap_alt_win"
# exec startxfce4

# herbstluftwm
# xrdb -load .Xresources
# exec herbstluftwm

# bspwm
export PATH="${PATH}:~/.bin"
xrdb -load .Xresources
xsetroot -cursor_name left_ptr
sh ~/.fehbg &
compton -c -b
sxhkd -f 50 &
unclutter -root &
urxvtd -q -f -o
exec bspwm
