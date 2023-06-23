show databases;
use frank_sql;
show tables;
#创建索引
#① 普通索引
#create index 索引名 on 表名(索引属性);
#② 唯一索引
#create unique index 索引名 on 表名(索引属性);
#③ 全文索引
#create fulltext index 索引名 on 表名(索引属性);
#④ 多列索引
#create index 索引名 on 表名(索引属性1,索引属性2...);
#5、修改方式建立索引
#alter table 表名 add (索引类型(例index)) 索引名(索引属性);
#修改索引名
#alter 索引类型 <旧索引名> rename to <新索引名>
#删除索引
#drop 索引类型 索引名 on 表名; 
#显示索引  \G：将查询到的横向表格纵向输出，方便阅读。
#SHOW INDEX FROM 表名\G
