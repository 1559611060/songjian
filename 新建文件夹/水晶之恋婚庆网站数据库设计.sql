
drop database if exists weddingDB;

create database weddingDB character set utf8;

use weddingDB;

/************客户表**************/
drop table if exists customerInfo;
create table customerInfo
(
	customer_id int primary key auto_increment,-- 编号id，主键自增
	customer_name varchar(20) not null,--         客户姓名,非空
	customer_phone varchar(11) not null,--        客户手机号，作为客户登陆信息
	customer_img varchar(20), --                  客户头像              
	customer_password varchar(12) not null--      客户密码
);
select * from customerInfo;


/****************管理员表******************/
drop table if exists adminInfo;
create table adminInfo
(
	admin_id int primary key auto_increment,--  管理员编号
	admin_name varchar(20) not null,--          管理员姓名
	admin_img varchar(20), --                   管理员头像  
	admin_password varchar(12) not null--       管理员密码
);
select * from adminInfo;


/************礼服品牌表***************/
drop table if exists weddingveilBrandInfo;
create table weddingveilBrandInfo
(
	wb_id int primary key auto_increment, 	--  品牌编号
	wb_name varchar(50) --                  品牌名字
);
select * from weddingveilBrandInfo;

/******************婚纱礼服表**********************/
drop table if exists weddingveilInfo;
create table weddingveilInfo
(
	weddingveil_id int primary key auto_increment,--  编号
	weddingveil_name varchar(50),--          					礼服名字
	wb_id int ,--         					                  礼服品牌,外键
	weddingveil_model varchar(50),--         					礼服型号
	weddingveil_type int , --                         礼服类型()
	weddingveil_color varchar(20),--         					礼服颜色
	weddingveil_fabric varchar(20),--     					  礼服面料
	weddingveil_price double ,--             					礼服价格(吊牌价)
	weddingveil_discount double default 0,-- 					礼服折扣，不打折可以为空
	weddingveil_imgs varchar(2000),--                 礼服图片(多张图片时用分号隔开)
	weddingveil_state varchar(2),--           				礼服状态 0表示为下架，1 表示为上架
	foreign key(wb_id) references weddingveilBrandInfo(wb_id)
);
select * from weddingveilInfo;

/***********场地类型表**************/
drop table if exists fieldTypeInfo;
create table fieldTypeInfo
(
	ft_id int primary key auto_increment,--       场地类型编号
	ft_type varchar(50)--                         场地类型名称
);
select * from fieldTypeInfo;

/************************场地表******************************/
drop table if exists fieldInfo;
create table fieldInfo
(
	field_id int primary key auto_increment,--  场地编号
	ft_id int ,--                               场地类型
	field_address varchar(100) ,--              场地地址
	field_region varchar(20) ,--                场地区域
	field_name varchar(20) ,--                  场地名称或酒店名称
	field_img varchar(50),--                    场地图片（多张图片用;号隔开）
	field_star varchar(20),--                   场地星级
	field_tableNum int,--                       场地可容纳的最大桌数
	field_price double, --                      场地价格(包场)
	field_remark text,--                        场地介绍  
	foreign key(ft_id) references fieldTypeInfo(ft_id)
);
select * from fieldInfo;

/*******************厅数表********************/
drop table if exists fieldHallInfo;
create table fieldHallInfo
(
	fh_id int primary key auto_increment, -- 厅编号
	field_id int, --                         场地外键
	fh_name varchar(20), --                  厅名称
	fh_tablenum int , --                     桌数
	fh_hallHeight int , --                   厅高
	fh_style int , --                        花柱数
	fh_price double, --                      每桌价格
	foreign key(field_id) references fieldInfo(field_id)
);
select * from fieldHallInfo;

/*******************案例详情表**********************/
drop table if exists casusInfo;
create table casusInfo
(
	casus_id int primary key auto_increment,--   案例编号
	casus_theme varchar(20) ,--                  案例主题
	casus_imgs varchar(2000) ,--                 案例照片(多张图片时用分号隔开)
	casus_address varchar(100),--                案例地点
	casus_weddingveiltime varchar(20),--         案例婚期
	casus_datails varchar(500),--                案例详情
	casus_price double --                        该案例的价格
);
select * from casusInfo;

/***********套餐表(活动表  倒计时3天)***********/
drop table if exists packageInfo;
create table packageInfo
(
	package_id int primary key auto_increment,--     套餐编号
	package_name varchar(50) ,--                     套餐名字
	package_theme varchar(20) ,--                    套餐主题
	package_img varchar(2000) ,--                    套餐照片(多张照片用分号隔开)
	package_address varchar(100) ,--                 套餐地址
	package_tablenum int ,--                         套餐桌数
	package_price double ,--                         套餐价格(预算总价格)
	package_time varchar(20),--                      套餐时间(设置活动截止时间)
	package_remark varchar(500) --                   套餐简介
);

/***********方案表************/
drop table if exists programmeInfo;
create table programmeInfo
(
	programme_id int primary key auto_increment,--    方按编号
	programme_style varchar(20),--                    婚礼风格
	wb_id1 int ,--         					                  婚纱,外键
	wb_id2 int ,--         					                  西服,外键
	ft_id int ,--                                     场地类型 
	programme_emcee varchar(20) ,--                   司仪姓名  
	programme_remark varchar(2000) ,--                详情描述
	foreign key(wb_id1) references weddingveilInfo(weddingveil_id),
	foreign key(wb_id2) references weddingveilInfo(weddingveil_id),
	foreign key(ft_id) references fieldTypeInfo(ft_id)
);
select * from programmeInfo;


/*********订单表**********/
drop table if exists orderInfo;
create table orderInfo
(
	order_id int primary key auto_increment,--     	 订单表编号
	order_number varchar(30),--                      订单号(如：获取当前时间加上订单编号)
	order_type varchar(20),--                        订单类型
	programme_id int ,--                             方案编号
	wedding_time varchar(20),--                      婚期
	order_state varchar(20),--                       订单状态(未接单、已接单、执行中、已完成)
	order_time varchar(20),--                        订单时间(下订单的时间)
	foreign key(programme_id) references programmeInfo(programme_id)
);
select * from orderInfo;

/***
			订单详情表的数据通过订单表(orderInfo)联合查询方案表(programmeInfo)得到详细信息
*/


/****************案例视频表****************/
drop table if exists mvInfo;
create table mvInfo
(
	mv_id int primary key auto_increment,--     视频编号
	mv_title varchar(50),--                     视频标题
	mv_url varchar(200)--                      视频路劲
);
select * from mvInfo;


/*********公告信息表**********/
drop table if exists noticeInfo;
create table noticeInfo
(
	notice_id int primary key auto_increment, -- 公告编号
	admin_id int, -- 发布者（管理员）
	notice_title varchar(20), -- 公告标题
	notice_context text,-- 公告内容
	notice_time varchar(20), -- 发布时间
	foreign key(admin_id) references adminInfo(admin_id)
);
select * from noticeInfo;

