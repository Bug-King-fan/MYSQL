create database book_reader_db;
show databases;
use book_reader_db;
show tables;

select user();
select database();

describe book;
describe reader;
describe borrow;

create table book(
	书号 varchar(15) not null,
    类别 varchar(10) not null,
    出版社 varchar(20) not null,
    作者 varchar(15) not null,
    书名 varchar(15) not null,
    定价 varchar(8) not null,
    备注 varchar(50),
    primary key(书号)
);
create table reader(
	编号 varchar(15) not null,
    姓名 varchar(5) not null,
    单位 varchar(20) not null,
    性别 enum('男','女') not null,
    电话 varchar(20) not null,
    primary key(编号)
);
create table borrow(
	书号 varchar(15) not null,
    读者编号 varchar(10) not null,
    借阅日期 varchar(20) not null,
    primary key(书号,读者编号),
    foreign key (书号) references book(书号),
    foreign key (读者编号) references reader (编号)
);
#FOREIGN KEY (子表id) REFERENCES 关联表名(外主表id);
#ALTER TABLE 表1 ADD FOREIGN KEY (从表的外键) REFERENCES dept(主表的主键);
#alter table 表名 drop foreign key 外键名;  删除外键
#show create table 表名   查询外键名系统自动给一个

alter table borrow add 还书日期 varchar(20) not null;
alter table book add 数量 varchar(5) not null;
alter table book add 购买日期 varchar(20) not null;

# 插入数据
select * from reader;
insert into reader(编号,姓名,单位,性别,电话) value('001','吴凡','上饶师范学院','男','17331203925');
insert into reader(编号,姓名,单位,性别,电话) value('002','王微','河北外国语学院','女','13581503914');
insert into reader(编号,姓名,单位,性别,电话) value('003','路人甲','网易雷火','男','110110110');

select * from book;
#修改位置
#ALTER TABLE 表名 MODIFY 字段名1 数据类型 FIRST ｜ AFTER 字段名2; first指位置
alter table book modify 数量 varchar(5) after 定价;
alter table book modify 购买日期 varchar(20) after 数量;
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000001','计算机','北京邮电大学出版社','张三','C++程序设计','99.9','5','2021.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000002','计算机','杭州电子科技大学出版社','李四','数据结构','89.0','3','2022.06.19',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000003','计算机','北京大学出版社','屈婉玲','算法设计与分析','599.9','1','2023.01.01','唯一本典藏');
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000004','中文系','河北大学出版社','王五','中文词典','15.0','16','2021.07.29',null);

select * from borrow;
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000001','001','2023.02.01','2023.03.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000002','002','2023.01.19','2023.02.19');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000003','001','2023.02.01','2023.03.01');

# sql查询操作
select * from book;
select * from book where 类别='计算机';
select count(*) from book group by 类别;
select * from reader;
select * from borrow;
select 读者编号,count(书号) from borrow group by 读者编号 order by 读者编号;
select 书号,count(读者编号) from borrow group by 书号 order by 书号;

