#!/bin/bash

sudo linuxkit run \
  -networking vmnet \
  -mem 4096 \
  -disk file=homebox-state/disk,size=4G \
    homebox

# -data-file metadata.json \
