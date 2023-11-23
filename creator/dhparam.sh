#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
KEYS_PATH="${KEYS_PATH:-$SCRIPT_PATH/priv}"
DH_NAME="${DH_NAME:-www}"
DH_SIZE="${DH_SIZE:-8192}"

if ! [ -d "$KEYS_PATH" ]; then
    mkdir -p "$KEYS_PATH"
fi

cd "$KEYS_PATH"

openssl dhparam -out "$DH_NAME".pem $DH_SIZE

