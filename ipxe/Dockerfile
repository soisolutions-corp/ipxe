FROM debian:bookworm-slim

ARG BUILD_THREADS=4
ARG ISO_FILE=ipxe.iso
ARG COMMIT_HASH=master

WORKDIR /tmp

RUN apt-get update && apt-get install -y build-essential git curl xorriso syslinux-utils gcc-aarch64-linux-gnu liblzma-dev isolinux mtools

RUN git clone https://github.com/ipxe/ipxe.git

WORKDIR /tmp/ipxe/src

RUN git reset --hard ${COMMIT_HASH}

RUN curl -O http://ca.ipxe.org/ca.crt

COPY config/local-base/* config/local/

RUN make -j${BUILD_THREADS} TRUST=ca.crt bin/ipxe.lkrn

COPY config/local-efi/* config/local/

RUN make -j${BUILD_THREADS} TRUST=ca.crt bin-x86_64-efi/ipxe.efi

RUN make -j${BUILD_THREADS} CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 TRUST=ca.crt bin-arm64-efi/ipxe.efi

RUN ./util/genfsimg -o ${ISO_FILE} bin-x86_64-efi/ipxe.efi bin/ipxe.lkrn bin-arm64-efi/ipxe.efi
