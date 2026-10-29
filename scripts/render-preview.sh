#!/bin/sh
set -eu
input=${1:-poster.pdf}
output=${2:-assets/preview/poster.png}
mkdir -p "$(dirname "$output")"
if command -v "${PDFTOPPM:-pdftoppm}" >/dev/null 2>&1; then
  "${PDFTOPPM:-pdftoppm}" -f 1 -singlefile -scale-to 2400 -png "$input" "${output%.png}"
elif command -v sips >/dev/null 2>&1; then
  sips -s format png "$input" --out "$output" >/dev/null
  sips -Z 2400 "$output" >/dev/null
else
  printf '%s\n' 'Install Poppler (pdftoppm) to generate the README preview.' >&2
  exit 1
fi
printf 'Preview saved to %s\n' "$output"
