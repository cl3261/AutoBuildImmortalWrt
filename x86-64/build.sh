#!/bin/bash

echo "编译固件大小为: $PROFILE MB"
echo "Include Docker: $INCLUDE_DOCKER"

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始编译..."



# 定义所需安装的包列表
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-zh-cn"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-opkg-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
PACKAGES="$PACKAGES luci-app-smartdns"
PACKAGES="$PACKAGES luci-i18n-smartdns-zh-cn"
PACKAGES="$PACKAGES luci-app-poweroff"
PACKAGES="$PACKAGES luci-i18n-poweroff-zh-cn"
PACKAGES="$PACKAGES luci-app-adguardhome"
PACKAGES="$PACKAGES luci-i18n-adguardhome-zh-cn"
PACKAGES="$PACKAGES luci-app-mosdns"
PACKAGES="$PACKAGES luci-i18n-mosdns-zh-cn"
PACKAGES="$PACKAGES luci-app-lucky"
PACKAGES="$PACKAGES luci-i18n-lucky-zh-cn"
PACKAGES="$PACKAGES luci-app-filetransfer"
PACKAGES="$PACKAGES luci-i18n-filetransfer-zh-cn"
PACKAGES="$PACKAGES luci-app-autoreboot"
PACKAGES="$PACKAGES luci-i18n-autoreboot-zh-cn"
PACKAGES="$PACKAGES luci-app-netdata"
PACKAGES="$PACKAGES luci-i18n-netdata-zh-cn"
PACKAGES="$PACKAGES luci-app-wireguard"
PACKAGES="$PACKAGES luci-i18n-wireguard-zh-cn"

# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "no" ]; then
   PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$PROFILE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
