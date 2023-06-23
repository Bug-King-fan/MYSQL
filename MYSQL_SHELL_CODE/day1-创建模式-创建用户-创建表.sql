show databases;
#创建一个数据库
#create database frank_sql;
use frank_sql;
select database();
# 以下用于sql server
#创建登录名
# create login <登录名> with password = "123456"
#创建用户名
# create user <WF> for login <admin> with default_schema = <模式名>;
#dbo是创建表的默认模式
#创建模式
# create schema <模式名> authorization <用户名>;
#若没有指定模式名，则模式名隐含为用户名
#在test模式下创建student表
#create table test.student(
#	学号 char(8),
#    姓名 varchar(3),
#    性别 char(1),
#    年龄 char(3),
#    所在系 char(3),
#    primary key(学号)
#);
#查看所有用户
select user,host from mysql.user;
#查看当前用户
select user();

#创建用户
#localhost为主机名，即用户连接 MySQL 时所用主机的名字。
#如果在创建的过程中，只给出了用户名，而没指定主机名，
#那么主机名默认为“%”，表示一组主机，即对所有主机开放权限。
#创建一个用户
#create user'新用户名'@'localhost'identified by '新密码';
create user 'frank' @'localhost' identified by '123456';
#删除用户frank
drop user 'frank'@'localhost';
#修改用户名frank 为Frank1
rename user 'frank'@'localhost' to 'Frank1'@'localhost';
#修改登录密码
#set password for 'frank'@'localhost' = password('1230123');
#alter user '123456'@'localhost' identified by '1230123';
#查看用户权限
show grants for 'frank'@'localhost';
#赋予权限 test数据库的score表
#grant all on test.score to 'frank'@'localhost';
#这里的all是指将test.score的所有权限都给frank
#撤销权限
#revoke all on test.score from 'frank'@'localhost';

show tables;
create table student(
	学号 char(8),
    姓名 varchar(3),
    性别 char(1),
    年龄 varchar(3),
    所在系 varchar(10),
    primary key(学号)
#参照 foreign key(外码/参照列) references <被参照表>(被参照列)
);
#显示当前搜索路径（模式）
# show search_path;
#创建模式(相当于数据库)
show schemas;
create schema st;
drop schema st;

show tables;
describe student;
select * from student;
drop table student;
#插入数据
insert into student(学号,姓名,性别,年龄,所在系) value('21010531','吴凡','男','20','计算机');
#修改表
#插入入学年份列
alter table student add 入学时间 char(5);
delete from student where 学号='21010531';
insert into student(学号,姓名,性别,年龄,所在系,入学时间) value('21010531','吴凡','男','20','计算机','2021');
#修改数据类型
alter table student modify column 入学时间 varchar(8);
alter table student modify column 学号 varchar(15);
#修改字段名
alter table student rename column 所在系 to 所在院系;
#删除字段
alter table student drop column 入学时间;
#删除表
#drop table <表名> [restrict|cascade];
#restrict有限制删除，不能被别的表引用，不能有视图，不能有触发器，不能有存储过程或函数
#cascade无限制删除，将其相关依赖对象全部删除
#添加性别约束
#性别 char(2) default '男' check (性别 in ('男','女'));
