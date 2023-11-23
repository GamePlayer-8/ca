#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
DH_NAME="${DH_NAME:-services}"

cd "$SCRIPT_PATH"

set -o verbose

openssl dhparam -out priv/"$DH_NAME".pem 8192

