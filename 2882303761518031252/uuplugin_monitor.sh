#!/bin/sh


PLUGIN_DIR=$(dirname "$0")
PID_FILE="/var/run/uuplugin.pid"
RUNNING_DIR="${PLUGIN_DIR}"
PLUGIN_EXE="uuplugin"
PLUGIN_CONF="uu.conf"

trap stop_uuplugin INT
trap stop_uuplugin TERM

# Return: 0 means running.
check_running() {
    if [ -f "$PID_FILE" ];then
        pid=$(cat $PID_FILE)
        running_pid=$(ps | sed 's/^[ \t ]*//g;s/[ \t ]*$//g' | \
            sed 's/[ ][ ]*/#/g' | grep "${PLUGIN_EXE}" | \
            grep -v "grep" | cut -d'#' -f1 | grep -e "^${pid}$")
        if [ "$pid" = "${running_pid}" ];then
            return 0
        fi
    fi
    return 1
}

start_uuplugin() {
    local uuplugin="${RUNNING_DIR}/${PLUGIN_EXE}"
    local conf="${RUNNING_DIR}/${PLUGIN_CONF}"
    export LD_LIBRARY_PATH=${RUNNING_DIR}/lib:${LD_LIBRARY_PATH}

    chmod u+x "${uuplugin}"
    "${uuplugin}" "${conf}" &
}

stop_uuplugin() {
    echo "Signal received."
    killall "${PLUGIN_EXE}"
    sleep 1
    exit
}

while :
do
    check_running
    if [ "$?" != "0" ];then
        start_uuplugin
    fi

    sleep 60 &
    wait $!
done
