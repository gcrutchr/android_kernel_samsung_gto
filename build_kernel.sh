#!/bin/bash
export CROSS_COMPILE=/home/gcrutchr/skyhawk/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
mkdir out
chmod -R 777 out
make -C $(pwd) O=out -j5 ARCH=arm64 CROSS_COMPILE=/home/gcrutchr/skyhawk/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- KCFLAGS=-mno-android  gto_eur_open_defconfig
make -C $(pwd) O=out -j5 ARCH=arm64 CROSS_COMPILE=/home/gcrutchr/skyhawk/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y 2>&1 | tee build.log
cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image 
tools/mkdtimg create out/dtbo.img --page_size=4096 $(find out -name "*.dtbo")
