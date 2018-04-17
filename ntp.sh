#!/usr/bin/env bash
usage (){
    echo "Usage: ntp.sh <ntpserver_IP>"
}

if [ $# = 1 ]; then

if [ -f /etc/ntp.conf ]; then
    sed -i 's/^server/#server/g' /etc/ntp.conf
    echo -e "server $1 prefer \nrestrict $1  nomodify notrap noquery\nserver 127.0.0.1" >> /etc/ntp.conf
else
    yum install ntp -y && echo -e "server $1 prefer \n restrict $1  nomodify notrap noquery" >> /etc/ntp.conf
fi

/etc/init.d/ntpd restart
chkconfig ntpd on
else
    usage
fi
