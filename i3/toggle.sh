#!/usr/bin/env sh
if pgrep -x "polybar" > /dev/null; then
    pkill polybar
else
    nohup polybar top >/dev/null 2>&1 &
fi
