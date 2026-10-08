#!/usr/bin/env bash
# Wallpaper + palette picker (rofi): 1) grid of wallpapers, 2) row of palette cards (source colors found in the image).
# Enter on a wallpaper opens the palette row, Enter on a palette applies both via matugen, Esc goes one step back.
dir="$HOME/Pictures/wallpapers"
rofi_dir="$HOME/.config/rofi"
cache_dir="$HOME/.cache/matugen-picker"

pick_image() {
    find "$dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -printf '%f\n' | sort |
    while read -r file; do
        printf '%s\0icon\x1f%s\n' "$file" "$dir/$file"
    done |
    rofi -dmenu -i -show-icons -p "Wallpaper" -theme "$rofi_dir/wallpaper.rasi"
}

pick_palette() {
    local img="$1" cache choice rc i n hex src a b c s svg
    local -a rows
    cache="$cache_dir/v3-$(basename "$img").$(stat -c %Y "$img")"

    # Cache line: source color + primary, raised surface, tertiary, surface of its palette.
    # The image is read once (to find the candidates); the palettes come from the source colors alone.
    if [[ ! -s "$cache" ]]; then
        mkdir -p "$cache_dir"
        matugen image "$img" --dry-run --show-source-colors 2>/dev/null | grep -o -E '#[0-9a-fA-F]{6}' |
        while read -r hex; do
            printf '%s %s\n' "$hex" "$(matugen color hex "$hex" --dry-run --json hex 2>/dev/null < /dev/null |
                jq -r '.colors | [.primary.default.color, .surface_container_high.default.color, .tertiary.default.color, .surface.default.color] | join(" ")')"
        done > "$cache"
    fi

    mapfile -t rows < "$cache"
    n=${#rows[@]}
    if (( n == 0 )); then echo 0; return 0; fi

    # One small SVG card per variant: surface background, primary on top, raised surface and tertiary below
    for i in "${!rows[@]}"; do
        read -r src a b c s <<< "${rows[$i]}"
        svg="$cache.$i.svg"
        [[ -s "$svg" ]] || printf '<svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" viewBox="0 0 120 120"><rect width="120" height="120" rx="14" fill="%s"/><rect x="10" y="10" width="100" height="52" rx="8" fill="%s"/><rect x="10" y="68" width="48" height="42" rx="8" fill="%s"/><rect x="62" y="68" width="48" height="42" rx="8" fill="%s"/></svg>\n' "${s:-#222222}" "${a:-#888888}" "${b:-#888888}" "${c:-#888888}" > "$svg"
    done

    # Window width follows the number of variants: n * (icon 140 + 16) + (n - 1) * 10 + 28
    choice=$(
        for i in "${!rows[@]}"; do
            read -r src _ <<< "${rows[$i]}"
            printf '%s\0icon\x1f%s\n' "$src" "$cache.$i.svg"
        done |
        rofi -dmenu -show-icons -format i -p "Palette" -theme "$rofi_dir/palette.rasi" -theme-str "window { width: $((166 * n + 18))px; } listview { columns: $n; }"
    )
    rc=$?
    [[ $rc -eq 0 ]] && echo "$choice"
    return $rc
}

while true; do
    image=$(pick_image) || exit 0
    [[ -z "$image" ]] && exit 0
    index=$(pick_palette "$dir/$image") || continue
    [[ -z "$index" ]] && continue
    exec matugen image "$dir/$image" --source-color-index "$index"
done
