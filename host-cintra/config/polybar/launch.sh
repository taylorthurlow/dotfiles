#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -r cintra-center &
polybar -r cintra-left &
polybar -r cintra-right &
