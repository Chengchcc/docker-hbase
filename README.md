## docker-hbase+phoenix+kafka
> you shoud add "172.17.2.1 hbase" in /etc/hosts
### Build
```bash
$ docker build  . -t docker-dev:v1
```
### start
```bash
$ docker run  -p 9092:9092 -p 2181:2181 --hostname hbase  -itd docker-dev:v1
```
