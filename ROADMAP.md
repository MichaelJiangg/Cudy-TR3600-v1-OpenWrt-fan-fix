# ROADMAP

## 当前阶段

- v2 已作为 GitHub Pre-release 发布并完成实机启动与风扇检查。
- v3 已完成编译与本地静态验证，包含小米／Android USB 网络共享驱动及轻量 USB NAS，等待实机刷写验证。

## 已完成

- PWM1 修正为 TR3600 v1 实机使用的 PWM0。
- 风扇服务脚本权限修正为 `0755`。
- LuCI 手动模式 dirty-state 修复与行为测试。
- 固件结构、CRC、设备元数据和差异白名单验证。
- 密码、VPN／代理订阅、SSH 密钥及个人标记审计。
- README、变更记录、源码补丁和发布说明整理。
- GitHub 公开仓库与 `tr3600-v1-fanfix-v2` Pre-release 已发布。
- 固定 v3 构建来源，加入 Android USB 网络、USB 存储、Ext4、KSMBD 及 LuCI 中文界面的构建配置和校验脚本。
- GitHub Actions 运行 `36273338537` 成功生成 v3 可刷写固件，并通过构建配置与固件清单双重校验。
- v3 固件 SHA256、`cudy_tr3600-v1` 目标板标识及 sysupgrade tar 结构已在本地核对通过。

## 进行中

- 在 TR3600 v1 上执行 `sysupgrade -T` 并刷写 v3 固件。
- 实机验证 Android USB 网络共享、风扇控制和轻量 NAS。

## 待办

- 在路由器上执行 v3 固件的 `sysupgrade -T` 检查。
- 实机验证小米手机开启 USB 网络共享后生成网络接口并取得 DHCP 地址。
- 验证自动温控、手动档位和重启后服务状态未回归。
- 实机验证 USB SSD 识别、Ext4 挂载和 SMB 读写。

## 最近验证

- 固件 SHA256：`5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56`。
- 根文件系统共 2926 项，只有 3 项预期差异。
- LuCI dirty-state 行为测试通过。
- GitHub Release 四个附件的大小与 SHA256 均已和本地文件核对一致。
- v2 已在 TR3600 v1 上通过 `sysupgrade -T` 并正常启动；PWM0、温度读取与风扇冷却设备均已识别。
- v3 GitHub Actions 构建耗时 1 小时 18 分 48 秒，编译、清单验证和私有产物上传全部通过。
- v3 固件文件为 `openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade.bin`，SHA256 为 `b9765daac67f345702ccacac803f19da200fe4a5943163eb7132a47ad15c2cb3`。
- v3 清单确认包含风扇控制、RNDIS／CDC USB 网络、USB Storage UAS、Ext4、KSMBD 服务及 LuCI 中文界面。
