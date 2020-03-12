FROM ubuntu:18.04

LABEL MAINTAINER=chen@theoan.com

# install basic dependence
ADD dependence-install.sh dependence-install.sh

RUN ./dependence-install.sh

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV PATH $JAVA_HOME/bin:$PATH

WORKDIR /root/
# 下载 zookeeper
RUN  wget https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz \
    && tar zxvf zookeeper-3.4.14.tar.gz \
    && rm zookeeper-3.4.14.tar.gz \
    && mv zookeeper-3.4.14/conf/zoo_sample.cfg zookeeper-3.4.14/conf/zoo.cfg \
    && sed -i "s/\/tmp\/zookeeper/~\/zookkeeper-3.4.14\/data\ndataLogDir=\/root\/zookeeper-3.4.14\/log\n/g" zookeeper-3.4.14/conf/zoo.cfg \
    && sed -i "$ a\server.1=0.0.0.0:2888:3888" zookeeper-3.4.14/conf/zoo.cfg

# 下载 hbase
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/1.4.13/hbase-1.4.13-bin.tar.gz \
    && tar zxvf hbase-1.4.13-bin.tar.gz \
    && rm hbase-1.4.13-bin.tar.gz \
    && sed -i "$ a\export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\nexport HBASE_MANAGES_ZK=false" hbase-1.4.13/conf/hbase-env.sh

ADD hbase-site.xml /root/hbase-1.4.13/conf/hbase-site.xml

# 下载 phoneix
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/phoenix/apache-phoenix-4.14.3-HBase-1.4/bin/apache-phoenix-4.14.3-HBase-1.4-bin.tar.gz \
    && tar zxvf apache-phoenix-4.14.3-HBase-1.4-bin.tar.gz \
    && rm apache-phoenix-4.14.3-HBase-1.4-bin.tar.gz \
    && cp apache-phoenix-4.14.3-HBase-1.4-bin/phoenix-4.14.3-HBase-1.4-server.jar hbase-1.4.13/lib/ \
    && cp hbase-1.4.13/conf/hbase-site.xml apache-phoenix-4.14.3-HBase-1.4-bin/bin/

# 下载 kafka
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.1.1/kafka_2.11-2.1.1.tgz \
    && tar zxvf kafka_2.11-2.1.1.tgz \
    && rm kafka_2.11-2.1.1.tgz

ADD replace-hostname.sh replace-hostname.sh
ADD start-pseudo-distributed.sh start-pseudo-distributed.sh

ENV HBASE_HOME /root/hbase-1.4.13
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$HBASE_HOME/bin:$PATH

EXPOSE 2181
EXPOSE 9092

CMD ./start-pseudo-distributed.sh

