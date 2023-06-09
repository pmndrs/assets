SRC = src
DIST = dist

# hdr -> exr.js
HDR_FILES := $(wildcard $(SRC)/**/*.hdr)
HDR_TARGETS := $(patsubst $(SRC)/%,$(DIST)/%.js,$(HDR_FILES:%.hdr=%.exr))

# webp,png,jpg -> webp.js
WEBP_FILES := $(wildcard $(SRC)/**/*.webp)
WEBP_TARGETS := $(patsubst $(SRC)/%,$(DIST)/%.js,$(WEBP_FILES))
PNG_FILES := $(wildcard $(SRC)/**/*.png)
PNG_TARGETS := $(patsubst $(SRC)/%,$(DIST)/%.js,$(PNG_FILES:%.png=%.webp))
JPG_FILES := $(wildcard $(SRC)/**/*.jpg)
JPG_TARGETS := $(patsubst $(SRC)/%,$(DIST)/%.js,$(JPG_FILES:%.jpg=%.webp))

# json -> json.js
JSON_FILES := $(wildcard $(SRC)/**/*.json)
JSON_TARGETS := $(patsubst $(SRC)/%,$(DIST)/%.js,$(JSON_FILES))

TARGETS = $(HDR_TARGETS) \
					$(WEBP_TARGETS) $(PNG_TARGETS) $(JPG_TARGETS) \
					$(JSON_TARGETS)

RESIZE = 512x512
QUALITY = 80

all: $(TARGETS)

$(DIST)/%.js: $(SRC)/%.b64
	mkdir -p $(dir $@)
	cat $^ | ./bin/b64toesm.js > $@

%.b64: %.compressed
	cat $^ | openssl base64 | tr -d '\n' > $@

%.exr.compressed: %.hdr
	convert $< $*.tmp.exr
	convert $*.tmp.exr -compress ZIP -resize $(RESIZE) $@
	rm $*.tmp.exr

TOWEBP_TYPES = webp png jpg
define WEBP_TEMPLATE
%.webp.compressed: %.$(1)
	convert $$< $$*.tmp.webp
	convert $$*.tmp.webp -quality $(QUALITY) -resize $(RESIZE) $$@
	rm $$*.tmp.webp
endef
$(foreach type,$(TOWEBP_TYPES),$(eval $(call WEBP_TEMPLATE,$(type))))

%.json.compressed: %.json
	cat $< | jq -c > $@

# Fallback for all other extensions
%.compressed: %
	cp $< $@

.PHONY: clean
clean:
	rm -rf $(DIST)
