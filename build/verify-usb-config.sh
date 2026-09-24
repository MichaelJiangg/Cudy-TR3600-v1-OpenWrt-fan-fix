#!/bin/sh
set -eu

config_file=${1:-.config}

for symbol in \
	CONFIG_PACKAGE_kmod-usb3 \
	CONFIG_PACKAGE_kmod-usb-net \
	CONFIG_PACKAGE_kmod-usb-net-cdc-ether \
	CONFIG_PACKAGE_kmod-usb-net-cdc-ncm \
	CONFIG_PACKAGE_kmod-usb-net-rndis
do
	grep -qx "${symbol}=y" "$config_file" || {
		echo "missing required config: ${symbol}=y" >&2
		exit 1
	}
done

echo "Android USB tethering config verified."
