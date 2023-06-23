show databases;
use frank_sql;
show tables;
describe student;
delete from student where 学号='21010531';
insert into student(学号,姓名,性别,年龄,所在院系) value ('201215121','李勇','男','20','CS');
insert into student(学号,姓名,性别,年龄,所在院系) value ('201215122','刘晨','女','19','CS');
insert into student(学号,姓名,性别,年龄,所在院系) value ('201215123','王敏','女','18','MA');
insert into student(学号,姓名,性别,年龄,所在院系) value ('201215125','张立','男','19','IS');
select * from student;
# 表的引擎类型
#InnoDB 引擎 行级别锁 支持事务
#MyISM 引擎 表级锁 不支持rollback

create table course(
	课程号 varchar(3),
    课程名 varchar(10),
    先行课 varchar(3),
    学分 varchar(3),
    primary key(课程号)
);
insert into course(课程号,课程名,先行课,学分) value('1','数据库','5','4');
insert into course(课程号,课程名,先行课,学分) value('2','数学',NULL,'2');
insert into course(课程号,课程名,先行课,学分) value('3','信息系统','1','4');
insert into course(课程号,课程名,先行课,学分) value('4','操作系统','6','3');
insert into course(课程号,课程名,先行课,学分) value('5','数据结构','7','4');
insert into course(课程号,课程名,先行课,学分) value('6','数据处理',NULL,'2');
insert into course(课程号,课程名,先行课,学分) value('7','PASCAL语言','6','4');
select * from course;
show tables;
create table SC(
	学号 char(12),
    课程号 char(2),
    成绩 char(3),
    primary key(学号,课程号)
);
insert into SC(学号,课程号,成绩) value('201215121','1','92');
insert into SC(学号,课程号,成绩) value('201215121','2','85');
insert into SC(学号,课程号,成绩) value('201215121','3','88');
insert into SC(学号,课程号,成绩) value('201215122','2','90');
insert into SC(学号,课程号,成绩) value('201215122','3','80');
select *from SC;

#create table if not exists SC(
#	sno varchar(20),
#    cno varchar(20),
#    grade int,
#    primary key(sno,cno),
#    foreign key(sno) references student(sno)
#		on delete cascade on update cascade,  当删除更新student表时 级联删除更新sc数据
#	foreign key(cno) references course(cno)
#		on delete cascade on update cascade  当删除更新course表时 级联删除更新sc数据
#        );

# check([字段名] in('[值],[值]')

