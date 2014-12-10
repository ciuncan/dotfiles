#!/bin/bash
#
# Quickly switch between a given keyboard layout and the US Qwerty one

OTHER_LAYOUT="tr"
CURRENT=`$HOME/dotfiles/i3/current-xkbmap.sh`

if [ "$CURRENT" = "us" ] ; then
  echo \#2E8B57
else
  echo \#8b0000
fi
