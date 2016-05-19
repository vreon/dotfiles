#!/bin/sh

# Source files from xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

. ~/.zshrc_local

installed () {
    command -v $1 >/dev/null 2>&1
}

installed redshift && redshift &

case "$KEYBOARD" in
apple)
    setxkbmap -option "compose:rwin"
    setxkbmap -option "caps:swapescape"
    ;;
chromebook)
    xmodmap -e "keycode 133 = Escape"
    xmodmap -e "remove mod1 = Alt_L"
    xmodmap -e "keycode 64 = Super_L"
    xmodmap -e "add mod4 = Super_L"
    ;;
esac

export PATH="${PATH}:~/.bin"
export GTK_IM_MODULE="xim"
xrdb -load .Xresources
xsetroot -cursor_name left_ptr
sxhkd -f 50 &
urxvtd -q -f -o
[ -f ~/.fehbg ] && sh ~/.fehbg &
installed compton && compton -b
installed unclutter && unclutter -root &
exec bspwm
