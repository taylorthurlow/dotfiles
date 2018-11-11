#!/bin/bash

amixer set Master toggle
amixer set Speaker unmute
amixer set "Bass Speaker" unmute
amixer set Headphone unmute
if [[ "$(pacmd list-sinks | ag muted | cut -d ' ' -f2)" == 'yes' ]]; then
  notify-send -t 2000 -u low "Muted audio."
else
  notify-send -t 2000 -u low "Unmuted audio."
fi
