#!/bin/sh
#
# connects to wifi using iwd
# USAGE: wifi -c SSID PASS
#        wifi -d

CARD="$(ip link | grep -o 'w.*:' | tr -d ':')"
case "$1" in
   --con | -c)
      iwctl station "$CARD" get-networks
      iwctl --passphrase "${PASS:-$2}" station "$CARD" connect "${SSID:-$1}"
      ;;
   --dis | -d) iwctl station "$CARD" disconnect ;;
esac
