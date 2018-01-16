#!/bin/bash
ss_dir=/root/.shadowsocks/
date +%Y/%m/%d_%T
portlist=`grep -r -h  server_port $ss_dir | cut -d":" -f 2 | cut -d"," -f1`
echo "采集端口列表:" $portlist
for x in $portlist
do
        iptables -I INPUT -p tcp --dport $x
        iptables -I OUTPUT -p tcp --sport $x
done

