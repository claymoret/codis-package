#!/bin/bash


### admin/codis-fe-admin.sh
COORDINATOR_ADDR="10.70.20.117,10.70.20.119,10.70.20.120,10.70.20.122,10.70.20.124"

sed -i "s/^COORDINATOR_ADDR.*$/COORDINATOR_ADDR=\"$COORDINATOR_ADDR\"/" admin/codis-fe-admin.sh

### admin/codis-proxy-admin.sh
CODIS_DASHBOARD_ADDR="10.70.20.119:18080"

sed -i "s/^CODIS_DASHBOARD_ADDR.*$/CODIS_DASHBOARD_ADDR=\"$CODIS_DASHBOARD_ADDR\"/" admin/codis-proxy-admin.sh

### admin/codis-server-admin.sh
redis_port=7900

sed -i "s/6379/$redis_port/g" admin/codis-server-admin.sh

### config/dashboard.toml
coordinator_addr="10.70.20.117,10.70.20.119,10.70.20.120,10.70.20.122,10.70.20.124"
product_name="weview-codis"
admin_addr="0.0.0.0:18080"

sed -i "s/^coordinator_addr.*$/coordinator_addr = \"$coordinator_addr\"/" config/dashboard.toml
sed -i "s/^product_name.*$/product_name = \"$product_name\"/" config/dashboard.toml
sed -i "s/^admin_addr.*$/admin_addr = \"$admin_addr\"/" config/dashboard.toml

### config/proxy.toml
admin_addr="0.0.0.0:11080"
proxy_addr="0.0.0.0:19000"
jodis_addr="10.70.20.117,10.70.20.119,10.70.20.120,10.70.20.122,10.70.20.124"

sed -i "s/^product_name.*$/product_name = \"$product_name\"/" config/proxy.toml
sed -i "s/^admin_addr.*$/admin_addr = \"$admin_addr\"/" config/proxy.toml
sed -i "s/^proxy_addr.*$/proxy_addr = \"$proxy_addr\"/" config/proxy.toml
sed -i "s/^jodis_addr.*$/jodis_addr = \"$jodis_addr\"/" config/proxy.toml

### config/redis.conf

sed -i "s/6379/$redis_port/g" config/redis.conf


