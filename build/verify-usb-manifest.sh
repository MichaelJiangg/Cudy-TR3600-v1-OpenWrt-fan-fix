#!/bin/sh
set -eu

manifest_file=${1:?usage: verify-usb-manifest.sh <manifest>}

for package in \
	kernel \
	kmod-usb3 \
	kmod-usb-net \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-ncm \
	kmod-usb-net-rndis
do
	grep -q "^${package} - " "$manifest_file" || {
		echo "missing required package: ${package}" >&2
		exit 1
	}
done

echo "Android USB tethering manifest verified."
