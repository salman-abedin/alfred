#!/bin/sh
#
# Audio controller for spotify & mpd
#
# Dependencies:playerctl, pulseaudio-alsa(for getting volume levels over 100%)
#               canberra-gtk-play [optional] (for audible notification)
#
# Usage: setplayer --play (next|prev|toggle)
#                  --vol (up|down|toggle)

silence() { "$@" > /dev/null 2>&1; }

case $1 in
   --play)
      silence pidof mpd || silence mpd
      case $2 in
         next) silence playerctl next || silence mpc next ;;
         prev) silence playerctl previous || silence mpc prev ;;
         toggle) silence playerctl play-pause || silence mpc toggle ;;
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
      ;;
   *) exit 1 ;;
esac

#===============================================================================
#                             Exp
#===============================================================================

# pkill -35 -f "panel -v" 2> /dev/null
