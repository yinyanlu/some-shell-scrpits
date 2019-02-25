#!/bin/bash
input=$1
final=$input.output
echo ''>$final
while read line; do
    echo $line >> $final
    curl -s https://portal.qiniu.io/api/proxy/pili/pili/hubs-streams/status/history?end=1542593100\&hub\=koocan\&start\=1542592500\&streamTitle\=$line -H "cookie: _ga=GA1.2.544492729.1540733033; gr_user_id=2881b0e1-2dfd-46a4-982a-69d4585b0162; ADMIN-V2_SESSION=NTA5QTJITkNDQjRRU1AzT1cxWVI1UThJMTFQTjRWMFksMTU0MjA3NjI2NjU5NjA5MjExMixhMzY2YzNmYWZmOTQzODlhYTZhNWM2MzQ1ZDE5Y2JiMDBmOGY1OTBk; _editor_token=ZVdsdWVXRnViSFU9OmY5YjhhZTM3NmVkMGUwMTMyMTAyMTIxNDY3NmQ3MDdkMjNmMDc3OGIxOGM3ZDlmMDkyNDEwMmU4MGE4NzBlM2QwOWJiYjNlZjRkMGYyMjBiZjhlNjRiN2Q2OTI0N2I3YzljODIyYWZmMDJiMTA3MjNlMzNiYjIyOTcxOWEzMjFh; _gid=GA1.2.1948585454.1542590060" |jq . | grep bps |sort --human-numeric-sort -t: -k 2 -r |head -1>> $final
done < $input
