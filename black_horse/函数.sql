use frank_sql;
#加密函数
#md5
select md5('abc');

#sha
select sha('abc');

#sha2 SHA2(str, hash_length)使用 hash_length 作为长度，加密 str。
#hash_length 支持的值为 224、256、 384、512 和 0。其中，0 等同于 256
select sha2('abc', 256);



#时间函数
#返回系统当前日期和时间
select now();
select sysdate();
select current_timestamp();

#返回系统当前日期
select curdate();

#返回系统当前时间
select current_time();

#返回括号内的年份
select year(now());

#返回括号内的月份
select month(now());

#返回括号内的日期
select day(now());

#返回括号内的星期
select weekday(now());
#返回括号内的小时
select hour(now());

#返回括号内的分钟
select minute(now());

#返回括号内的秒
select second(now());

#字段值字符串拼接
select concat(month(now()), '-', day(now()), '-');
# 或 select month(now())+ ' - ' + day(now());

# 判断函数 case when 使用
# case 列/表达式
#     when 表达式1 then 结果1
#     when 表达式2 then 结果2
#     ...
#     else 结果3
select id,
       case gender
           when 1 then '男'
           when 2 then '女' end
           as 性别
from student;

#字符串函数[索引从1开始]
#字符串长度
select length('abc');
#字符串拼接
select concat('a', 'b');
#字符串截取
select substr('abcde', 1, 3);
#字符串反转
select reverse('abcde');
#字符串查找
select instr('abcde', 'b');
#字符串替换
select replace('abcde', 'b', 'f');
#字符串转大写
select upper('abcde');
#字符串转小写
select lower('ABCDE');
#去掉开始和结尾的空格
select trim('  a bc  ');

#数学函数
#四舍五入
select round(12.345, 2);
#不用四舍五入
select truncate(12.345, 2);
#向上取整
select ceil(12.345);
#向下取整
select floor(12.345);
#幂
select power(2, 3);
#绝对值
select abs(-10);
#0~1的随机小数
select rand();
#返回列表数据最小值
select least(12, 14, 26, 2, 6);
#返回列表数据最大值
select greatest(12, 14, 26, 2, 6);
#返回列中的最大值
select max(id)
from student;
#返回列中的最小值
select min(id)
from student;
#返回列中的平均值
select avg(id)
from student;
#返回列中的总和
select sum(id)
from student;
