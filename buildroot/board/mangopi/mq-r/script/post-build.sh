#!/bin/sh
BOARD_DIR="$(dirname $0)/../../../allwinner-generic/$4"

# For debug
echo "Target binary dir $BOARD_DIR"

# Copy Files to BINARY
cp $BOARD_DIR/bin/* -rfvd  $BINARIES_DIR
cp $BOARD_DIR/../sunxi-generic/bin/* -rfvd  $BINARIES_DIR
cp $BOARD_DIR/../../mangopi/mq-r/script/env_mqr.cfg $BINARIES_DIR


cd $BINARIES_DIR
echo "item=dtb, $5" >> boot_package.cfg

$BINARIES_DIR/dragonsecboot  -pack boot_package.cfg
$BINARIES_DIR/mkenvimage -r -p 0x00 -s 131072 -o env.fex env_mqr.cfg

mkbootimg --kernel zImage  --ramdisk  ramdisk.img --board sun8iw20p1 --base  0x40200000 --kernel_offset  0x0 --ramdisk_offset  0x01000000 -o  boot.img
