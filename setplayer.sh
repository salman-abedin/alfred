#!/usr/bin/env sh

# Audio player controller for spotify & mpd
# setplayer --[next,prev,toggle]

pidof mpd || mpd
setplayer() { playerctl "$1" || mpc "$1"; }
case $1 in
    next) setplayer next ;;
    prev) setplayer prev ;;
    toggle) setplayer play-pause || setplayer toggle ;;
    *) : ;;
esac
