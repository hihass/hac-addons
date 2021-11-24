#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

HOST=$(jq --raw-output ".frp_server" $CONFIG_PATH)
PORT=$(jq --raw-output ".frp_server_port" $CONFIG_PATH)
TOKEN=$(jq --raw-output ".frp_token" $CONFIG_PATH)
SERVER_LOCAL=$(jq --raw-output ".local_host" $CONFIG_PATH)
PORT_LOCAL=$(jq --raw-output ".local_port" $CONFIG_PATH)
TYPE=$(jq --raw-output ".tunnel_type" $CONFIG_PATH)

HTTP_DOMAIN=$(jq --raw-output ".http_domain" $CONFIG_PATH)
HTTP_SUBDOMAIN_HOST=$(jq --raw-output ".http_subdomain_host" $CONFIG_PATH)
TCP_PORT_REMOTE=$(jq --raw-output ".tcp_remote_port" $CONFIG_PATH)

if [[ "$HTTP_SUBDOMAIN_HOST" == "null" ]]; then
    HTTP_SUBDOMAIN_HOST=$(cat /proc/sys/kernel/random/uuid)
fi

if [[ ${TYPE} == "http" ]]; then

    if [[ "$HTTP_DOMAIN" == "null" ]]; then
        HTTP_DOMAIN="{HTTP_DOMAIN}"
    fi
    URL=http://${HTTP_SUBDOMAIN_HOST}.${HTTP_DOMAIN}

    echo 你可以通过链接：${URL}访问HASS。
    echo 说明：${HTTP_DOMAIN}为你的frps服务器的域名。
    echo 注意：如果frps服务器的vhost_http_port值不为80，则需要在${URL}后面添加端口号。

    /frpc http -s ${HOST}:${PORT} --sd ${HTTP_SUBDOMAIN_HOST} -i ${SERVER_LOCAL} -l ${PORT_LOCAL} -t ${TOKEN} -n HAC_Andos_frp_${HTTP_SUBDOMAIN_HOST}

fi

if [[ ${TYPE} == "tcp" ]]; then

    URL=http://${HOST}:${TCP_PORT_REMOTE}

    echo 你可以通过链接：${URL}访问HASS。

    /frpc tcp -s ${HOST}:${PORT} -i ${SERVER_LOCAL} -l ${PORT_LOCAL} -t ${TOKEN} -r ${TCP_PORT_REMOTE} -n HAC_Andos_frp_${HTTP_SUBDOMAIN_HOST}

fi