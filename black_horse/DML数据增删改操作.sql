#增加insert  删除delete  更新update
describe student;

select *
from student;

#insert
#给指定列添加数据
insert into frank_sql.student (id, name, gender, birthday, score, state)
values ('1', '张三', '男', '1998-12-12', '100', 0);
#给全部列添加数据
insert into frank_sql.student
values ('2', '李四', '女', 1999 - 1 - 1, '95', '123@qq.com', '10086', 0);
#批量添加数据
insert into frank_sql.student (id, name)
values ('3', '王五'),
       ('4', '赵六'),
       ('5', '吴大'),
       ('6', '周小');


#update
# UPDATE 表名 SET 列1=值1,列2=值2,... [WHERE 条件];
# IN() 表示在什么范围内
update student set gender='女';
update student set gender=null;
update student set gender='男' where id = '1';
update student set gender='女' where id = '2';
update student set gender='男' where id in(select id from student where gender='女');
#is null / is not null 判断是否空
update student set gender='女',score='90',email='hello@outlook.com' where id = '3' and score is null;


#delete
# delete from 表名 where 条件;
delete from student where id in ('4','5');
delete from student where gender is null;
#删除整张表内容
truncate student;
# truncate <表名> 删除整张表内容[将整个表摧毁，在创建一个结构一摸一样的表]，并重置自增索引，删除表空间！！！
# delete 并不是真正的删除空间还存在 只是做了一个标识 需要optimize table <表名>进行优化 才能真正删除表空间 但会产生一个锁
# delete配合 OPTIMIZE table t_image; 才会删除表空间