.PHONY: main preview color-previews clean FORCE

main: poster.pdf

poster.pdf: FORCE
	latexmk -lualatex -interaction=nonstopmode -halt-on-error poster.tex

preview: poster.pdf
	sh scripts/render-preview.sh poster.pdf assets/preview/poster.png

color-previews:
	sh scripts/render-color-previews.sh

clean:
	latexmk -pdf -C
