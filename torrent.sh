#!/usr/bin/env sh

# Torrent  related scripts
# torrent --[add,downloader]

case $1 in
    --add)
        shift
        if ! pidof transmission-daemon > /dev/null; then
            transmission-daemon
            sleep 1
        fi
        transmission-remote -a "$@"
        notify-send -t 1000 -i "$ICONS"/transmission.png \
            "Transmission" "Torrent added"
        ;;
    --downloaded)
        notify-send -t 0 -i "$ICONS"/transmission.png \
            "Transmission" "$TR_TORRENT_NAME Downloaded"
        ;;
esac
