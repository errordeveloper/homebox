image:
	./linuxkit build -disable-content-trust homebox.yaml

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
