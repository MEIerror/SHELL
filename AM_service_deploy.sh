#!/usr/bin/env bash
read -p "please input the path of service(example /mnt/*):" TAR1 TAR2
read -p "please input the HDP version (2.5):" HDP


if [ -z $HDP ]; then
    WORKDIR='/var/lib/ambari-server/resources/stacks/HDP/2.5/services'
else
    if [ -d /var/lib/ambari-server/resources/stacks/HDP/${HDP} ]; then
        WORKDIR="/var/lib/ambari-server/resources/stacks/HDP/$HDP/services"
    else
        echo "No such directory"
        exit 0
    fi
fi


for i in $TAR1 $TAR2
do
if [ -f $i ]; then
    if [ ${i##*.} = bz2 ] ; then
        tar -jxf $i -C $WORKDIR
    elif [ ${i##*.} = gz ];then
        tar -zxf $i -C $WORKDIR
    elif [ ${i##*.} = zip ];then
        unzip $i -d $WORKDIR
     echo "unpacking... please wait"
    fi
elif [ -d $i ] && [ -f $i/metainfo.xml ];then
    mv $i $WORKDIR
fi
done
echo "restart the ambari-server"
/etc/init.d/ambari-server restart
