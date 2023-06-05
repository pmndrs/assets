SRC = $(wildcard src/**/*.hdr)
DST = $(patsubst src/%.hdr,dist/%.js,$(SRC))

all: $(DST)

dist/%.js: src/%.b64
	mkdir -p $(dir $@)
	cat $^ | ./bin/b64toesm > $@

%.b64: %.exr
	base64 -i $^ -o $@

%.exr: %.hdr
	convert $^ -compress DWAB -resize 512x512 $@

.PHONY: clean
clean:
	rm -rf dist