#!/bin/sh
set -eu

manifest_file=${1:?usage: verify-adblock-manifest.sh <manifest>}

for package in \
	adblock-fast \
	luci-app-adblock-fast \
	gawk \
	grep \
	sed \
	coreutils-sort
do
	grep -q "^${package} - " "$manifest_file" || {
		echo "missing required package: ${package}" >&2
		exit 1
	}
done

echo "AdBlock Fast manifest verified."
