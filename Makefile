SRC = src
DIST = dist

FILES = $(shell find $(SRC) -type f -name '[!.]*') # all except hidden files
TARGETS = $(patsubst $(SRC)/%,$(DIST)/%.js,$(FILES:%.hdr=%.exr))

RESIZE = 512x512
QUALITY = 80

all: $(TARGETS)

$(DIST)/%.js: $(SRC)/%.b64
	mkdir -p $(dir $@)
	cat $^ | ./bin/b64toesm.js > $@

%.b64: %.compressed
	cat $^ | openssl base64 | tr -d '\n' > $@

%.exr.compressed: %.hdr
	convert $< $*.exr
	convert $*.exr -compress ZIP -resize $(RESIZE) $@
	rm $*.exr
%.webp.compressed: %.webp
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
%.jpg.compressed: %.jpg
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
%.png.compressed: %.png
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
%.json.compressed: %.json
	cat $< | jq -c > $@

# Fallback for all other extensions
%.compressed: %
	cp $< $@

.PHONY: clean
clean:
	rm -rf $(DIST)
