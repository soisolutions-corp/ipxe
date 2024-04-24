# iPXE Bootable Image

This project builds a custom iPXE image which is used in the Managed Service Platform to netboot customer appliances and virtual machines.

This code is inspired by the https://netboot.xyz project.

## Requirements

* make
* Docker

## Running

To build the generic iPXE iso, run:

```bash
make bin/ipxe-multiarch.iso
```

To clean build artifacts, run:

```bash
make clean
```

To remove everything from your system, run:

```bash
make nuke
```

You can customize the number of build threads for the iPXE compiling by setting BUILD_THREADS to the desired number. The default value is `4`.

```bash
make BUILD_THREADS=8
```
