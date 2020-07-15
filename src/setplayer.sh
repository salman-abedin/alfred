#!/bin/sh
#
# Audio controller for spotify & mpd
# Dependencies: playerctl, pulseaudio-alsa(for getting volume levels over 100%)
# Usage: setplayer --play (next|prev|toggle)
#                  --vol (up|down|toggle)

case $1 in
   --play)
      pidof mpd || mpd
      case $2 in
         next) playerctl next || mpc next ;;
         prev) playerctl previous || mpc prev ;;
         toggle) playerctl play-pause || mpd toggle ;;
      esac
      ;;
   --vol)
      case $2 in
         up) pactl set-sink-volume @DEFAULT_SINK@ +10% ;;
         down) pactl set-sink-volume @DEFAULT_SINK@ -10% ;;
         toggle) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
      esac
      canberra-gtk-play -i audio-volume-change
      uniblocks -u vol 2> /dev/null # Personal script (chill & ignore)
      # pkill -35 -f "panel -v" 2> /dev/null # Personal script (chill & ignore)
      # pkill -RTMIN+3 dwmblocks
      ;;
   *) exit 1 ;;
esac
