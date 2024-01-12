#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
ADDRESS_DATA="${1:-example.com}"
CA_DATA="$SCRIPT_PATH/priv"

cd "$SCRIPT_PATH"

if ! [ -d keys ]; then
	mkdir keys
fi

cd keys

rm -rf "$ADDRESS_DATA"

mkdir "$ADDRESS_DATA"

cd "$ADDRESS_DATA"

cp "$SCRIPT_PATH"/web.conf .

sed -i 's/%website%/'"$ADDRESS_DATA"'/g' web.conf

shift

tick=2
for address in "$@"; do
	echo 'DNS.'"$tick"' = '"$address" >> web.conf
	tick=$(expr $tick + 1)
done

export WWW_NAME="${WWW_NAME:-web}"
export WWW_CONF="web.conf"
export WWW_SIZE="${WWW_SIZE:-8192}"
export KEYS_PATH="$(pwd)"

cp "$CA_DATA"/ca* . -r
rm -f ./ca.srl

sh "$SCRIPT_PATH"/www.sh

rm -f ca*
