.PHONY: build clean nuke
export
IPXE_DOCKER_IMAGE = soi-ipxe-localbuild

build: clean
	$(MAKE) -C ipxe iso

clean:
	git clean -f -X bin/

nuke: clean
	docker image rm $(IPXE_DOCKER_IMAGE)
