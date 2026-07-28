#!/usr/bin/env sh
if pgrep -x "waybar" > /dev/null; then
    pkill waybar
else
    nohup waybar >/dev/null 2>&1 &
fi
