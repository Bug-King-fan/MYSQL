select database();
show tables;
create table if not exists usr(
    id int primary key auto_increment,
    usrname varchar(20) not null,
    password varchar(256) not null
);

insert into usr(usrname, password) values('admin', md5('admin'));
insert into usr(usrname, password) values('user1', md5('user1'));
insert into usr(usrname, password) values('user2', md5('user2'));
insert into usr(usrname, password) values('user3', '123');

select * from usr;
select * from usr where usrname = 'admin' and password = md5('admin');

select * from usr where usrname = 'user3' and password ='123';

