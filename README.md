# benchmark 测试
测试 10 20 50 100 200 1k 2k 3k 3k5 字节 value 大小
到35000时速度明显下降
具体内容在benchmark log中

# 写入测试
用shell写入随机数据，测试结果在memory info.log
批量写入10 20 50 100 200 1k 2k各100次
写入value数据0.33M，memory info使用内存0.38M

