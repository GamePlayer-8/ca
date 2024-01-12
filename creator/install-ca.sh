#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

CA_FILE="priv/ca.crt"

if ! [ -d /etc/ssl/certs ]; then
	mkdir -p /etc/ssl/certs
fi

cat "$CA_FILE" >> /etc/ssl/certs/ca-certificates.crt
cat "$CA_FILE" >> /etc/ssl/cert.pem
