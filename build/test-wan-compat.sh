#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
script="$script_dir/files/99-tr3600-wan-compat"
tmp_dir=$(mktemp -d)

mkdir -p "$tmp_dir/bin"

cat > "$tmp_dir/bin/uci" <<'EOF'
#!/bin/sh
actions_file=${TEST_ACTIONS_FILE:?}

[ "${1:-}" = '-q' ] && shift
command=${1:-}
[ "$#" -gt 0 ] && shift

case "$command" in
	get)
		case "${1:-}" in
			network.wan) printf '%s\n' interface ;;
			network.wan.device) printf '%s\n' "${TEST_WAN_DEVICE:-eth0}" ;;
			network.wan6) printf '%s\n' interface ;;
			network.wan6.device) printf '%s\n' "${TEST_WAN6_DEVICE:-eth0}" ;;
			network.br_wan.name)
				[ "${TEST_DEFINE_BR_WAN:-0}" = 1 ] && printf '%s\n' br-wan
				;;
		esac
		;;
	show)
		cat <<EOF_SHOW
network.wan=interface
network.wan.device='${TEST_WAN_DEVICE:-eth0}'
network.wan6=interface
network.wan6.device='${TEST_WAN6_DEVICE:-eth0}'
EOF_SHOW
		if [ "${TEST_DEFINE_BR_WAN:-0}" = 1 ]; then
			cat <<'EOF_SHOW'
network.br_wan=device
network.br_wan.name='br-wan'
EOF_SHOW
		fi
		;;
	set|commit)
		printf '%s %s\n' "$command" "$*" >> "$actions_file"
		;;
esac
EOF

cat > "$tmp_dir/bin/logger" <<'EOF'
#!/bin/sh
exit 0
EOF

chmod +x "$tmp_dir/bin/uci" "$tmp_dir/bin/logger"

run_case() {
	name=$1
	compatible=$2
	wan_device=$3
	wan6_device=$4
	define_br_wan=$5
	has_eth0=$6
	expect_change=$7
	case_dir="$tmp_dir/$name"

	mkdir -p "$case_dir/net"
	printf '%s\000' "$compatible" > "$case_dir/compatible"
	[ "$has_eth0" = 1 ] && mkdir -p "$case_dir/net/eth0"
	: > "$case_dir/actions"

	PATH="$tmp_dir/bin:$PATH" \
	TEST_ACTIONS_FILE="$case_dir/actions" \
	TEST_WAN_DEVICE="$wan_device" \
	TEST_WAN6_DEVICE="$wan6_device" \
	TEST_DEFINE_BR_WAN="$define_br_wan" \
	TR3600_WAN_COMPATIBLE_FILE="$case_dir/compatible" \
	TR3600_WAN_NET_CLASS_DIR="$case_dir/net" \
		"$script"

	if [ "$expect_change" = 1 ]; then
		grep -qx 'set network.wan.device=eth0' "$case_dir/actions"
		grep -qx 'set network.wan6.device=eth0' "$case_dir/actions"
		grep -qx 'commit network' "$case_dir/actions"
	else
		[ ! -s "$case_dir/actions" ]
	fi
}

sh -n "$script"
run_case stale_br_wan cudy,tr3600-v1 br-wan br-wan 0 1 1
run_case valid_br_wan cudy,tr3600-v1 br-wan br-wan 1 1 0
run_case correct_eth0 cudy,tr3600-v1 eth0 eth0 0 1 0
run_case other_board cudy,tr3000-v1 br-wan br-wan 0 1 0
run_case missing_eth0 cudy,tr3600-v1 br-wan br-wan 0 0 0

echo 'TR3600 WAN compatibility migration tests passed.'
