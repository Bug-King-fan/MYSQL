show tables;
# 使用表
create database book2;
use book2;
show databases;
drop table book2.book;
drop table book2.reader;
drop table book2.borrow;
create table book(
	书号 varchar(15) not null,
    类别 varchar(10) not null,
    出版社 varchar(20) not null,
    作者 varchar(15) not null,
    书名 varchar(15) not null,
    定价 varchar(8) not null,
    数量 int not null,
    购买日期 date not null,
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
    借阅日期 date not null,
    还书日期 date not null,
    primary key(书号,读者编号),
    foreign key (书号) references book(书号),
    foreign key (读者编号) references reader (编号)
);



