#!/bin/bash

amixer set Speaker unmute
amixer set "Bass Speaker" unmute
amixer set Headphone unmute

MUTE_STATUS=$(amixer get Master mute | tail -n 1 | cut -d ' ' -f 8)
if [[ "$MUTE_STATUS" == '[off]' ]]; then
  amixer set Master unmute
  notify-send -t 2000 -u low "Unmuted audio."
else
  amixer set Master mute
  notify-send -t 2000 -u low "Muted audio."
fi
