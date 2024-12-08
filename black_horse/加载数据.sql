#load data infile命令导入 ！！！！适用于数据量很大的情况！
show variables like '%secure%';
#修改my.ini mysqld下
#secure_file_priv = ''
#还原 my.ini修改 mysqld下
#secure_file_priv = 'E:\MySQL_database\Uploads'
#将数据放在'secure_file_priv' 对应路径下 否则会提示权限不够

show variables like 'local_infile';
set global local_infile=1;
#最后还原为off
set global local_infile=off;

load data infile 'E:\\MySQL_database\\Uploads\\p2_mars_tianchi_songs.csv' # 文件路径
    into table mars_tianchi_songs             # 表名
    character set UTF8MB4                 # 编码
    fields terminated by ','           # 分隔符
    lines terminated by '\r\n'         # 换行符，windows下是\r\n
;
# ignore 1 lines;    # 忽略第一行