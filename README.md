# uuplugin-redmi-ax6000
用于红米AX6000路由器的网易UU加速器插件。

腾讯加速器（测试中）：https://github.com/edwardvon/tencent-accelerator-rb06

## 修改内容说明
实际上是从小米AX6000的插件抓过来的，只不过红米ax6000原版系统缺了libssl.so，补上了以后在原版插件的启动命令上补了lib的临时变量。
```
# uuplugin_monitor.sh

start_uuplugin() {
    local uuplugin="${RUNNING_DIR}/${PLUGIN_EXE}"
    local conf="${RUNNING_DIR}/${PLUGIN_CONF}"

# 就加了这一句
+++ export LD_LIBRARY_PATH=${RUNNING_DIR}/lib:${LD_LIBRARY_PATH}

    chmod u+x "${uuplugin}"
    "${uuplugin}" "${conf}" &
}
```

## 安装
### 防雷提醒：如果你不明白以下操作，请不要随便尝试，分享者不为一切后果负责。

### （主要安装步骤参考auto.sh，希望大佬提点优化意见）
0. 官方固件先解锁SSH，详请见：https://www.right.com.cn/forum/thread-8258466-1-1.html 
 一定要永久开启SSH，这样才有auto_ssh脚本以便开机自动运行UU

1. ssh登录路由器（建议用MobaXterm等，方便传文件）

2. 下载本仓库所有文件，复制到路由器/data目录下（任意文件夹，例如/data/uuplugin）
3. 修改权限，运行auto.sh
```
cd /data/uuplugin
chmod +x auto.sh
./auto.sh
```
    auto.sh自动检测插件安装目录进行安装，然后运行。

4. [重要]把启动命令写到/data/auto_ssh/auto_ssh.sh结尾（vi写也行，目的是重启后自动启动插件）
```
echo "sleep 5 && /bin/sh /data/uuplugin/auto.sh &" >> /data/auto_ssh/auto_ssh.sh
```
5. 现在理论上重启以后就能用UU主机加速APP，或者在米家的路由器页面绑定（后附功能截图）

## 功能情况预览
1. UU主机加速APP
![Screenshot_2023-05-10-19-49-53-855_com netease uurouter](https://github.com/edwardvon/uuplugin-redmi-ax6000/assets/16309465/ecbc182c-e42f-4af8-92d5-705b647c337e)
![Screenshot_2023-05-10-19-52-42-325_com netease uurouter](https://github.com/edwardvon/uuplugin-redmi-ax6000/assets/16309465/a40217c7-143d-4735-bda3-f72de4fe6fec)
2. 米家路由器管理
![Screenshot_2023-05-10-19-50-14-395_com xiaomi smarthome](https://github.com/edwardvon/uuplugin-redmi-ax6000/assets/16309465/fae42e1a-1eab-49a0-8765-48de663bea33)
![Screenshot_2023-05-10-19-50-25-000_com xiaomi smarthome](https://github.com/edwardvon/uuplugin-redmi-ax6000/assets/16309465/5c918737-c4cc-4b85-882c-0c7d0da4547b)
加速效果（原来NAT是B）
![IMG_20230510_195259](https://github.com/edwardvon/uuplugin-redmi-ax6000/assets/16309465/99da914e-0610-4061-b483-ebfa3c2bfb73)
