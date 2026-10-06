#!/usr/bin/env bash
cache="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist-thumbs"
mkdir -p "$cache"
meta_re='^[0-9]+[[:space:]]\[\[ binary data ([0-9.]+ [KMGT]?i?B) (png|jpe?g|gif|bmp|webp) ([0-9]+x[0-9]+) \]\]$'

prune_cache() {
    local -A keep=()
    local line id f
    for line in "${entries[@]}"; do
        keep["${line%%$'\t'*}"]=1
    done
    for f in "$cache"/*; do
        [[ -e "$f" ]] || continue
        id="${f##*/}"
        id="${id%.*}"
        [[ -n "${keep[$id]}" ]] || rm -f -- "$f"
    done
}

mapfile -t entries < <(cliphist list)
prune_cache
[[ ${#entries[@]} -eq 0 ]] && exit 0

render() {
    local line id file label
    for line in "${entries[@]}"; do
        if [[ "$line" =~ $meta_re ]]; then
            id="${line%%$'\t'*}"
            file="$cache/$id.${BASH_REMATCH[2]}"
            [[ -f "$file" ]] || printf '%s' "$line" | cliphist decode > "$file"
            label="Image ${BASH_REMATCH[3]} · ${BASH_REMATCH[2]} · ${BASH_REMATCH[1]}"
            printf '%s\0icon\x1f%s\n' "$label" "$file"
        else
            printf '%s\n' "${line#*$'\t'}"
        fi
    done
}

float_exec() {
    local before addr=""
    before=$(hyprctl clients -j | jq -r '.[].address' | sort)
    hyprctl dispatch "hl.dsp.exec_cmd('$1', { float = true, center = true, size = { 'monitor_w * 0.4', 'monitor_h * 0.5' } })" >/dev/null

    # find the window that just appeared
    for _ in $(seq 20); do
        sleep 0.1
        addr=$(comm -13 <(printf '%s\n' "$before") \
            <(hyprctl clients -j | jq -r '.[].address' | sort) | head -n1)
        [[ -n "$addr" ]] && break
    done

    # wait until it is closed
    while [[ -n "$addr" ]] && hyprctl clients -j \
            | jq -e --arg a "$addr" 'any(.[]; .address == $a)' >/dev/null; do
        sleep 0.3
    done
}

preview() {
    local line="$1" id file
    id="${line%%$'\t'*}"
    if [[ "$line" =~ $meta_re ]]; then
        file="$cache/$id.${BASH_REMATCH[2]}"
        float_exec "imv -b 141419 $file"
    else
        file="$cache/$id.txt"
        printf '%s' "$line" | cliphist decode > "$file"
        float_exec "kitty --title Clipboard-preview -o confirm_os_window_close=0 less -R $file"
    fi
}

sel=0
while true; do
    out=$(render | rofi -dmenu -show-icons -p "Clipboard" \
        -format i -selected-row "$sel" \
        -kb-custom-1 "Control+s,Control+Cyrillic_yeru,Control+Ukrainian_i" \
        -theme-str 'element-icon { size: 36px; } listview { lines: 6; fixed-height: false; cycle: false; }' \
        -hover-select -me-select-entry '' -me-accept-entry 'MousePrimary')
    code=$?
    [[ -z "$out" ]] && exit 0
    [[ "$out" =~ ^[0-9]+$ ]] || continue
    sel="$out"
    case $code in
        0)  printf '%s' "${entries[$sel]}" | cliphist decode | wl-copy; exit 0 ;;
        10) preview "${entries[$sel]}" ;;
        *)  exit 0 ;;
    esac
done
