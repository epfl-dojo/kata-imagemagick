# kata-imagemaagick's Makefile
SHELL := /bin/bash

.PHONY: all

all: clean readme_reveal.html

clean:
	rm -f readme_beamer.pdf readme_reveal.html

# Using Pandoc Beamer (pdf)
# https://pandoc.org/MANUAL.html#variables-for-beamer-slides
readme_beamer.pdf: README.md
	# Another theme: theme:Madrid
	pandoc $< -r markdown -t beamer \
		--slide-level=1 \
		--toc \
		--variable aspectratio=169 \
		--variable navigation=horizontal \
		--highlight-style=tango \
		--variable theme:Warsaw \
		--variable colorlinks \
		--variable linkcolor=blue \
		--variable urlcolor=blue \
		-o $@

## Using Pandoc reveal.js
readme_reveal.html: README.md
	pandoc $< --standalone --self-contained \
		-t revealjs \
		--variable revealjs-url="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/" \
		-o $@