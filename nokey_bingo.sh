#!/usr/bin/env bash
#Usage: nokey_s2c.sh <host_position1> <host_postion2>...
PASSWD="123456"
#NET=192.168.1
HOSTS=`grep -Ev 'localhost4|localhost6' /etc/hosts|awk '{print $1}'|awk '{print $1}'`
yum install expect -y > /dev/null

/usr/bin/expect <<EOF
set timeout 20
log_user 0
#是否显示脚本输出信息  1显示 0 不显示
spawn ssh-keygen -t rsa
expect {
    "id_rsa)"
    { send "\n" ; exp_continue }
    "(y/n)?"
    { send "n\n" ; exp_continue }
    "passphrase)"
    { send "\n" ; exp_continue } 
    "again"
    { send "\n" ; exp_continue }
}
EOF
#注意EOF之后的空格，如果有空格脚本不能执行！
echo "ssh-keygen ok"

for IP in $HOSTS
do
echo "################# copy id_rsa.pub to $IP##################"
/usr/bin/expect <<EOF
set timeout 15
log_user 0
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$IP
expect {
    "(yes/no)?"
    { send "yes\n" ; exp_continue }
    "password"
    { send "$PASSWD\n" ; exp_continue }
}
EOF
done
