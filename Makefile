SRC = src
DIST = dist

RESIZE = 512x512
QUALITY = 80

#
# Build TARGETS
#
# To summup: src/**/*.{hdr,webp,png,jpg,json} => dist/**/*.{exr,webp,webp,webp,json}.js
#

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

all: $(TARGETS)

$(DIST)/%.js: $(SRC)/%.b64
	mkdir -p $(dir $@)
	echo "export default 'data:application/octet-binary;base64,$$(cat $<)'" > $@

%.b64: %.compressed
	cat $^ | openssl base64 | tr -d '\n' > $@

%.exr.compressed: %.exr
	convert $< -compress DWAB -resize $(RESIZE) $@
%.exr: %.hdr
	convert $< $@

%.webp.compressed: %.webp
	convert $< -quality $(QUALITY) -resize $(RESIZE) $@
TOWEBP_TYPES = png jpg
define WEBP_TEMPLATE
%.webp: %.$(1)
	convert $$< $$@
endef
$(foreach type,$(TOWEBP_TYPES),$(eval $(call WEBP_TEMPLATE,$(type))))

%.json.compressed: %.json
	cat $< | jq -c > $@

# Fallback for all other extensions
%.compressed: %
	echo "WARNING: COPYING $* WITH NO COMPRESSION"
	cp $< $@

.PHONY: clean
clean:
	rm -rf $(DIST)
