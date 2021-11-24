# HAC社区插件: Frp内网穿透

通过frp隧道，使局域网中的Home Assistant可以通过公网访问。  
***插件中frpc的版本为：[0.38.0](https://github.com/fatedier/frp/releases/tag/v0.38.0)。***

## 关于

[frp](https://github.com/fatedier/frp/blob/master/README_zh.md)是一个可用于内网穿透的高性能的反向代理应用。

本插件可以连接到frps服务器，实现http或者tcp的反向代理。

缺省配置仅作为示例，无法实际使用。如果你需要稳定穿透服务，需要在公网上搭建自己的frps服务器，具体教程参见[frp官方教程](https://gofrp.org/docs/)或[frps服务器搭建](#frps服务器搭建)。

## 配置选项说明

- *`frp_server`  
**必须**。frps服务器的IP地址/域名（如果使用域名的形式，则该域名需要已经解析到搭载frps的服务器）

- *`frp_server_port`  
**必须**。frp服务器端口

- *`frp_token`  
**必须**。frp服务器连接token

- `tcp_remote_port`  
**非必须**。使用tcp协议反向代理后服务对外暴露的实际端口。
***仅在使用tcp协议时需要***

- *`local_host`  
**必须**。本地Home Assistant所在服务器的IP地址/名称（如果使用的是Home Assistant OS部署的HA仅需要填`homeassistant`)

- *`local_port`  
**必须**。本地Home Assistant服务的端口号，Home Assistant默认为8123

- *`tunnel_type`  
**必须**。代理使用的服务协议，插件中提供了`tcp`和`http`两种（同时只能有一种生效）

- `http_domain`  
**非必须**。使用http协议反向代理后访问的主域名，此参数只有在使用`http`时需要填写，应该保持和frps服务器中`subdomain_host`的值一致。  
***仅在使用http协议时需要，需和frps服务器中`subdomain_host`的值一致***
- `http_subdomain_host`  
**非必须**。使用http协议反向代理后访问的子域名，如果为空，则使用系统中的随机UUID。此参数只有在使用`http`时会生效。
***仅在使用http协议时需要***

## frps服务器搭建

搭建并使用自己的frps服务器的前提条件是：拥有一台可以通过公网直接访问的服务器/云主机（使用国内的云服务商提供的服务器/云主机时你可能需要进行备案）。

**搭建过程**：  
在服务器上运行frps程序。详细搭建过程见[frps服务器搭建](DOCs/frps服务器搭建.md)

支持`tcp`反向代理的配置`frps.ini`：
```
[common]
bind_port = 7000
token = 12345678
```

同时支持`tcp`和`http`反向代理的配置`frps.ini`：
```
[common]
bind_port = 7000
token = 12345678

vhost_http_port = 80
subdomain_host = yyyy.com
```
*注：在http模式中如果允许`http_subdomain_host`值为空，，你必须要将泛域名`*.yyyy.com`解析到你的主机。*

关于frps的更多配置参见[frps默认配置文件](https://github.com/fatedier/frp/blob/dev/conf/frps_full.ini)和[frp官方教程](https://gofrp.org/docs/)。

## 说明

1. 缺省配置仅作为示例，无法实际使用
2. 插件中使用的frpc版本会定期更新，搭建自己的frps服务器，建议使用对应版本（说明：frp官方没有指明frps和frpc版本一定要对应，考虑到稳定性建议使用一致的版本）
3. 启动后，通过公网访问Home Assistant的URL可以在日志中查看

## 更多支持
- [HAC社区网站](https://hihass.com)
- HAC社区[Telegram频道](https://t.me/hihac)、[电报群](https://t.me/hihass)、[QQ交流群:45218782](https://qm.qq.com/cgi-bin/qm/qr?k=KsP5QPFeIwc4DS18UL5MCv1Mn63b1sC6&jump_from=webapi)
- [HAC社区插件库](https://github.com/hihass/hac-addons)