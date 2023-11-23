#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

echo 'Executing setup...'
sh scripts/set.sh res/parser.conf index.html
sh scripts/set.sh res/parser.conf README.md

echo 'Executing certificate launchpad setup...'
sh setup.sh
