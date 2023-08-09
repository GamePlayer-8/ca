#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

mkdir -p "$SCRIPT_PATH"/priv 2>/dev/null 3>&2

if ! [ "$1" == "no-dhparam" ]; then
    sh "$SCRIPT_PATH"/dhparam.sh
fi

set -o verbose

openssl genrsa -out "$SCRIPT_PATH"/priv/services.key 16384
openssl req -new -sha256 -key "$SCRIPT_PATH"/priv/services.key -config "$SCRIPT_PATH"/services-configured.conf -extensions 'x509_conf' -out "$SCRIPT_PATH"/priv/services.csr
openssl x509 -req -in "$SCRIPT_PATH"/priv/services.csr -CA "$SCRIPT_PATH"/../ca/certificate.crt -CAkey "$SCRIPT_PATH"/priv/ca.key -CAcreateserial -out "$SCRIPT_PATH"/../ca/services.crt -extfile "$SCRIPT_PATH"/services-configured.conf -extensions 'x509_conf' -days 365 -sha256
