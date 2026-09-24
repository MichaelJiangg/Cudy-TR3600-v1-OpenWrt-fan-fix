# ROADMAP

## 当前阶段

- v2 已作为 GitHub Pre-release 发布并完成实机启动与风扇检查。
- v3 正在补充小米／Android USB 网络共享驱动，尚未生成可刷写固件。

## 已完成

- PWM1 修正为 TR3600 v1 实机使用的 PWM0。
- 风扇服务脚本权限修正为 `0755`。
- LuCI 手动模式 dirty-state 修复与行为测试。
- 固件结构、CRC、设备元数据和差异白名单验证。
- 密码、VPN／代理订阅、SSH 密钥及个人标记审计。
- README、变更记录、源码补丁和发布说明整理。
- GitHub 公开仓库与 `tr3600-v1-fanfix-v2` Pre-release 已发布。

## 进行中

- 固定 v3 构建来源并准备 Android USB 网络驱动配置。
- 重新编译包含风扇修复和 USB 网络驱动的整套固件。

## 待办

- 验证 v3 构建产物包含 `kmod-usb-net-rndis`、`kmod-usb-net-cdc-ether` 和 `kmod-usb-net-cdc-ncm`。
- 对 v3 固件执行 SHA256、设备元数据和 `sysupgrade -T` 检查。
- 实机验证小米手机开启 USB 网络共享后生成网络接口并取得 DHCP 地址。
- 验证自动温控、手动档位和重启后服务状态未回归。

## 最近验证

- 固件 SHA256：`5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56`。
- 根文件系统共 2926 项，只有 3 项预期差异。
- LuCI dirty-state 行为测试通过。
- GitHub Release 四个附件的大小与 SHA256 均已和本地文件核对一致。
- v2 已在 TR3600 v1 上通过 `sysupgrade -T` 并正常启动；PWM0、温度读取与风扇冷却设备均已识别。
