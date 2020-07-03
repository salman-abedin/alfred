#!/usr/bin/env sh

# Display related scripts
# setdisplay --bg [shuffle,delete] sets & deletes wallpapers
#   Requires an Environment variable named WALLPAPERS that has the path to your wallpapers
# setdisplay --dpi sets the correct dpi

while :; do
    case $1 in
        --bg)
            WALL=/tmp/wall
            shift
            case $1 in
                shuffle)
                    find "$WALLPAPERS" -name "*.jpg" -o -name "*.png" | shuf -n1 > "$WALL"
                    feh --no-fehbg --bg-scale "$(cat $WALL)"
                    ;;
                delete)
                    find "$WALLPAPERS" -name "$(cat $WALL)" -delete
                    $0 --bg shuffle
                    ;;
                *)
                    echo "$1" > $WALL
                    feh --no-fehbg --bg-scale "$(cat $WALL)"
                    ;;
            esac
            ;;
        --dpi)
            FILE=~/.config/X11/Xresources

            grep 'Xft.dpi' "$FILE" && xrdb -merge "$FILE" && return

            INFO=$(xrandr | grep ' connected')

            WIDTH_MM=$(echo "$INFO" | awk '{print $NF}')
            WIDTH_IN=$(echo "${WIDTH_MM%mm}" | awk '{print $1 * 0.03937007874015748}')

            HEIGHT_MM=$(echo "$INFO" | awk '{print $(NF-2)}')
            HEIGHT_IN=$(echo "${HEIGHT_MM%mm}" | awk '{print $1 * 0.03937007874015748}')

            DIAGONAL_IN=$(awk -v w="$WIDTH_IN" -v h="$HEIGHT_IN" \
                'BEGIN{print sqrt(w^2 + h^2)}')

            PX=$(echo "$INFO" | cut -d ' ' -f 4)

            WIDTH_PX=${PX%x*}

            HEIGHT_PXS=${PX#*x}
            HEIGHT_PX=${HEIGHT_PXS%%+*}

            DIAGONAL_PX=$(awk -v w="$WIDTH_PX" -v h="$HEIGHT_PX" \
                'BEGIN{print sqrt(w^2 +h^2)}')

            DPI=$(awk -v dp="$DIAGONAL_PX" -v di="$DIAGONAL_IN" \
                'BEGIN{print dp / di}')

            echo "Xft.dpi: $DPI" >> "$FILE"
            xrdb -merge "$FILE"
            ;;
        *) break ;;
    esac
    shift
done
