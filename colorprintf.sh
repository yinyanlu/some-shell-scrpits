#!/bin/bash

#字体颜色格式化
HD="\033["
ED="\033[0m"
#字体
DEFAULT=0; GL=1; AD=2; XT=3; XH=4; FZ=7
#所有颜色:
HEI=0; HONG=1; LV=2; HUANG=3; LAN=4; PH=5; QING=6; BAI=7
#函数格式化

xecho(){
  F=$1
  B=$2
  echo -e "$HD$1;${F:+$(($F+30))};${B:+$(($B+40))}m$4$ED"
  #xecho $GL $HONG $BAI "xecho2_is_more_easier?"
}
xprintf(){
  F=$1
  B=$2
  printf "$HD${F:+$(($F+30))};${B:+$(($B+40))}m$3$ED\n" $4
  # $1 前景 "$HEI"
  # $2 背景 "$BAI"
  # $3 内容排版 "%-20s"
  # $4 原始内容 "Hello, World!"
  #xprintf "$HONG" "$BAI" "%-20s%-20s" "hello~ world~"
}

#使用方法
usage(){
xecho $XT $BAI '' "Font    \t\tColor   \tCodec"
xprintf $BAI 'SLV' "%-24s\t%-16s\t%s" "通用 前景 背景色"
xprintf "$LV"  "" "%-24s\t%-16s\t%s" "0重置 30黑色 40黑色"
xprintf "$BAI" ""  "%-24s\t%-16s\t%s" "1高亮/加粗 31红色 41红色"
xprintf "$LV"  "" "%-24s\t%-16s\t%s" "2暗淡 32绿色 42绿色"
xprintf "$BAI" ""  "%-24s\t%-16s\t%s" "3斜体(仅英文) 33黄色 43黄色"
xprintf "$LV"  "" "%-24s\t%-16s\t%s" "4下划线(中文仅半边) 34蓝色 44蓝色"
xprintf "$BAI" ""  "%-24s\t%-16s\t%s" "5闪烁(无) 35品红 45品红"
xprintf "$LV"  "" "%-24s\t%-16s\t%s" "7反转 36青色 46青色"
xprintf "$BAI" ""  "%-24s\t%-16s\t%s" "8隐藏(无) 37白色 47白色"
}
#usage
