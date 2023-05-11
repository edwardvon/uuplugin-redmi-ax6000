# uuplugin-redmi-ax6000
用于红米AX6000路由器的网易UU加速器插件。

## 修改内容说明
实际上是从小米AX6000的插件抓过来的，只不过红米ax6000原版系统缺了libssl.so，补上了以后在原版插件的启动命令上补了lib的临时变量。
```
# uuplugin_monitor.sh

start_uuplugin() {
    local uuplugin="${RUNNING_DIR}/${PLUGIN_EXE}"
    local conf="${RUNNING_DIR}/${PLUGIN_CONF}"
+++ export LD_LIBRARY_PATH=${RUNNING_DIR}/lib:${LD_LIBRARY_PATH}

    chmod u+x "${uuplugin}"
    "${uuplugin}" "${conf}" &
}
```

## 安装
### （工作忙）先放一个简单的一键脚本，希望能用
1. ssh登录路由器
2. 下载auto.sh并运行
（或者你手动下载auto.sh传到路由器里运行）
```
cd /data
curl -O https://raw.githubusercontent.com/edwardvon/uuplugin-redmi-ax6000/main/auto.sh
chmod +x ./auto.sh
./auto.sh
```

### 手动方法（也可以参考auto.sh，其实也很简单）
0. 官方固件先解锁SSH，详请见：https://www.right.com.cn/forum/thread-8258466-1-1.html 
 一定要永久开启SSH，这样才有auto_ssh脚本以便开机自动运行UU
1. 把 2882303761518031252文件夹 复制到路由器/userdisk/appdata/下
2. 修改脚本运行权限
```
cd /userdisk/appdata/2882303761518031252
chmod 777 *
```

3. 2882303761518031252.json 复制到/userdisk/appdata/installPlugin/下
4. [重要]把启动命令写到/data/auto_ssh/auto_ssh.sh结尾（你手动写也行）
```
echo "sleep 5 && /bin/sh /userdisk/appdata/2882303761518031252/uuplugin_monitor.sh &" >> /data/auto_ssh/auto_ssh.sh
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
