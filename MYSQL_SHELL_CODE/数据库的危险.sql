use frank_sql;
#  SQL注入 添加or 1=1 值为真 数据透明 
select * from student where 学号='2101';
select * from student where 学号='2101' or 1=1;

# grant 授权
# revoke 收回权限
# grant <权限>[,<权限>...[所有权限：all]] on <对象类型><对象名>[,<对象类型><对象名>...] to <用户>[,<用户>...] [with grant option];
# [with grant option] 代表被授权的用户也具有授权 这些被授予的权限 的权限 !!!
# revoke <权限>[,<权限>...[所有权限：all]] on <对象类型><对象名>[,<对象类型><对象名>...] from <用户>[,<用户>...] [cascade|restrict];

# 角色授权
# 一个角色可以有多个用户 一个用户可以有多个角色
# 所有学生可以是一个角色 ....
# 创建角色
# create role <角色名>
# 给角色授权
# grant <权限>[,<权限>...[所有权限：all]] on <对象类型><对象名>[,<对象类型><对象名>...] to <角色>[,<角色>];
# 将一个角色授权给其他角色或用户
# grant <角色>[,<角色>...] to <角色>[,<用户>...];
# 角色权限收回
# revoke <权限>[,<权限>...[所有权限：all]] on <对象类型><对象名>[,<对象类型><对象名>...] from <角色>[,<角色>];
#例
# create role 'user1';
# 给用户分配角色
# grant user1 to frank@localhost;
# !!!!分配后必须激活
# set default role all to 'frank'@'localhost';
# 给用户撤销角色
# revoke 'user1'from 'frank'@'localhost';
# 删除角色
# drop role 'user1';
# 删除用户
# drop user 'frank'@'localhost';



select user();
create user 'frank'@'localhost' identified by '123456';
select user,host from mysql.user;
grant select on table sc to 'frank'@'localhost';
revoke select on table sc from 'frank'@'localhost';
#显示frank的权限
show grants for frank@localhost;
drop user 'frank'@'localhost';


