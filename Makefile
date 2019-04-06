# TODO: setup content trust

BUILD_IMG_ARGS := -disable-content-trust

image: BUILD_IMG_SPEC := homebox.yaml
image: do-build-img
image-bios: BUILD_IMG_ARGS += -format raw-bios
image-bios: image
image-tar: BUILD_IMG_ARGS += -format tar
image-tar: image

image-minimal-test: BUILD_IMG_SPEC := minimal-test.yaml
image-minimal-test: do-build-img
#image-minimal-test-tar: BUILD_IMG_ARGS := -format tar-kernel-initrd
image-minimal-test-tar: BUILD_IMG_ARGS := -format tar
image-minimal-test-tar: image-minimal-test

do-build-img:
	./linuxkit/bin/linuxkit build $(BUILD_IMG_ARGS) $(BUILD_IMG_SPEC)

build-pkgs:
	for i in build-pkg-dropbox build-pkg-pms build-pkg-sshd-root build-pkg-sshd-user build-pkg-transmission build-pkg-zfs ; do $(MAKE) $$i ; done

build-pkg-dropbox: BUILD_PKG_NAME := dropbox
build-pkg-dropbox: do-build-pkg

build-pkg-pms: BUILD_PKG_NAME := pms
build-pkg-pms: do-build-pkg

build-pkg-sshd-root: BUILD_PKG_NAME := sshd-root
build-pkg-sshd-root: do-build-pkg
build-pkg-sshd-user: BUILD_PKG_NAME := sshd-user
build-pkg-sshd-user: do-build-pkg

build-pkg-transmission: BUILD_PKG_NAME := transmission
build-pkg-transmission: do-build-pkg

build-pkg-zfs: BUILD_PKG_NAME := zfs
build-pkg-zfs: do-build-pkg

do-build-pkg:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/$(BUILD_PKG_NAME)

push-all:
	docker push errordeveloper/dropbox
	docker push errordeveloper/init
	docker push errordeveloper/kernel
	docker push errordeveloper/metadata
	docker push errordeveloper/pms
	docker push errordeveloper/sshd-root
	docker push errordeveloper/sshd-user
	docker push errordeveloper/transmission
	docker push errordeveloper/zfs
	docker push errordeveloper/zfs-kmod
