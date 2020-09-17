#!/bin/sh
set -e

pushd anbox-work/vendor/anbox
scripts/create-package.sh "$PWD/../../out/target/product/arm64/ramdisk.img" "$PWD/../../out/target/product/arm64/system.img"
popd
mv anbox-work/vendor/anbox/android.img ./
