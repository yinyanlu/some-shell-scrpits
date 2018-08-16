#!/bin/bash

#this script is to read qiniu listbucket file and get keys in every line

# $1 is the list file

if [ -z $1 ];then
echo "need a filelist file"
exit 0
fi


FILENAME="$1"
TmpFILE="/tmp/tmp2.out" > $TmpFILE

awk -F' '  '{print $1}' $FILENAME >> $TmpFILE

for i in  `cat $TmpFILE` 
do
qrsctl mv huanan:$i total16:$i 
done
