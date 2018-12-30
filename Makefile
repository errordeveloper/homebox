image:
	./linuxkit build -disable-content-trust homebox.yaml

build-pkgs: build-pkg-dropbox
push-pkgs: push-pkg-dropbox

build-pkg-dropbox:
	env DOCKER_BUILDKIT=1 linuxkit pkg build -org errordeveloper -network pkg/dropbox

push-pkg-dropbox:
	linuxkit pkg push -org errordeveloper pkg/dropbox
