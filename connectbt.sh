#!/usr/bin/env sh

doas rfkill unblock bluetooth
doas systemctl start bluetooth
bluetoothctl power on

right=${1:-E8:EC:A3:27:60:15}
left=${1:-E8:EC:A3:15:05:0D}

bluetoothctl connect "$right" ||
    bluetoothctl connect "$left"

bluetoothctl scan off

sleep 2
uniblocks -r v
