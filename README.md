## docker-hbase+phoenix+kafka

### Build
```bash
$ docker build  . -t docker-dev:v1
```
### start
```bash
$ docker run  -p 9092:9092 -p 2181:2181 --hostname hbase  -itd docker-dev:v1
```