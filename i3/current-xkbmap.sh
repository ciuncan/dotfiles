#!/bin/sh
setxkbmap -query | grep layout | perl -pe 's/^layout: +([^ ]+)$/$1/'
