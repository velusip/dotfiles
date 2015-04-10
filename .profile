# source .bashrc on login & interactive
. $HOME/.bashrc

#sudo loadkeys -q ~/.consolevu.map&
#eval `keychain --eval --agents ssh id_rsa`

PATH=$PATH:/home/velusip/bin

#prompt
PS1='[\u@\h \W]\$ '
eval `dircolors -b`

#grep color codes
export GREP_COLOR="1;33"

#less colour codes
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

#language
export LANG=en_CA.UTF-8

#x
#export DISPLAY=:0

#default editor
export EDITOR="/usr/bin/vim"

#default perms
umask 027

