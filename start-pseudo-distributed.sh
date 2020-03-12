#/bin/sh

./replace-hostname.sh

echo "=================start zookeeper"
cd /root/zookeeper-3.4.14/bin
./zkServer.sh start
echo "=================start hbase"
cd /root/hbase-1.4.13/bin
./start-hbase.sh
echo "=================start kafka"
cd /root/kafka_2.11-2.1.1/bin
nohup ./kafka-server-start.sh ../config/server.properties 2>/dev/null &

cd ~
/bin/bash

