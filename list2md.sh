#!/bin/bash
#this script is to trans a filelist into markdown, so that can be viewed in browser within html easily.

#color env
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
    green "Usage:"
    white "------"
    green "$1"
    white "----------------------"
    yellow "Author: Yinyanlu@qiniu"
}

#Usage
if [ -z $1 ];then
  usage "bash $0 bucket host (with none 'http://')"
  exit
fi

#vars
BKT="$1"
HOST=$2
##_TMP_FILE_1 is listbucket result
_TMP_FILE_1="/tmp/tmp.out" > $_TMP_FILE_1
##MD. The final result file
_FIN_FILE="./$BKT.md" > $_FIN_FILE


#Get filelist from given bucket
qshell listbucket $BKT $_TMP_FILE_1

#Get pure filelist
PURE_FILELIST=`cat $_TMP_FILE_1 | awk '{print $1}'`

#read PURE_FILELIST and edit into markdown syntax line by line
for line in $PURE_FILELIST
do
  echo -e '- ['${line}'](http://'$HOST'/'$line')'  >> $_FIN_FILE
done

#return final result
green "Success!"
white "Output file is '$_FIN_FILE'"
