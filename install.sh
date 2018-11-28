#!/bin/bash

cd $(dirname $0)

install_dir=${1:-/tmp/codis}

programs="dashboard proxy fe server sentinel"
dashboard_files="admin/codis-dashboard-admin.sh bin/codis-dashboard config/dashboard.toml"
proxy_files="admin/codis-proxy-admin.sh bin/codis-proxy config/proxy.toml"
fe_files="admin/codis-fe-admin.sh bin/codis-fe bin/assets"
server_files="admin/codis-server-admin.sh bin/codis-server bin/redis-cli config/redis.conf config/local.conf data/"
sentinel_files="admin/codis-sentinel-admin.sh bin/redis-sentinel config/sentinel.conf log/"

for p in $programs
do
	echo "processing $p"
	full=$install_dir/$p
	mkdir -p $full 2>/dev/null
	files=`eval echo '$'"$p""_files"`
	for file in $files
	do
		subdir=${file%%/*}
		mkdir $full/$subdir 2>/dev/null
		if [[ $subdir == "config" ]]
		then
			cp -i $file $full/$subdir
		elif [[ $subdir == "data" || $subdir == "log" ]]
		then
			continue
		else
			cp -r $file $full/$subdir
		fi
	done
done

