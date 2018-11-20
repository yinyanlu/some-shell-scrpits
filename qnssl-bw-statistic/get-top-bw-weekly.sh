#!/bin/sh
#并发shell脚本
#
#工作过程：先指定thread参数值指定线程数量，比如30. 然后定义自己的任务子程序，如a_sub. 最后进行执行

# #color env
black(){
  echo -e "\033[30m $1 \033[0m"
}
red(){
  echo -e "\033[31m $1 \033[0m"
}
green(){
  echo -e "\033[32m $1 \033[0m"
}
yellow(){
  echo -e "\033[33m $1 \033[0m"
}
blue(){
  echo -e "\033[34m $1 \033[0m"
}
purple(){
  echo -e "\033[35m $1 \033[0m"
}
skyblue(){
  echo -e "\033[36m $1 \033[0m"
}
white(){
  echo -e "\033[37m $1 \033[0m"
}


usage(){
    red "Usage:"
    red "$1"
    white "----------------------"
    yellow "Log/Output:"
    #yellow $2
    yellow "<input-file>.log.\`date +s%\`"
    white "----------------------"
    green "Author: Yinyanlu@qiniu"
    white "----------------------"
}

#Usage

if [ -z $1 ];then
  usage "bash $0 <input-file>"
  #
  #如果有需要
  #usage "$1" "$2"
  exit
fi


#vars
input="$1"
#l=$(wc -l $1 | sed 's/^[ \t]*//g' | cut -d ' ' -f1)
starttime=$(date +%s)
logs="$1.log.$starttime"
#export starttime
thread=30

#并发多线程关键一：实名管道/
tmp_fifofile="/tmp/$$.fifo"
echo $tmp_fifofile
mkfifo $tmp_fifofile
#管道以读写方式装载到文件操作符6
exec 6<>$tmp_fifofile
rm $tmp_fifofile

function a_sub {
        uid=$1
        domain=$2
        rz=`curl -s -X POST https://fusion-admin.qiniu.io/api/v1/admin/traffic/domain -H 'cookie: _ga=GA1.2.1196577095.1534323655; _editor_token=ZVdsdWVXRnViSFU9OmY5YjhhZTM3NmVkMGUwMTMyMTAyMTIxNDY3NmQ3MDdkMjNmMDc3OGIxOGM3ZDlmMDkyNDEwMmU4MGE4NzBlM2QwOWJiYjNlZjRkMGYyMjBiZjhlNjRiN2Q2OTI0N2I3YzljODIyYWZmMDJiMTA3MjNlMzNiYjIyOTcxOWEzMjFh; gr_user_id=f91b06c5-3b2e-4abd-b4d6-e68a182faadd; ADMIN_FUSION_SESSION=REEwQzFFUlY5TFI5T1BKRzhMUURDQzFBV1ZaTUgxNzIsMTUzOTkzMjg2ODY5NjMwNzAyOSxkOWIzZmM3MTU4M2UxYjE1Yzg1OTRkOGY3MWJhZWRjMzNmMGU0NWQw; _gid=GA1.2.1581502507.1540122534' -H 'content-type: application/json' -d "{\"type\":\"bandwidth\",\"region\":[\"china\",\"asia\",\"sea\",\"ameu\",\"sa\",\"oc\",\"nozone\"],\"protocol\":[\"http\",\"https\"],\"start\":\"2018-10-19\",\"end\":\"2018-10-26\",\"g\":\"day\",\"domain\":\"$domain\"}"`
        pk=`echo $rz|awk -F'peak' '{print $2}' |awk -F'[:,]' '{print $2}'`
        pek=`echo "scale=6;$pk/1000000"|bc`
        peak=$(printf "%.6f" $pek)
        echo -e "$1 $2 $peak Mbps"
}

for ((i=0;i<$thread;i++));
do
echo
done >&6

j=0
while read line
do
  ((j++))
  {
    a_sub $line >> $logs 2>&1
    #每个任务都打入管道，这样可以最多打入$thread 个数的任务
    echo >&6
  } &
done < $input
wait

#并发多线程的结束，给出日志路径
echo "任务完成！任务日志文件：$logs "

exec 6>&-
exit 0


