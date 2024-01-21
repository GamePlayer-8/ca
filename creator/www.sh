#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
KEYS_PATH="${KEYS_PATH:-$SCRIPT_PATH/priv}"
CA_NAME="${CA_NAME:-ca}"
CA_PASSWD="${CA_PASSWD:-ca.passwd}"
WWW_NAME="${WWW_NAME:-services}"
WWW_CONF="${WWW_CONF:-../www.conf}"
WWW_SIZE="${WWW_SIZE:-16384}"

if ! [ -d "$KEYS_PATH" ]; then
    mkdir -p "$KEYS_PATH"
fi

cd "$KEYS_PATH"

passwd_err() {
    echo 'Key not found!'
    echo 'Please check your CA KEY.'
    exit 2
}

if ! [ -f "$CA_NAME".key ]; then
    echo "CA key '$CA_NAME.key' not found!"
    exit 3
fi

if ! [ -f "$CA_NAME".crt ]; then
    echo "CA certificate '$CA_NAME.crt' not found!"
    exit 4
fi

if [ -f "$CA_PASSWD" ]; then
    CA_PASSWD="$(cat "$CA_PASSWD")"
    if [ -z "$CA_PASSWD" ]; then
        passwd_err
    else
        CA_PASSWD="$(echo "$CA_PASSWD" | base64 -d)"
    fi
else
    passwd_err
fi

TMP_PASSWD=/tmp/"$(date +%s).p.tmp"

if ! [ -f "$WWW_NAME".key ]; then
    openssl genrsa \
            -out "$WWW_NAME".key $WWW_SIZE
    openssl req \
            -new \
            -sha256 \
            -key "$WWW_NAME".key \
            -config "$WWW_CONF" \
            -extensions 'x509_conf' \
            -out "$WWW_NAME".csr
fi
if ! [ -f "$WWW_NAME".crt ]; then
    echo "$CA_PASSWD" > "$TMP_PASSWD"
    openssl x509 \
            -req \
            -in "$WWW_NAME".csr \
            -CA "$CA_NAME".crt \
            -CAkey "$CA_NAME".key \
            -CAcreateserial \
            -passin "file:$TMP_PASSWD" \
            -out "$WWW_NAME".crt \
            -extfile "$WWW_CONF" \
            -extensions 'x509_conf' \
            -days 365 \
            -sha256
    rm -f "$TMP_PASSWD"
fi
