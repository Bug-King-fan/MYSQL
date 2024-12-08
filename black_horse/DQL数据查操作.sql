# 查询
#select 字段列表 from 表明列表 where 条件列表
#   group by 字段列表 having 条件列表 order by 字段列表 limit 分页限定
#查询指定字段
#select <字段1,字段2...> from 表名;
#查询指定字段并去重
#select distinct <字段1,字段2...> from 表名;
#起别名对字段值求和查询（字段2起别名）
#select <字段1,字段2+字段4> as 别名 from 表名 [as 表别名];
#where的使用 where只能用于from和视图
#select *from 表名 where 字段名 (=比较类型) 值;

# select 可以用 and 或 or 或 between A and B 或 in 去添加条件
/*
比较运算符
>  < <= >=  =  [<>  !=]	大于、小于、大于（小于）等于、不等于
BETWEEN ...AND...	显示在某一区间的值
IN(set)	显示在某一区间的
模糊查询
LIKE '张某'  模糊查询
NOT LIKE ''  模糊查询
IS  NULL	判断是否为空
逻辑运算符
and	多个条件是否成立
or	多个条件任一成立
not	不成立，例如where not (salary>100);
*/

# having 只能作用在分组语句 group by
#select count(*) as 统计 from 表名 group by 字段名1 [having count(*)(>=比较类型)2],字段名2 [having ...];

# order by
#select 字段名 from 表名 [ Group by having...] order by 字段名 [asc|desc] , 字段2 [asc|desc]... 默认asc升序
# 当字第一个排序的字段值相同时，才会按照第二个排序规则排序，依次类推

#limit
#select * from 表名 limit 数量 显示前数量条记录
#select * from 表名 limit num1,num2 显示从num1开始的num2条记录

#count()用于统计
#count(列名)  count(*)/count(常量)
#COUNT(常量) 和 COUNT(*)表示的是直接查询符合条件的数据库表的行数。
#COUNT(列名)表示的是查询符合条件的列的值不为NULL的行数。

#链接
#select sno,sname,sdeptname from 学生表 left join 院系表 on （学生表中的列 = 院系表中的列）相等的条件;
#SELECT name,stu.id,grade FROM stu LEFT JOIN exam ON stu.id = exam.id

# 查询经过计算的值
# select name,year(getdate())-age as 出生年份 , '江西省' as 出生省份 from 表名; 查询学生出生日期 并添加显示列出生省份 并全部赋值为江西省

# between and / not between  and
# select sno from student where sage between 20 and 23;

# in / not in
#select sno from student where sdeptname in ('计算机','架构');

# like / not like
# like '<匹配串>' [escape '<换码字符>']
# <匹配串>可以是一个完整字符串，也可以是包含有通配符%和_
# % ：表示任意长度（可以为0）的字符串 例如 aa%b 为以aa 开始 b结束的字符串
# _ ：表示任意单个字符 例如 aa_b -- 4个字符  以aa开头 b结尾 长度4的字符串


#通过 获取到的值 修改 呈现值
# select (case when sex='1' then '男' when sex='2' then '女' else '未知' end) as 性别 from student;

#笛卡尔积 注意作用域 book,borrow 做笛卡尔积
select book.书号,borrow.读者编号 from book,borrow where book.书号=borrow.书号;

# order by 排序  desc 降序 默认升序
select 书号,书名,定价 from book order by 书名 desc;

# group by 分组 having 只能对group by过滤
select count(*) as 类别 from book group by 类别;
use frank_sql;
select * from sc;
select 学号,count(课程号) as 数量 from sc group by 学号;
select 学号,count(课程号) as 数量 from sc group by 学号 having count(distinct 课程号)>2;

# 聚合函数 且不能出现在where语句中
# mysql中null加任意值结果还是 null !!!
# select 聚合函数 from 表名 [where 条件]
# count(*)
# count([distinct]列名)
# sum([distinct]列名)
# avg([distinct]列名)
# max([distinct]列名)
# min([distinct]列名)

#isnull(字段名) 查看字段是否为空
select id,isnull(email) from student;
#IFNULL(expr1,expr2)，如果expr1的值为null，则返回expr2的值，如果expr1的值不为null，则返回expr1的值。
select id,ifnull(email,'无') as 邮箱 from student;
#NULLIF(expr1,expr2)，如果expr1=expr2成立，那么返回值为null，否则返回值为expr1的值。
#IF(expr1,expr2,expr3)，如果expr1的值为true，则返回expr2的值，如果expr1的值为false，则返回expr3的值。


# 链接查询 两个表以上的查询
#1、等值与非等值链接查询
select student.*,sc.*,课程名 from student,sc,course where student.学号 = sc.学号 and sc.课程号 = course.课程号;
select * from course;
select * from sc;
# 悬浮元组
select 姓名,性别,年龄,所在院系,student.学号,课程号,成绩 from student left join sc on student.学号 = sc.学号;
select 姓名,性别,年龄,所在院系,student.学号,课程号,成绩 from student right join sc on student.学号 = sc.学号;
select 姓名,性别,年龄,所在院系,student.学号,课程号,成绩 from student join sc on student.学号 = sc.学号;

select student.学号,姓名 from student,sc where student.学号 = sc.学号 and sc.课程号 = '2' and sc.成绩 >= 90;

# 自身链接 first 和 second
select first.课程号,second.先行课 from course first,course second where first.先行课 = second.课程号;

#带有any/all的查询
select * from student;
select 姓名,年龄 from student where 年龄 < any(select 年龄 from student where 所在院系 = 'CS') and 所在院系 <> 'CS';
#等价于
select 姓名,年龄 from student where 年龄 < (select max(年龄) from student where 所在院系='CS') and 所在院系 <> 'CS';

select 姓名,年龄 from student where 年龄 < all(select 年龄 from student where 所在院系 = 'CS') and 所在院系 <> 'CS';
#等价于
select 姓名,年龄 from student where 年龄 < (select min(年龄) from student where 所在院系='CS') and 所在院系 <> 'CS';

# 带有 exists/not exists 谓词的子查询
select 姓名 from student where exists (select * from sc where sc.学号=student.学号 and 课程号='1');
select 姓名 from student where student.学号 in (select sc.学号 from sc where sc.学号=student.学号 and 课程号='1');
select student.学号,姓名,课程号 from student left join sc on student.学号=sc.学号 where 课程号='1';


#查询学生选择了所有选修课的姓名
#法一、
use frank_sql;
#with a as (select 学号,姓名,年龄 from student)
#select * from a;
with t as (select 学号 from sc group by 学号 having count(*) = (select count(*) as 课程总数 from course))
select t.学号,姓名 from student right join t on student.学号=t.学号;
#法二、
select 学号,姓名 from student where 学号 in(select 学号 from sc group by 学号 having count(*) = (select count(*) from course));


#集合查询 union并 intersect交  except差

#派生表  with  as / 子查询放在from select where中

#查询某张表是否在某个数据库中
select count(*) as ans from information_schema.TABLES as t where t.TABLE_SCHEMA ='frank_sql' and t.TABLE_NAME ='sc';

#查询某个数据库是否存在
select count(*) as ans from information_schema.schemata WHERE schema_name='frank_sql';
