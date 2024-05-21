SHELL := /bin/bash
ISO_FILE := bin/ipxe-multiarch.iso
COMMIT_HASH := d7e58c5a812988c341ec4ad19f79faf067388d58
BUILD_THREADS := 4

.PHONY: build iso

ifeq ($(shell uname -m),arm64)
include ../Makefile.arm64
endif

build:
	docker build $(PLATFORM) -t $(IPXE_DOCKER_IMAGE) --build-arg="BUILD_THREADS=$(BUILD_THREADS)" --build-arg="ISO_FILE=$(ISO_FILE)" --build-arg="COMMIT_HASH=$(COMMIT_HASH)" .

iso: build
	$(MAKE) $(ISO_FILE)
	$(MAKE) bin-x86_64-efi/ipxe.efi
	$(MAKE) bin-arm64-efi/ipxe.efi SUFFIX=arm64
	$(MAKE) bin/ipxe.lkrn
	$(MAKE) bin-x86_64-pcbios/aws.lkrn
	$(MAKE) bin-arm64-efi/aws.efi SUFFIX=arm64

.DEFAULT:
	$(eval TEMP := $(shell mktemp -d))
	docker run --rm $(PLATFORM) -v "$(TEMP):/output" $(IPXE_DOCKER_IMAGE) cp /tmp/ipxe/src/$@ /output/$(@F)
ifdef SUFFIX
	$(eval FILENAME := $(shell echo $(@F) | sed -r 's/([^\.]+)\.(.*)$$/\1-$(SUFFIX).\2/'))
	cp $(TEMP)/$(@F) ../bin/$(FILENAME);
else
	cp $(TEMP)/$(@F) ../bin/$(@F)
endif
	rm -rf $(TEMP)
