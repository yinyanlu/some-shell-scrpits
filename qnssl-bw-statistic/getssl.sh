#!/bin/bash

input="$1"

for domain in `cat $input`
do
  check_result=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates | grep After)
  #echo -e "$domain\t $check_result" | awk -F"\t" '{sub(/^ /,"",$2);printf "%-40s%s\n",$1,$2}'
  echo -e "$domain\t $check_result" >> $input.onebyone
done
