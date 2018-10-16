#!/bin/bash

input="$1"

# for ((i=0;i<20;i++));do
#         {
#                 sleep 3;echo 1>>aa && echo " $$ done!"
#         }&
#         #这个实例实际上就在上面基础上多加了一个后台执行&符号，此时应该是5个循环任务并发执行，最后需要3s左右时间。
#         #所讲的实例都是进程数目不可控制的情况


# done
#
#while
i=0
#while [[ $i -le 19 ]]; do
while read line1
do
  #statements
  #let ++i
  ((i++))
  {
    sleep 3
    echo $line1
  }&
done < $input

wait
