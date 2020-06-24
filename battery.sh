#!/usr/bin/env sh

# Monitors Battery level,
# Blocks Charging on High battery level
# Notifies on Plug and Unplug (Udev Script)

case $1 in
    --block-charge)
        config="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
        if [ "$2" = true ]; then
            echo 1
        else
            echo 0
        fi | doas tee $config > /dev/null
        ;;
    --monitor)
        [ "$(cat /sys/class/power_supply/ADP?/online > /dev/null)" = 1 ] && return
        cap=$(cat /sys/class/power_supply/BAT?/capacity)
        if [ "$cap" -lt 10 ]; then
            doas systemctl poweroff
        elif [ "$cap" -lt 20 ]; then
            notify-send -t 0 -i "$ICONS"/critical.png 'Low Battery!'
        elif [ "$cap" -lt 90 ]; then
            $0 --block-charge false
        else
            $0 --block-charge true
        fi
        ;;
    --plugged)
        export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
        if [ "$2" = true ]; then
            /usr/bin/notify-send -t 3000 -i ~/.icons/system/charging.png "Charging"
        else
            /usr/bin/notify-send -t 3000 -i ~/.icons/system/discharging.png "Discharging"
        fi
        ;;
esac
