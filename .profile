# environment stuff, usually sourced during logins

umask 027
export LANG=en_CA.UTF-8
for x in /home/velusip/bin; do
  case ":$PATH:" in
    *":$x:"*) :;; # already there
    *) PATH="$x:$PATH";;
  esac
done
export EDITOR="/usr/bin/vim"

export DISPLAY=:0
export BROWSER=/bin/firefox
export ANDROID_HOME=/opt/android-sdk
