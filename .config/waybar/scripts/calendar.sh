#!/usr/bin/env bash
tput civis
trap 'tput cnorm' EXIT

m=$(date +%-m); y=$(date +%Y)

shift_month() {
  m=$((m + $1))
  if   (( m > 12 )); then m=1;  y=$((y + 1))
  elif (( m < 1  )); then m=12; y=$((y - 1))
  fi
}

while true; do
  clear
  cal -3m "$m" "$y"
  read -rsn1 k
  if [[ $k == $'\e' ]]; then
    read -rsn2 -t 0.05 seq
    case $seq in
      '[C') shift_month 1 ;;     # →
      '[D') shift_month -1 ;;    # ←
      '[A') y=$((y + 1)) ;;      # ↑
      '[B') y=$((y - 1)) ;;      # ↓
      '')   exit 0 ;;            # Esc
    esac
  else
    case $k in
      l) shift_month 1 ;;
      h) shift_month -1 ;;
      k) y=$((y + 1)) ;;
      j) y=$((y - 1)) ;;
      t) m=$(date +%-m); y=$(date +%Y) ;;
      q) exit 0 ;;
    esac
  fi
done
