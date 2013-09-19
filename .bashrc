
# Check for an interactive session
[ -z "$PS1" ] && return

#alias
alias ls='ls --color=auto'
alias bc='bc -l'
alias screenx='screen -c ~/.screenx'

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

#default editor
export EDITOR="/usr/bin/vim"

#default perms
umask 077

#say XD
say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

# ponify
ponyfortune() { fortune | sed -e 's/amareica/amareica/g' -e 's/Amareica/Amareica/g' -e 's/anypony/anypony/g' -e 's/Anypony/Anypony/g' -e 's/anypony/anypony/g' -e 's/Anypony/Anypony/g' -e 's/colt/colt/g' -e 's/Colt/Colt/g' -e 's/flankhurt/saddle-sore/g' -e 's/Flankhurt/Saddlesore/g' -e 's/foals/foals/g' -e 's/Foals/Foals/g' -e 's/foal/foal/g' -e 's/Foal/Foal/g' -e 's/cowpony/cowpony/g' -e 's/Cowpony/Cowpony/g' -e 's/cowpony/cowpony/g' -e 's/Cowpony/Cowpony/g' -e 's/gentlecolts/gentlecolts/g' -e 's/Gentlecolts/Gentlecolts/g' -e 's/everypony/everypony/g' -e 's/Everypony/Everypony/g' -e 's/everypony/everypony/g' -e 's/Everypony/Everypony/g' -e 's/hooves/hooves/g' -e 's/Hooves/Hooves/g' -e 's/foalks/foalks/g' -e 's/Foalks/Foalks/g' -e 's/foal/foal/g' -e 's/Foal/Foal/g' -e 's/hoof/hoof/g' -e 's/Hoof/Hoof/g' -e 's/fillies/fillies/g' -e 's/Fillies/Fillies/g' -e 's/filly/filly/g' -e 's/Filly/Filly/g' -e 's/nightmare night/nightmare night/g' -e 's/Nightmare Night/Nightmare Night/g' -e 's/hooves/hooves/g' -e 's/Hooves/Hooves/g' -e 's/hoofed/hooved/g' -e 's/Hoofed/Hooved/g' -e 's/hoof/hoof/g' -e 's/Hoof/Hoof/g' -e 's/\bhey\b/hay/g' -e 's/\bHey\b/Hay/g' -e 's/ponies/ponies/g' -e 's/Ponies/Ponies/g' -e 's/pony/pony/g' -e 's/Pony/Pony/g' -e 's/fillies/fillies/g' -e 's/Fillies/Fillies/g' -e 's/mane/mane/g' -e 's/Mane/Mane/g' -e 's/mare/mare/g' -e 's/Mare/Mare/g' -e 's/mares/mares/g' -e 's/Mares/Mares/g' -e 's/\bman\b/stallion\ /g' -e 's/\bMan\b/Stallion/g' -e 's/\bmen\b/stallions/g' -e 's/\bMen\b/Stallions/g' -e 's/no\ one\ else/no\ pony\ else/g' -e 's/No\ one\ else/No\ pony\ else/g' -e 's/nopony/nopony/g' -e 's/Nopony/Nopony/g' -e 's/ponies/ponies/g' -e 's/Ponies/Ponies/g' -e 's/pony/pony/g' -e 's/Pony/Pony/g' -e 's/fillydelphia/fillydelphia/g' -e 's/Fillydelphia/Fillydelphia/g' -e 's/somepony/somepony/g' -e 's/Somepony/Somepony/g' -e 's/cutie mark/cutie\ mark/g' -e 's/Cutie Mark/Cutie\ mark/g' -e 's/the\ heck/the\ hay/g' -e 's/The\ heck/The hay/g' -e 's/the\ hell/the\ hay/g' -e 's/The\ Hell/The\ Hay/g' -e 's/parasprite/parasprite/g' -e 's/Parasprite/Parasprite/g' | ponysay ; }

