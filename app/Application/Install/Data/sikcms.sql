/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : choucms

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-12-27 21:42:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for chou_access
-- ----------------------------
DROP TABLE IF EXISTS `chou_access`;
CREATE TABLE `chou_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `menu_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) NOT NULL,
  KEY `groupId` (`role_id`),
  KEY `nodeId` (`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='操作和用户组的对应权限';

-- ----------------------------
-- Records of chou_access
-- ----------------------------
INSERT INTO `chou_access` VALUES ('1', '4', '2');
INSERT INTO `chou_access` VALUES ('1', '20', '3');
INSERT INTO `chou_access` VALUES ('1', '15', '3');
INSERT INTO `chou_access` VALUES ('2', '7', '3');
INSERT INTO `chou_access` VALUES ('2', '4', '2');
INSERT INTO `chou_access` VALUES ('2', '14', '3');
INSERT INTO `chou_access` VALUES ('2', '13', '3');
INSERT INTO `chou_access` VALUES ('2', '6', '3');
INSERT INTO `chou_access` VALUES ('2', '5', '3');



-- ----------------------------
-- Table structure for chou_adverts
-- ----------------------------
DROP TABLE IF EXISTS `chou_adverts`;
CREATE TABLE `chou_adverts` (
  `advert_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '广告位ID',
  `type` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '广告位类型',
  `title` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '广告位标题',
  `ctime` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` enum('true','false') DEFAULT 'true' COMMENT '是否启用true：启用 false：失效',
  PRIMARY KEY (`advert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='广告位';

-- ----------------------------
-- Records of chou_adverts
-- ----------------------------
INSERT INTO `chou_adverts` VALUES ('1', 'index_advert', '首页广告位', '1474182368', 'true');
INSERT INTO `chou_adverts` VALUES ('2', 'list_advert', '列表广告位', '1474182368', 'false');

-- ----------------------------
-- Table structure for chou_adverts_list
-- ----------------------------
DROP TABLE IF EXISTS `chou_adverts_list`;
CREATE TABLE `chou_adverts_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '广告标题',
  `type` enum('1','2') CHARACTER SET utf8 DEFAULT '1' COMMENT '广告类型 1 :普通 2：连接',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '连接地址',
  `imgs` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '广告图片',
  `advert_id` int(10) DEFAULT NULL COMMENT '关联广告位ID',
  `ctime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `advert_id` (`advert_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='广告列表';




-- ----------------------------
-- Table structure for chou_articles
-- ----------------------------
DROP TABLE IF EXISTS `chou_articles`;
CREATE TABLE `chou_articles` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `channel_id` smallint(11) DEFAULT NULL COMMENT '栏目ID',
  `template_id` smallint(11) DEFAULT NULL COMMENT '模板ID',
  `username` char(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '发布人',
  `inputtime` int(10) DEFAULT NULL COMMENT '录入时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` int(2) DEFAULT '0' COMMENT '状态(0：草稿; 1:审核中; 2:审核通过;3:回收站)',
  `listorder` tinyint(3) DEFAULT NULL COMMENT '排序',
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '标题',
  `flag` char(10) CHARACTER SET utf8 DEFAULT NULL COMMENT '自定属性(h：头条 c：推荐 f：幻灯 j：调转) 多个与逗号分隔',
  `thumb` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '缩略图',
  `userid` int(10) DEFAULT NULL COMMENT '发布者ID',
  `isadmin` int(10) DEFAULT '0' COMMENT '是否为后台管理员发布（0：否 1：是）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1 COMMENT='内容文章主表';


-- ----------------------------
-- Table structure for chou_article_data
-- ----------------------------
DROP TABLE IF EXISTS `chou_article_data`;
CREATE TABLE `chou_article_data` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `content` mediumtext CHARACTER SET utf8 COMMENT '内容',
  `readpoint` smallint(5) unsigned DEFAULT NULL COMMENT '阅读数',
  `comment_count` int(11) DEFAULT NULL COMMENT '评论数',
  `articles_id` smallint(11) DEFAULT NULL COMMENT '关联文章主建ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1 COMMENT='文章内容从表';

-- ----------------------------
-- Table structure for chou_channel
-- ----------------------------
DROP TABLE IF EXISTS `chou_channel`;
CREATE TABLE `chou_channel` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '栏目名称',
  `path` varchar(30) CHARACTER SET latin1 DEFAULT NULL COMMENT '访问路径',
  `module_id` smallint(11) DEFAULT NULL COMMENT '站点ID',
  `template_id` smallint(11) DEFAULT NULL COMMENT '模板ID',
  `parentid` smallint(11) DEFAULT '0' COMMENT '父栏目ID',
  `ctime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `sort` tinyint(4) DEFAULT '1' COMMENT '排序',
  `ishidden` tinyint(2) DEFAULT '0' COMMENT '是否隐藏(0:显示 1:隐藏)',
  `level` tinyint(1) DEFAULT '1' COMMENT '栏目界别',
  `attr` enum('0','1','2') DEFAULT '0' COMMENT '0:最终列表栏目 1：频道封面 2：外部链接',
  `dir_url` varchar(255) DEFAULT NULL COMMENT '目标地址(attr为2时用到)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='栏目表';




-- ----------------------------
-- Table structure for chou_comment
-- ----------------------------
DROP TABLE IF EXISTS `chou_comment`;
CREATE TABLE `chou_comment` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `userid` int(10) DEFAULT NULL COMMENT '用户ID',
  `content` text COMMENT '评论内容',
  `nickname` varchar(20) DEFAULT NULL COMMENT '用户昵称',
  `ip` char(15) DEFAULT NULL,
  `is_audit` enum('1','0') DEFAULT '0' COMMENT '是否已审核(1：是 0 ：否)',
  `ctime` int(10) DEFAULT NULL,
  `reply_nums` int(10) DEFAULT '0' COMMENT '回复数',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `channel_id` int(8) NOT NULL COMMENT '关联类目ID',
  `pid` int(8) DEFAULT '0' COMMENT '父类ID',
  `reply_username` varchar(20) DEFAULT NULL COMMENT '回复人',
  `reply_userid` int(10) DEFAULT NULL COMMENT '回复人ID',
  `relation_id` int(8) DEFAULT NULL COMMENT '关联文档ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='评论';


-- ----------------------------
-- Table structure for chou_config
-- ----------------------------
DROP TABLE IF EXISTS `chou_config`;
CREATE TABLE `chou_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `valuename` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '类型',
  `value` text COMMENT '类型值',
  `info` varchar(100) CHARACTER SET utf8 NOT NULL,
  `groupid` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk COMMENT='全站配置';

-- ----------------------------
-- Records of chou_config
-- ----------------------------

-- ----------------------------
-- Table structure for chou_email
-- ----------------------------
DROP TABLE IF EXISTS `chou_email`;
CREATE TABLE `chou_email` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(40) NOT NULL COMMENT '模板编号',
  `subject` varchar(255) NOT NULL COMMENT '邮件主题',
  `content` text NOT NULL COMMENT '模板内容',
  `addtime` int(10) DEFAULT '0' COMMENT '添加时间',
  `edittime` int(10) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邮件模板表';

-- ----------------------------
-- Records of chou_email
-- ----------------------------

-- ----------------------------
-- Table structure for chou_loginlog
-- ----------------------------
DROP TABLE IF EXISTS `chou_loginlog`;
CREATE TABLE `chou_loginlog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(20) DEFAULT NULL COMMENT '登录ip',
  `username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `status` tinyint(2) DEFAULT '0' COMMENT '状态(0:正常 1：删除)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=374 DEFAULT CHARSET=gbk COMMENT='登录日志';


-- ----------------------------
-- Table structure for chou_member
-- ----------------------------
DROP TABLE IF EXISTS `chou_member`;
CREATE TABLE `chou_member` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `ctime` int(10) DEFAULT NULL,
  `header` varchar(255) DEFAULT NULL COMMENT '头像信息',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of chou_member
-- ----------------------------
INSERT INTO `chou_member` VALUES ('1', '127.0.0.1', 'admin', 'b731a546748caff9fd49692bf14c9b07', '1481685950', 'head1.png', '萌萌猫');
INSERT INTO `chou_member` VALUES ('11', '180.166.239.106', 'chenfeizhou', 'd0c616c7fbb0614def0a36695359fa34', '1481708890', 'head3.png', '爱笑的眼泪');
INSERT INTO `chou_member` VALUES ('12', '120.38.64.101', 'fenfen', '4a77e1f514bba2e7c23382f0c78434e0', '1481946501', 'head3.png', '萌萌猪');
INSERT INTO `chou_member` VALUES ('13', '163.24.2.240', 'uboby', '25d55ad283aa400af464c76d713c07ad', '1482131297', 'head6.png', 'uboby');

-- ----------------------------
-- Table structure for chou_menu
-- ----------------------------
DROP TABLE IF EXISTS `chou_menu`;
CREATE TABLE `chou_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统菜单ID',
  `pid` int(10) DEFAULT NULL COMMENT '父级ID',
  `name` varchar(200) DEFAULT NULL COMMENT '菜单名称',
  `params` varchar(200) DEFAULT NULL COMMENT 'url参数',
  `sort` tinyint(4) DEFAULT '1' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '菜单状态（1：显示 2：隐藏 3：删除）',
  `is_system` tinyint(1) DEFAULT '0' COMMENT '是否系统菜单（1：是 0：否）',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '菜单级别',
  `controller` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'controller名称',
  `action` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'action名称',
  `model` varchar(20) DEFAULT NULL COMMENT '模块名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=gbk COMMENT='系统菜单表';

-- ----------------------------
-- Records of chou_menu
-- ----------------------------
INSERT INTO `chou_menu` VALUES ('1', '0', '系统面板', '', '1', '1', '1', '1', '', '', 'Admin');
INSERT INTO `chou_menu` VALUES ('3', '0', '安全记录', '', '4', '1', '1', '1', 'SafeLog', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('2', '0', '系统管理', '', '1', '1', '1', '1', '', '', 'Admin');
INSERT INTO `chou_menu` VALUES ('7', '4', '删除菜单', '', '1', '2', '0', '3', 'Menu', 'deleteMenu', 'Admin');
INSERT INTO `chou_menu` VALUES ('8', '2', '系统用户', '', '1', '1', '0', '2', 'Users', 'user', 'Admin');
INSERT INTO `chou_menu` VALUES ('9', '8', '用户列表', '', '1', '1', '0', '3', 'Users', 'user', 'Admin');
INSERT INTO `chou_menu` VALUES ('10', '8', '添加用户', '', '1', '2', '0', '3', 'Users', 'userAdd', 'Admin');
INSERT INTO `chou_menu` VALUES ('11', '8', '删除用户', '', '1', '2', '0', '3', 'Users', 'userDelete', 'Admin');
INSERT INTO `chou_menu` VALUES ('12', '2', '系统角色', '', '1', '1', '0', '2', 'Role', 'role', 'Admin');
INSERT INTO `chou_menu` VALUES ('4', '2', '菜单管理', '', '1', '1', '0', '2', 'Menu', 'menu', 'Admin');
INSERT INTO `chou_menu` VALUES ('5', '4', '菜单列表', '', '1', '1', '0', '3', 'Menu', 'menu', 'Admin');
INSERT INTO `chou_menu` VALUES ('6', '4', '添加菜单', '', '1', '2', '0', '3', 'Menu', 'addMenu', 'Admin');
INSERT INTO `chou_menu` VALUES ('13', '12', '角色列表', '', '1', '1', '0', '3', 'Role', 'role', 'Admin');
INSERT INTO `chou_menu` VALUES ('14', '12', '添加角色', '', '2', '2', '0', '3', 'Role', 'roleAdd', 'Admin');
INSERT INTO `chou_menu` VALUES ('15', '12', '删除角色', '', '1', '2', '0', '3', 'Role', 'roleDelete', 'Admin');
INSERT INTO `chou_menu` VALUES ('16', '12', '编辑角色', '', '1', '2', '0', '3', 'Role', 'roleEdit', 'Admin');
INSERT INTO `chou_menu` VALUES ('17', '12', '角色授权', '', '3', '2', '0', '3', 'Role', 'roleAccess', 'Admin');
INSERT INTO `chou_menu` VALUES ('18', '3', '操作日志', '', '1', '1', '0', '2', 'SafeLog', 'operationLog', 'Admin');
INSERT INTO `chou_menu` VALUES ('19', '18', '日志记录', '', '1', '1', '0', '3', 'SafeLog', 'operationLog', 'Admin');
INSERT INTO `chou_menu` VALUES ('20', '1', '系统首页', '', '1', '1', '0', '2', 'Index', 'main', 'Admin');
INSERT INTO `chou_menu` VALUES ('21', '20', '系统首页', '', '1', '1', '0', '3', 'Index', 'main', 'Admin');
INSERT INTO `chou_menu` VALUES ('42', '0', '广告管理', '', '1', '1', '0', '1', 'Adverts', 'adverts', 'Admin');
INSERT INTO `chou_menu` VALUES ('43', '42', '广告位管理', '', '1', '1', '0', '2', 'Adverts', 'adverts', 'Admin');
INSERT INTO `chou_menu` VALUES ('44', '43', '广告位列表', '', '1', '1', '0', '3', 'Adverts', 'adverts', 'Admin');
INSERT INTO `chou_menu` VALUES ('45', '43', '广告列表', '', '2', '1', '0', '3', 'Adverts', 'adlist', 'Admin');
INSERT INTO `chou_menu` VALUES ('46', '43', '编辑广告位', '', '1', '2', '0', '3', 'Adverts', 'advert_edit', 'Admin');
INSERT INTO `chou_menu` VALUES ('47', '2', '数据库管理', '', '2', '1', '0', '2', 'Database', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('48', '47', '数据导入', '&type=import', '2', '1', '0', '3', 'Database', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('49', '47', '数据恢复', '&type=export', '1', '1', '0', '3', 'Database', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('50', '0', '内容管理', '', '1', '1', '0', '1', 'Articles', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('51', '50', '文章管理', '', '1', '1', '0', '2', 'Articles', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('52', '51', '文章列表', null, '1', '1', '0', '3', 'Articles', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('57', '56', '模型列表', null, '1', '1', '0', '3', 'Module', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('55', '51', '栏目列表', '', '1', '1', '0', '3', 'Channel', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('56', '50', '模型管理', '', '2', '1', '0', '2', 'Module', 'index', 'Admin');
INSERT INTO `chou_menu` VALUES ('58', '51', '评论管理', null, '1', '1', '0', '3', 'Comment', 'index', null);
INSERT INTO `chou_menu` VALUES ('59', '51', '添加文章', '', '1', '0', '0', '3', 'Articles', 'add', null);


-- ----------------------------
-- Table structure for chou_module
-- ----------------------------
DROP TABLE IF EXISTS `chou_module`;
CREATE TABLE `chou_module` (
  `id` mediumint(8) NOT NULL COMMENT '模型ID',
  `typename` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '模型名称',
  `issystem` smallint(2) DEFAULT NULL COMMENT '类型(1：系统模型 0：自动模型)',
  `nid` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '标识',
  `relation_table` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '关联表',
  `status` tinyint(2) DEFAULT '0' COMMENT '状态(1:禁用 0：正常)',
  `addaction` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '添加方法(如:Articles/add)',
  `editaction` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改方法(如:Articles/edit)',
  `listaction` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '显示列表(如：Articles/list)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of chou_module
-- ----------------------------
INSERT INTO `chou_module` VALUES ('5', '文章', '1', 'article', 'chou_articles,chou_article_data', '0', 'Articles/add', 'Articles/edit', 'Articles/index');

-- ----------------------------
-- Table structure for chou_operationlog
-- ----------------------------
DROP TABLE IF EXISTS `chou_operationlog`;
CREATE TABLE `chou_operationlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `uid` smallint(6) NOT NULL DEFAULT '0' COMMENT '操作帐号ID',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `ip` char(20) NOT NULL DEFAULT '' COMMENT 'IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0错误提示，1为正确提示',
  `info` text COMMENT '其他说明',
  `get` varchar(255) NOT NULL DEFAULT '' COMMENT 'get数据',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `username` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2872 DEFAULT CHARSET=utf8 COMMENT='后台操作日志表';


-- ----------------------------
-- Table structure for chou_role
-- ----------------------------
DROP TABLE IF EXISTS `chou_role`;
CREATE TABLE `chou_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `pid` smallint(6) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '是否开启',
  `remark` varchar(255) DEFAULT NULL,
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='管理员分组表';

-- ----------------------------
-- Records of chou_role
-- ----------------------------
INSERT INTO `chou_role` VALUES ('1', '领导组', '0', '1', '超级管理员', '0');
INSERT INTO `chou_role` VALUES ('2', '普通用户', '0', '1', '普通用户员', '3');

-- ----------------------------
-- Table structure for chou_role_user
-- ----------------------------
DROP TABLE IF EXISTS `chou_role_user`;
CREATE TABLE `chou_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32) DEFAULT NULL,
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户对应分组';

-- ----------------------------
-- Records of chou_role_user
-- ----------------------------
INSERT INTO `chou_role_user` VALUES ('1', '1');
INSERT INTO `chou_role_user` VALUES ('2', '2');

-- ----------------------------
-- Table structure for chou_template
-- ----------------------------
DROP TABLE IF EXISTS `chou_template`;
CREATE TABLE `chou_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index_template` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '封面模板',
  `list_template` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '列表模板',
  `article_template` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '内容模板',
  `module_id` mediumint(8) DEFAULT NULL COMMENT '模型ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='模型对应模板';

-- ----------------------------
-- Records of chou_template
-- ----------------------------
INSERT INTO `chou_template` VALUES ('1', '/Article/index.html', '/Article/lists.html', '/Article/info.html', '5');

-- ----------------------------
-- Table structure for chou_user
-- ----------------------------
DROP TABLE IF EXISTS `chou_user`;
CREATE TABLE `chou_user` (
  `userid` mediumint(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `roleid` smallint(5) DEFAULT NULL,
  `encrypt` varchar(6) DEFAULT NULL,
  `lastloginip` varchar(15) DEFAULT NULL,
  `lastlogintime` int(10) DEFAULT '0',
  `email` varchar(40) DEFAULT NULL,
  `head_ico` varchar(100) DEFAULT NULL,
  `realname` varchar(50) NOT NULL,
  `verify` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '证验码',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=gbk COMMENT='管理员表';
