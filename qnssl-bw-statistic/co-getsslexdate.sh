#!/bin/sh
#并发shell脚本
#
#工作过程：先指定thread参数值指定线程数量，比如30. 然后定义自己的任务子程序，如a_sub. 最后进行执行
#原理：
#https://www.cnblogs.com/chenjiahe/p/6268853.html
#http://blog.51cto.com/egon09/1754317
#
#
#

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
#usage函数，负责提示函数使用方法。
#三个部分
#红色提示输入语法规则
##输入语法规则根据不同脚本有所不同，所以这里通过变量$1传入规则
#黄色提示输出文件路径/log路径
##输出或者log基本是确定的格式：输入文件名+log+时间戳
##输出也支持定义输出格式，通过$2传给函数
#绿色提示我的名字
usage(){
    red "Usage:"
    red "$1"
    white "----------------------"
    yellow "Log/Output:"
    #yellow $2
    yellow "<input-file>.<script-name>.log.\`date +s%\`"
    white "----------------------"
    green "Author: Yinyanlu@qiniu"
    white "----------------------"
}

#Usage
#实际使用时根据脚步指定输入语法规则，应该因脚步而异
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
logs="$1.$0.log.$starttime"
#export starttime
thread=30

#并发多线程关键一：实名管道/
tmp_fifofile="/tmp/$$.fifo"
echo $tmp_fifofile
mkfifo $tmp_fifofile
#管道以读写方式装载到文件操作符6
exec 6<>$tmp_fifofile
rm $tmp_fifofile



#该脚本的任务子程序，是打印程序的输入参数，并获取一众程序执行相关信息，比如状态、线程、子任务ID、总进度、耗时、时间等，然后一起按照格式打印输出
#输出到 $logs 形成执行日志
#替换以下内容
####################################################################################
function a_sub {
        #为了测试效果，模拟每个任务执行时间为1秒
        #sleep 1
        uid=$1
        domain=$2
        check_result=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates | grep After)
        echo -e "$domain\t $check_result"
}
#####################################################################################
#并发多线程关键二：管道中写入$thread 个数的回车符号
for ((i=0;i<$thread;i++));
do
echo
done >&6

#并发多线程关键三：使用while遍历全部任务，u6、&、配合wait进行多线程配发。该实例每次配发30线程的任务
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

#并发多线程关键四：释放实名管道，退出任务
exec 6>&-
exit 0


