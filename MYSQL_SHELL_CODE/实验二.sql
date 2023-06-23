use book_reader_db;
show tables;

select * from book;
select * from borrow;
select * from reader;

insert into reader(编号,姓名,单位,性别,电话) value('004','网易有道','北京市西二旗','女','18915493277');
insert into reader(编号,姓名,单位,性别,电话) value('005','网易游戏','杭州','男','15935457677');
insert into reader(编号,姓名,单位,性别,电话) value('006','网易互娱','广州','女','11025796217');
insert into reader(编号,姓名,单位,性别,电话) value('007','网易严选','互联网','男','11967796217');
insert into reader(编号,姓名,单位,性别,电话) value('008','网易互联网','杭州','女','12077795217');
insert into reader(编号,姓名,单位,性别,电话) value('009','新东方','北京市海淀区','男','400-000-7879');
insert into reader(编号,姓名,单位,性别,电话) value('010','东方甄选','互联网','女','400-111-8569');
insert into reader(编号,姓名,单位,性别,电话) value('011','艺电','美国','男','400-100-999');
insert into reader(编号,姓名,单位,性别,电话) value('012','DICE','美国','女','400-120-888');

insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000005','环境','中国人民大学出版社','赵六','环境工程','39.9','3','2021.02.21',null);
insert into book(书号,类别,出版社,作者,书名,定价,数量,购买日期,备注) value('000006','环境','中国地址大学出版社','孙七','环境治理及保护','50.0','7','2021.03.17',null);

insert into borrow(书号,读者编号,借阅日期,还书日期) value('000005','001','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000005','002','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000006','003','2023.01.01','2023.01.15');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','001','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','002','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','003','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','005','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','006','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','007','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','008','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','009','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','010','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','011','2022.12.01','2022.12.31');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000004','012','2022.12.01','2022.12.31');

select 编号,姓名,单位 from reader where 编号 in (select 读者编号 from borrow where 书号 in (select 书号 from book where 类别 = '环境'));

select 编号,姓名,单位 from reader where 编号 in (select 读者编号 from borrow);

select 书号,书名 from book where 书号 in (select 书号 from borrow where 读者编号 in (select 编号 from reader where 姓名 = '吴凡'));

select 姓名 from reader where 编号 not in (select 读者编号 from borrow);

select 书名,书号 from book where 书号 in (select 书号 from borrow group by 书号 having count(*)>=10);
 
#  插入数据
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000001','012','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000002','012','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000003','012','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000005','012','2023.03.01','2023.04.01');
insert into borrow(书号,读者编号,借阅日期,还书日期) value('000006','012','2023.03.01','2023.04.01');
#

select 编号,姓名 from reader where 编号 in (select 读者编号 from borrow group by 读者编号 having count(书号) >= 5);
