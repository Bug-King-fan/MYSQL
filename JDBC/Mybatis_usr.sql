select database();
show tables ;
create table if not exists user(
    id int primary key auto_increment,
    username varchar(20),
    brithday date,
    sex char(1) default '男',
    address varchar(50)
);
describe user;

insert into user values(null,'孙悟空','1980-10-24','男','花果山');
insert into user values(null,'猪八戒','1983-05-20','男','高老庄');
insert into user values(null,'白骨精','1992-11-12','女','白骨洞');
insert into user values(null,'蜘蛛精','1995-03-22','女','盘丝洞');

insert into user values(null,'124','1924-03-22','女','56');
delete from user where id = 9;
select max(id) from user;
alter table user auto_increment = 5;
select * from user;