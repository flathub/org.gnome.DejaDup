#!/usr/bin/env bash

set -xeuo pipefail

TARBALL_URL="$(yq -r '.[][] | select(.name=="rclone") | .sources[].url' ./org.gnome.DejaDup.yaml)"
RCLONE_SOURCE="$(mktemp -d)"
curl -fsSL "$TARBALL_URL" | tar xzvf - -C "${RCLONE_SOURCE}"
SOURCE_DIR="$(find "${RCLONE_SOURCE}/" -type d -maxdepth 1 | tail -n 1)"
trap 'rm -rf ${RCLONE_SOURCE}' EXIT

sed -i "/^godebug/d" "${SOURCE_DIR}/go.mod"
podman run --rm -it -w /app -v "$SOURCE_DIR:/app:Z" docker.io/library/golang:latest go run github.com/dennwc/flatpak-go-mod@latest .

mkdir -p rclone
cp "$SOURCE_DIR/go.mod.yml" ./rclone/go-sources.yml
sed -i "s/modules.txt/rclone\/modules.txt/g" ./rclone/go-sources.yml
cp "$SOURCE_DIR/modules.txt" ./rclone/modules.txt

TARBALL_URL="$(yq -r '.[][] | select(.name=="restic") | .sources[].url' ./org.gnome.DejaDup.yaml)"
RESTIC_SOURCE="$(mktemp -d)"
curl -fsSL "$TARBALL_URL" | tar xzvf - -C "${RESTIC_SOURCE}"
SOURCE_DIR="$(find "${RESTIC_SOURCE}/" -type d -maxdepth 1 | tail -n 1)"
trap 'rm -rf ${RESTIC_SOURCE}' EXIT

sed -i "/^godebug/d" "${SOURCE_DIR}/go.mod"
podman run --rm -it -w /app -v "$SOURCE_DIR:/app:Z" docker.io/library/golang:latest go run github.com/dennwc/flatpak-go-mod@latest .

mkdir -p restic
cp "$SOURCE_DIR/go.mod.yml" ./restic/go-sources.yml
sed -i "s/modules.txt/restic\/modules.txt/g" ./restic/go-sources.yml
cp "$SOURCE_DIR/modules.txt" ./restic/modules.txt

