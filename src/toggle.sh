#!/bin/sh
#
# Toggles Wifi, Notification & Wallpaper reeling
# toggle --[noti,wifi,wall-reel]

DDM=/tmp/ddm

wallreel() {
   REELPID=/tmp/reelpid
   if [ -s $REELPID ]; then
      kill -9 "$(cat $REELPID)"
      : > $REELPID
      notify-send -u low -i "$ICONS"/wall.png "Wallpaper Reeling Stopped"
   else
      notify-send -u low -i "$ICONS"/wall.png "Wallpaper Reeling Started"
      while :; do
         setdisplay --bg shuffle
         sleep 5m
      done &
      echo $! > $REELPID
   fi
}

notifications() {
   if [ -s "$DDM" ]; then
      : > "$DDM"
      killall -SIGUSR2 dunst
      sleep 1
      notify-send -u low -i "$ICONS"/bell.png 'Disturb all you want'
   else
      echo on > "$DDM"
      notify-send -u low -i "$ICONS"/dnd.png 'Do not disturb'
      sleep 2
      killall -SIGUSR1 dunst
   fi
   # uniblocks -u noti
}

wifi() {
   if pidof iwd > /dev/null; then
      doas systemctl stop iwd
      notify-send -u low -i "$ICONS"/disconnected.png 'Turned Wifi Off'
   else
      doas systemctl start iwd
      notify-send -u low -i "$ICONS"/connected.png 'Turned Wifi On'
   fi
}

focusmode() {
   if [ -s "$DDM" ]; then
      xdo show -a "$STATUSBAR"
      bspc config top_padding 35
   else
      xdo hide -a "$STATUSBAR"
      bspc config top_padding 0
   fi
   tmux set status
   wallreel
   wifi
   notifications
}

while :; do
   case $1 in
      --wall-reel | -r) wallreel ;;
      --noti | -n) notifications ;;
      --wifi | -w) wifi ;;
      --focus-mode | -f) focusmode ;;
      *) break ;;
   esac
   shift
done
