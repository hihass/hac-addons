# frps服务器搭建

## frps安装及服务配置

### 下载并安装frps

下载最新的frp安装包，下载[地址](https://github.com/fatedier/frp/releases)为。  
***你可选择下载源码进行编译安装，具体编译过程参考go语言的开发教程。本教程直接使用由frp仓库编译好的二进制包进行安装。***  

将下载的安装包解压到目标目录
```
sudo vim /lib/systemd/system/frps.service
```

删除不使用的文件（由于frp仓库将frps和frpc程序发布在同一个包内，所以你下载的包内包括了frps和frpc两个程序及示例配置文件）。
```
sudo vim /lib/systemd/system/frps.service
```

### 配置frps服务

创建frps.service  
```
sudo vim /lib/systemd/system/frps.service
```
在frps.service里添加以下内容
```
[Unit]
Description=frps service
After=network.target syslog.target net-work-online.target
Wants=network.target

[Service]
Type=simple
ExecStart=/usr/local/frps/frps -c /usr/local/frps/frps.ini
Restart=on-failure
RestartSec=15s

[Install]
WantedBy=multi-user.target
```
***注意"ExecStart="之后的路径为frps实际安装路径(本文以安装到/usr/local/为例)***  
***此处直接运行systemctl命令会提示需要重载，使用`systemctl daemon-reload`命令重载后再进行操作。***

## frps配置

为了实现通过自定义域名访问内网服务，需要使用http穿透，在设置中指定`vhost_http_port = 8080`，设置访问http服务的端口，参数`subdomain_host = hicube.top`指定访问http服务的一级域名。则最终的http服务访问路径为`http://{subdomain}.{subdomain_host}:{vhost_http_port}`,其中subdomain由frpc中的subdomain值指定。

***在frp的整个设置过程中只使用http对外暴露内部的服务，不实用https进行暴露，主要的原因是使用https进行暴露的话需要在frpc中指定证书，为了使用ftps提供统一的证书，https服务由nginx的反向代理服务提供。具体配置参见[nginx代理配置](#nginx代理配置)。***  

目前 frpc 和 frps 之间支持两种身份验证方式，token 和 oidc，默认为 token。

通过 frpc.ini 和 frps.ini 的 [common] 段落中配置 authentication_method 来指定要使用的身份验证方式。

只有通过身份验证的客户端(frpc)才能成功连接 frps。

Token  
基于 Token 的身份验证方式比较简单，需要在 frpc 和 frps 的 [common] 段落中配置上相同的 token 参数即可。

OIDC  
OIDC 是 OpenID Connect 的简称，验证流程参考 [Client Credentials Grant](https://datatracker.ietf.org/doc/html/rfc6749#section-4.4)。

启用这一验证方式，参考配置如下：
```
# frps.ini
[common]
authentication_method = oidc
oidc_issuer = https://example-oidc-issuer.com/
oidc_audience = https://oidc-audience.com/.default 
```
```
# frpc.ini
[common]
authentication_method = oidc
oidc_client_id = 98692467-37de-409a-9fac-bb2585826f18 # Replace with OIDC client ID
oidc_client_secret = oidc_secret
oidc_audience = https://oidc-audience.com/.default
oidc_token_endpoint_url = https://example-oidc-endpoint.com/oauth2/v2.0/token
```

使用的frps.ini配置
```
[common]
bind_port = 7000
token = 5da55d512161ea774cb56d72913a3aed

vhost_http_port = 8080
#vhost_https_port = 443

# authentication_method 指定frpc使用什么身份认证方法与frps进行身份认证。
# If "token" is specified - token will be read into login message.
# If "oidc" is specified - OIDC (Open ID Connect) token will be issued using OIDC settings. 默认值为"token".
authentication_method = token

# if subdomain_host is not empty, you can set subdomain when type is http or https in frpc's configure file
# when subdomain is test, the host used by routing is test.frps.com
subdomain_host = hihass.com

# tls_only specifies whether to only accept TLS-encrypted connections. By default, the value is false.
tls_only = false

# only allow frpc to bind ports you list, if you set nothing, there won't be any limit
allow_ports = 2000-3000,3001,3003,4000-50000

# tls_cert_file = server.crt
# tls_key_file = server.key
# tls_trusted_ca_file = ca.crt

# 日志的记录级别，分为debug, info, warn, error四级，日志保存的天数，默认3天
log_file = /usr/local/frp/frps/frps.log
log_level = debug
log_max_days = 3
```

## 使用`systemctl`命令管理服务

启动frps服务
```
sudo systemctl start frps  
```
关闭frps服务  
```
sudo systemctl stop frps  
```
重启frps服务  
```
sudo systemctl restart frps  
```
查看frps服务状态  
```
sudo systemctl status frps  
```
设置开机自动启动frps服务  
```
sudo systemctl enable frps  
```