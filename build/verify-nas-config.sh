#!/bin/sh
set -eu

config_file=${1:-.config}

for symbol in \
	CONFIG_PACKAGE_block-mount \
	CONFIG_PACKAGE_kmod-usb-storage \
	CONFIG_PACKAGE_kmod-usb-storage-uas \
	CONFIG_PACKAGE_kmod-fs-ext4 \
	CONFIG_PACKAGE_kmod-fs-ntfs3 \
	CONFIG_PACKAGE_e2fsprogs \
	CONFIG_PACKAGE_kmod-fs-ksmbd \
	CONFIG_PACKAGE_ksmbd-server \
	CONFIG_PACKAGE_luci-app-ksmbd \
	CONFIG_PACKAGE_luci-i18n-ksmbd-zh-cn
do
	grep -qx "${symbol}=y" "$config_file" || {
		echo "missing required config: ${symbol}=y" >&2
		exit 1
	}
done

echo "Lightweight NAS config verified."
