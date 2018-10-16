#!/bin/bash

cookie="_ga=GA1.2.1196577095.1534323655; _editor_token=ZVdsdWVXRnViSFU9OmY5YjhhZTM3NmVkMGUwMTMyMTAyMTIxNDY3NmQ3MDdkMjNmMDc3OGIxOGM3ZDlmMDkyNDEwMmU4MGE4NzBlM2QwOWJiYjNlZjRkMGYyMjBiZjhlNjRiN2Q2OTI0N2I3YzljODIyYWZmMDJiMTA3MjNlMzNiYjIyOTcxOWEzMjFh; gr_user_id=f91b06c5-3b2e-4abd-b4d6-e68a182faadd; ADMIN_FUSION_SESSION=OEtSTkQ3T1Q0WUdMMjVLT0NGOVFCSkRWUUlHRFc3UkIsMTUzODk2Nzc1MjExNzU1NDE4Niw2MDBkMTY5YzkwODRiZGFmYmQyNDUyYzBkOGY0ZjQ5MzM5Y2M5NzI4; _gid=GA1.2.1022651578.1539535671"

#vars
input="$1"
output="$1.out"

while read ip
do
	echo -en $ip >> $output 2>&1 
	echo `curl -H "cookie: $cookie" https://fusion-admin.qiniu.io/api/v1/servicequery/services?ip=$ip` >> $output 2>&1
	echo >>$output 2>&1
done < $input

