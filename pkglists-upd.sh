#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
pacman -Qqen > pkglist.txt
pacman -Qqem > pkglist-aur.txt
