# ROADMAP

## 当前阶段

- v2 已作为 GitHub Pre-release 发布并完成实机启动与风扇检查。
- v3 已完成编译、刷写与联网验证，包含小米／Android USB 网络共享驱动及轻量 USB NAS。
- v4 已完成 NTFS3、AdBlock Fast 和保留配置升级时 WAN 兼容迁移的远端编译与固件内校验，等待实机验证。

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
- v3 已在 TR3600 v1 实机完成 `sysupgrade -T`、刷写、启动与基本联网验证。
- v4 已加入 NTFS3、AdBlock Fast、推荐规则处理工具和 WAN 兼容迁移的构建输入，并通过本地静态验证。
- GitHub Actions 运行 `36290785007` 成功生成 v4 固件；编译、三组 manifest 校验、WAN 迁移脚本内容与执行权限校验、私有产物上传均通过。
- 已修正 v4 artifact 对上游 `sha256sums` 的收集规则、自定义校验文件路径，并补齐九个 USB／NAS 内核包的非空校验。

## 进行中

- 重新编译并核对修正附件校验后的 v4 最终产物，随后进行实机刷写验证。

## 待办

- 实机验证小米手机开启 USB 网络共享后生成网络接口并取得 DHCP 地址。
- 验证自动温控、手动档位和重启后服务状态未回归。
- 实机配置 NTFS 硬盘挂载并验证 KSMBD 读写。

## 最近验证

- 固件 SHA256：`5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56`。
- 根文件系统共 2926 项，只有 3 项预期差异。
- LuCI dirty-state 行为测试通过。
- GitHub Release 四个附件的大小与 SHA256 均已和本地文件核对一致。
- v2 已在 TR3600 v1 上通过 `sysupgrade -T` 并正常启动；PWM0、温度读取与风扇冷却设备均已识别。
- v3 GitHub Actions 构建耗时 1 小时 18 分 48 秒，编译、清单验证和私有产物上传全部通过。
- v3 固件文件为 `openwrt-mediatek-filogic-cudy_tr3600-v1-squashfs-sysupgrade.bin`，SHA256 为 `b9765daac67f345702ccacac803f19da200fe4a5943163eb7132a47ad15c2cb3`。
- v3 清单确认包含风扇控制、RNDIS／CDC USB 网络、USB Storage UAS、Ext4、KSMBD 服务及 LuCI 中文界面。
- v3 实机保留旧配置升级后发现 WAN 引用了不存在的 `br-wan`；手动恢复为 `eth0` 后 DHCP、默认路由与外网连接正常。
- 已加入受限的 WAN 兼容迁移与五组回归场景，等待重新构建并验证迁移脚本进入固件根文件系统。
- 实机确认 `/dev/sda1` 为 NTFS；v3 未包含 NTFS3 或 FUSE，无法直接挂载且官方源没有匹配的内核模块。
- AdBlock Fast 手动安装后成功生成 6.1 MiB 规则文件并拦截 228668 个域名，`google-analytics.com` 返回 `NXDOMAIN`。
- v4 首次远端构建已完成全部编译，USB、NTFS3、KSMBD 和 AdBlock Fast manifest 校验通过；最终根文件系统校验因工具名应为 `unsquashfs4` 而失败，已修正并等待重跑。
- v4 第二次远端构建 `36290785007` 于提交 `1a0e9f5` 成功完成，耗时 1 小时 43 分 35 秒；产物 `TR3600-v4-ntfs-nas-7` 大小为 59123864 字节，GitHub artifact digest 为 `sha256:95372274cc620e6b7c893640ece8d9259fa5c067914a54e01435c8e9d84e17ec`。
- 本次成功运行只有 GitHub Actions Node.js 20 弃用警告，没有编译或验证错误。
