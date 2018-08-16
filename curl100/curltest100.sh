#!/bin/bash

#this is loop 100 test about given url with curl
#and
#awk httpcode
#and statstic count of every kind of httpcode

if [ $# -lt 2 ]
then
    echo  -e "Usage:\n"
    echo  -e "$0 'url' output.txt"
    exit
fi

for i in {1..100} 
do
curl $1 |grep HTTP >> $2
echo -e "\n"
done

cat $2 |awk -F' ' '{print $3}' |sort|uniq -c >> $2
