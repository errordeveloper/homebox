image:
	./linuxkit/bin/linuxkit build -disable-content-trust homebox.yaml

image-zfs-dev:
	./linuxkit/bin/linuxkit build -disable-content-trust homebox-zfs-dev.yaml

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
