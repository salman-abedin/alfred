#!/bin/sh
#
# Cleans up the system (cronjob)

doas -n -- pacman -Scc --noconfirm
doas -n -- pacman -Rns --noconfirm $(pacman -Qttdq)
find ~ -xtype l -delete
find ~ -type d -empty -delete
doas -n -- rm -fr \
   /var/cache/pacman/pkg/* \
   /var/log/journal/*

# ~/.local/share/Trash/* \
# ~/.local/share/Trash/.*

# canberra-gtk-play -i trash-empty &
