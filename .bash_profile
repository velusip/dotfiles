# bash-only environment, ff to x
. $HOME/.bashrc
. $HOME/.profile
# just autostart x
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -le 2 ]; then
    startx
fi
