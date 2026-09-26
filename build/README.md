# v3 构建输入

本目录用于在 v2 风扇修复基础上重新编译包含 Android USB 网络共享驱动和轻量 USB NAS 的 TR3600 v1 固件。

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
7. 执行 `make oldconfig`。
8. 应用仓库 `patches/` 中的风扇修复。
9. 编译固件和软件包。

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
e2fsprogs
kmod-fs-ksmbd
ksmbd-server
luci-app-ksmbd
luci-i18n-ksmbd-zh-cn
```

KSMBD 用于局域网 SMB 文件共享，不包含 Docker、Jellyfin、媒体转码或完整 NAS 系统。

构建产物必须同时保留对应内核 ABI 的 USB 网络、USB 存储、Ext4 和 KSMBD `kmod` 软件包，不得使用官方源或其他固件生成的内核模块替换。
