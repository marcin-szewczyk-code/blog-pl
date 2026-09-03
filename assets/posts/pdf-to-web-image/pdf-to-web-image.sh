#!/usr/bin/env bash
set -e

pdf="$1"
[ -n "$pdf" ] || { echo "Usage: ./pdf-to-web-image.sh example.pdf"; exit 1; }

base="$(basename "$pdf" .pdf)"

pdftoppm -png -r 300 -f 1 -singlefile "$pdf" "${base}-raw"

magick "${base}-raw.png"   -resize 620x   -bordercolor white -border 12   -bordercolor "#e0e0e0" -border 1   -alpha set   \( +clone -background black -shadow 45x4+0+3 \)   +swap -background none -compose over -composite   -strip -quality 92   "${base}-web.png"

echo "OK: ${base}-web.png"
