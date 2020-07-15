#!/bin/sh
#
# Queues up a file on mpv

MPVFIFO=/tmp/mpvfifo

[ -e $MPVFIFO ] || mkfifo $MPVFIFO
if pidof mpv; then
   echo loadfile "$@" append-play > $MPVFIFO
else
   mpv --input-file="$MPVFIFO" "$@" > /dev/null 2>&1 &
fi
