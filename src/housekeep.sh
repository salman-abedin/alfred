#!/bin/sh
#
# Cleans up the system (weekly cronjob)

doas -- pacman -Scc --noconfirm
doas -- pacman -Rns --noconfirm $(pacman -Qttdq)
find ~ -xtype l -delete
find ~ -type d -empty -delete
doas -- rm -fr \
   ~/.local/share/Trash/* \
   /var/cache/pacman/pkg/* \
   /var/log/journal/*
