#!/bin/bash

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

mkdir -p "$SCRIPT_PATH"/priv 2>/dev/null 3>&2

set -o verbose

openssl genrsa -aes256 -out "$SCRIPT_PATH"/priv/ca.key 16384
openssl req -x509 -new -nodes -key "$SCRIPT_PATH"/priv/ca.key -sha256 -days 1095 -config "$SCRIPT_PATH"/ca.conf -out "$SCRIPT_PATH"/../ca/certificate.crt

rm -f "$SCRIPT_PATH"/../ca/certificate.srl
