#!/bin/sh
#
# Checks if wifi & internet is up or not
# Dependencies: grep, timeout, curl

grep "up" /sys/class/net/w*/operstate > /dev/null && {
   wget -q --spider http://google.com
   # timeout 3 curl google.com > /dev/null 2>&1 || exit 1
}

# ping -q -c 1 1.1.1.1 > /dev/null 2>&1 \
# || notify-send -t 3000 -i "$ICONS"/disconnected.png "Disconnected"
