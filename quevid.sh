#!/usr/bin/env sh

MPVFIFO=/tmp/mpvfifo
[ $MPVFIFO ] || mkfifo $MPVFIFO

if pidof mpv; then
    echo loadfile "$1" > $MPVFIFO
else
    mpv --input-ipc-server="$MPVFIFO" "$1"
fi
