#!/bin/bash

current_layout=$(setxkbmap -query | grep layout | awk '{ print $2 }')

if [[ "$1" != "toggle" ]]; then
  echo "$current_layout"
  🇺🇸
elif [[ "$current_layout" == "tr" ]]; then
  setxkbmap us
else
  setxkbmap tr
fi
