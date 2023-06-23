#锁
use frank_sql;
#查看表是否有锁
show open tables;
#给表添加锁
lock tables course read; #读锁
lock tables course write; #写锁
show open tables where In_use>0;
#释放锁
unlock tables;


#InnoDB一共有四种锁：共享锁（读锁/S锁）、排他锁（写锁/X锁）、意向共享锁（IS锁）和意向排他锁（IX锁）。
#其中共享锁与排他锁属于行级锁，另外两个意向锁属于表级锁。
#共享锁（读锁/S锁）：若事务T对数据对象A加上S锁，则事务T可以读A但不能修改A，其他事务只能再对A加S锁，而不能加X锁，直到T释放S锁。
#排他锁（写锁/X锁）：若事务T对数据对象A加上X锁，则只允许T读取和修改A，其他事务不能再对A加作何类型的锁，直到T释放A上的X锁。
#意向共享锁（IS锁）：事务T在对表中数据对象加S锁前，首先需要对该表加IS（或更强的IX）锁。
#意向排他锁（IX锁）：事务T在对表中的数据对象加X锁前，首先需要对该表加IX锁。
#例如：
# SELECT ... FROM T1  LOCK IN SHARE MODE
# 语句首先会对表T1加IS锁，成功加上IS锁后才会对数据加S锁。
# SELECT ... FROM T1  FOR UPDATE
# 语句首先会对表T1加IX锁，成功加上IX锁后才会对数据加X锁。

#mysql加行锁的方法：
#    1.select … for update
#    对读取的记录加独占（排他）锁；
#    2.select … lock in share mode
#    对读取的记录加共享锁；
#    3.使用delete
#    自动加独占锁；
#    4.使用update
#    自动加独占锁；
#锁的规则：
#共享锁（S锁）满足读读共享，读写互斥。独占锁（X锁）满足写写互斥、读写互斥。




#排他锁 全局锁 行锁 表锁 乐观锁 悲观锁等详见博客
