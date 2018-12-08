#!/sbin/sh

operate=$1
module=$2

if [ -d /magisk/$module ]; then

    if [ $operate = "status_am" ]; then
        # Enable: 1, Disable: 0, Removed: 2
        [ -f /magisk/$module/auto_mount ] && exit 1 || exit 0
    fi

    [ -f /magisk/$module/update ] && exit 3

    [ -f /magisk/$module/remove ] && exit 4

    if [ $operate = "on_module" ]; then
        rm -rf /magisk/$module/disable
        echo ""
        echo "Successfully enable module $module !"
    fi

    if [ $operate = "off_module" ]; then
        touch /magisk/$module/disable
        echo ""
        echo "Successfully disable module $module !"
    fi

    if [ $operate = "on_auto_mount" ]; then
        touch /magisk/$module/auto_mount
        echo ""
        echo "Successfully enable auto_mount for $module!"
    fi

    if [ $operate = "off_auto_mount" ]; then
        rm -rf /magisk/$module/auto_mount
        echo ""
        echo "Successfully disable auto_mount for $module!"
    fi

    if [ $operate = "remove" ]; then
        rm -rf /magisk/$module
        echo ""
        echo "Successfully removed module $module !"
    fi

    if [ $operate = "status" ]; then
        # Enable: 1, Disable: 0, Removed: 2, UpdateFlag: 3, RemoveFlag: 4
        [ ! -f /magisk/$module/disable ] && exit 1
    fi

    exit 0
fi

exit 2

