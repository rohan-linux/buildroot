#!/bin/sh

BOARD_DIR="$(dirname $0)"

if grep -Eq "^BR2_TARGET_ROOTFS_CPIO=y$" ${BR2_CONFIG}; then
        if [ ! -e ${TARGET_DIR}/init ]; then
                install -m 0755 fs/cpio/init ${TARGET_DIR}/init;
        fi
        fakeroot mknod -m 0622 ${TARGET_DIR}/dev/console c 5 1
fi

if grep -Eq "^BR2_TARGET_GRUB2=y$" ${BR2_CONFIG}; then
        cp -f ${BOARD_DIR}/grub.cfg ${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg
fi

if ! grep -Eq "^BR2_TARGET_GENERIC_GETTY=y$" ${BR2_CONFIG}; then
        cp -f ${BOARD_DIR}/inittab ${TARGET_DIR}/etc/inittab
fi
