#!/usr/bin/env sh

# Forked from Luke Smith.

path=$(readlink -f "$1")
name="${path%.*}"
ext="${path##*.}"
# dir="${path%/*}"

case $ext in
   c)  cc "$path" -o "$name" && "$name" ;;
   h|sh) doas make install ;;
   js) node "$path" ;;
   ms) groff -ms -ept "$path" > "$name".ps ;;
   py)  python "$path" ;;
   sass) sassc -a "$path" "$name.css" ;;
   tex) xelatex "$path" ;;
   # sh) sh "$path" ;;
   # ms) groff -m ms -T pdf "$path" > "$name".pdf ;;
   # ms) groff -m ms -T ps "$path" > "$name".ps ;;
   # ms) eqn "$path" -T pdf | groff -ms -T pdf > "$name".pdf ;;
   # c)  tcc "$path" -o "$name" && "$TERMINAL" -e sh -c "$name; read -r line" ;;
      # scss) sassc "$path" "$name.css" ;;
      # ts)     tsc "$file";;
      # c)      gcc $file && $TERMINAL -e sh -c "" ;;
      # [rR]md) Rscript -e "require(rmarkdown); rmarkdown::render('$file', quiet=TRUE)" ;;
      # ms)     groff -ms -T pdf $file > $name.pdf ;;
      # ms)     eqn $file -T pdf | groff -ms -T pdf > $name.pdf ;;
      # md)     pandoc $file --pdf-engine=xelatex -o $name.pdf ;;
      # ms)     refer -PS -e $file | groff -me -ms -kept -T pdf > $name.pdf ;;
      # mom)    refer -PS -e $file | groff -mom -kept -T pdf > $name.pdf ;;
esac
