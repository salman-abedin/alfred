#!/bin/sh
#
# Explore using fzf

dir=${1:-$PWD}
last_dir=$dir
export FZF_DEFAULT_OPTS="-i --reverse --border --info hidden --cycle --margin 15%,30% --bind=tab:down,btab:up"

while :; do
   cd "$dir" 2> /dev/null || launch -f "$(realpath "$dir")"
   dir=$(
      for file in * .*; do
         [ "$file" != . ] && echo "$file"
      done |
         fzf --prompt "explore: " --bind "]:execute(lf $(realpath {})),[:execute(exit)"
   ) || break
   last_dir=$dir
done
last_dir=$(readlink -f "$last_dir")
# realpath "$last_dir"
# ns "$(realpath "$last_dir")"

# fzf --prompt "explore: " --bind "]:execute(lf $(realpath {})),[:execute(tmux split-window -h \; swap-pane -d -t :.1)"

#===============================================================================
#                             Exp
#===============================================================================

# Explore files on lf using the last visited path
# LAST_PATH=~/.local/share/LF_LAST_PATH
# if [ "$*" ]; then
#    lf -last-dir-path $LAST_PATH "$*"
# else
#    lf -last-dir-path $LAST_PATH "$(cat $LAST_PATH)"
# fi
