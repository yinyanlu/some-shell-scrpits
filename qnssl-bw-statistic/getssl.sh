#!/bin/bash
#串行，获取证书、然后查看证书有效期。
#输入是域名列表文件
#输出是“域名制表符有效期”格式的文件
#
input="$1"

for domain in `cat $input`
do
  check_result=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates | grep After)
  echo -e "$domain\t $check_result" >> $input.rezult
done
