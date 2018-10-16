while read col1 col2 col3 col4
# col1 col2 col3 col4
# 意思是
# 读取一行并分割为4列读入，分隔符可以同时是
# 空格、tab

do
  echo "col1 is $col1"
  echo "col2 is $col2"
  echo "col3 is $col3"
  echo "col4 is $col4"
done < $1
