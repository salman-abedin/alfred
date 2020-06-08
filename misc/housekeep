#!/usr/bin/env sh

doas -- pacman -Scc --noconfirm
doas -- pacman -Rns "$(pacman -Qtdq)" --noconfirm
doas -- rm -fr ~/.local/share/cache/* /var/log/journal/* ~/.local/share/Trash/.*
doas -- find ~ -xtype l -delete
doas -- find ~ -type d -empty -delete

