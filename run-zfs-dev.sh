#!/bin/bash

sudo linuxkit run \
  -networking vmnet \
  -mem 8192 \
  -data-file metadata.json \
  -disk file=homebox-state/disk1,size=1G \
  -disk file=homebox-state/disk2,size=1G \
  -disk file=homebox-state/disk3,size=1G \
  -disk file=homebox-state/disk4,size=1G \
    homebox-zfs-dev
