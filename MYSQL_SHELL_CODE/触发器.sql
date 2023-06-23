use frank_sql;
show tables;

select * from sc;
describe sc;
select * from student;
select * from course;

# 触发器
#DELIMITER &&
#CREATE TRIGGER 触发器名 BEFORE|AFTER 触发事件
#ON 表名 FOR EACH ROW
#BEGIN
#  执行语句列表
#END &&
#DELIMITER ; 将结束符修改回去

#NEW和OLD是MySQL触发器中的两个伪行，它们分别代表触发器执行前和执行后的行。
#例如，在BEFORE INSERT触发器中，NEW代表将要插入的行，而OLD则没有意义。
#在AFTER UPDATE触发器中，NEW代表更新后的行，而OLD则代表更新前的行。
#可以使用它们来获取行的值或者进行一些其他操作。

#执行的时候会报ERROR 1415 Not allowed to return a result set from a trigger 的错误。
#MySQL5早期版本是支持的，现在的新版本已经不支持这种写法。
#触发器不允许出现SELECT *的形式，因为这会返回一个结果集，而这是不允许的，
#所以会报出这种错。
#触发器中可以使用SELECT  INTO的形式来进行查询，将结果放进一个变量，然后查询该变量。

# declare 触发器中定义数据类型
# DELIMITER && 修改结束标志为 &&
DELIMITER &&
create trigger updata_student_sno after update on student for each row
begin
	declare s1 char(12);
    declare s2 char(12);
    select new.学号 into s2;# s2赋值原学号
    select old.学号 into s1;# s1赋值原学号
    update sc set 学号 = s2 where 学号=s1;
end &&
DELIMITER ;
#删除触发器
drop trigger updata_student_sno;
show triggers;

update student set 学号='201215157' where 学号 = '201215122';
update student set 学号='201215122' where 学号 = '201215157';

