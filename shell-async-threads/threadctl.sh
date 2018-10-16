#!/bin/sh
#
logs="$0.log" > $logs

function a_sub {
        sleep 3;
        echo 1>>aa && endtime=$(date +%s) && echo "我是$i,运行了3秒,整个脚本执行了$(expr $endtime - $starttime)秒" && echo
}
starttime=$(date +%s)
export starttime
tmp_fifofile="/tmp/$$.fifo"
echo $tmp_fifofile
mkfifo $tmp_fifofile
exec 6<>$tmp_fifofile
rm $tmp_fifofile
thread=5
for ((i=0;i<$thread;i++));
do
echo
done >&6
for ((i=0;i<10;i++))
do
read -u6
{
#a_sub >> $logs 2>&1
a_sub
echo >&6
} &
done
wait
exec 6>&-
wc -l aa
rm -f aa
exit 0
