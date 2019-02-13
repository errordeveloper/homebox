# TODO: setup content trust

BUILD_IMG_ARGS := -disable-content-trust

image: BUILD_IMG_SPEC := homebox.yaml
image: do-build-img
image-bios: BUILD_IMG_ARGS += -format raw-bios
image-bios: image
image-tar: BUILD_IMG_ARGS += -format tar
image-tar: image

image-zfs-dev: BUILD_IMG_SPEC := homebox-zfs-dev.yaml
image-zfs-dev: do-build-img
image-zfs-dev-bios: BUILD_IMG_ARGS += -format raw-bios
image-zfs-dev-bios: image-zfs-dev-bios

do-build-img:
	./linuxkit/bin/linuxkit build $(BUILD_IMG_ARGS) $(BUILD_IMG_SPEC)

build-pkgs:
	for i in build-pkg-dropbox build-pkg-transmission build-pkg-zfs build-pkg-sshd-user build-pkg-sshd-root ; do $(MAKE) $$i ; done

build-pkg-dropbox: BUILD_PKG_NAME := dropbox
build-pkg-dropbox: do-build-pkg

build-pkg-transmission: BUILD_PKG_NAME := transmission
build-pkg-transmission: do-build-pkg

build-pkg-zfs: BUILD_PKG_NAME := zfs
build-pkg-zfs: do-build-pkg

build-pkg-sshd-user: BUILD_PKG_NAME := sshd-user
build-pkg-sshd-user: do-build-pkg
build-pkg-sshd-root: BUILD_PKG_NAME := sshd-root
build-pkg-sshd-root: do-build-pkg

do-build-pkg:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/$(BUILD_PKG_NAME)

push-all:
	docker push errordeveloper/kernel
	docker push errordeveloper/zfs-kmod
	docker push errordeveloper/init
	docker push errordeveloper/transmission
	docker push errordeveloper/dropbox
	docker push errordeveloper/zfs
	docker push errordeveloper/sshd-root
	docker push errordeveloper/sshd-user
	docker push errordeveloper/metadata
