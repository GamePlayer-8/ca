#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

mkdir -p "$SCRIPT_PATH"/creator/priv
cp -r "$SCRIPT_PATH"/creator "$SCRIPT_PATH"/creator-ready

sh "$SCRIPT_PATH"/scripts/set.sh "$SCRIPT_PATH"/docs/parser.conf "$SCRIPT_PATH"/creator-ready/services.conf
sh "$SCRIPT_PATH"/scripts/set.sh "$SCRIPT_PATH"/docs/parser.conf "$SCRIPT_PATH"/creator-ready/ca.conf

# Disable for actions
#sh "$SCRIPT_PATH"/creator-ready/main.sh
#sh "$SCRIPT_PATH"/creator-ready/services.sh
