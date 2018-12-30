#!/bin/bash

sudo linuxkit run \
  -networking vmnet \
  -mem 4096 \
  -data-file metadata.json \
  -disk file=homebox-state/disk,size=4G \
    homebox
