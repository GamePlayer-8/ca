#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

export CA_SIZE=2048
export WWW_SIZE=2048

sh created/ca.sh
sh created/www.sh
