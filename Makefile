BUILD_IMG_ARGS := -disable-content-trust

image: BUILD_IMG_SPEC := homebox.yaml
image: do-build-img
image-bios: BUILD_IMG_ARGS += -format raw-bios
image-bios: image

image-zfs-dev: BUILD_IMG_SPEC := homebox-zfs-dev.yaml
image-zfs-dev: do-build-img
image-zfs-dev-bios: BUILD_IMG_ARGS += -format raw-bios
image-zfs-dev-bios: image-zfs-dev

do-build-img:
	./linuxkit/bin/linuxkit build $(BUILD_IMG_ARGS) $(BUILD_IMG_SPEC)

build-pkgs: build-pkg-dropbox build-pkg-transmission
push-pkgs: push-pkg-dropbox push-pkg-transmission

# TODO: setup content trust

build-pkg-dropbox:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/dropbox

build-pkg-transmission:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/transmission

push-pkg-dropbox:
	docker push $(shell linuxkit pkg show-tag -org errordeveloper pkg/dropbox)

push-pkg-transmission:
	docker push $(shell linuxkit pkg show-tag -org errordeveloper pkg/transmission)

push-all:
	docker push errordeveloper/kernel
	docker push errordeveloper/zfs-kmod
	docker push errordeveloper/init
	docker push errordeveloper/transmission
	docker push errordeveloper/dropbox
