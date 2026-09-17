#!/bin/bash

STATE_FILE="$XDG_RUNTIME_DIR/nightlight_state"

if [[ -f "$STATE_FILE" ]]; then
    echo '{"text": "󰈈", "class": "active"}'
else
    echo '{"text": "󰈉", "class": "inactive"}'
fi
