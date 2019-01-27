#!/bin/bash

sudo linuxkit run \
  -networking vmnet \
  -mem 8192 \
  -data-file metadata.json \
  -disk file=homebox-zfs-dev-state/disk1,size=1G \
  -disk file=homebox-zfs-dev-state/disk2,size=1G \
  -disk file=homebox-zfs-dev-state/disk3,size=1G \
  -disk file=homebox-zfs-dev-state/disk4,size=1G \
    homebox-zfs-dev
