#!/bin/bash

#!/bin/bash
if [ $# -gt 1 ]; then

B=""
for  i in $(seq 2 $[$2+1])
do
B=${B},${i}
done
C=${B/,/}

rpm -ql $1|cut -d '/' -f ${C}|uniq -c|awk '{print $1 "\t/" $2}'
else
echo  -e "\033[1;31mUsage:\033[0m rpml <rpmname> [arg1] [arg2]..."
fi


#if [ $# -gt 1 ]; then
#
#B=""
#for  i in $(seq 2 $[$2+1])
#do
#B=${B},${i}
#done
#C=${B/,/}
#
#A=`rpm -ql $1|cut -d '/' -f ${C}|uniq -c|awk '{print $1 "\t/" $2}'`
#for i in $A
#do
#if [ ${i} = 'etc' ]; then
#   echo -e "\033[1;31m${i}\033[0m"
#elif [ ${i} = 'usr' ]; then
#       echo -e "\033[1;32m${i}\033[0m"
#elif [ ${i} = 'var' ]; then
#       echo -e "\033[1;33m${i}\033[0m"
#fi
#done
#else
#echo  -e "Usage: rpml <rpmname> \033[1;31m[arg1] [arg2]...\033[0m"
#fi

