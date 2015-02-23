#!/bin/sh

# Source files from xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

redshift &  # Prevent self from going blind

# Also look for fonts in /usr/share/fonts/local (TODO: why?)
xset +fp /usr/share/fonts/local
xset fp rehash

# Fix keyboard oddities
# ... or, depending on your perpective, add them
# TODO: Move these into the keymap so the console uses them too!
# see: https://wiki.archlinux.org/index.php/KEYMAP
setxkbmap -option "caps:swapescape"
setxkbmap -option "compose:rwin"

# xfce4
# setxkbmap -option "altwin:swap_alt_win"
# exec startxfce4

# xmonad
# xfdesktop &
# xsetroot -cursor_name left_ptr
# exec xmonad

# dwm
# exec dwm
# TODO: Implement startdwm
# see: https://wiki.archlinux.org/index.php/Dwm#Using_dbus_with_dwm
# exec dbus-launch --sh-syntax --exit-with-session ~/bin/startdwm

# herbstluftwm
# xrdb -load .Xresources
# exec herbstluftwm

# bspwm
export PATH="${PATH}:~/.bin"
xrdb -load .Xresources
xsetroot -cursor_name left_ptr
sh ~/.fehbg &
compton -c -b
sxhkd &
unclutter -root &
exec bspwm
