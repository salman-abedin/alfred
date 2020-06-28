#!/usr/bin/env sh

# Toggles Wifi & Notification
# toggle --[noti,wifi,wall-reel]

while :; do
    case $1 in
        --wall-reel | -r)
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
            ;;
        --noti | -n)
            if [ -s "$DONT_DISTURB_MODE" ]; then
                : > "$DONT_DISTURB_MODE"
                killall -SIGUSR2 dunst
                sleep 1
                notify-send -u low -i "$ICONS"/bell.png 'Disturb all you want'
            else
                echo on > "$DONT_DISTURB_MODE"
                notify-send -u low -i "$ICONS"/dnd.png 'Do not disturb'
                sleep 2
                killall -SIGUSR1 dunst
            fi
            refresh-block 3
            ;;
        --wifi | -w)
            if pidof iwd; then
                doas systemctl stop iwd
                notify-send -u low -i "$ICONS"/disconnected.png 'Turned Wifi Off'
            else
                doas systemctl start iwd
                notify-send -u low -i "$ICONS"/connected.png 'Turned Wifi On'
            fi
            ;;
        *) break ;;
    esac
    shift
done
