#!/bin/sh
set -eu

manifest_file=${1:?usage: verify-nas-manifest.sh <manifest>}

for package in \
	block-mount \
	kmod-usb-storage \
	kmod-usb-storage-uas \
	kmod-fs-ext4 \
	kmod-fs-ntfs3 \
	e2fsprogs \
	kmod-fs-ksmbd \
	ksmbd-server \
	luci-app-ksmbd \
	luci-i18n-ksmbd-zh-cn
do
	grep -q "^${package} - " "$manifest_file" || {
		echo "missing required package: ${package}" >&2
		exit 1
	}
done

echo "Lightweight NAS manifest verified."
