use book_reader_db;
select * from book;
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000007','计算机','机械工业出版社','周扒皮','C++程序设计','89.9','5','2021.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000008','计算机','清华大学出版社','老六','C++程序设计','129.0','1','2021.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000009','环境','清华大学出版社','狗八','环境破坏','19.9','5','2022.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000010','语言','机械工业出版社','狗大','全球语','87.9','5','2011.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000011','计算机','清华大学出版社','严蔚敏','数据结构','77.9','5','2011.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000012','计算机','西安电子工业出版社','侯捷','操作系统','67.9','5','2011.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000013','土木','工地出版社','猫大','土木1','100.0','5','2011.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000014','土木','工地出版社','猫二','土木2','1.0','5','2011.05.09',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000015','土木','工地出版社','猫三','土木3','1.0','5','2011.05.09',null);
delete from book where 书号='000015';
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000016','土木','工地出版社','猫四','土木4','1.0','5','2011.05.09',null);


select * from borrow;
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000011','001','2023.03.17','2023.04.17');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000012','002','2023.03.17','2023.04.17');


select * from book where 类别='计算机' union select * from book where 出版社='机械工业出版社';
select * from book where 出版社='清华大学出版社' and 书名 not in (select 书名 from book where 出版社='机械工业出版社');
select * from book where 出版社='清华大学出版社' and 类别='环境';

select 读者编号 from borrow left join book on borrow.书号=book.书号 where 书名='数据结构' and 出版社='清华大学出版社' 
union
select 读者编号 from borrow left join book on borrow.书号=book.书号 where 书名='操作系统' and 出版社='西安电子工业出版社';

# 2
select 类别 from book group by 类别 having max(定价)>= 2*avg(定价);
select 类别,avg(定价) as 平均价格 from book where 出版社='机械工业出版社' group by 类别;
select 书号,书名,定价,数量,数量*定价 as 总价 from book where 类别='计算机';

select 书号,书名,定价 from book where 类别='计算机';
select 出版社,类别,sum(定价*数量) as 总价 from book where 类别='计算机' group by 出版社,类别;
select sum(数量) as 全部册数,sum(定价*数量) as 总价 from book where 类别='计算机';

select 出版社,sum(数量) as 订购数量 from book group by 出版社 order by 订购数量 desc limit 1;

select sum(数量) as 总数量 from book where 购买日期>='2020.00.01';

select 类别,count(*) as 借出册数 from borrow left join book on borrow.书号=book.书号 group by 类别 order by 借出册数 desc;
select * from borrow left join book on borrow.书号=book.书号;

select 书号,count(读者编号) as 借阅次数 from borrow group by 书号 order by 借阅次数 desc;

#创建临时表
with t as (select 书名,定价*数量 as 总价值 from book)
select * from t;


