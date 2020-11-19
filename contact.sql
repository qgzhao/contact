/*
 Navicat Premium Data Transfer

 Source Server         : mysql-localhost
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : contact

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 19/11/2020 17:03:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理ID（主键）',
  `account` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '账号',
  `password` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '密码',
  `name` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for classinfo
-- ----------------------------
DROP TABLE IF EXISTS `classinfo`;
CREATE TABLE `classinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级ID（主健）',
  `name` varchar(32) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '班级名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '通讯录ID（主健）',
  `name` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '姓名',
  `stuid` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '学号（唯一健）',
  `sex` char(1) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '性别',
  `classId` int(11) NULL DEFAULT NULL COMMENT '班级ID（外健）',
  `mobile` varchar(11) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(64) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `qq` varchar(16) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT 'QQ号码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `stuid`(`stuid`) USING BTREE,
  INDEX `classId`(`classId`) USING BTREE,
  CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `classinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
