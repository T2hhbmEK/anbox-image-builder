#!/bin/bash
set -e

cd /src

if [ ! -d .repo ]; then
  repo init -u https://github.com/anbox/platform_manifests.git -b anbox --depth=1
fi

if [ ! -d .repo/local_manifests ]; then
  cp -r /anbox/local_manifests .repo/
fi

export QUILT_PATCHES=.data

if [ -d .pc ]; then
  quilt pop -a
  rm -rf .data
fi

repo sync --force-sync

cp -r /data .data

quilt push -a

. build/envsetup.sh
lunch anbox_arm64-userdebug
make -j9
vendor/anbox/scripts/create-package.sh "$PWD/out/target/product/arm64/ramdisk.img" "$PWD/out/target/product/arm64/system.img"
