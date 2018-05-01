# environment stuff, usually sourced during logins

# append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
        ;;
        *)
        PATH="$PATH:$1"
    esac
}

umask 027
export LANG=en_CA.UTF-8
#see /etc/profile
appendpath '/home/velusip/bin'
export PATH
export EDITOR="/usr/bin/vim"
export DISPLAY=:0
export BROWSER=/bin/firefox
export ANDROID_HOME=/opt/android-sdk
