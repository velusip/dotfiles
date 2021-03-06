# shell-only stuff
# Check for an interactive session
[ -z "$PS1" ] && return
PS1='[\u@\h \W]\$ '

#ls colour codes
#eval `dircolors -b`
[ -f ~/.config/dircolors.ansi-universal ] && eval `dircolors ~/.config/dircolors.ansi-universal`
TERM=screen-256color
#grep color codes
GREP_COLOR="1;33"
#less colour codes
LESS_TERMCAP_mb=$'\e[1;31m'
LESS_TERMCAP_md=$'\e[1;31m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[1;44;33m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[1;32m'

#alias
alias ls='ls --color=auto'
alias lsg='ls --group-directories-first'
alias lsc='ls --color=never'
alias bc='bc -l'
alias grep='grep --color=auto'
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && ssh'
alias bd='. bd -s'
alias screenx='screen -d -m -c ~/.screenrc; startx'
alias 4k='mplayer -ao pulse -vo gl_nosw -lavdopts threads=8 -framedrop'

# Richard Bronosky's BASH script for migrating ACL grants:
# usage:  mygrants --host=sourcehost --user=root --password=secret | grep user_in_transit | mysql --host=desthost --user=root --password=secret
mygrants()
{
    mysql -B -N $@ -e "SELECT DISTINCT CONCAT('SHOW GRANTS FOR ''', user, '''@''', host, ''';') AS query FROM mysql.user" | \
    mysql $@ | \
    sed 's/\(GRANT .*\)/\1;/;s/^\(Grants for .*\)/## \1 ##/;/##/{x;p;x;}'       
}

#say with google translate:
say()
{
    if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null
}

np()
{
    #print file location of currently playing music to stdout
    # nppl > playlist.m3u8
    echo "$(cmus-remote -Q | awk 'NR == 2 {for(i = 2; i <= NF; i++) printf((i!=NF)?$i " ":$i);printf("\n")}')"
}
npcp()
{
    #copy currently playing music to current directory
    cp "$(cmus-remote -Q | awk 'NR == 2 {for(i = 2; i <= NF; i++) printf((i!=NF)?$i " ":$i);printf("\n")}')" .
}

f2c()
{
    #what is this cold the americans are talking about
    echo "(5/9)*(${1}-32)" | bc
}

