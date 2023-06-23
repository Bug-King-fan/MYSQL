create database Aliyun;
use aliyun;
create table mars_tianchi_user_actions(
	user_id varchar(200),
	song_id varchar(200),
    gmt_create varchar(200),
    action_type enum('1','2','3'),
    Ds varchar(10)
);

create table mars_tianchi_songs(
	song_id varchar(200),
    artist_id varchar(200),
    publish_time varchar(10),
    song_init_palys varchar(20),
    `Language` varchar(20),
    Gender varchar(20),
    primary key(song_id)
);


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
lines terminated by '\n'         # 换行符，windows下是\r\n
;
# ignore 1 lines;    # 忽略第一行


select count(*) from mars_tianchi_songs; #26958条
select * from mars_tianchi_songs limit 500;

load data infile 'E:\\MySQL_database\\Uploads\\p2_mars_tianchi_user_actions.csv' # 文件路径
into table mars_tianchi_user_actions             # 表名
character set UTF8MB4                 # 编码
fields terminated by ','           # 分隔符
lines terminated by '\n'         # 换行符，windows下是\r\n
;

select count(*) from mars_tianchi_user_actions;#15884087条


#查询操作

#1
select * from mars_tianchi_user_actions group by user_id having count(*)=1;

#2
with t as (select distinct user_id from mars_tianchi_user_actions)
select count(*) as 用户数量 from t;

#3
select song_id,count(*) as 行为量 from mars_tianchi_user_actions group by song_id;

#4
select song_id from mars_tianchi_user_actions group by song_id having count(*)=1;

#5
select song_id,sum(action_type='1') as 播放量,sum(action_type='2') as 下载量,
sum(action_type='3') as 收藏量 from mars_tianchi_user_actions group by song_id;
#等价于
select song_id,sum(if(action_type='1',1,0)) as 播放量,sum(if(action_type='2',1,0)) as 下载量,
sum(if(action_type='3',1,0)) as 收藏量 from mars_tianchi_user_actions group by song_id;

#6
with t as (select artist_id from mars_tianchi_songs group by artist_id)
select count(*) as 艺人数量 from t; 

#7
select artist_id,count(*) as 歌曲数量 from mars_tianchi_songs group by artist_id order by 歌曲数量 desc;

#8对于所有艺人每天的播放量 下载量 收藏量 
create table mars_tianch_artist_play_download_collect_counts(
	artist_id varchar(200),
    play_counts int,
    download_counts int,
    collect_counts int,
    Ds varchar(10)
);

#9


insert into mars_tianch_artist_play_download_collect_counts with t as(
select song_id,Ds,count(action_type='1') as 播放量,count(action_type='2') as 下载量,
count(action_type='3') as 收藏量  from mars_tianchi_user_actions group by song_id,Ds
)
select artist_id,sum(播放量) as 播放,sum(下载量) as 下载,sum(收藏量) as 收藏,Ds from mars_tianchi_songs left join t 
on mars_tianchi_songs.song_id=t.song_id group by artist_id,Ds;

#10
select * from mars_tianch_artist_play_download_collect_counts;
create view view_mars_tianchi_artist_palys_day as 
(select artist_id,play_counts+download_counts+collect_counts as plays,Ds 
from mars_tianch_artist_play_download_collect_counts);

#11
select * from view_mars_tianchi_artist_palys_day;

select * from view_mars_tianchi_artist_palys_day group by artist_id;

select * from mars_tianch_artist_play_download_collect_counts group by artist_id;

select artist_id,
	sum(case when Ds='20150301' then plays else 0 end) as d1,
    sum(case when Ds='20150302' then plays else 0 end) as d2,
    sum(case when Ds='20150303' then plays else 0 end) as d3,
    sum(case when Ds='20150304' then plays else 0 end) as d4,
    sum(case when Ds='20150305' then plays else 0 end) as d5,
    sum(case when Ds='20150306' then plays else 0 end) as d6,
    sum(case when Ds='20150307' then plays else 0 end) as d7,
    sum(case when Ds='20150308' then plays else 0 end) as d8,
    sum(case when Ds='20150309' then plays else 0 end) as d9,
    sum(case when Ds='20150310' then plays else 0 end) as d10,
    sum(case when Ds='20150311' then plays else 0 end) as d11,
    sum(case when Ds='20150312' then plays else 0 end) as d12,
    sum(case when Ds='20150313' then plays else 0 end) as d13,
	sum(case when Ds='20150314' then plays else 0 end) as d14,
    sum(case when Ds='20150315' then plays else 0 end) as d15,
    sum(case when Ds='20150316' then plays else 0 end) as d16,
    sum(case when Ds='20150317' then plays else 0 end) as d17,
    sum(case when Ds='20150318' then plays else 0 end) as d18,
    sum(case when Ds='20150319' then plays else 0 end) as d19,
    sum(case when Ds='20150320' then plays else 0 end) as d20,
    sum(case when Ds='20150321' then plays else 0 end) as d21,
    sum(case when Ds='20150322' then plays else 0 end) as d22,
    sum(case when Ds='20150323' then plays else 0 end) as d23,
    sum(case when Ds='20150324' then plays else 0 end) as d24,
    sum(case when Ds='20150325' then plays else 0 end) as d25,
    sum(case when Ds='20150326' then plays else 0 end) as d26,
    sum(case when Ds='20150327' then plays else 0 end) as d27,
    sum(case when Ds='20150328' then plays else 0 end) as d28,
    sum(case when Ds='20150329' then plays else 0 end) as d29,
    sum(case when Ds='20150330' then plays else 0 end) as d30,
    sum(case when Ds='20150331' then plays else 0 end) as d31,
    
    sum(case when Ds='20150401' then plays else 0 end) as d32,
    sum(case when Ds='20150402' then plays else 0 end) as d33,
    sum(case when Ds='20150403' then plays else 0 end) as d34,
	sum(case when Ds='20150404' then plays else 0 end) as d35,
    sum(case when Ds='20150405' then plays else 0 end) as d36,
    sum(case when Ds='20150406' then plays else 0 end) as d37,
    sum(case when Ds='20150407' then plays else 0 end) as d38,
    sum(case when Ds='20150408' then plays else 0 end) as d39,
    sum(case when Ds='20150409' then plays else 0 end) as d40,
    sum(case when Ds='20150410' then plays else 0 end) as d41,
    sum(case when Ds='20150411' then plays else 0 end) as d42,
    sum(case when Ds='20150412' then plays else 0 end) as d43,
    sum(case when Ds='20150413' then plays else 0 end) as d44,
    sum(case when Ds='20150414' then plays else 0 end) as d45,
    sum(case when Ds='20150415' then plays else 0 end) as d46,
    sum(case when Ds='20150416' then plays else 0 end) as d47,
    sum(case when Ds='20150417' then plays else 0 end) as d48,
    sum(case when Ds='20150418' then plays else 0 end) as d49,
    sum(case when Ds='20150419' then plays else 0 end) as d50,
    sum(case when Ds='20150420' then plays else 0 end) as d51,
    sum(case when Ds='20150421' then plays else 0 end) as d52,
    sum(case when Ds='20150422' then plays else 0 end) as d53,
    sum(case when Ds='20150423' then plays else 0 end) as d54,
    sum(case when Ds='20150424' then plays else 0 end) as d55,
    sum(case when Ds='20150425' then plays else 0 end) as d56,
    sum(case when Ds='20150426' then plays else 0 end) as d57,
    sum(case when Ds='20150427' then plays else 0 end) as d58,
    sum(case when Ds='20150428' then plays else 0 end) as d59,
    sum(case when Ds='20150429' then plays else 0 end) as d60,
    sum(case when Ds='20150430' then plays else 0 end) as d61,
    
    sum(case when Ds='20150501' then plays else 0 end) as d62,
    sum(case when Ds='20150502' then plays else 0 end) as d63,
    sum(case when Ds='20150503' then plays else 0 end) as d64,
    sum(case when Ds='20150504' then plays else 0 end) as d65,
    sum(case when Ds='20150505' then plays else 0 end) as d66,
    sum(case when Ds='20150506' then plays else 0 end) as d67,
    sum(case when Ds='20150507' then plays else 0 end) as d68,
    sum(case when Ds='20150508' then plays else 0 end) as d69,
    sum(case when Ds='20150509' then plays else 0 end) as d70,
    sum(case when Ds='20150510' then plays else 0 end) as d71,
    sum(case when Ds='20150511' then plays else 0 end) as d72,
    sum(case when Ds='20150512' then plays else 0 end) as d73,
    sum(case when Ds='20150513' then plays else 0 end) as d74,
    sum(case when Ds='20150514' then plays else 0 end) as d75,
    sum(case when Ds='20150515' then plays else 0 end) as d76,
    sum(case when Ds='20150516' then plays else 0 end) as d77,
    sum(case when Ds='20150517' then plays else 0 end) as d78,
    sum(case when Ds='20150518' then plays else 0 end) as d79,
    sum(case when Ds='20150519' then plays else 0 end) as d80,
    sum(case when Ds='20150520' then plays else 0 end) as d81,
    sum(case when Ds='20150521' then plays else 0 end) as d82,
    sum(case when Ds='20150522' then plays else 0 end) as d83,
    sum(case when Ds='20150523' then plays else 0 end) as d84,
    sum(case when Ds='20150524' then plays else 0 end) as d85,
    sum(case when Ds='20150525' then plays else 0 end) as d86,
    sum(case when Ds='20150526' then plays else 0 end) as d87,
    sum(case when Ds='20150527' then plays else 0 end) as d88,
    sum(case when Ds='20150528' then plays else 0 end) as d89,
    sum(case when Ds='20150529' then plays else 0 end) as d90,
    sum(case when Ds='20150530' then plays else 0 end) as d91,
    sum(case when Ds='20150531' then plays else 0 end) as d92,
    
    sum(case when Ds='20150601' then plays else 0 end) as d93,
    sum(case when Ds='20150602' then plays else 0 end) as d94,
    sum(case when Ds='20150603' then plays else 0 end) as d95,
    sum(case when Ds='20150604' then plays else 0 end) as d96,
    sum(case when Ds='20150605' then plays else 0 end) as d97,
    sum(case when Ds='20150606' then plays else 0 end) as d98,
    sum(case when Ds='20150607' then plays else 0 end) as d99,
    sum(case when Ds='20150608' then plays else 0 end) as d100,
    sum(case when Ds='20150609' then plays else 0 end) as d101,
    sum(case when Ds='20150610' then plays else 0 end) as d102,
    sum(case when Ds='20150611' then plays else 0 end) as d103,
    sum(case when Ds='20150612' then plays else 0 end) as d104,
    sum(case when Ds='20150613' then plays else 0 end) as d105,
    sum(case when Ds='20150614' then plays else 0 end) as d106,
    sum(case when Ds='20150615' then plays else 0 end) as d107,
    sum(case when Ds='20150616' then plays else 0 end) as d108,
    sum(case when Ds='20150617' then plays else 0 end) as d109,
    sum(case when Ds='20150618' then plays else 0 end) as d110,
    sum(case when Ds='20150619' then plays else 0 end) as d111,
    sum(case when Ds='20150620' then plays else 0 end) as d112,
    sum(case when Ds='20150621' then plays else 0 end) as d113,
    sum(case when Ds='20150622' then plays else 0 end) as d114,
    sum(case when Ds='20150623' then plays else 0 end) as d115,
    sum(case when Ds='20150624' then plays else 0 end) as d116,
    sum(case when Ds='20150625' then plays else 0 end) as d117,
    sum(case when Ds='20150626' then plays else 0 end) as d118,
    sum(case when Ds='20150627' then plays else 0 end) as d119,
    sum(case when Ds='20150628' then plays else 0 end) as d120,
    sum(case when Ds='20150629' then plays else 0 end) as d121,
    sum(case when Ds='20150630' then plays else 0 end) as d122,
    
    
    sum(case when Ds='20150701' then plays else 0 end) as d123,
    sum(case when Ds='20150702' then plays else 0 end) as d124,
    sum(case when Ds='20150703' then plays else 0 end) as d125,
    sum(case when Ds='20150704' then plays else 0 end) as d126,
    sum(case when Ds='20150705' then plays else 0 end) as d127,
    sum(case when Ds='20150706' then plays else 0 end) as d128,
    sum(case when Ds='20150707' then plays else 0 end) as d129,
    sum(case when Ds='20150708' then plays else 0 end) as d130,
    sum(case when Ds='20150709' then plays else 0 end) as d131,
    sum(case when Ds='20150710' then plays else 0 end) as d132,
    sum(case when Ds='20150711' then plays else 0 end) as d133,
    sum(case when Ds='20150712' then plays else 0 end) as d134,
    sum(case when Ds='20150713' then plays else 0 end) as d135,
    sum(case when Ds='20150714' then plays else 0 end) as d136,
    sum(case when Ds='20150715' then plays else 0 end) as d137,
    sum(case when Ds='20150716' then plays else 0 end) as d138,
    sum(case when Ds='20150717' then plays else 0 end) as d139,
    sum(case when Ds='20150718' then plays else 0 end) as d140,
    sum(case when Ds='20150719' then plays else 0 end) as d141,
    sum(case when Ds='20150720' then plays else 0 end) as d142,
    sum(case when Ds='20150721' then plays else 0 end) as d143,
    sum(case when Ds='20150722' then plays else 0 end) as d144,
    sum(case when Ds='20150723' then plays else 0 end) as d145,
    sum(case when Ds='20150724' then plays else 0 end) as d146,
    sum(case when Ds='20150725' then plays else 0 end) as d147,
    sum(case when Ds='20150726' then plays else 0 end) as d148,
    sum(case when Ds='20150727' then plays else 0 end) as d149,
    sum(case when Ds='20150728' then plays else 0 end) as d150,
    sum(case when Ds='20150729' then plays else 0 end) as d151,
    sum(case when Ds='20150730' then plays else 0 end) as d152,
    sum(case when Ds='20150731' then plays else 0 end) as d153,
    
    sum(case when Ds='20150801' then plays else 0 end) as d154,
    sum(case when Ds='20150802' then plays else 0 end) as d155,
    sum(case when Ds='20150803' then plays else 0 end) as d156,
    sum(case when Ds='20150804' then plays else 0 end) as d157,
    sum(case when Ds='20150805' then plays else 0 end) as d158,
    sum(case when Ds='20150806' then plays else 0 end) as d159,
    sum(case when Ds='20150807' then plays else 0 end) as d160,
    sum(case when Ds='20150808' then plays else 0 end) as d161,
    sum(case when Ds='20150809' then plays else 0 end) as d162,
    sum(case when Ds='20150810' then plays else 0 end) as d163,
    sum(case when Ds='20150811' then plays else 0 end) as d164,
    sum(case when Ds='20150812' then plays else 0 end) as d165,
    sum(case when Ds='20150813' then plays else 0 end) as d166,
    sum(case when Ds='20150814' then plays else 0 end) as d167,
    sum(case when Ds='20150815' then plays else 0 end) as d168,
    sum(case when Ds='20150816' then plays else 0 end) as d169,
    sum(case when Ds='20150817' then plays else 0 end) as d170,
    sum(case when Ds='20150818' then plays else 0 end) as d171,
    sum(case when Ds='20150819' then plays else 0 end) as d172,
    sum(case when Ds='20150820' then plays else 0 end) as d173,
    sum(case when Ds='20150821' then plays else 0 end) as d174,
    sum(case when Ds='20150822' then plays else 0 end) as d175,
    sum(case when Ds='20150823' then plays else 0 end) as d176,
    sum(case when Ds='20150824' then plays else 0 end) as d177,
    sum(case when Ds='20150825' then plays else 0 end) as d178,
    sum(case when Ds='20150826' then plays else 0 end) as d179,
    sum(case when Ds='20150827' then plays else 0 end) as d180,
    sum(case when Ds='20150828' then plays else 0 end) as d181,
    sum(case when Ds='20150829' then plays else 0 end) as d182,
    sum(case when Ds='20150830' then plays else 0 end) as d183
    
from view_mars_tianchi_artist_palys_day group by artist_id order by artist_id;

