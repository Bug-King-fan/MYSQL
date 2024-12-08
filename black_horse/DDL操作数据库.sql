#查看数据库
show databases;

#查看当前数据库
select database();

#创建数据库
create database test;
#确认是否存在
create database if not exists test;

#删除数据库
drop database test;
#确认是否存在
drop database if exists test;

#使用数据库
use frank_sql;

#查看当前数据库下所有表
show tables;

#创建表
#数据类型： int double char varchar date[yyyy-MM-dd]
create table student
(
    id       char(8),
#     AUTO_INCREMENT 自增索引  id int auto_increment,
#     alter table 表名 auto_increment = 1; 自增重置操作，从第一条开始重新设置自增索引
    name     varchar(5),
    gender   enum ('男', '女'),
#  添加性别约束   char(2) default '男' check (性别 in ('男','女'));
    birthday date,
    score    double,
    email    varchar(64),
    tel      varchar(20),
    # 0：正常 1：休学 2：毕业
    state    int,
    primary key (id)
#参照 foreign key(外码/参照列) references <被参照表>(被参照列)
);

#描述表信息
describe student;
SHOW COLUMNS FROM student;

#删除表
drop table student;
drop table if exists student;

#修改表
#该表名
alter table student rename to student2;
#添加字段
alter table student
    add column study varchar(10);
#删除字段
alter table student
    drop column study;
#修改字段名
alter table student rename column study to 所学专业;
#修改数据类型
alter table student
    modify column 所学专业 char(8);
#删除字段
alter table student
    drop column 所学专业;
#drop table <表名> [restrict|cascade];
#restrict有限制删除，不能被别的表引用，不能有视图，不能有触发器，不能有存储过程或函数
#cascade无限制删除，将其相关依赖对象全部删除

