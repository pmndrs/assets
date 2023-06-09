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
	convert $< $*.webp
	convert $*.webp -quality $(QUALITY) -resize $(RESIZE) $@
	rm $*.webp
%.jpg.compressed: %.jpg
	convert $< $*.webp
	convert $*.webp -quality $(QUALITY) -resize $(RESIZE) $@
	rm $*.webp
%.png.compressed: %.png
	convert $< $*.webp
	convert $*.webp -quality $(QUALITY) -resize $(RESIZE) $@
	rm $*.webp
%.json.compressed: %.json
	cat $< | jq -c > $@

# Fallback for all other extensions
%.compressed: %
	cp $< $@

.PHONY: clean
clean:
	rm -rf $(DIST)
