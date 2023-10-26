#!/bin/sh
echo -ne '\033c\033]0;BalaYCastigo\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/BalaYCastigo.x86_64" "$@"
