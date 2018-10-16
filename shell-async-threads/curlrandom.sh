#!/bin/bash


for (( i = 0; i < 30; i++ )); do
{
r=$RANDOM
t=`echo $r/550|bc`
echo $t

/usr/bin/expect <<EOF

set timeout $t

spawn curl -o $t.out http://huadong.yyl.qiniuts.com/huadong.mp4

expect "stop?"

EOF
} &
done

wait

exit 0
