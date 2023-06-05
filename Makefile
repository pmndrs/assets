SRC = src
DIST = dist

FILES = $(shell find $(SRC) -name '*.hdr' -o -name '*.webp' -o -name '*.jpg')
TARGETS = $(patsubst $(SRC)/%,$(DIST)/%.js,$(FILES:%.hdr=%.exr))

all: $(TARGETS)

$(DIST)/%.js: $(SRC)/%.b64
	mkdir -p $(dir $@)
	cat $^ | ./bin/b64toesm > $@

%.b64: %.compressed
	base64 -i $^ -o $@

%.exr.compressed: %.hdr
	echo "compressing hdr file: $<"
	convert $< -compress DWAB -resize 512x512  $@

%.webp.compressed: %.webp
	echo "compressing webp file: $<"
	cp $< $@

%.jpg.compressed: %.jpg
	echo "compressing jpg file: $<"
	cp $< $@

.PHONY: clean
clean:
	rm -rf dist