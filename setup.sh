#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"
rm -rf created
cp -r creator created

if ! [ -d created/priv ]; then
    mkdir -p created/priv
fi

sh scripts/set.sh res/parser.conf created/www.conf
sh scripts/set.sh res/parser.conf created/ca.conf
