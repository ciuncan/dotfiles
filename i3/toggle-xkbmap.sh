#!/bin/bash
#
# Quickly switch between a given keyboard layout and the US Qwerty one

OTHER_LAYOUT="tr"
CURRENT=`$HOME/dotfiles/i3/current-xkbmap.sh`

if [ "$CURRENT" = "us" ] ; then
  setxkbmap -layout $OTHER_LAYOUT -option ctrl:nocaps
else
  setxkbmap -layout us -option ctrl:nocaps
fi
