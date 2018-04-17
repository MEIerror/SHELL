#!/usr/bin/env bash

FILE=./jdk.sh
NET=192.168.1.
HOST=(81 82 83 84) #(host1 host2 host3)
for H in ${HOST[@]}
do
IP=${NET}${H}
scp $FILE root@$IP:/mnt/;ssh root@$IP "sh /mnt/$FILE;source /etc/profile;echo 'source jdk_env ok'"
done
wget -O /etc/yum.repos.d/ambari.repo http://192.168.1.38/ambari/ambari.repo;yum clean all