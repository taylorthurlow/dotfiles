#!/bin/bash

if [[ "$1" == 'up' ]]; then
  amixer set Master 5%+
else
  amixer set Master 5%-
fi

VOLUME=$(amixer sget Master | tail -1 | ag -o '\[([0-9%]{2,3})\]')

notify-send -t 250 -u low "Volume: ${VOLUME:1:-1}"
