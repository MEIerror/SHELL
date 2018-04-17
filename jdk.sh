#!/bin/bash
JDK_DURL="http://192.168.1.38/ambari/dependences/java/jdk-7u45-linux-x64.gz"
JDK_INSTALL_DIR="/usr/local"
JDK_ROOT_FOLDER="jdk1.7.0_45"
PROFILE="/etc/profile"
JDK_FILE="jdk-7u45-linux-x64.gz"
AM_REPO="http://192.168.1.38/ambari/ambari.repo"

echo "
192.168.1.95	www.adm.01.com
192.168.1.132	www.adm.02.com
192.168.1.70	www.adm.03.com
192.168.1.78	www.adm.04.com
192.168.1.117	www.adm.05.com
192.168.1.84	www.adm.06.com
192.168.1.59	www.adm.07.com
192.168.1.120	www.adm.08.com
192.168.1.64	www.adm.09.com
192.168.1.126	www.adm.10.com
" >> /etc/hosts
echo "nameserver 114.114.114.114" >> /etc/resolv.conf

sed -i "s/^SELINUX=.*/SELINUX=disabled/" /etc/selinux/config
/etc/init.d/iptables stop;chkconfig  iptables off

#rm -fr /usr/local/jdk*
yum remove java* \-y
cd "$JDK_INSTALL_DIR"
    wget $JDK_DURL &> /dev/null
    echo "get java and unpacking"
    tar -zxvf "$JDK_FILE" &> /dev/null
echo "unpacked finish"

mv "$JDK_ROOT_FOLDER" "java"

sed -i -e  "/JAVA_HOME=/d" -e "/export PATH=/d" -e "/JRE_HOME=/d" -e "/CLASSPATH=/d"  /etc/profile
echo "export JAVA_HOME=$JDK_INSTALL_DIR/java" >> "$PROFILE"
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> "$PROFILE"
echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jdk/lib/" >> "$PROFILE"

