#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

if ! [ -d keys ]; then
	mkdir keys
fi

cd keys

for X in $(find * -maxdepth 0 -type d); do
	sh "$SCRIPT_PATH"/keycreator.sh "$X" &
done
