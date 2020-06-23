#!/usr/bin/env sh

# Misc script piled together for ease of calling
# alfred --dg sets wallpapers (options: shuffle,reel,delete)
# alfred --dpi sets the correct dpi

setbg() {
    WALL=/tmp/wall
    REELPID=/tmp/reelpid
    case $1 in
        shuffle)
            find "$WALLPAPERS" -name "*.jpg" -o -name "*.png" | shuf -n1 | tee "$WALL"
            ;;
        reel)
            shift
            [ "$1" = stop ] && kill -9 "$REELPID" && exit
            while :; do
                setbg shuffle
                sleep "$1"
            done
            echo $! > $REELPID
            shift
            ;;
        delete)
            find "$WALLPAPERS" -name "$(cat $WALL)" -delete
            setbg shuffle
            return
            ;;
        *)
            echo "$1" > $WALL
            ;;
    esac
    feh --no-fehbg --bg-scale "$(cat $WALL)"
}

setdpi() {
    file=~/.config/X11/Xresources

    grep 'Xft.dpi' "$file" && xrdb -merge "$file" && return

    info=$(xrandr | grep ' connected')

    width=$(echo "$info" | awk '{print $NF}')
    width_in=$(echo "${width%mm}" | awk '{print $1 * 0.03937007874015748}')

    height=$(echo "$info" | awk '{print $(NF-2)}')
    height_in=$(echo "${height%mm}" | awk '{print $1 * 0.03937007874015748}')

    diagonal_in=$(awk -v w="$width_in" -v h="$height_in" \
        'BEGIN{print sqrt(w^2 + h^2)}')

    px=$(echo "$info" | cut -d ' ' -f 4)

    width_px=${px%x*}

    height_px=${px#*x}
    height_px=${height_px%%+*}

    diagonal_px=$(awk -v w="$width_px" -v h="$height_px" \
        'BEGIN{print sqrt(w^2 +h^2)}')

    dpi=$(awk -v dp="$diagonal_px" -v di="$diagonal_in" \
        'BEGIN{print dp / di}')

    echo "Xft.dpi: $dpi" >> "$file"
    xrdb -merge "$file"
}

while :; do
    case $1 in
        --bg)
            shift
            setbg "$@"
            ;;
        --dpi) setdpi ;;
        *) break ;;
    esac
    shift
done
