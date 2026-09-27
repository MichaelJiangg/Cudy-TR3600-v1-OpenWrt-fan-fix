# 变更记录

## v4（开发中）

- 增加内核 NTFS3 驱动，使现有 NTFS 硬盘可以在不格式化的情况下挂载。
- 内置 AdBlock Fast、LuCI 管理页及其推荐的规则处理工具。
- 增加 NTFS3、AdBlock Fast 构建配置与固件 manifest 校验。
- 构建产物保留与固件内核 ABI 一致的 NTFS3 内核模块。
- 增加 TR3600 v1 首次启动 WAN 兼容迁移：仅在保留配置引用不存在的 `br-wan` 时回退到默认 WAN 设备 `eth0`。
- 增加 WAN 迁移回归测试，并验证迁移脚本实际进入固件根文件系统。

## v3（2026-09-27）

- 增加 Android USB 网络共享驱动构建输入。
- 增加 USB Mass Storage、UAS、Ext4 和 KSMBD 轻量 NAS 构建输入。
- 增加 `.config` 与固件 manifest 双重校验，缺少任一必需组件时终止构建。
- 构建产物保留与固件内核 ABI 一致的 USB 网络、USB 存储、Ext4 和 KSMBD 内核模块。

## v2（2026-09-23）

- 保留已经实机验证的 TR3600 v1 PWM0 内核修复。
- 修正 `/usr/sbin/tr3600-fan` 和 `/etc/init.d/tr3600-fan` 的可执行权限。
- 修复 LuCI 页面每 5 秒轮询覆盖未提交模式和档位的问题。
- 保留状态轮询、应用期间锁定、成功后回读以及过期响应保护。
- 重新生成 SquashFS 和固件外层 CRC。
- 完成差异白名单与敏感信息基线审计。

### 固件指纹

- v2 SHA256：`5e3d09de56ce568337e822d976a1e1af6b1924023b319a2d157e5b69f22c2a56`
- PWM0 基础镜像 SHA256：`066b10394d0b3c2351e7a962c1afd5c66beadbbdaec59f018a643809a13b65b1`
- 内核 SHA256：`f3e018baf5ed2a9af32c0eb8852d1b393a2ca79410d5b60cf9b75f1eb7e28334`
- LuCI 页面 SHA256：`52bcc95c8fdc42d6f86e560b8e6eb1af7c35f3947bbb43a0aac8d9dced577ee1`
