#!/usr/bin/env sh

# checkstorage <PATH1> <THRESHOLD1> <PATH2> <THRESHOLD2> ...
# Notifies on low storage level

while [ "$1" ]; do
    LOCATION=$1
    THRESHOLD=$2
    FREE=$(df -h "$LOCATION" | awk '(NR == 2){print int($4)}' | sed 's/G//')
    [ "$FREE" -lt "$THRESHOLD" ] && notify-send -t 1000 -i "$ICONS"/critical.png \
        "$LOCATION has less than $THRESHOLD gig"
    shift
    shift
done

# getfree() { df -h "$1" | awk '(NR == 2){print $4}' | sed 's/G//'; }
# root=$(getfree /)
# home=$(getfree /home)
# [ "$root" -lt 5 ] && notify-send -t 0 -i "$ICONS"/critical.png "Low System Storage"
# [ "$home" -lt 10 ] && notify-send -t 0 -i "$ICONS"/critical.png "Low Home Storage"
