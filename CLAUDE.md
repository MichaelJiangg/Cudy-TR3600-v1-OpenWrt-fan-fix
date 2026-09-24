# CLAUDE.md

## 项目范围

本仓库维护 Cudy TR3600 v1（R126）的 OpenWrt 风扇修复与 USB 网络共享固件说明、补丁、可复现构建输入和发布记录。

## 约束

- 不得把 WR3600、TR3000、TR1200 或其他型号标记为兼容。
- 固件与 ZIP 只作为 GitHub Release 附件发布，不提交进 Git 仓库。
- 每次发布前验证 SHA256、`sysupgrade -T`、设备元数据和差异白名单。
- 不提交密码、VPN／代理订阅、SSH 密钥、配置备份、日志或设备运行时状态。
- README 必须保留 Cudy 官方中间固件入口、风险说明和源码来源。
- USB 网络驱动必须与整套固件使用同一次构建产生的内核 ABI，禁止混装其他版本的 `kmod` 软件包。
- Android USB 网络共享至少包含 `kmod-usb-net-rndis`、`kmod-usb-net-cdc-ether` 和 `kmod-usb-net-cdc-ncm`。
- 构建时固定 OpenWrt 源码提交和基础配置提交；变更任一来源时必须重新核验设备元数据和驱动清单。
- 每次完成发布、修复或验证后同步更新 `ROADMAP.md`。
