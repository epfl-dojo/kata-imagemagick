# kata-imagemaagick's Makefile
SHELL := /bin/bash

.PHONY: all init

GALDIR=images/gallery
GALLERY=adrien-olichon-iHXO2bccJcw-unsplash.jpg \
        cameron-venti-ISqTudqZERQ-unsplash.jpg \
        chris-mok-cr-mok-h_-JUPC_B6w-unsplash.jpg \
        juan-ordonez-rvMXPHXpdeI-unsplash.jpg \
        kon-karampelas-QDPnhYAS0xA-unsplash.jpg \
        library-of-congress-dB8hFMYTT9U-unsplash.jpg \
        lycs-architecture-wUa5QIuKnno-unsplash.jpg \
        nice-m-nshuti-KAlqieElnpc-unsplash.jpg \
        pascal-meier-tXpD84c8ZwI-unsplash.jpg \
        pat-whelen-HOWfdzh1Q0g-unsplash.jpg \
        ricardo-gomez-angel-96--kK-c5KY-unsplash.jpg
GALFILES=$(addprefix $(GALDIR)/,$(GALLERY))

PRESFILES=$(addprefix img/, CB.jpg CB_com.jpg CB_wm1.jpg CB_wm2.jpg CB_wm3.jpg dojoman.png)

all: clean readme_reveal.html readme_beamer.pdf
slide: clean readme_reveal.html
pdf: clean readme_beamer.pdf

clean:
	rm -f readme_beamer.pdf readme_reveal.html

# Using Pandoc Beamer (pdf)
# https://pandoc.org/MANUAL.html#variables-for-beamer-slides
readme_beamer.pdf: README.md init $(PRESFILES)
	# Another theme: theme:Madrid
	pandoc $< -r markdown -t beamer \
		--slide-level=1 \
		--toc \
		--variable aspectratio=169 \
		--variable navigation=horizontal \
		--highlight-style=tango   \
		--variable theme:Warsaw   \
		--variable colorlinks     \
		--variable linkcolor=blue \
		--variable urlcolor=blue  \
		-o $@

## Using Pandoc reveal.js
readme_reveal.html: README.md init $(PRESFILES) 
	pandoc $< --standalone --self-contained \
		-t revealjs \
		--variable revealjs-url="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/" \
		--variable  slideNumber=true  \
		--variable     progress=true  \
		--variable        theme=night \
		--variable        width=1600  \
		--variable       height=700   \
		-o $@

init: $(GALDIR) $(GALFILES) images/dojoman.png images/MarilynMonroe.jpg

images:
	mkdir -p $@

$(GALDIR):
	mkdir -p $@

images/dojoman.png: images
	curl -L --progress-bar -o $@ "https://upload.wikimedia.org/wikipedia/commons/4/46/Marilyn_Monroe_in_1952_TFA.jpg"

images/MarilynMonroe.jpg: images
	curl -L --progress-bar -o $@ "https://gitlab.com/epfl-dojo/dojo-design/-/raw/master/dojoman/dojoman.png"

$(GALDIR)/adrien-olichon-iHXO2bccJcw-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/iHXO2bccJcw/download?force=true"

$(GALDIR)/cameron-venti-ISqTudqZERQ-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/ISqTudqZERQ/download?force=true"

$(GALDIR)/chris-mok-cr-mok-h_-JUPC_B6w-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/h_-JUPC_B6w/download?force=true"

$(GALDIR)/juan-ordonez-rvMXPHXpdeI-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/rvMXPHXpdeI/download?force=true"

$(GALDIR)/kon-karampelas-QDPnhYAS0xA-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/QDPnhYAS0xA/download?force=true"

$(GALDIR)/library-of-congress-dB8hFMYTT9U-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/dB8hFMYTT9U/download?force=true"

$(GALDIR)/lycs-architecture-wUa5QIuKnno-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/wUa5QIuKnno/download?force=true"

$(GALDIR)/nice-m-nshuti-KAlqieElnpc-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/KAlqieElnpc/download?force=true"

$(GALDIR)/pascal-meier-tXpD84c8ZwI-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/tXpD84c8ZwI/download?force=true"

$(GALDIR)/pat-whelen-HOWfdzh1Q0g-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/HOWfdzh1Q0g/download?force=true"

$(GALDIR)/ricardo-gomez-angel-96--kK-c5KY-unsplash.jpg: $(GALDIR)
	curl -L --progress-bar -o $@ "https://unsplash.com/photos/96--kK-c5KY/download?force=true"

$(addprefix tmp/composite/, 00_basic_composite.jpg 01_watermark_30x100.jpg 02_watermark_30x0.jpg 04_watermark_text1.jpg):
	./composite.sh

img/CB_com.jpg: tmp/composite/00_basic_composite.jpg
	convert -resize 400x $< $@

img/CB_wm1.jpg: tmp/composite/01_watermark_30x100.jpg
	convert -resize 400x $< $@

img/CB_wm2.jpg: tmp/composite/02_watermark_30x0.jpg
	convert -resize 400x $< $@

img/CB_wm3.jpg: tmp/composite/04_watermark_text1.jpg
	convert -resize 400x $< $@

img/CB.jpg: images/gallery/pascal-meier-tXpD84c8ZwI-unsplash.jpg
	convert -resize 200x $< $@

img/dojoman.png: images/dojoman.png
	convert -resize 200x $< $@
