#!/bin/sh

# pre window manager
[ -f ~/.xprofile ] && echo "sourcing ~/.xprofile" && source ~/.xprofile

# Load resources
[ -f ~/.Xresources ] && echo "merging Xresources" && xrdb -merge ~/.Xresources

# Load keymaps
# set menu button as compose
[ -f ~/.Xkbmap ] && echo "setting .Xkbmap" && setxkbmap `cat ".Xkbmap"`

# Load xmodmap (physical arrangement of keyboard keys)
[ -f ~/.Xmodmap ] && echo "mapping ~/.Xmodmap" && xmodmap ~/.Xmodmap

# Run user xsession
[ -f ~/.xsession ] && echo "sourcing ~/.xsession" && source ~/.xsession

