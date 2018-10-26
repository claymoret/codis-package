#!/bin/bash

cwd=$(dirname $0)
cd $cwd
admin_dir=$(pwd)
bin_dir=$admin_dir/../bin
config_dir=$admin_dir/../config
pid_file=$bin_dir/sentinel.pid

action=$1
shift

running() {
    if [ -f $pid_file ]; then
        pid=$(cat $pid_file)
        ps aux | awk -v pid=$pid '$2 == pid {print}' | grep $pid > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            return 0
        else
            rm $pid_file
            return 1
        fi
    fi
    return 1
}

start() {
	$bin_dir/redis-sentinel $config_dir/sentinel.conf
}

stop() {
	if [ -f $pid_file ]; then
		pid=$(cat $pid_file)
		kill $pid
	fi
}

status() {
	if running; then
		echo "sentinel is running"
	else
		echo "sentinel is not running"
	fi
}

help() {
    echo "Usage: $0 {start|stop|status|restart}"
}

case $action in

    start)
        start
        ;;

    stop)
        stop
        ;;

    status)
        status
        ;;

    *)
        help
        ;;
esac
