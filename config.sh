#!/bin/bash


### admin/codis-fe-admin.sh
COORDINATOR_ADDR="10.70.7.6:2181,10.70.7.7:2181,10.70.7.8:2181,10.70.7.9:2181,10.70.7.10:2181"

sed "s/^COORDINATOR_ADDR.*$/COORDINATOR_ADDR=\"$COORDINATOR_ADDR\"/" admin/codis-fe-admin.sh

### admin/codis-proxy-admin.sh
CODIS_DASHBOARD_ADDR="10.70.7.11:28080"

sed "s/^CODIS_DASHBOARD_ADDR.*$/CODIS_DASHBOARD_ADDR=\"$CODIS_DASHBOARD_ADDR\"/" admin/codis-proxy-admin.sh

### admin/codis-server-admin.sh
redis_port=7000

sed "s/6379/$redis_port/g" admin/codis-server-admin.sh

### config/dashboard.toml
coordinator_addr="10.70.7.6:2181,10.70.7.7:2181,10.70.7.8:2181,10.70.7.9:2181,10.70.7.10:2181"
product_name="noizz-codis-ab"
admin_addr="0.0.0.0:28080"

sed "s/^coordinator_addr.*$/coordinator_addr = \"$coordinator_addr\"/" config/dashboard.toml
sed "s/^product_name.*$/product_name = \"$product_name\"/" config/dashboard.toml
sed "s/^admin_addr.*$/admin_addr = \"$admin_addr\"/" config/dashboard.toml

### config/proxy.toml
admin_addr="0.0.0.0:21080"
proxy_addr="0.0.0.0:29000"
jodis_addr="10.70.7.6:2181,10.70.7.7:2181,10.70.7.8:2181,10.70.7.9:2181,10.70.7.10:2181"

sed "s/^product_name.*$/product_name = \"$product_name\"/" config/proxy.toml
sed "s/^admin_addr.*$/admin_addr = \"$admin_addr\"/" config/proxy.toml
sed "s/^proxy_addr.*$/proxy_addr = \"$proxy_addr\"/" config/proxy.toml
sed "s/^jodis_addr.*$/jodis_addr = \"$jodis_addr\"/" config/proxy.toml

### config/redis.conf

sed "s/6379/$redis_port/g" config/redis.conf


