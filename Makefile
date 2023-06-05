SRC = src
DIST = dist

FILES = $(shell find $(SRC) -name '*.hdr' -o -name '*.webp' -o -name '*.jpg' -o -name '*.png')
TARGETS = $(patsubst $(SRC)/%,$(DIST)/%.js,$(FILES:%.hdr=%.exr))

RESIZE = 512x512
QUALITY = 80

all: $(TARGETS)

$(DIST)/%.js: $(SRC)/%.b64
	mkdir -p $(dir $@)
	cat $^ | ./bin/b64toesm.js > $@

%.b64: %.compressed
	cat $^ | base64 > $@

%.exr.compressed: %.hdr
	convert $< $*.exr
	convert $*.exr -compress PIZ -resize $(RESIZE) $@
	rm $*.exr
%.webp.compressed: %.webp
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
%.jpg.compressed: %.jpg
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
%.png.compressed: %.png
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@

.PHONY: clean
clean:
	rm -rf dist
