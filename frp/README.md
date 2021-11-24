# HAC社区插件: Frp网络穿透

## 简介
通过frp隧道，使局域网中的Home Assistant可以通过公网访问。

## 说明

[frp](https://github.com/fatedier/frp/blob/master/README_zh.md)是一个可用于内网穿透的高性能的反向代理应用。

本Add-on可以连接到frps服务器，实现http或者tcp的反向代理。

缺省配置仅作为示例，无法实际使用。如果你需要稳定穿透服务，需要在公网上搭建自己的frps服务器，具体教程参见[frp官方教程](https://gofrp.org/docs/)或[frps服务器搭建](DOCS.md#frps服务器搭建)。

***注意：在HASS中插件（Add-on）特指运行在Supervisor中的功能组件，如果仅使用Home Assistant Core则无法使用插件（Add-on）。用于HA Core的功能组件被称为集成（Integrations ）。***

## 更多支持
- [HAC社区网站](https://hihass.com)
- HAC社区[Telegram频道](https://t.me/hihac)、[电报群](https://t.me/hihass)、[QQ交流群:45218782](https://qm.qq.com/cgi-bin/qm/qr?k=KsP5QPFeIwc4DS18UL5MCv1Mn63b1sC6&jump_from=webapi)
- [HAC社区插件库](https://github.com/hihass/hac-addons)