
# Check for an interactive session
[ -z "$PS1" ] && return

#alias
alias ls='ls --color=auto'
alias bc='bc -l'

#prompt
#setfont /usr/share/kbd/consolefonts/LatArCyrHeb-19.psfu.gz
PS1='[\u@\h \W]\$ '
eval `dircolors -b`

#grep color codes
export GREP_COLOR="1;33"
alias grep='grep --color=auto'
#less colour codes
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

#bin
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/opt/java/jre/bin:/usr/bin/perlbin/vendor:/usr/lib/perl5/core_perl/bin:/home/velusip/bin

#language
export LANG=en_CA.UTF-8

#x
export DISPLAY=:0.0

#default perms
umask 077

#say XD
say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

