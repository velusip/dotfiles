#!/bin/sh

# set menu button as compose
setxkbmap -option compose:menu

# compensate for physical rearrangement of keyboard keys
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# dpms screen blanking interval
xset s 7200 7200

# set mouse to dull (default 1/2 4) and curser
xset m 0 0
xsetroot -cursor_name left_ptr

# add font path
#xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/misc
xset fp rehash

# cycle wallpaper
while true;
do
    feh --bg-fill ~/.wallpaper/"$(ls -A ~/.wallpaper | shuf -n 1)"
    sleep 15m
done &

# screensaver
#exec xscreensaver -no-splash &

# merge x resources
xrdb -merge ~/.Xresources

# pre window manager
[ -f ~/.xprofile ] && source ~/.xprofile

# set trayer beside xmobar
exec trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand false --widthtype percent --width 4.1 --transparent true --alpha 0 --tint 0xFEF9EC --heighttype pixel --height 18 &

# call wm
exec xmonad

