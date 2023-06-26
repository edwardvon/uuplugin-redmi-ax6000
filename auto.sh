#!/bin/sh

PLUGIN_ID="2882303761518031252"
PLUGIN_DIR=/userdisk/appdata/$PLUGIN_ID

if [ ! -d $PLUGIN_DIR ]; then
    cp -r "./${PLUGIN_ID}" $PLUGIN_DIR
    chmod -R +x $PLUGIN_DIR
fi

if [ ! -f "/userdisk/appdata/installPlugin/${PLUGIN_ID}.json" ]; then
    cp "./${PLUGIN_ID}.json" "/userdisk/appdata/installPlugin/${PLUGIN_ID}.json"
fi

$PLUGIN_DIR/uuplugin_monitor.sh 
