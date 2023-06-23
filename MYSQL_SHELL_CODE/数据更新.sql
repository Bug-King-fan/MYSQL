use frank_sql;
select * from student;
# 插入数据 
#insert into <表名>[属性列1.....] valuse(<常量1>....);
#插入多组数据:
#insert into <表名>[属性列1.....] valuse(<常量1>....),(<常量1>....), .... ,(<常量1>....);

#更新数据
#update <表名> set <列名>=<表达式> [,<列名>=<表达式>....] [where <条件>];
update student set 年龄=22 where 学号='201215121';
#恢复：
update student set 年龄=20 where 学号='201215121';
#也可修改多个元组值
# update student set 年龄=年龄+1;  #需禁用安全模式
# 带子查询的修改语句
# update sc set 成绩=0 where 学号 in (select 学号 from student where 所在院系='CS');

#删除数据
# delete 并不是真正的删除空间还存在 只是做了一个标识 需要optimize table <表名>进行优化 才能真正删除表空间 但会产生一个锁
# delete配合 OPTIMIZE table t_image; 才会删除表空间
# delete from <表名> [where <条件>];
# truncate <表名> 删除整张表内容，并重置自增索引，删除表空间！！！

# 空值判断 is null/is not null
#属性定义有not null定义的不能取空值
