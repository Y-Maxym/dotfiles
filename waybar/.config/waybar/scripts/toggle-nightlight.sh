#!/bin/bash

STATE_FILE="$XDG_RUNTIME_DIR/nightlight_state"

if [[ -f "$STATE_FILE" ]]; then
    hyprctl hyprsunset identity
    rm "$STATE_FILE"
else
    hyprctl hyprsunset temperature 5000
    touch "$STATE_FILE"
fi
