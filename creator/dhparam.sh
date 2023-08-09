#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

set -o verbose

openssl dhparam -out "$SCRIPT_PATH"/priv/services.pem 4096

