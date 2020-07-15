#!/bin/sh
#
# Screensaver and locker script

# Duration ( in minutes )
dur=$((INACTIVITY / 60))

# xtrlock &

# timeout 30m xterm -fullscreen -e "sleep 1; cmatrix -s -b -u 10" || systemctl suspend
# timeout 30m xterm -fullscreen -e "sleep 1; rain" || systemctl suspend

# xdo hide -a yabar
timeout "$dur"m \
   ffplay \
   -volume 0 -exitonkeydown -exitonmousedown -loop "$dur" \
   -fs ~/.local/share/screensavers/matrix.mp4 \
   > /dev/null 2>&1 ||
   systemctl suspend
# xdo show -a yabar

# timeout 300 mpv -fs --no-osc --no-audio --loop=inf --no-resume-playback ~/.wallpapers/matrix.mp4 >/dev/null 2>&1 || systectl suspend
