write_sizes="10 20 50 100 200 1000 2000 10000 20000 35000"
for size in $write_sizes
do
  redis-benchmark -d $size -t GET,SET > benchmark-$size.log
done

write_sizes="10 20 50 100 200 1000 2000"
touch memory_info.log
echo "" > random.csv
echo "---start---" > memory_info.log
redis-cli info memory >> memory_info.log
for size in $write_sizes
do
  for i in `seq 1 100`
  do
    value=`LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom |head -c $size`
    key=`LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom |head -c 13`
    echo $key,$value >> random.csv
    redis-cli set $key $value > /dev/null
  done
done
echo "---finish---" >> memory_info.log
redis-cli info memory >> memory_info.log

for line in `cat random.csv | cut -f 1 -d ,`
do
  redis-cli del $line > /dev/null
done
