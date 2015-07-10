#!/bin/bash -x
is_muted=$(pactl list sinks | grep Mute | head -2 - | tail -1 - | awk '{print $2}')
if [ $is_muted = 'yes' ]; then
  icon="🔇"
else
  icon="🔊"
fi

volume_level=$( pactl list sinks | grep "Volume:" | awk '{print $5}' | head -3 | tail -1 )

echo "$icon $volume_level"
