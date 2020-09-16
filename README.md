# Anbox image builder

Effortlessly build an arm64 image for Anbox to use on the Librem 5.

This tool builds an image with F-Droid and F-Droid Privileged Extension included.

## Usage:

Make sure Docker is installed and execute:

```
./build.sh
```

Use `./build.sh --sudo` if your user does not have permission to use Docker daemon, or `./build.sh --podman` if you want to use rootless Podman instead (untested).

Directory `anbox-work` will be created where all AOSP sources will be downloaded to and where the build will be performed. You need about 150GB of free disk space and 16GB of RAM.

## Installation:

Put the `anbox-work/android.img` file into `/var/lib/anbox/android.img` on your phone and reboot.
