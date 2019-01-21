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

### config/sentinel.conf
sentinel_port=27000
sentinel_master_prefix=avalon-codis-
sentinel_master_list="10.70.7.7 10.70.7.9"

sed -i "s/26379/$sentinel_port/g" config/sentinel.conf
sed -i "/^sentinel monitor.*$/d" config/sentinel.conf
sed -i "/^sentinel down-after-milliseconds.*$/d" config/sentinel.conf
sed -i "/^sentinel failover-timeout.*$/d" config/sentinel.conf

index=0
for master in $sentinel_master_list
do
    ((index++))
    master_name=$sentinel_master_prefix$index
    cat <<EOF >> config/sentinel.conf
sentinel monitor $master_name $master $redis_port 2
sentinel down-after-milliseconds $master_name 3000
sentinel failover-timeout $master_name 300000
EOF
done
