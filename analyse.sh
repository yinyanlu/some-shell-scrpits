#!/bin/bash
# get the ip location info by
# http://ipquery.qiniudns.com/v2/ipquery/ipview/xx.x.x.x

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

#Usage env
usage(){
    red "Usage:"
    red "$1"
    white "----------------------"
    yellow "Author: Yinyanlu@qiniu"
    white "----------------------"
}

#Usage
if [ -z $1 ];then
  usage "bash $0 <input-file>"
  green "Output:"
  green "<input-file>.out"
  exit
fi

#VARs
input="$1"
##_TMP_FILE_1 is temp file 1.
_TMP_FILE_1="/tmp/tmp.out" > $_TMP_FILE_1
##_FIN_FILE is final result file.
_FIN_FILE="./$input.out" > $_FIN_FILE
## input file longth
l=$(wc -l $1 | sed 's/^[ \t]*//g' | cut -d ' ' -f1)

#Step 1
i=1

#### for not good here
# for line in `/bin/cat $input`
# do
#   #打印进度
#   echo -en "\b\b\b\b\b\b\b\b\b"`echo $i*100/$l | bc `'%'
#   echo -en "\b\b\b\b\b\b\b\b\b"`yellow "$i / $l"\n`
#   ((i++))
#   echo $line
#   #第一栏,client ip, location
#   client_ip=`echo $line|awk -F',' '{print $1}'`
#   echo $client_ip
#   client_location=`curl -s http://ipquery.qiniudns.com/v2/ipquery/ipview/$client_ip`
#   #第二栏，cdn ip, location
#   cdn_ip=`echo $line|awk -F',' '{print $2}'`
#   echo $cdn_ip
#   cdn_location=`curl -s http://ipquery.qiniudns.com/v2/ipquery/ipview/$cdn_ip`
#   #第三栏, url, status by me
#   url=`echo $line|awk -F',' '{print $3}'`
#   echo $url
#   status=`curl -Is $url |grep HTTP |awk '{print $2}'`
#   echo "$client_ip,$client_location,$cdn_ip,$cdn_location,$url,$status" >> $_FIN_FILE
# done

while read line; do
  #打印进度
  #echo -en "\b\b\b\b"`echo $i*100/$l | bc `'%'
  echo -en "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"`echo '正在处理第'$i'行 / 总共'$l'行'`
  ((i++))
  #echo $line
  #第一栏,client ip, location
  client_ip=`echo $line|awk -F',' '{print $1}'`
  #echo $client_ip
  client_location=`curl -s http://ipquery.qiniudns.com/v2/ipquery/ipview/$client_ip`
  client_loc=`echo $client_location |awk -F'-' '{print $5$2$4}'`

  #第二栏，cdn ip, location
  cdn_ip=`echo $line|awk -F',' '{print $2}'`
  #echo $cdn_ip
  cdn_location=`curl -s http://ipquery.qiniudns.com/v2/ipquery/ipview/$cdn_ip`
  cdn_loc=`echo $cdn_location | awk -F'-' '{print $5$2$4}'`
  #第三栏, url, status by me
  url=`echo $line|awk -F',' '{print $3}'`
  #echo $url
  status=`curl -Is $url |grep HTTP |awk '{print $2}'`

  #写入新文件
  echo "$client_ip,$client_loc,$cdn_ip,$cdn_loc,$url,$status" >> $_FIN_FILE
done < $1

#Step 2
echo -e '\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bOK！                         '
#exit


#* 获取百分比
percent(){
  # 定义变量 i
  i=1
  # 获取 输入文件的行数，并把运行结果赋予变量 l
  l=$(wc -l $1 | sed 's/^[ \t]*//g' | cut -d ' ' -f1)

  # 每行遍历循环
  while read line; do

    # 输出百分比
    echo -en "\b\b\b\b"`echo $i*100/$l | bc `'%'
    #sleep 1
    #echo $line
    # 计算 i++
    ((i++))

  # 传入要处理的文件
  done < $1
  # 完成时打个OK，因为字符长度不足以遮盖原先的百分比，所以后面加了几个空格
  echo -e '\b\b\b\bOK'
}
