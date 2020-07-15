#!/bin/sh
#
# Forked from Luke Smith.
# Compiles Files based on their extensions
# 'compile --clean' cleans up on exit (Vim autocommand)

[ "$1" = --clean ] && shift && clean=true
path=$(readlink -f "$1")
# name="${path%.*}"
ext="${path##*.}"
dir="${path%/*}"

cd "$dir" || exit 1

[ "$clean" ] &&
   case $ext in
      tex) rm -f ./*.out ./*.log ./*.aux ./*.toc ;;
      c) rm -f "$dir/a.out" ;;
   esac && exit

makefile() {
   found=$(find . -name Makefile | wc -l)
   if [ "$found" = 1 ]; then
      doas make install
   else
      cd ..
      doas make install
   fi
}

case $ext in
   c | h | sh) makefile ;;
   py) python "$path" ;;
   tex) xelatex "$path" ;;
   lua) lua "$path" ;;
   txt) wc -w "$path" ;;
      # c) gcc -Wall "$path" -lxcb ;;
      # c) cc "$path" ;;
      # c) cc "$path" -o "$name" && "$name" ;;
      # ms) groff -ms -ept -K utf8 "$path" > "$name".ps ;;
      # js) node "$path" ;;
      # sass) sassc -a "$path" "$name.css" ;;
      # sh) sh "$path" ;;
      # ms) groff -m ms -T pdf "$path" > "$name".pdf ;;
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
