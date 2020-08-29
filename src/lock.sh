#!/bin/sh
#
# Screen locker
# Dependencies: timeout, i3lock-color

dur=$((INACTIVITY * 3 / 60))
QUOTE=$(shuf -n1 ~/.local/share/misc/quotes)

# toggle -n

timeout "$dur"m \
   i3lock -k \
   --timestr "%H:%M" \
   --time-font monospace --timecolor ffffff --timesize 100 \
   --datestr "%a, %d %b" --datepos='tx+0:ty+50' \
   --date-font monospace --datecolor ffffff --datesize 30 \
   --greetertext "$QUOTE" --greeterpos 'w/2:100' \
   --greetercolor ffffff --greetersize 30 \
   --pass-volume-keys --pass-media-keys \
   -c 00000000 -B 10 \
   -enu || systemctl suspend

# toggle -n

#===============================================================================
#                             Exp
#===============================================================================

# timeout "$dur"m \
#    ffplay \
#    -volume 0 -exitonkeydown -exitonmousedown -loop "$dur" \
#    -fs ~/.local/share/screensavers/matrix.mp4 \
#    > /dev/null 2>&1 ||
#    systemctl suspend

# xtrlock -f
# timeout 30m xterm -fullscreen -e "sleep 1; cmatrix -s -b -u 10" || systemctl suspend
# timeout 30m xterm -fullscreen -e "sleep 1; rain" || systemctl suspend
# timeout 300 mpv -fs --no-osc --no-audio --loop=inf --no-resume-playback ~/.wallpapers/matrix.mp4 >/dev/null 2>&1 || systectl suspend

# SCREEN=/tmp/screen.png
# ffmpeg -y \
#    -hide_banner \
#    -loglevel error \
#    -f x11grab \
#    -video_size "$(xrandr | awk '(/current/){print $8 "x" $10 }' | sed 's/,//')" \
#    -i "$DISPLAY" \
#    -vframes 1 \
#    $SCREEN
# convert $SCREEN -blur 0x10 $SCREEN
# convert $SCREEN ~/.local/share/images/arch.png -gravity center -composite -matte $SCREEN
# # launch -f $SCREEN
# timeout "$dur"m i3lock -enuc 00000000 -i $SCREEN
