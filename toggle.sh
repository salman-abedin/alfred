#!/usr/bin/env sh

# Toggles Wifi & Notification

while :; do
    case $1 in
        --noti)
            if [ -s "$DONT_DISTURB_MODE" ]; then
                : > "$DONT_DISTURB_MODE"
                killall -SIGUSR2 dunst
                sleep 1
                notify-send -t 1000 -i "$ICONS"/bell.png 'Disturb all you want'
            else
                echo on > "$DONT_DISTURB_MODE"
                notify-send -t 1000 -i "$ICONS"/dnd.png 'Do not disturb'
                sleep 2
                killall -SIGUSR1 dunst
            fi
            refresh-block 3
            ;;
        --wifi)
            if pidof iwd; then
                doas systemctl stop iwd
                notify-send -i "$ICONS"/disconnected.png 'Turned Wifi Off'
            else
                doas systemctl start iwd
                notify-send -i "$ICONS"/connected.png 'Turned Wifi On'
            fi
            ;;
        *) break ;;
    esac
    shift
done
