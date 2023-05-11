#!/bin/sh

PLUGIN_DIR="/userdisk/appdata/2882303761518031252"
PLUGIN_ID="2882303761518031252"

mkdir /data/uu && cd /data/uu
# 如果下载一直出错，可以把压缩包下载了手动解压
curl -O https://raw.githubusercontent.com/edwardvon/uuplugin-redmi-ax6000/main/uuplugin.tar.gz
tar -xzvf uuplugin.tar.gz

cp -r "./${PLUGIN_ID}" "${PLUGIN_DIR}"
cp "./${PLUGIN_ID}.json" "/userdisk/appdata/installPlugin/${PLUGIN_ID}.json"
cd "${PLUGIN_DIR}"
chmod 777 *

echo "sleep 5 && /bin/sh ${PLUGIN_DIR}/uuplugin_monitor.sh &" >> /data/auto_ssh/auto_ssh.sh


