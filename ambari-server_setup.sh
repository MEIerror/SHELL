#!/bin/bash
JAVA_HOME=/usr/local/java8

/usr/bin/expect <<EOF
set timeout 30
log_user 1
#是否显示脚本输出信息  1显示 0 不显示
spawn ambari-server setup
expect {
    "to continue"
    { send "\n" ; exp_continue }
    "Customize user"
    { send "\n" ; exp_continue }
    "want to change"
    { send "y\n" ; exp_continue }
    "(1):"
    { send "3\n" ; exp_continue }
    "JAVA_HOME:"
    { send "$JAVA_HOME\n" ; exp_continue }
    "database configuration"
    { send "\n" ; exp_continue }
}
EOF