#### UAC、RTL、IA bug修改
1. 通过端口获取pid时，由原来的7951端口改为8017.8017能更早的看到pid，而7951时在数据库连接成功后才会打开，比较慢。
2. tomcat需要root来启动，uac用户启动时只启动了tomcat，不能连接上数据库。
3. tomcat目录下的文件所属权限问题。
4. 创建pid文件改为以前的方法：etl_service("config", output)
