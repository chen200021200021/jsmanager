# Host: 127.0.0.1  (Version: 5.5.53)
# Date: 2022-04-06 22:21:17
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "category"
#

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL COMMENT '类型',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序值(从小到大)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Data for table "category"
#

INSERT INTO `category` VALUES (2,'class','2201班',1),(3,'class','2202班',2),(6,'xueyuan','学院一',1),(7,'xueyuan','学院二',2),(8,'zhuanye','计算机软件工程',1),(9,'zhuanye','电子商务',2),(10,'xueyuan','学院三',3);

#
# Structure for table "code"
#

CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `codetype` varchar(40) NOT NULL DEFAULT '' COMMENT '编码组',
  `codedesc` varchar(100) NOT NULL COMMENT '编码组用途',
  `code` varchar(10) NOT NULL COMMENT '编码',
  `name` varchar(100) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Data for table "code"
#

INSERT INTO `code` VALUES (1,'USER_TYPE','用户类型','10','管理员'),(5,'USER_STATUS','账号状态','20','冻结'),(6,'USER_STATUS','账号状态','10','正常'),(7,'USER_TYPE','用户类型','30','教师');

#
# Structure for table "kecheng"
#

CREATE TABLE `kecheng` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `classid` int(11) DEFAULT NULL COMMENT '所属班级',
  `teacherid` int(11) DEFAULT NULL COMMENT '授课教师',
  `time` varchar(255) DEFAULT NULL COMMENT '上课时间',
  `addr` varchar(255) DEFAULT NULL COMMENT '授课地点',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "kecheng"
#

INSERT INTO `kecheng` VALUES (1,'软件工程技术',2,45,'每周二/四  8:00 - 10:00','第一多媒体教室'),(2,'高等数学',2,45,'每周二/四  8:00 - 10:00','1号楼101教室'),(3,'大数据',3,47,'每周三  14:00 - 16:00','1号楼301教室'),(5,'英语6级',2,45,'每周二/四  8:00 - 10:00','101语音室'),(6,'马列主义',2,47,'每周一/三/五    14:00-16:00','2号楼201多媒体教室'),(7,'汉语言',2,45,'每周一/三/五    14:00-16:00','第一多媒体教室');

#
# Structure for table "offer"
#

CREATE TABLE `offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ym` varchar(20) DEFAULT NULL COMMENT '月份',
  `ycq` varchar(100) DEFAULT NULL COMMENT '应出勤',
  `cq` varchar(100) DEFAULT NULL COMMENT '实际出勤',
  `qj` varchar(100) DEFAULT NULL COMMENT '请假',
  `jb` varchar(100) DEFAULT NULL COMMENT '加班',
  `offer` varchar(10) DEFAULT NULL COMMENT '岗位工资',
  `offer_jbf` varchar(10) DEFAULT NULL COMMENT '加班费',
  `offer_kf` varchar(10) DEFAULT NULL COMMENT '扣除工资',
  `offer_gs` varchar(10) DEFAULT NULL COMMENT '个税',
  `offer_sf` varchar(100) DEFAULT NULL COMMENT '实发工资',
  `uid` int(11) DEFAULT NULL COMMENT '申请人id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Data for table "offer"
#

INSERT INTO `offer` VALUES (1,'2022-03','21','21','0','0','5000','0','0','0','5000',45),(2,'2022-04','21','21','0','0','10000','0','0','100','9900',45);

#
# Structure for table "user"
#

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '昵称',
  `login` varchar(40) NOT NULL COMMENT '登录账号',
  `pwd` varchar(40) NOT NULL COMMENT '登陆密码',
  `utype` varchar(10) NOT NULL COMMENT '用户类型(C001)',
  `status` varchar(10) DEFAULT '10' COMMENT '账号状态(10:正常 20:冻结)',
  `itime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户账户表';

#
# Data for table "user"
#

INSERT INTO `user` VALUES (1,'超级管理员','admin','111111','10','10','2022-04-06 12:20:36'),(45,'张老师','T001','111111','30','10','2022-04-06 12:20:36'),(46,'孙思邈','T002','111111','30','10','2022-04-06 12:20:36'),(47,'杨洋','T003','111111','30','10','2022-04-06 12:20:36');

#
# Structure for table "userinfo30"
#

CREATE TABLE `userinfo30` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `icon` varchar(255) DEFAULT NULL COMMENT '照片',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `age` varchar(255) DEFAULT NULL COMMENT '年龄',
  `tel` varchar(255) DEFAULT NULL COMMENT '电话',
  `xueli` varchar(255) DEFAULT NULL COMMENT '学历',
  `school` varchar(255) DEFAULT NULL COMMENT '毕业院校',
  `descr` varchar(2000) DEFAULT NULL COMMENT '备注',
  `classid` varchar(255) DEFAULT NULL COMMENT '所属班级',
  `itime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `xueyuanid` varchar(255) DEFAULT NULL COMMENT '学院',
  `zhuanyeid` varchar(255) DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

#
# Data for table "userinfo30"
#

INSERT INTO `userinfo30` VALUES (45,'张老师','../../upload/16132777212505.jpg','男','45','13811111111','研究生','清华大学','大师傅','2','2022-04-06 12:20:36','6','8'),(46,'孙思邈','../../upload/16132777980852.jpg','男','55','13811111111','研究生','清华大学','','3','2022-04-06 12:20:36','7','9'),(47,'杨洋','../../upload/16132778372706.jpg','女','55','13812222222','研究生','清华大学','','3','2022-04-06 12:20:36','6','8');
