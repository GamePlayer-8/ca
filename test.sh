#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

export CA_SIZE=2048
export WWW_SIZE=2048
export DH_SIZE=2048

sh -x created/ca.sh
sh -x created/www.sh
sh -x created/dhparam.sh
