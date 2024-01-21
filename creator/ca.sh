#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
KEYS_PATH="${KEYS_PATH:-$SCRIPT_PATH/priv}"
CA_NAME="${CA_NAME:-ca}"
CA_CONF="${CA_CONF:-../ca.conf}"
CA_PASSWD="${CA_PASSWD:-ca.passwd}"
CA_SIZE="${CA_SIZE:-16384}"

if ! [ -d "$KEYS_PATH" ]; then
    mkdir -p "$KEYS_PATH"
fi

cd "$KEYS_PATH"

gen_random_passwd() {
    local new_passwd="$(head /dev/urandom | \
                        tr -dc A-Za-z0-9 | \
                        head -c 68719476736)"
    echo "$new_passwd"
    if [ -z "$CA_PASSWD" ]; then
        CA_PASSWD=ca.passwd
    fi
    if [ -d "$CA_PASSWD" ]; then
        echo 'CA_PASSWD is a directory.' >&2
        echo "CA_PASSWD value is: $CA_PASSWD" >&2
        exit 2
    fi
    local passwd_dir="$(dirname "$CA_PASSWD")"
    if ! [ -z "$passwd_dir" ]; then
        if ! [ -d "$passwd_dir" ]; then
            mkdir -p "$passwd_dir"
        fi
    fi
    local base64_passwd="$(echo "$new_passwd" | base64)"
    if [ -f "$CA_PASSWD" ]; then
        mv "$CA_PASSWD" "$CA_PASSWD"."$(date +%s)".old
    fi
    echo "$base64_passwd" > "$CA_PASSWD"
}

if [ -f "$CA_PASSWD" ]; then
    CA_PASSWD="$(cat "$CA_PASSWD")"
    if [ -z "$CA_PASSWD" ]; then
        CA_PASSWD="$(gen_random_passwd)"
    else
        CA_PASSWD="$(echo "$CA_PASSWD" | base64 -d)"
    fi
else
    CA_PASSWD="$(gen_random_passwd)"
fi

TMP_PASSWD=/tmp/"$(date +%s).p.tmp"

echo "$CA_PASSWD" > "$TMP_PASSWD"

if ! [ -f "$CA_NAME".key ]; then
    openssl genrsa \
            -aes256 \
            -passout "file:$TMP_PASSWD" \
            -out "$CA_NAME".key $CA_SIZE
fi
if ! [ -f "$CA_NAME".crt ]; then
    openssl req \
            -x509 \
            -new \
            -nodes \
            -CAcreateserial \
            -key "$CA_NAME".key \
            -passin "file:$TMP_PASSWD" \
            -sha256 \
            -days 1095 \
            -config "$CA_CONF" \
            -addext basicConstraints=critical,CA:TRUE,pathlen:0 \
            -out "$CA_NAME".crt
fi

rm -f "$TMP_PASSWD"
