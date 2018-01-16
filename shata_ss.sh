#!/bin/bash
ss_dir=/root/.shadowsocks/
date +%Y/%m/%d_%T
portlist=`grep -r -h  server_port $ss_dir | cut -d":" -f 2 | cut -d"," -f1`
echo "采集端口列表:" $portlist
for s in $portlist
do
	iptables -nvL -t filter | egrep "spt:$s$" | awk -F ' ' '{print $10 "\t" $2}' | tr '\n' '\t'
	iptables -nvL -t filter | egrep "dpt:$s$" | awk -F ' ' '{print $10 "\t" $2}'
done
for a in $portlist
do
        iptables -D INPUT -p tcp --dport $a
        iptables -D OUTPUT -p tcp --sport $a
done
for b in  $portlist
do
        iptables -I INPUT -p tcp --dport $b
        iptables -I OUTPUT -p tcp --sport $b
done
