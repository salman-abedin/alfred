#!/bin/sh
#
# Wifi related scripts
# USAGE: wifi -l | [-c SSID PASS] | -d | -S | -s

WIFI_SSID=c4rn@g3
WIFI_PASS=pqlamz.,

REPEATER_SSID=DIRECT-2D-Android_7e2a
REPEATER_PASS=qqSe18Rt

CJ_SSID="The Color Pink"
CJ_PASS=pink1221

MARINADE_SSID="Cafe Marinade"
MARINADE_PASS=password

CARD=$(ip link | grep -o 'wl.\w*')

run() { iwctl station "$CARD" "$@"; }

case "$1" in
   --dis | -d) run disconnect ;;
   --show | -S) run show ;;
   --scan | -s) run scan ;;
   --list | -l)
      $0 -s
      # sleep 1
      run get-networks
      ;;
   --con | -c)
      $0 -s
      # $0 -d && $0 -s
      # sleep 1
      # run --passphrase "${WIFI_PASS:-$3}" connect "${WIFI_SSID:-$2}"
      run --passphrase "${3:-$WIFI_PASS}" connect "${2:-$WIFI_SSID}"
      $0 -S
      ;;
   --rep | -r) $0 -c $REPEATER_SSID $REPEATER_PASS ;;
   --saraj) $0 -c "$CJ_SSID" "$CJ_PASS" ;;
   --marinade | -m) $0 -c "$MARINADE_SSID" "$MARINADE_PASS" ;;
esac

# CARD=$(awk -F: 'END {gsub(/ /, "", $1); print $1}' /proc/net/wireless)
