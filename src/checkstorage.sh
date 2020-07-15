#!/bin/sh
#
# checkstorage <PATH1> <THRESHOLD1> <PATH2> <THRESHOLD2> ...
# Notifies on low storage level (cron script)

while [ -n "$1" ]; do
   LOCATION=$1
   THRESHOLD=$2
   FREE=$(df -h "$LOCATION" | awk '(NR == 2){print int($4)}' | sed 's/G//')
   [ "$FREE" -lt "$THRESHOLD" ] && notify-send -t 0 -i "$ICONS"/critical.png \
      "$LOCATION has less than $THRESHOLD gig"
   shift 2
done
