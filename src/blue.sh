#!/bin/sh
#
# Bluetooth related scripts

connect() {
   # doas rfkill unblock bluetooth
   # doas systemctl start bluetooth
   # bluetoothctl power on
   # bluetoothctl scan on

   right=${1:-E8:EC:A3:27:60:15}
   left=${1:-E8:EC:A3:15:05:0D}

   { bluetoothctl connect "$right" || bluetoothctl connect "$left"; } && {
      sleep 2
      uniblocks -u vol
      # bluetoothctl scan off
   }
}

toggle_mic() {
   CARD=$(pactl list short cards | tail -1 | cut -f1)
   if pactl list cards | grep -i "active profile: a2dp_sink" > /dev/null; then
      pactl set-card-profile "$CARD" "headset_head_unit"
   else
      pactl set-card-profile "$CARD" "a2dp_sink"
   fi
}

case $1 in
   --con | -c) connect "$2" ;;
   --tog | -t) toggle_mic ;;
   *) exit 1 ;;
esac
