#!/bin/bash

list="$1"
outlog="$1.`gdate -I`"

totallines=`wc -l $list |awk '{print $1}'`
times=`echo "$totallines/20" |bc`
ntl=`echo "$times*20" |bc`

# 刷新次数，刷新目标
for i in `seq $times`; do
  #取出对应行
  subline=`echo "20*$i"|bc`

  hd19=`head -$subline $list |tail -20|head -19 | awk '{print $2}' | tr '\n' ','|sed 's/,/","/g'`

  en1=`head -$subline $list |tail -1|awk '{print $2}'`
  #构造刷新数组
  urls="[\"$hd19$en1\"]"
  echo $urls | jq .
  log=`curl -s 'https://fusion-admin.qiniu.io/api/v2/refreshV4/prefetch'  -H 'cookie: _ga=GA1.2.544492729.1540733033; gr_user_id=2881b0e1-2dfd-46a4-982a-69d4585b0162; _editor_token=ZVdsdWVXRnViSFU9OmY5YjhhZTM3NmVkMGUwMTMyMTAyMTIxNDY3NmQ3MDdkMjNmMDc3OGIxOGM3ZDlmMDkyNDEwMmU4MGE4NzBlM2QwOWJiYjNlZjRkMGYyMjBiZjhlNjRiN2Q2OTI0N2I3YzljODIyYWZmMDJiMTA3MjNlMzNiYjIyOTcxOWEzMjFh; ADMIN_FUSION_SESSION=NFdWNkoyWUJORTRaU0ZVRzMwTU5RR0JPVlM0TDRWNzQsMTU1MDQ2NTQxNTQ5OTc2NDQxNixhMjZjYmMwMzIyMDY3M2JhZjNhODA1MTQyZjhjYzFlYzY3NjgxZjgy' -H 'content-type: application/json' -H 'accept: application/json, text/plain, */*' --data-binary "{\"cdns\":[],\"urls\":$urls,\"caller\":\"ADMIN\"}" --compressed`
  sleep 10
  echo $log >> $outlog

done

if [[ $totallines -gt $ntl ]]; then
  det=`echo "$totallines-$ntl"|bc`
  ddet=`echo "$det-1"|bc`
  hdn=`tail -$ddet $list |awk '{print $2}' | tr '\n' ','|sed 's/,/","/g'`
  ndn=`tail -1 $list |awk '{print $2}'`
  urlsend="[\"$hdn$ndn\"]"
  echo $urlsend | jq .
  logend=`curl 'https://fusion-admin.qiniu.io/api/v2/refreshV4/prefetch'  -H 'cookie: _ga=GA1.2.544492729.1540733033; gr_user_id=2881b0e1-2dfd-46a4-982a-69d4585b0162; _editor_token=ZVdsdWVXRnViSFU9OmY5YjhhZTM3NmVkMGUwMTMyMTAyMTIxNDY3NmQ3MDdkMjNmMDc3OGIxOGM3ZDlmMDkyNDEwMmU4MGE4NzBlM2QwOWJiYjNlZjRkMGYyMjBiZjhlNjRiN2Q2OTI0N2I3YzljODIyYWZmMDJiMTA3MjNlMzNiYjIyOTcxOWEzMjFh; ADMIN_FUSION_SESSION=NFdWNkoyWUJORTRaU0ZVRzMwTU5RR0JPVlM0TDRWNzQsMTU1MDQ2NTQxNTQ5OTc2NDQxNixhMjZjYmMwMzIyMDY3M2JhZjNhODA1MTQyZjhjYzFlYzY3NjgxZjgy' -H 'content-type: application/json' -H 'accept: application/json, text/plain, */*' --data-binary "{\"cdns\":[],\"urls\":$urlsend,\"caller\":\"ADMIN\"}" --compressed`
  echo $logend >> $outlog
fi
