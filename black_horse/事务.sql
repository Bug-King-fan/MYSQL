# 事务的四大特点：ACID 原子性 一致性 隔离性 持久性
# 事务是一种机制，包含了一组数据库操作命令，这组命令要么全部执行，要么全部不执行
/*
 MySQL数据库机制：
    1、自动提交（默认）
        没执行一条语句开启一个事务，
    2、手动提交(要写代码)
        先开启事务，执行SQL语句，然后提交事务（或回滚）
 */

#查询事务
select @@autocommit;

#设置事务 0代表手动 1代表自动
set autocommit = 0;

#开启事务
start transaction;

#众多SQL语句


#提交事务 [提交才会改变] 和回滚二选一
commit;

#回滚事务 [成功不需要回滚，失败需要回滚]
rollback;

set autocommit = 1;

# 事务隔离级别: read uncommitted 读未提交
#             read committed 读已提交    Oracle和SQL Server默认
#             repeatable read  重复读    MySQL默认
#             serializable 串行
# 使用不同级别安全性和性能对比
# 安全：串行>重复读>读已提交>读未提交
# 性能：串行<重复读<读已提交<读未提交
use frank_sql;
# 查看隔离级别
SELECT @@transaction_isolation;
# 或
show variables like 'tx_isolation';

# 设置隔离级别
set global transaction isolation level read committed;
