## 部署Ambari之前的准备工作：

* 集群无密码登陆、JDK环境、本地解析、DNS和防火墙等.

1.nokey_s2c.sh 实现无密码登陆;

用法： 先修改nokey_s2c.sh 中各节点的网络位和root密码；
```
PASSWD="123456"
NET=192.168.1
```

执行：
>./nokey_s2c.sh  <host_position1> <host_postion2>...


2.安装前环境

修改jdk.sh中 IP对应的域名；添加execute.sh中:
```
HOST=(host1 host2 ...)
```
执行：
>./execute.sh
            
3.时间同步：搭建好ntp服务器后，在需要同步的节点执行
> ntp.sh <ntpserver_IP>

