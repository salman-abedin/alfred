#!/usr/bin/env sh

bspc subscribe report |
    while read -r line; do
        line=${line#*:}
        line=${line%:L*}
        IFS=:
        set $line
        wm=
        while :; do
            case $1 in
                [FOU]*) name=🏚 ;;
                f*) name=🕳 ;;
                o*) name=🌴 ;;
                *) break ;;
            esac
            wm="$wm $name"
            shift
        done
        echo "$wm"
    done
