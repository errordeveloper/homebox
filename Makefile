image:
	./linuxkit build -disable-content-trust homebox.yaml

build-pkgs: build-pkg-dropbox build-pkg-transmission
push-pkgs: push-pkg-dropbox push-pkg-transmission

build-pkg-dropbox:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/dropbox

build-pkg-transmission:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/transmission

push-pkg-dropbox:
	linuxkit pkg push -org errordeveloper pkg/dropbox

push-pkg-transmission:
	linuxkit pkg push -org errordeveloper pkg/transmission
