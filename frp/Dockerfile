ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# 安装功能组件和拷贝数据
ARG BUILD_ARCH

RUN \
   if [ "$BUILD_ARCH" = "armv7" ]; then curl -LO https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_arm.tar.gz && tar xvf frp_0.38.0_linux_arm.tar.gz && mv frp_0.38.0_linux_arm/frpc / && rm -rf frp_0.38.0_linux_arm.tar.gz frp_0.38.0_linux_arm ; \
   elif [ "$BUILD_ARCH" = "armhf" ]; then curl -LO https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_arm.tar.gz && tar xvf frp_0.38.0_linux_arm.tar.gz && mv frp_0.38.0_linux_arm/frpc / && rm -rf frp_0.38.0_linux_arm.tar.gz frp_0.38.0_linux_arm ; \
   elif [ "$BUILD_ARCH" = "aarch64" ]; then curl -LO https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_arm64.tar.gz && tar xvf frp_0.38.0_linux_arm64.tar.gz && mv frp_0.38.0_linux_arm64/frpc / && rm -rf frp_0.38.0_linux_arm64.tar.gz frp_0.38.0_linux_arm64 ; \
   elif [ "$BUILD_ARCH" = "amd64" ]; then curl -LO https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_amd64.tar.gz && tar xvf frp_0.38.0_linux_amd64.tar.gz && mv frp_0.38.0_linux_amd64/frpc / && rm -rf frp_0.38.0_linux_amd64.tar.gz frp_0.38.0_linux_amd64 ; \
   elif [ "$BUILD_ARCH" = "i386" ]; then curl -LO https://github.com/fatedier/frp/releases/download/v0.38.0/frp_0.38.0_linux_386.tar.gz && tar xvf frp_0.38.0_linux_386.tar.gz && mv frp_0.38.0_linux_386/frpc / && rm -rf frp_0.38.0_linux_386.tar.gz frp_0.38.0_linux_386 ; \
   else echo 'NOT VALID BUILD'; exit 1; \
   fi

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]