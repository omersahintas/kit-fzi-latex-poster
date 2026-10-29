#!/bin/sh
# Render each supported palette without changing poster.tex or poster.pdf.
set -eu
cd "$(dirname "$0")/.."
if [ "$#" -eq 0 ]; then
  set -- kit-green kit-blue kit-black70 fzi-green
fi
for palette in "$@"; do
  case "$palette" in
    kit-green|kit-blue|kit-black70|fzi-green) ;;
    *) printf 'Unknown palette: %s\n' "$palette" >&2; exit 1 ;;
  esac
  build_dir=".build/colors/$palette"
  mkdir -p "$build_dir"
  printf '\\def\\kitfzipalette{%s}\n\\def\\kitfzicolormodel{rgb}\n\\input{poster.tex}\n' "$palette" > "$build_dir/preview.tex"
  printf 'Building %s...\n' "$palette"
  if ! latexmk -lualatex -interaction=nonstopmode -halt-on-error \
      -outdir="$build_dir" "$build_dir/preview.tex" > "$build_dir/build.log" 2>&1; then
    cat "$build_dir/build.log" >&2
    exit 1
  fi
  sh scripts/render-preview.sh "$build_dir/preview.pdf" "assets/preview/colors/$palette.png"
done
