#!/bin/bash
set -e

cd /src

if [ ! -d .repo ]; then
  repo init -u https://github.com/anbox/platform_manifests.git -b anbox --depth=1
fi

export QUILT_PATCHES=.patches

if [ -d .pc ]; then
  quilt pop -a || rm -rf .pc
  rm -rf .patches
fi

repo sync -l --force-sync

cp -r /patches .patches

quilt push -a

. build/envsetup.sh
lunch anbox_x86_64-userdebug
make -j9
