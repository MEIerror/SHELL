#!/usr/bin/env bash
#Usage: nokey_c2s.sh <host_position1> <host_postion2>...
PASSWD="buzhidao"
NET=172.25.16

yum install expect -y > /dev/null

/usr/bin/expect <<EOF
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

/usr/bin/expect <<EOF
set timeout 15
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@localhost
expect {
    "(yes/no)?"
    { send "yes\n" ; exp_continue }
    "password"
    { send "$PASSWD\n" ; exp_continue }
}
EOF

for HOST in  $@
do
IP=${NET}.${HOST}

/usr/bin/expect <<EOF
set timeout 15
spawn scp /root/.ssh/id_rsa root@${IP}:~/.ssh/
expect {
    "(yes/no)?"
    { send "yes\n" ; exp_continue }
	"password"
	{ send "$PASSWD\n" ; exp_continue}
}
EOF

echo "################# copy id_rsa to $IP##################"
done

