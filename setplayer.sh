#!/usr/bin/env sh

setplayer() {
    if pidof spotify; then
        playerctl "$1"
    else
        mpc "$1"
    fi
}
case $1 in
    next) setplayer next ;;
    prev) setplayer prev ;;
    toggle)
        setplayer toggle
        setplayer play-pause
        ;;
    *) : ;;
esac
