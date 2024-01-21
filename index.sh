#!/bin/sh

SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$SCRIPT_PATH"

echo '<!DOCTYPE html>' > index.html
echo '<html lang="en-US">' >> index.html
cat res/head.html >> index.html

echo '<body>' >> index.html
echo '<div>' >> index.html
echo '<div>' >> index.html
markdown README.md >> index.html
echo '</div>' >> index.html
echo '</div>' >> index.html
cat res/credits.html >> index.html
cat res/legacy.html >> index.html
echo '</body>' >> index.html
echo '</html>' >> index.html
