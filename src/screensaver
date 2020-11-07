#!/bin/sh
#
# Locks & shows screensaver

# Duration ( in minutes )
dur=$((INACTIVITY / 60))
SCREEN=/tmp/screen.png

ffmpeg -y \
   -hide_banner \
   -loglevel error \
   -f x11grab \
   -video_size "$(xrandr | awk '(/current/){print $8 "x" $10 }' | sed 's/,//')" \
   -i "$DISPLAY" \
   -vframes 1 \
   $SCREEN
convert $SCREEN -blur 0x5 $SCREEN
convert $SCREEN ~/.local/share/images/arch.png -gravity center -composite -matte $SCREEN

# launch -f $SCREEN
timeout "$dur"m i3lock -n -e -f -c 000000 -i $SCREEN ||
   timeout "$dur"m \
      ffplay \
      -volume 0 -exitonkeydown -exitonmousedown -loop "$dur" \
      -fs ~/.local/share/screensavers/matrix.mp4 \
      > /dev/null 2>&1 ||
   systemctl suspend

#===============================================================================
#                             Exp
#===============================================================================

# xtrlock -f
# timeout 30m xterm -fullscreen -e "sleep 1; cmatrix -s -b -u 10" || systemctl suspend
# timeout 30m xterm -fullscreen -e "sleep 1; rain" || systemctl suspend
# timeout 300 mpv -fs --no-osc --no-audio --loop=inf --no-resume-playback ~/.wallpapers/matrix.mp4 >/dev/null 2>&1 || systectl suspend
