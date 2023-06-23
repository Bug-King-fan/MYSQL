create database spj;
use SPJ;
create table S(
	sno char(2) not null,
    sname varchar(10) not null,
    `status` int not null,
    city varchar(3),
	primary key(sno)
);
create table P(
	pno char(2) not null,
    pname varchar(10) not null,
    color varchar(5) not null,
    weight int not null,
    primary key(pno)
);
create table J(
	jno char(2) not null,
    jname varchar(10) not null,
    city varchar(3) not null,
    primary key(jno)
);
create table SPJ(
	sno char(2) not null,
    pno char(2) not null,
    jno char(2) not null,
    qty int not null,
    primary key(sno,pno,jno)
);

INSERT INTO `spj`.`s` (`sno`, `sname`, `status`, `city`) VALUES ('S1', '精益', '20', '天津');
INSERT INTO `spj`.`s` (`sno`, `sname`, `status`, `city`) VALUES ('S2', '盛锡', '10', '北京');
INSERT INTO `spj`.`s` (`sno`, `sname`, `status`, `city`) VALUES ('S3', '东方红', '30', '北京');
INSERT INTO `spj`.`s` (`sno`, `sname`, `status`, `city`) VALUES ('S4', '丰泰盛', '20', '天津');
INSERT INTO `spj`.`s` (`sno`, `sname`, `status`, `city`) VALUES ('S5', '为民', '30', '上海');

INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P1', '螺母', '红', '12');
INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P2', '螺栓', '绿', '17');
INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P3', '螺丝刀', '蓝', '14');
INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P4', '螺丝刀', '红', '14');
INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P5', '凸轮', '蓝', '40');
INSERT INTO `spj`.`p` (`pno`, `pname`, `color`, `weight`) VALUES ('P6', '齿轮', '红', '30');

INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J1', '三建', '北京');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J2', '一汽', '长春');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J3', '弹簧厂', '天津');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J4', '造船厂', '天津');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J5', '机车厂', '唐山');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J6', '无线电厂', '常州');
INSERT INTO `spj`.`j` (`jno`, `jname`, `city`) VALUES ('J7', '半导体厂', '南京');

INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S1', 'P1', 'J1', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S1', 'P1', 'J3', '100');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S1', 'P1', 'J4', '700');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S1', 'P2', 'J2', '100');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P3', 'J1', '400');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P3', 'J2', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P3', 'J4', '500');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P3', 'J5', '400');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P5', 'J1', '400');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S2', 'P5', 'J2', '100');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S3', 'P1', 'J1', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S3', 'P5', 'J1', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S4', 'P5', 'J1', '100');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S4', 'P6', 'J3', '300');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S4', 'P6', 'J4', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S5', 'P2', 'J4', '100');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S5', 'P3', 'J1', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S5', 'P6', 'J2', '200');
INSERT INTO `spj`.`spj` (`sno`, `pno`, `jno`, `qty`) VALUES ('S5', 'P6', 'J4', '500');

# 
select sno from spj where jno = 'j1';
select sno from spj where jno='j1' and pno = 'p1';
select sno from spj where jno='j1' and pno in (select pno from p where color='红');

select distinct jno from spj where spj.sno in 
(select s.sno from s where city <> '天津') and 
spj.pno in (select p.pno from p where color <> '红');

select distinct jno from spj where sno='S1';
select sname,city from s;
select pname,color,weight from p;
select jno from spj where sno='S1';

with t as (select jno,pno,qty from spj where jno = 'J2')
select pname,qty from t left join p on t.pno = p.pno;

select distinct pno from spj where sno in(select sno from s where city ='上海');

select jname from j where jno in(
select distinct jno from spj where sno in(select sno from s where city ='上海') 
and pno in (select distinct pno from spj where sno in 
(select sno from s where city ='上海')));

#12
select jno from spj where jno not in(
select distinct jno from spj left join s on spj.sno=s.sno where city = '天津');
#13
select * from p;
update p set color='蓝' where color='红' and pno in('P1','P4','P6');
select * from p;
update p set color='红' where pno='P1' or pno='P4' or pno='P6';
select * from p;
#14
select * from spj where sno='S5' and jno='J4' and pno ='P6';
update spj set sno='S3' where sno='S5' and jno='J4' and pno ='P6';
select * from spj;
update spj set sno='S5' where sno='S3' and jno='J4' and pno ='P6';
#15
select * from s;
delete from s where sno='s2';
delete from spj where sno='s2';
#16
insert into spj values('S2','P4','J6',200);
DELETE FROM `spj`.`spj` WHERE (`sno` = 'S2') and (`pno` = 'P4') and (`jno` = 'J6');
#17
select * from j;
select sno,pno,qty from spj where jno in (select jno from j where jname='三建');
create view 三建供应情况 as (select sno,pno,qty from spj where jno in (select jno from j where jname='三建'));
drop view 三建供应情况;
select * from 三建供应情况;
select pno,sum(qty) as 数量 from 三建供应情况 group by pno;
select * from 三建供应情况 where sno='S1';