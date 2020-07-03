#!/usr/bin/env sh

# Queues up a file on mpv

MPVFIFO=/tmp/mpvfifo
mkfifo $MPVFIFO 2> /dev/null
if pidof mpv; then
    echo loadfile "$*" append-play > $MPVFIFO
else
    mpv --input-file="$MPVFIFO" "$*" > /dev/null 2>&1 &
fi
