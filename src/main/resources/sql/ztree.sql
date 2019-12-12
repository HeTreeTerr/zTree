/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : ztree

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-12-12 13:52:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tree_type
-- ----------------------------
DROP TABLE IF EXISTS `tree_type`;
CREATE TABLE `tree_type` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` bigint(11) DEFAULT NULL COMMENT '父编号',
  `name` varchar(255) NOT NULL COMMENT '节点名',
  `open` int(11) DEFAULT '0' COMMENT '是否展开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tree_type
-- ----------------------------
