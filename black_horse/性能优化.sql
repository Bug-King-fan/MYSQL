#查看累计插入和返回数据条数
show global status like 'Innodb_rows%';
use frank_sql;
show databases;
select * from student;
#实验
#1、创建表
create table if not exists user
(
    id       INT,
    username VARCHAR(32),
    password VARCHAR(32),
    sex      varchar(6),
    email    varchar(50)
);

#2、创建存储过程，实现批量插入
# 声明存储过程结束标记未$$
DELIMITER $$
create procedure auto_insert()
BEGIN
    DECLARE i INT DEFAULT 1;
    START TRANSACTION ;
    WHILE (i <= 10000000)
        DO
            INSERT INTO user VALUES (i, concat('user_', i), MD5(i), concat('sex_', i), concat('email_', i));
            SET i = i + 1;
        END WHILE;
    COMMIT;
END $$
DELIMITER ;

#3、查看存储过程
show create procedure auto_insert;
#3、调用存储过程
call auto_insert();
#4、查看累计插入和返回数据条数
show global status like 'Innodb_rows%';

#插入及其消耗时间
#由此引出索引
#索引
# 主键索引 在创建表时声明primary key时就自动生效
# 唯一索引
# 普通索引
# 组合索引 多字段组成索引
# 全文索引 效率低，用es、solr等插件替代
# 哈希索引  不适合范围索引
#① 普通索引
#create index 索引名 on 表名(索引属性);
#② 唯一索引
#create unique index 索引名 on 表名(索引属性);
#③ 全文索引
#create fulltext index 索引名 on 表名(索引属性);
#④ 多列索引
#普通组合索引
#create index 索引名 on 表名(索引属性1,索引属性2...);
#唯一组合索引
#create unique index 索引名 on 表名(索引属性1,索引属性2...);
#⑤ 哈希索引
# MySQL 目前并不直接支持创建哈希索引，通常可以通过使用 MEMORY 存储引擎来实现哈希索引：
# create index 索引名 on 表名(索引属性) using hash;
# 注意：只有 MEMORY 存储引擎支持哈希索引。

#5、修改方式建立索引 [主键默认名：primary 唯一默认名：字段名 普通默认名：字段名]
#alter table 表名 add (索引类型(例index)) 索引名(索引属性);
#alter table 表名 add unique index uid(id);
#修改索引名
#alter 索引类型 <旧索引名> rename to <新索引名>
#删除索引
#drop 索引类型 索引名 on 表名;
#显示索引  \G：将查询到的横向表格纵向输出，方便阅读。
SHOW INDEX FROM student;

#B+树：划分了叶子节点和非叶子节点[为提高查询效率，针对叶子维护了一个类似双向链表的结构]
# ---叶子节点：  存储索引和指针
# ---非叶子节点：存储数据
#mysql中每个节点16KB，每个节点存储元素数量：16*1024/(8[索引占8字节]+6[一个指针6字节])=1170 个 ，
# 当非叶子节点高度为2时，存储数据的节点数为：1170**2=130W个
show global status like 'Innodb_page_size';



