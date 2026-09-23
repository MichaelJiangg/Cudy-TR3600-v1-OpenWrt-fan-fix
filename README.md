# Cudy TR3600 v1 风扇修复固件 v2

这是面向 **Cudy TR3600 v1** 的非官方 OpenWrt `sysupgrade` 固件。它基于 OpenWrt 25.12-SNAPSHOT `r0-046aec0`，保留原第三方固件的软件与功能，只修复风扇 PWM、脚本权限和 LuCI 手动控制页面。

> [!CAUTION]
> 本固件只适用于 **Cudy TR3600 V1.0（R126）**。**WR3600 是另一款设备，禁止刷入。**

## 适用范围

- 设备：Cudy TR3600 v1
- 设备标识：`cudy,tr3600-v1`、`R126`
- 平台：`mediatek/filogic`
- 镜像类型：`squashfs-sysupgrade`

**不要用于 WR3600、TR3000、TR1200 或其他型号。原厂系统不能直接上传这个 `sysupgrade` 文件。**

## 适用人群

本固件面向具备路由器刷机、SSH 命令和故障恢复能力的用户，不适合第一次接触刷机的新手。建议使用可靠的 AI 工具辅助逐步核对型号、命令和终端输出，但最终操作与风险判断仍由刷机者本人负责。

联系作者：[小红书－小猫望远镜](https://www.xiaohongshu.com/user/profile/6956712700000000190372ea) 

## 下载

- [Cudy TR3600 v1 OpenWrt 风扇修复版 v2（Pre-release）](https://github.com/MichaelJiangg/Cudy-TR3600-v1-OpenWrt-fan-fix/releases/tag/tr3600-v1-fanfix-v2)
- 固件 SHA256：`5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56`

## 本版修复

1. 将风扇 PWM 从错误的 PWM1／`pwm1_0` 改为实机可用的 PWM0／`pwm0`。
2. 将 `/usr/sbin/tr3600-fan` 与 `/etc/init.d/tr3600-fan` 权限改为 `0755`，服务可在启动时正常执行。
3. 修复 LuCI 风扇页：保留 5 秒状态轮询，同时避免轮询覆盖尚未应用的“自动／手动”模式和档位选择。
4. 应用设置期间锁定控件，并忽略过期轮询结果；提交成功后重新读取真实状态。

自动模式沿用原设备树温控曲线：PWM 档位为 `0／128／192／255`，主要升档温度为 `40℃／85℃／115℃`，回差为 `2℃`。

## 完整性校验

在包含固件和校验文件的目录执行：

```sh
shasum -a 256 -c openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin.sha256
```

预期输出：

```text
openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin: OK
```

固件 SHA256：

```text
5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56
```

## 已经运行兼容 OpenWrt 的设备

以下示例假设路由器地址为 `192.168.6.1`。如果你的 LAN 地址不同，请替换命令中的地址。

### 1．上传并做非破坏性检查

```sh
scp openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin root@192.168.6.1:/tmp/
ssh root@192.168.6.1
sysupgrade -T /tmp/openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin
echo "CHECK_RC=$?"
```

只有看到 `CHECK_RC=0` 才继续。检查失败时立即停止，**不要使用 `sysupgrade -F`**。

### 2．备份当前配置

在路由器 SSH 中执行：

```sh
sysupgrade -b /tmp/tr3600-backup.tar.gz
exit
```

在电脑终端执行：

```sh
scp root@192.168.6.1:/tmp/tr3600-backup.tar.gz .
```

### 3．刷入固件

推荐先做一次干净安装，用于排除旧 overlay 和历史配置的影响：

```sh
ssh root@192.168.6.1
sysupgrade -n /tmp/openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin
```

如果明确需要保留当前设备自己的 `/etc` 改动，可改用：

```sh
sysupgrade -c /tmp/openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade-pwm0-fan-ui-v2.bin
```

刷写期间不要断电。SSH 断开属于正常现象。干净安装后默认 LAN 地址为 `192.168.6.1`；建议先用网线登录，并立即设置管理员密码和 Wi-Fi 密码。

## 从原厂系统首次安装

本文件是 `sysupgrade` 镜像，原厂系统需要先完成一次官方中间固件转换：

1. 确认机身标签为 **TR3600 V1.0**。
2. 从 [Cudy 官方 TR3600 1.0 下载页](https://www.cudy.com/zh-cn/pages/download-center/tr3600-1-0) 下载 `Develop_files_for_TR3600.zip`。
3. 解压并阅读包内 README，在原厂 Web 后台刷入 `Intermediate firmware/cudy_tr3600-v1-sysupgrade_260715.bin`。
4. 中间固件启动并进入 OpenWrt 后，再上传本包中的 v2 `sysupgrade` 固件。
5. 执行前文的 `sysupgrade -T`；只有返回 `0` 才能继续刷写。

已经运行兼容 OpenWrt 的 TR3600 v1 无需重复刷中间固件。

参考：

- [Cudy 官方 TR3600 1.0 下载页](https://www.cudy.com/zh-cn/pages/download-center/tr3600-1-0) 
- [OpenWrt TR3600 首次安装说明](https://github.com/openwrt/openwrt/pull/24596) 
- [TR3600 第三方固件项目](https://github.com/liangcanming/Cudy-tr3600-v1-6.12) 
- [发布页面](https://github.com/liangcanming/Cudy-tr3600-v1-6.12/releases) 

不要跨型号使用中间固件，也不要用 `-F` 绕过设备检查。

## 刷写后检查

```sh
DT=/sys/firmware/devicetree/base
hexdump -v -e '4/1 "%02x" "\n"' "$DT/pwm-fan/pwms"
tr '\000' '\n' < "$DT/soc/pinctrl@1001f000/pwm-pins/mux/groups"
ls -l /usr/sbin/tr3600-fan /etc/init.d/tr3600-fan
for c in /sys/class/thermal/cooling_device*; do
  echo "$c type=$(cat "$c/type") state=$(cat "$c/cur_state")/$(cat "$c/max_state")"
done
```

关键预期结果：

- `pwms` 的第二个 32 位值是 `00000000`，代表 PWM0。
- 引脚组输出 `pwm0`。
- 两个风扇脚本都带可执行权限。
- 存在 `type=pwm-fan` 的冷却设备。
- LuCI“系统 → TR3600 风扇控制”可切换手动档位，并可恢复自动模式。

## 清洁性与审计

此包没有从任何运行中的路由器导出 `/overlay`、配置备份、密码或 VPN／代理订阅。与干净基础根文件系统的 2926 个节点相比，只存在 3 项预期差异：两个脚本权限和一个 LuCI 页面文件。详见 `audit/difference-manifest.json`。

个人标记、用户目录、订阅文件名、SSH 授权密钥、Dropbear 主机密钥、shell 历史和运行时随机种子均未写入镜像。`/etc/shadow` 与干净基础固件逐字节一致。

## 验证状态

已完成：

- 固件结构、设备兼容元数据和外层 CRC 验证；
- 内核与已实机验证的 PWM0 版本逐字节比对；
- SquashFS 文件类型、权限、UID／GID、符号链接和设备节点比对；
- JavaScript 语法与交互状态测试；
- 个人配置和敏感信息基线审计。

在正式公开发布前，仍应在 TR3600 v1 实机上完成一次 `sysupgrade -T`，并最好执行一次 `sysupgrade -n` 干净启动测试。

## 来源

- OpenWrt 源码提交：`046aec0dccd90f5a156cb8e9725c121c81955dd3`
- 第三方构建仓库提交：`d696469c394c490fafe0660ba4581452b7fe41be`
- 风扇 LuCI 基线提交：`a13235ac8181525eee73c7850d33f188a9199ca0`
- [Cudy 官方 TR3600 V1.0 开发包与中间固件](https://www.cudy.com/zh-cn/pages/download-center/tr3600-1-0) 
- [OpenWrt TR3600 支持与首次安装顺序](https://github.com/openwrt/openwrt/pull/24596) 
- [TR3600 PWM0 实机测试记录](https://github.com/openwrt/openwrt/pull/24581#issuecomment-5694201905) 
- [LuCI 风扇插件源码](https://github.com/liangcanming/luci-app-tr3600-fan) 

补丁文件位于 `patches/`。公开分发时请保留上游许可证与源码链接，并核对所包含各组件的许可证要求。
