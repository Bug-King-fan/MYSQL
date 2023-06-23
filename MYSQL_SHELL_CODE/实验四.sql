use book_reader_db;
show tables;
select * from book;
select * from reader;
select * from borrow;


create view view1 as select * from book;
select 书名 from view1;

alter table borrow modify column 借阅日期 date;
alter table borrow modify column 还书日期 date;

insert into borrow(书号,读者编号,借阅日期,还书日期) value('000007','001','2023-01-01','2023-03-16');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000007','002','2023-01-25','2023-04-01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000007','003','2023-02-01','2023-04-17');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000007','008','2023-01-15','2023-04-16');

create view view2 as (
select 读者编号,姓名,单位,电话,book.书号,书名,借阅日期,
date_add(借阅日期,interval '60' day) as 应归还日期,还书日期, 
datediff(还书日期,date_add(借阅日期,interval '60' day)) as 逾期天数 
from book,reader,borrow 
where book.书号=borrow.书号 and borrow.读者编号 = reader.编号 
and datediff(还书日期,date_add(借阅日期,interval '60' day))>0);

select *,(逾期天数*1) as 罚款金额 from view2;

# 2 
create user 'u1'@'localhost' identified by '123456';
create user 'u2'@'localhost' identified by '123456';
create user 'u3'@'localhost' identified by '123456';
create user 'u4'@'localhost' identified by '123456';
create user 'u5'@'localhost' identified by '123456';
create user 'u6'@'localhost' identified by '123456';

select user,host from mysql.user;

alter table book modify column 购买日期 date;
grant select on table book to 'u1'@'localhost' with grant option;
grant insert on table borrow to 'u3'@'localhost';
grant insert on table book to 'u4'@'localhost';
grant alter on table reader to 'u5'@'localhost';

revoke select on table book from 'u1'@'localhost';
revoke select on table book from 'u2'@'localhost';
revoke insert on table borrow from 'u3'@'localhost';
revoke insert on table book from 'u4'@'localhost';
revoke alter on table reader from 'u5'@'localhost';

show grants for u5@localhost;

drop user u1@localhost;
drop user u2@localhost;
drop user u3@localhost;
drop user u4@localhost;
drop user u5@localhost;
drop user u6@localhost;



