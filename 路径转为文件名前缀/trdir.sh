#!/bin/bash
# 用于把文件路径转成文件名的前缀，另存在当前路径

if [ -z $1 ];then
 echo "Usage:"
 echo "./trdir.sh /full/path/filename"
 echo "for example:"
 echo "./trdir.sh /123/234/456/1.txt"
else
 cp $1 `dirname $1 |tr '/' '_'`_`basename $1`
fi
