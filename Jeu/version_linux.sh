#!/bin/sh
printf '\033c\033]0;%s\a' Nouveau projet de jeu
base_path="$(dirname "$(realpath "$0")")"
"$base_path/version_linux.x86_64" "$@"
