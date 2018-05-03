#!/bin/bash

GROUP='hadoop'
PASSWORD="$2_123456"
userHOME="/home/$2"
STARTIP=160
STOPIP=179


add() {
user=$1
for i in $(seq ${STARTIP} ${STOPIP})
do
ssh root@192.168.1.${i} "
useradd ${user} -g ${GROUP} -d ${userHOME}
echo ${user}:${PASSWORD}|chpasswd

sed -i \"/^root/a${user}\tALL=(ALL)\tALL\" /etc/sudoers
"
done
}

del() {
user=$1
for i in $(seq ${STARTIP} ${STOPIP})
do
ssh root@192.168.1.${i} "
userdel -r ${user}

sed -i \"/^${user}/d\" /etc/sudoers
"
done
}


usage() {
echo 'Usage: userctl.sh {add|del} username'
}

case $1 in
	add)
	 add $2
	 ;;
	del)
	 del $2
	 ;;
	test)
	 test 
	 ;;
	*)
	 usage
	 ;;
esac
