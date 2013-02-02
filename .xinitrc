#!/bin/sh

# set menu button as compose
setxkbmap -option compose:menu

# compensate for physical rearrangement of keyboard keys
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# set mouse to dull (default 1/2 4)
xset m 0 0

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

# tray beside xmobar
exec trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand false --width 2 --transparent true --alpha 0 --tint 0x000000 --height 15 &
exec xmonad
