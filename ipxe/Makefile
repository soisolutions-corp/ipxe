ISO_FILE := bin/ipxe-multiarch.iso
COMMIT_HASH := d7e58c5a812988c341ec4ad19f79faf067388d58
BUILD_THREADS := 4

.PHONY: build iso

ifeq ($(shell uname -m),arm64)
include ../Makefile.arm64
endif

build:
	docker build $(PLATFORM) -t $(IPXE_DOCKER_IMAGE) --build-arg="BUILD_THREADS=$(BUILD_THREADS)" --build-arg="ISO_FILE=$(ISO_FILE)" --build-arg="COMMIT_HASH=$(COMMIT_HASH)" .

bin-%-efi/ipxe.efi bin/%: SHELL := /bin/bash
bin-%-efi/ipxe.efi bin/%:
	$(eval TEMP := $(shell mktemp -d))
	docker run --rm $(PLATFORM) -v "$(TEMP):/output" $(IPXE_DOCKER_IMAGE) cp /tmp/ipxe/src/$@ /output/$(@F)
	$(eval FILENAME := $(shell echo $(@F) | sed -r 's/([^\.]+)\.(.*)$$/\1-$*.\2/'))
	if [[ "$*" != "$(@F)" ]]; then cp $(TEMP)/$(@F) ../bin/$(FILENAME); else cp $(TEMP)/$(@F) ../bin/$(@F); fi
	rm -rf $(TEMP)

iso: build
	$(MAKE) $(ISO_FILE) bin-x86_64-efi/ipxe.efi bin-arm64-efi/ipxe.efi bin/ipxe.lkrn
