#!/usr/bin/env sh

# Audio player controller for spotify & mpd

case $1 in
    play)
        pidof mpd || mpd
        case $2 in
            next) playerctl next || mpc next ;;
            prev) playerctl prev || mpc prev ;;
            toggle) setplayer play-pause || setplayer toggle ;;
        esac
        ;;
    vol)
        case $2 in
            up) pactl set-sink-volume @DEFAULT_SINK@ +10% ;;
            down) pactl set-sink-volume @DEFAULT_SINK@ -10% ;;
            toggle) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
        esac
        canberra-gtk-play -i audio-volume-change
        uniblocks -u vol
        ;;
    *) : ;;
esac
