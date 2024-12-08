# 主键约束 primary key
# 唯一约束 unique
# 外键约束 foreign key
# 检查约束 check
# 默认约束 default 默认值
# 非空约束 not null
# 笛卡尔积 内外链接 子查询

#高级玩法：
create table t as (select * from t_user);

create table t_user(
    #主键 自增
    id int primary key auto_increment,
    name varchar(20) not null,
    age int check ( age > 0 and age < 120 ),
    tel char(11) unique,
    # now()获取当前系统时间
    birthday date default now(),
    course varchar(20),
    #外键约束
    constraint 外键名 foreign key (course) references t_course(course_name)
);
#重置自增
alter table t_user auto_increment = 1;

#指定字段添加非空约束
alter table t_user modify name varchar(20) not null;

#删除外键约束
# ALTER TABLE 从表名 drop FOREIGN KEY 外键名


#面试：唯一约束+非空约束 与 主键约束区别？【多个主键复合成一个主键约束】
#   1、主键约束只允许存在一个，但唯一约束+非空约束可以存在多个
#   2、主键约束可以添加自增，但唯一约束+非空约束不可以
#   3、主键约束底层维护主键索引，而唯一约束维护唯一索引

#外键设计：
# 一对一：
#     法一：合成一张表
#     法二：任意一方为从表，添加唯一约束和外键约束
# 多对多：
#     创建中间表，将两个外键提出来组成一张新表，并各自添加外键约束
# 一对多：
#     外键创建在多表上

#级关联删除和更新
# on update cascade
# on delete cascade
# 或删除时drop table <表名> [(默认)restrict|cascade];
# restrict有限制删除，不能被别的表引用，不能有视图，不能有触发器，不能有存储过程或函数
# cascade无限制删除，将其相关依赖对象全部删除
alter table t_user add constraint fk foreign key(course) references course(course_id)
    on update cascade on delete cascade ;

#笛卡尔积[隐式内连接]
select * from t_user, student;
#消除笛卡尔积
select * from t_user, student where t.id = student.id;

#内链接
select * from t_user inner student on t.id = student.id;

#左外连接 左表中所有记录返回，右表如果没有匹配的记录，返回null【称未匹配的为悬浮元组】
select * from t_user left join student on t_user.id = student.id;
#右外连接 右表中所有记录返回，左表如果没有匹配的记录，返回null【称未匹配的为悬浮元组】
select * from t_user right join student on t_user.id = student.id;

#子查询
select * from t_user,(select name from s) as 从 where id in (select id from student);

