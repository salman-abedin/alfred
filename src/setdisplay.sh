#!/bin/sh
#
# Display related scripts
# setdisplay --bg [shuffle,delete] sets & deletes wallpapers
#   Requires an Environment variable named WALLPAPERS that has the path to your wallpapers
# setdisplay --dpi sets the correct dpi

setdpi() {
   FILE=~/.config/X11/Xresources

   grep 'Xft.dpi' "$FILE" && xrdb -merge "$FILE" && return

   INFO=/tmp/display_info
   xrandr | grep ' connected' > $INFO

   WIDTH_MM=$(awk '{print $NF}' $INFO)
   WIDTH_IN=$(echo "${WIDTH_MM%mm}" | awk '{print $1 * 0.03937007874015748}')

   HEIGHT_MM=$(awk '{print $(NF-2)}' $INFO)
   HEIGHT_IN=$(echo "${HEIGHT_MM%mm}" | awk '{print $1 * 0.03937007874015748}')

   DIAGONAL_IN=$(awk -v w="$WIDTH_IN" -v h="$HEIGHT_IN" \
      'BEGIN{print sqrt(w^2 + h^2)}')

   PX=$(cut -d ' ' -f 4 $INFO)

   WIDTH_PX=${PX%x*}

   TEMP_HEIGHT_PX=${PX#*x}
   HEIGHT_PX=${TEMP_HEIGHT_PX%%+*}

   DIAGONAL_PX=$(awk -v w="$WIDTH_PX" -v h="$HEIGHT_PX" \
      'BEGIN{print sqrt(w^2 +h^2)}')

   DPI=$(awk -v dp="$DIAGONAL_PX" -v di="$DIAGONAL_IN" \
      'BEGIN{print dp / di}')

   echo "Xft.dpi: $DPI" >> "$FILE"
   xrdb -merge "$FILE"
   rm $INFO
}

setbg() {
   exec 3> /tmp/wall
   exec 4< /tmp/wall
   case $1 in
      shuffle)
         find "$WALLPAPERS" -name "*.jpg" -o -name "*.png" | shuf -n1 >&3
         feh --no-fehbg --bg-scale "$(cat <&4)"
         ;;
      delete)
         find "$WALLPAPERS" -name "$(cat <&4)" -delete
         setbg shuffle
         ;;
      *)
         echo "$1" >&3
         feh --no-fehbg --bg-scale "$(cat <&4)"
         ;;
   esac
   exec 3<&-
   exec 4<&-
}

case $1 in
   --bg) setbg "$2" ;;
   --dpi) setdpi ;;
esac
