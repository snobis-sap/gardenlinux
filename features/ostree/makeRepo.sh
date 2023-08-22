#!/usr/bin/env bash

set -eufo pipefail

# Call this script from the root of the gardenlinux repo as:
# ./features/ostree/makeRepo.sh .build/kvm_dev-ostree-arm64-today-local.tar

OSTREE_REPO=.build/ostree-repo
OSTREE_ROOTFS=.build/ostree-rootfs
OSTREE_REF=gardenlinux/today/arm64

if [ $# -ne 1 ]; then
    echo "Usage: $0 <rootfs tarball>"
    exit 1
fi

ROOTFS_TARBALL=$1

mkdir -p $OSTREE_ROOTFS
mkdir -p $OSTREE_REPO
tar xf "$ROOTFS_TARBALL" --directory=$OSTREE_ROOTFS
ostree init --mode=archive --repo=$OSTREE_REPO
ostree commit --repo=$OSTREE_REPO --branch $OSTREE_REF --skip-if-unchanged -s "Gardenlinux build $(date)" --no-xattrs $OSTREE_ROOTFS
