# v4 构建输入

本目录用于编译包含 Android USB 网络共享、NTFS／Ext4 轻量 USB NAS、AdBlock Fast 和升级兼容修复的 TR3600 v1 固件。

## 固定来源

- OpenWrt 源码：`https://github.com/soapmancn/openwrt.git`
- 源码分支：`agent/cudy-tr3600-v1-6.12`
- 源码提交：`046aec0dccd90f5a156cb8e9725c121c81955dd3`
- 基础构建仓库：`https://github.com/liangcanming/Cudy-tr3600-v1-6.12.git`
- 基础构建提交：`d696469c394c490fafe0660ba4581452b7fe41be`
- 基础配置：`mt7987-cudy-tr3600-iStore.config`

## 配置合并顺序

1. 执行基础构建仓库的 `diy-iStore-part1.sh`。
2. 更新并安装 feeds。
3. 执行基础构建仓库的 `diy-iStore-part2.sh`。
4. 将基础配置复制为 OpenWrt 的 `.config`。
5. 把 `android-usb.config` 追加到 `.config`。
6. 把 `nas.config` 追加到 `.config`。
7. 把 `adblock.config` 追加到 `.config`。
8. 执行 `make oldconfig`。
9. 应用仓库 `patches/` 中的风扇修复。
10. 编译固件和软件包。

## 必须验证

最终 `.config` 和 manifest 必须包含：

```text
kmod-usb-net
kmod-usb-net-cdc-ether
kmod-usb-net-cdc-ncm
kmod-usb-net-rndis
```

`usbutils` 只用于 `lsusb` 诊断，不作为驱动成功的必要条件。

轻量 NAS 必须同时包含：

```text
kmod-usb-storage
kmod-usb-storage-uas
kmod-fs-ext4
kmod-fs-ntfs3
e2fsprogs
kmod-fs-ksmbd
ksmbd-server
luci-app-ksmbd
luci-i18n-ksmbd-zh-cn
```

KSMBD 用于局域网 SMB 文件共享，不包含 Docker、Jellyfin、媒体转码或完整 NAS 系统。

AdBlock Fast 必须同时包含：

```text
adblock-fast
luci-app-adblock-fast
gawk
grep
sed
coreutils-sort
```

固件内置 AdBlock Fast 及其推荐处理工具，避免保留配置升级后只剩 UCI 配置、缺少服务程序和规则文件。

## WAN 升级兼容

v4 构建会安装 `99-tr3600-wan-compat`。它只在以下条件全部满足时修复网络配置：

1. 设备兼容标识为 `cudy,tr3600-v1`；
2. 保留下来的 `network.wan.device` 指向 `br-wan`；
3. UCI 中没有名为 `br-wan` 的有效 `device` 配置；
4. TR3600 v1 默认 WAN 设备 `eth0` 存在。

满足条件时，脚本将 WAN，以及同样指向 `br-wan` 的 WAN6，恢复为 `eth0`。已经正确使用 `eth0` 或明确配置了 `br-wan` 设备的系统不会被修改。

构建产物必须同时保留对应内核 ABI 的 USB 网络、USB 存储、Ext4、NTFS3 和 KSMBD `kmod` 软件包，不得使用官方源或其他固件生成的内核模块替换。
