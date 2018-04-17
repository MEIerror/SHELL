#!/bin/bash
## 2018-03-28
## CentOS 6.5


REDIS_URL='http://192.168.1.38/ambari/dependences/redis/redis-3.2.8.tar.gz'
GEM_URL='http://192.168.1.38/ambari/dependences/redis/redis-3.2.1.gem'
REDIS_DIR='/usr/local'
REDIS_CLUSTER_DIR='/usr/local/cluster'
usage(){
echo -e "\033[1;31mUsage:\033[0m redis.sh {install <start_port> <end_port>|start <start_port> <end_port>|stop}"
}

install() {
num1=$1
num2=$2
yum install rubygems -y
wget $GEM_URL
gem install -l redis-3.2.1.gem && rm -fr redis-3.2.1.gem
wget $REDIS_URL
tar -zxf redis-3.2.8.tar.gz -C $REDIS_DIR && rm -fr redis-3.2.8.tar.gz
cd $REDIS_DIR/redis-3.2.8
make && make install

sed -i 's/^bind 127.0.0.1/bind 0.0.0.0/' redis.conf
sed -i 's/^daemonize no/daemonize yes/' redis.conf
sed -i '/cluster-enabled/a cluster-enabled yes' redis.conf
sed -i '/cluster-node-timeout/a cluster-node-timeout 5000' redis.conf
sed -i 's/appendonly no/appendonly yes/' redis.conf

for i in $(seq ${num1} ${num2})
do
mkdir -p $REDIS_CLUSTER_DIR/$i
cp $REDIS_DIR/redis-3.2.8/redis.conf $REDIS_CLUSTER_DIR/$i
sed -i "s/port 6379/port $i/" ${REDIS_CLUSTER_DIR}/${i}/redis.conf
sed -i "/cluster-config-file/a cluster-config-file nodes_$i.conf" $REDIS_CLUSTER_DIR/$i/redis.conf
done
}

start(){
num1=$1
num2=$2
ip=`ifconfig eth0|grep 'inet addr'|sed -e 's/^.*addr://'|awk '{print $1}'`
cd $REDIS_CLUSTER_DIR
for i in $(seq ${num1} ${num2})
do
redis-server $REDIS_CLUSTER_DIR/$i/redis.conf
echo $ip:$i >> port.info
done

if [ ! -e dump.rdb ];then
$REDIS_DIR/redis-3.2.8/src/redis-trib.rb create --replicas 1 `cat port.info` <<EOF
yes
EOF
fi
rm -fr port.info
}

stop() {
killall redis-server
}



case $1 in
  install)
    if (($# == 3)); then
    install $2 $3
    else
    usage
    fi
    ;;
  start)
    if (($# == 3));then
    start $2 $3
    else
    usage
    fi
    ;;
  stop)
    stop
    ;;
  *)
    usage
    ;;
esac