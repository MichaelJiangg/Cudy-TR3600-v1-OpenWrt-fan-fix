#!/bin/sh
set -eu

config_file=${1:-.config}

for symbol in \
	CONFIG_PACKAGE_adblock-fast \
	CONFIG_PACKAGE_luci-app-adblock-fast \
	CONFIG_PACKAGE_gawk \
	CONFIG_PACKAGE_grep \
	CONFIG_PACKAGE_sed \
	CONFIG_PACKAGE_coreutils-sort
do
	grep -qx "${symbol}=y" "$config_file" || {
		echo "missing required config: ${symbol}=y" >&2
		exit 1
	}
done

echo "AdBlock Fast config verified."
