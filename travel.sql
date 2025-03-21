/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : travel

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 21/03/2025 18:00:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_cuisine
-- ----------------------------
DROP TABLE IF EXISTS `sys_cuisine`;
CREATE TABLE `sys_cuisine`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `scenic_id` int NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scenic_id`(`scenic_id` ASC) USING BTREE,
  CONSTRAINT `sys_cuisine_ibfk_1` FOREIGN KEY (`scenic_id`) REFERENCES `sys_scenic` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_cuisine
-- ----------------------------
INSERT INTO `sys_cuisine` VALUES (2, '测试餐厅', 1, 123.00, '132', '2025-03-21 15:51:42', '2025-03-21 15:51:42', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `url` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '下载链接',
  `type` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `md5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件md5',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `enable` tinyint NULL DEFAULT 1 COMMENT '是否禁用(1-启用, 1-禁用)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '文件上传的列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (150, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:28:26', '2025-03-21 10:28:26', 0);
INSERT INTO `sys_file` VALUES (151, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:31:03', '2025-03-21 10:31:03', 0);
INSERT INTO `sys_file` VALUES (152, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:31:39', '2025-03-21 10:31:39', 0);
INSERT INTO `sys_file` VALUES (153, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:32:09', '2025-03-21 10:32:09', 0);
INSERT INTO `sys_file` VALUES (154, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:33:26', '2025-03-21 10:33:26', 0);
INSERT INTO `sys_file` VALUES (155, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:34:11', '2025-03-21 10:34:11', 0);
INSERT INTO `sys_file` VALUES (156, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:35:18', '2025-03-21 10:35:18', 0);
INSERT INTO `sys_file` VALUES (157, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:36:37', '2025-03-21 10:36:37', 0);
INSERT INTO `sys_file` VALUES (158, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:37:47', '2025-03-21 10:37:47', 0);
INSERT INTO `sys_file` VALUES (159, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:38:52', '2025-03-21 10:38:52', 0);
INSERT INTO `sys_file` VALUES (160, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:40:04', '2025-03-21 10:40:04', 0);
INSERT INTO `sys_file` VALUES (161, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:45:36', '2025-03-21 10:45:36', 0);
INSERT INTO `sys_file` VALUES (162, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:46:32', '2025-03-21 10:46:32', 0);
INSERT INTO `sys_file` VALUES (163, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 10:47:54', '2025-03-21 10:47:54', 0);
INSERT INTO `sys_file` VALUES (164, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 11:52:54', '2025-03-21 11:52:54', 0);
INSERT INTO `sys_file` VALUES (165, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:07:31', '2025-03-21 14:07:31', 0);
INSERT INTO `sys_file` VALUES (166, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:13:10', '2025-03-21 14:13:10', 0);
INSERT INTO `sys_file` VALUES (167, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:24:53', '2025-03-21 14:24:53', 0);
INSERT INTO `sys_file` VALUES (168, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:34:13', '2025-03-21 14:34:13', 0);
INSERT INTO `sys_file` VALUES (169, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:37:12', '2025-03-21 14:37:12', 0);
INSERT INTO `sys_file` VALUES (170, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 14:39:34', '2025-03-21 14:39:34', 0);
INSERT INTO `sys_file` VALUES (171, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 15:51:21', '2025-03-21 15:51:21', 0);
INSERT INTO `sys_file` VALUES (172, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 15:52:21', '2025-03-21 15:52:21', 0);
INSERT INTO `sys_file` VALUES (173, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 15:53:37', '2025-03-21 15:53:37', 0);
INSERT INTO `sys_file` VALUES (174, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 16:32:42', '2025-03-21 16:32:42', 0);
INSERT INTO `sys_file` VALUES (175, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 17:46:09', '2025-03-21 17:46:09', 0);
INSERT INTO `sys_file` VALUES (176, '20250312-102234-6A009ACE80E5.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-21 17:52:00', '2025-03-21 17:52:00', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '管理员', 'admin');
INSERT INTO `sys_role` VALUES (2, '用户', '用户', 'user');

-- ----------------------------
-- Table structure for sys_route
-- ----------------------------
DROP TABLE IF EXISTS `sys_route`;
CREATE TABLE `sys_route`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `scenic_id` int NULL DEFAULT NULL,
  `route_data` json NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scenic_id`(`scenic_id` ASC) USING BTREE,
  CONSTRAINT `sys_route_ibfk_1` FOREIGN KEY (`scenic_id`) REFERENCES `sys_scenic` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_route
-- ----------------------------
INSERT INTO `sys_route` VALUES (1, '测试路线', 1, '{\"type\": \"walk\", \"steps\": [{\"path\": [[110.156997, 25.250716], [110.157053, 25.25069], [110.157717, 25.250508], [110.158073, 25.250456], [110.158498, 25.250417], [110.158902, 25.250399], [110.159149, 25.25036], [110.159523, 25.250356], [110.159779, 25.250356], [110.159835, 25.250347], [110.159874, 25.250312]], \"road\": \"\", \"time\": 236, \"action\": \"向右前方行走\", \"distance\": 295, \"instruction\": \"向东步行295米向右前方行走\", \"orientation\": \"东\", \"end_location\": [110.159874, 25.250312], \"start_location\": [110.156997, 25.250716], \"assistant_action\": \"\"}, {\"path\": [[110.159874, 25.250308], [110.159957, 25.250161]], \"road\": \"\", \"time\": 15, \"action\": \"左转\", \"distance\": 19, \"instruction\": \"向东南步行19米左转\", \"orientation\": \"东南\", \"end_location\": [110.159957, 25.250161], \"start_location\": [110.159874, 25.250308], \"assistant_action\": \"\"}, {\"path\": [[110.159957, 25.250156], [110.160082, 25.250152]], \"road\": \"世纪西路\", \"time\": 10, \"action\": \"向左前方行走\", \"distance\": 12, \"instruction\": \"沿世纪西路步行12米向左前方行走\", \"orientation\": \"\", \"end_location\": [110.160082, 25.250152], \"start_location\": [110.159957, 25.250156], \"assistant_action\": \"\"}, {\"path\": [[110.160082, 25.250148], [110.160365, 25.250295]], \"road\": \"\", \"time\": 26, \"action\": \"右转\", \"distance\": 33, \"instruction\": \"向东北步行33米右转\", \"orientation\": \"东北\", \"end_location\": [110.160365, 25.250295], \"start_location\": [110.160082, 25.250148], \"assistant_action\": \"\"}, {\"path\": [[110.160365, 25.250295], [110.160447, 25.250234], [110.160642, 25.250122]], \"road\": \"三元路\", \"time\": 27, \"action\": \"\", \"distance\": 34, \"instruction\": \"沿三元路步行34米\", \"orientation\": \"\", \"end_location\": [110.160642, 25.250122], \"start_location\": [110.160365, 25.250295], \"assistant_action\": \"\"}, {\"path\": [[110.160642, 25.250117], [110.160929, 25.250182], [110.163433, 25.250022], [110.164006, 25.249974]], \"road\": \"世纪西路\", \"time\": 272, \"action\": \"直行\", \"distance\": 340, \"instruction\": \"沿世纪西路向东步行340米直行\", \"orientation\": \"东\", \"end_location\": [110.164006, 25.249974], \"start_location\": [110.160642, 25.250117], \"assistant_action\": \"\"}, {\"path\": [[110.164006, 25.24997], [110.16428, 25.249957]], \"road\": \"\", \"time\": 22, \"action\": \"直行\", \"distance\": 27, \"instruction\": \"步行27米直行\", \"orientation\": \"\", \"end_location\": [110.16428, 25.249957], \"start_location\": [110.164006, 25.24997], \"assistant_action\": \"\"}, {\"path\": [[110.16428, 25.249952], [110.164826, 25.249931], [110.164935, 25.249931], [110.164935, 25.249931], [110.164987, 25.249926], [110.166402, 25.249865], [110.166714, 25.249848], [110.166714, 25.249848], [110.16714, 25.249822], [110.16714, 25.249822], [110.167656, 25.249805], [110.167817, 25.249787], [110.167817, 25.249787], [110.168116, 25.249757], [110.168116, 25.249757], [110.168485, 25.249722], [110.168937, 25.249688], [110.169258, 25.249605]], \"road\": \"世纪西路\", \"time\": 401, \"action\": \"左转\", \"distance\": 501, \"instruction\": \"沿世纪西路向东步行501米左转\", \"orientation\": \"东\", \"end_location\": [110.169258, 25.249605], \"start_location\": [110.16428, 25.249952], \"assistant_action\": \"\"}, {\"path\": [[110.169258, 25.249601], [110.16941, 25.249735], [110.16941, 25.249735], [110.169462, 25.249796], [110.16951, 25.24987], [110.169588, 25.250026]], \"road\": \"世纪西路\", \"time\": 46, \"action\": \"\", \"distance\": 57, \"instruction\": \"沿世纪西路步行57米\", \"orientation\": \"\", \"end_location\": [110.169588, 25.250026], \"start_location\": [110.169258, 25.249601], \"assistant_action\": \"\"}, {\"path\": [[110.169588, 25.250026], [110.169653, 25.24987], [110.169731, 25.249766], [110.169753, 25.249744], [110.169753, 25.249744], [110.169805, 25.249692], [110.169918, 25.249631], [110.170143, 25.249562]], \"road\": \"凤凰路\", \"time\": 64, \"action\": \"\", \"distance\": 80, \"instruction\": \"沿凤凰路步行80米\", \"orientation\": \"\", \"end_location\": [110.170143, 25.249562], \"start_location\": [110.169588, 25.250026], \"assistant_action\": \"\"}, {\"path\": [[110.170143, 25.249557], [110.170512, 25.249588], [110.173095, 25.249462], [110.173095, 25.249462], [110.174392, 25.249379], [110.174392, 25.249379], [110.174861, 25.249349], [110.174861, 25.249349], [110.175265, 25.249327], [110.175265, 25.249327], [110.175464, 25.249319], [110.175464, 25.249319], [110.175551, 25.249319], [110.177491, 25.249214], [110.177669, 25.249214], [110.177804, 25.249249]], \"road\": \"\", \"time\": 617, \"action\": \"向右前方行走\", \"distance\": 771, \"instruction\": \"向东步行771米向右前方行走\", \"orientation\": \"东\", \"end_location\": [110.177804, 25.249249], \"start_location\": [110.170143, 25.249557], \"assistant_action\": \"\"}, {\"path\": [[110.177804, 25.249249], [110.17786, 25.249175], [110.17786, 25.249175], [110.17819, 25.249167], [110.17819, 25.249167], [110.178251, 25.249197]], \"road\": \"\", \"time\": 40, \"action\": \"向右前方行走\", \"distance\": 50, \"instruction\": \"步行50米向右前方行走\", \"orientation\": \"\", \"end_location\": [110.178251, 25.249197], \"start_location\": [110.177804, 25.249249], \"assistant_action\": \"\"}, {\"path\": [[110.178251, 25.249197], [110.178355, 25.249184], [110.178442, 25.249162], [110.178945, 25.249097], [110.178945, 25.249097], [110.180343, 25.249045], [110.180343, 25.249045], [110.180929, 25.249023], [110.180929, 25.249023], [110.181393, 25.248989], [110.181393, 25.248989], [110.182248, 25.248902]], \"road\": \"\", \"time\": 322, \"action\": \"直行\", \"distance\": 402, \"instruction\": \"向东步行402米直行\", \"orientation\": \"东\", \"end_location\": [110.182248, 25.248902], \"start_location\": [110.178251, 25.249197], \"assistant_action\": \"\"}, {\"path\": [[110.182248, 25.248898], [110.182483, 25.24888]], \"road\": \"\", \"time\": 18, \"action\": \"直行\", \"distance\": 23, \"instruction\": \"步行23米直行\", \"orientation\": \"\", \"end_location\": [110.182483, 25.24888], \"start_location\": [110.182248, 25.248898], \"assistant_action\": \"\"}, {\"path\": [[110.182483, 25.248876], [110.183247, 25.248798], [110.183247, 25.248798], [110.183416, 25.248789], [110.183906, 25.248746], [110.183906, 25.248746], [110.184097, 25.248728], [110.184167, 25.248672], [110.184167, 25.248672], [110.184944, 25.24862], [110.184944, 25.24862], [110.185152, 25.248659], [110.185443, 25.248646], [110.185443, 25.248646], [110.185734, 25.248633], [110.185734, 25.248633], [110.186076, 25.248611], [110.186341, 25.248533], [110.186341, 25.248533], [110.18694, 25.248494], [110.18694, 25.248494], [110.187986, 25.248429], [110.187986, 25.248429], [110.188268, 25.248455], [110.188668, 25.248442], [110.188668, 25.248442], [110.190755, 25.248325], [110.190755, 25.248325], [110.192431, 25.248216], [110.192431, 25.248216], [110.192908, 25.248181], [110.192908, 25.248181], [110.193568, 25.248134], [110.193568, 25.248134], [110.194384, 25.248077], [110.194384, 25.248077], [110.195078, 25.248038], [110.195078, 25.248038], [110.196068, 25.247986], [110.196068, 25.247986], [110.196554, 25.247956], [110.196554, 25.247956], [110.198498, 25.247839], [110.198498, 25.247839], [110.198802, 25.247817], [110.198802, 25.247817], [110.201398, 25.247656], [110.201398, 25.247656], [110.202409, 25.247569], [110.202409, 25.247569], [110.20296, 25.24753], [110.20296, 25.24753], [110.203303, 25.247509], [110.203303, 25.247509], [110.203789, 25.247478], [110.203789, 25.247478], [110.204158, 25.247457], [110.204158, 25.247457], [110.204293, 25.247435], [110.204562, 25.24737]], \"road\": \"\", \"time\": 1779, \"action\": \"向右前方行走\", \"distance\": 2224, \"instruction\": \"向东步行2224米向右前方行走\", \"orientation\": \"东\", \"end_location\": [110.204562, 25.24737], \"start_location\": [110.182483, 25.248876], \"assistant_action\": \"\"}, {\"path\": [[110.204562, 25.247365], [110.204757, 25.247287]], \"road\": \"\", \"time\": 17, \"action\": \"直行\", \"distance\": 21, \"instruction\": \"向东南步行21米直行\", \"orientation\": \"东南\", \"end_location\": [110.204757, 25.247287], \"start_location\": [110.204562, 25.247365], \"assistant_action\": \"\"}, {\"path\": [[110.204757, 25.247283], [110.20487, 25.247274], [110.20487, 25.247274], [110.205056, 25.247209], [110.205056, 25.247209], [110.205182, 25.247122], [110.205182, 25.247122], [110.205308, 25.247057], [110.205308, 25.247057], [110.205482, 25.246966], [110.205833, 25.246879], [110.206107, 25.246801], [110.206107, 25.246801], [110.206528, 25.246693], [110.206593, 25.246671], [110.206649, 25.246649], [110.206766, 25.246593], [110.206979, 25.246506]], \"road\": \"世纪东路\", \"time\": 191, \"action\": \"直行\", \"distance\": 239, \"instruction\": \"沿世纪东路向东步行239米直行\", \"orientation\": \"东\", \"end_location\": [110.206979, 25.246506], \"start_location\": [110.204757, 25.247283], \"assistant_action\": \"\"}, {\"path\": [[110.206979, 25.246502], [110.207231, 25.24638]], \"road\": \"\", \"time\": 23, \"action\": \"直行\", \"distance\": 29, \"instruction\": \"步行29米直行\", \"orientation\": \"\", \"end_location\": [110.207231, 25.24638], \"start_location\": [110.206979, 25.246502], \"assistant_action\": \"\"}, {\"path\": [[110.207231, 25.246376], [110.207934, 25.245998], [110.207934, 25.245998], [110.208051, 25.245911], [110.208051, 25.245911], [110.208485, 25.245634], [110.208867, 25.245365], [110.208867, 25.245365], [110.209076, 25.245213], [110.209271, 25.245061], [110.209466, 25.244896], [110.209466, 25.244896], [110.209648, 25.244753]], \"road\": \"\", \"time\": 242, \"action\": \"左转\", \"distance\": 302, \"instruction\": \"向东南步行302米左转\", \"orientation\": \"东南\", \"end_location\": [110.209648, 25.244753], \"start_location\": [110.207231, 25.246376], \"assistant_action\": \"\"}, {\"path\": [[110.209648, 25.244748], [110.209705, 25.244796], [110.210239, 25.244392]], \"road\": \"\", \"time\": 62, \"action\": \"直行\", \"distance\": 77, \"instruction\": \"向东南步行77米直行\", \"orientation\": \"东南\", \"end_location\": [110.210239, 25.244392], \"start_location\": [110.209648, 25.244748], \"assistant_action\": \"\"}, {\"path\": [[110.210239, 25.244388], [110.210677, 25.244045], [110.210677, 25.244045], [110.210933, 25.243845]], \"road\": \"\", \"time\": 74, \"action\": \"直行\", \"distance\": 92, \"instruction\": \"向东南步行92米直行\", \"orientation\": \"东南\", \"end_location\": [110.210933, 25.243845], \"start_location\": [110.210239, 25.244388], \"assistant_action\": \"\"}, {\"path\": [[110.210933, 25.243841], [110.211345, 25.243498], [110.211324, 25.243472]], \"road\": \"\", \"time\": 48, \"action\": \"向左前方行走\", \"distance\": 60, \"instruction\": \"向东南步行60米向左前方行走\", \"orientation\": \"东南\", \"end_location\": [110.211324, 25.243472], \"start_location\": [110.210933, 25.243841], \"assistant_action\": \"\"}, {\"path\": [[110.211319, 25.243468], [110.211415, 25.24339], [110.211415, 25.24339], [110.211567, 25.24326], [110.211853, 25.242995], [110.211997, 25.242826], [110.212131, 25.242635], [110.212318, 25.242309], [110.212365, 25.242222], [110.212387, 25.242174], [110.212413, 25.242092], [110.212496, 25.241862], [110.212656, 25.241623], [110.212656, 25.241623], [110.212669, 25.241606], [110.212721, 25.241445], [110.212721, 25.241445], [110.21283, 25.241181], [110.21283, 25.241181], [110.212865, 25.241107], [110.212947, 25.240868], [110.213034, 25.24053], [110.213073, 25.240365], [110.213099, 25.240239], [110.213099, 25.240239], [110.213121, 25.240122], [110.213212, 25.239575], [110.213212, 25.239575], [110.213255, 25.23931], [110.213312, 25.239028], [110.213433, 25.238589], [110.213433, 25.238589], [110.213446, 25.238559], [110.213542, 25.237865]], \"road\": \"\", \"time\": 538, \"action\": \"\", \"distance\": 673, \"instruction\": \"向南步行673米\", \"orientation\": \"南\", \"end_location\": [110.213542, 25.237865], \"start_location\": [110.211319, 25.243468], \"assistant_action\": \"\"}, {\"path\": [[110.213542, 25.23786], [110.21352, 25.237786], [110.213537, 25.237595], [110.213537, 25.237595], [110.213598, 25.23717], [110.213655, 25.237049], [110.213655, 25.237049], [110.213741, 25.236389], [110.213741, 25.236389], [110.213845, 25.235599], [110.214006, 25.234379], [110.214054, 25.234284], [110.214054, 25.234284], [110.214141, 25.233711], [110.214171, 25.233407], [110.214145, 25.232925], [110.214067, 25.232652], [110.213841, 25.23194], [110.213759, 25.231823], [110.213689, 25.231684], [110.213628, 25.231432]], \"road\": \"\", \"time\": 580, \"action\": \"左转\", \"distance\": 725, \"instruction\": \"向南步行725米左转\", \"orientation\": \"南\", \"end_location\": [110.213628, 25.231432], \"start_location\": [110.213542, 25.23786], \"assistant_action\": \"\"}, {\"path\": [[110.213624, 25.231428], [110.214093, 25.231402], [110.214605, 25.231228], [110.214839, 25.231094], [110.214948, 25.231033], [110.215408, 25.23069], [110.215408, 25.23069], [110.215525, 25.230616], [110.215629, 25.230573], [110.216246, 25.230308], [110.216359, 25.230282], [110.216463, 25.230304]], \"road\": \"\", \"time\": 256, \"action\": \"右转\", \"distance\": 320, \"instruction\": \"向东南步行320米右转\", \"orientation\": \"东南\", \"end_location\": [110.216463, 25.230304], \"start_location\": [110.213624, 25.231428], \"assistant_action\": \"\"}, {\"path\": [[110.216463, 25.230304], [110.216576, 25.230152], [110.216645, 25.230065], [110.216645, 25.230065], [110.216918, 25.22974], [110.216992, 25.22964], [110.21707, 25.229523], [110.217131, 25.229427], [110.217179, 25.229327], [110.217253, 25.229154], [110.217266, 25.229106], [110.21727, 25.229071], [110.217274, 25.229032], [110.21727, 25.228971], [110.217218, 25.228737], [110.217192, 25.228542], [110.217179, 25.228511], [110.217157, 25.228477], [110.217057, 25.228372], [110.217027, 25.228329], [110.216988, 25.228216], [110.216962, 25.22816], [110.216823, 25.227882], [110.21681, 25.227847], [110.216797, 25.227786], [110.216797, 25.227752], [110.216801, 25.227665], [110.216797, 25.227543], [110.216797, 25.227496], [110.216797, 25.227461], [110.216806, 25.227418], [110.216827, 25.227361], [110.216862, 25.227296], [110.216884, 25.227266], [110.216905, 25.227244], [110.216992, 25.227187], [110.21707, 25.227101], [110.217101, 25.227079], [110.217183, 25.227031], [110.217227, 25.226997], [110.217565, 25.22674], [110.217743, 25.22661], [110.217782, 25.226589], [110.217869, 25.226541], [110.217899, 25.226532], [110.217925, 25.226532], [110.217969, 25.226532], [110.21803, 25.226541], [110.21819, 25.226576], [110.218338, 25.226593], [110.218442, 25.226615], [110.218533, 25.226641], [110.218576, 25.226645], [110.218637, 25.226649], [110.218685, 25.226641], [110.218759, 25.226606], [110.218841, 25.226567], [110.218919, 25.226532], [110.219028, 25.226493], [110.219201, 25.226441]], \"road\": \"\", \"time\": 514, \"action\": \"右转\", \"distance\": 642, \"instruction\": \"向东南步行642米右转\", \"orientation\": \"东南\", \"end_location\": [110.219201, 25.226441], \"start_location\": [110.216463, 25.230304], \"assistant_action\": \"\"}, {\"path\": [[110.219201, 25.226437], [110.219188, 25.22635], [110.219193, 25.226306], [110.219258, 25.226159], [110.219297, 25.226033], [110.219319, 25.22589], [110.219314, 25.225803], [110.219275, 25.225703], [110.219106, 25.225451], [110.219032, 25.225326], [110.218976, 25.225204], [110.218932, 25.225091], [110.218893, 25.225039], [110.218811, 25.224983], [110.218659, 25.224896], [110.218659, 25.224896], [110.218472, 25.2248], [110.218368, 25.224757], [110.218299, 25.224735], [110.218238, 25.224709], [110.218207, 25.224661], [110.218177, 25.224557], [110.218168, 25.224466], [110.218121, 25.22434], [110.21796, 25.224071], [110.217912, 25.224032], [110.21783, 25.224006], [110.217682, 25.22398], [110.217552, 25.223928], [110.217257, 25.22372], [110.217196, 25.22365], [110.217135, 25.223555], [110.217088, 25.223498], [110.217001, 25.223446], [110.216871, 25.223355], [110.216593, 25.223138], [110.216489, 25.222951], [110.216419, 25.222795], [110.21638, 25.222682], [110.216367, 25.222595], [110.216389, 25.222526], [110.216437, 25.222405], [110.216454, 25.222309], [110.216441, 25.222222], [110.216402, 25.222127], [110.216341, 25.221944], [110.216293, 25.221892], [110.216194, 25.221827], [110.216172, 25.221793], [110.216172, 25.221736], [110.216189, 25.221628], [110.216215, 25.221545], [110.216259, 25.221476], [110.216298, 25.22138], [110.216311, 25.221263], [110.216306, 25.221202], [110.216259, 25.221141], [110.216224, 25.221072], [110.21622, 25.22102], [110.216228, 25.220951], [110.216224, 25.220903], [110.216098, 25.22076], [110.216037, 25.220642], [110.215977, 25.220547], [110.21589, 25.220434], [110.215838, 25.220356], [110.215838, 25.220312], [110.215872, 25.220252], [110.21589, 25.220165], [110.215864, 25.220087], [110.215794, 25.219987], [110.215747, 25.219891], [110.215703, 25.219648], [110.215673, 25.219601], [110.215634, 25.219579]], \"road\": \"\", \"time\": 744, \"action\": \"左转\", \"distance\": 930, \"instruction\": \"向西南步行930米左转\", \"orientation\": \"西南\", \"end_location\": [110.215634, 25.219579], \"start_location\": [110.219201, 25.226437], \"assistant_action\": \"\"}, {\"path\": [[110.215629, 25.219575], [110.215764, 25.219544], [110.215881, 25.219531], [110.215972, 25.219531], [110.216081, 25.219514], [110.216172, 25.219484], [110.216254, 25.219444], [110.216528, 25.219301], [110.21658, 25.21928], [110.216645, 25.219275], [110.216827, 25.219327], [110.216892, 25.219336], [110.216962, 25.219332], [110.217209, 25.219162], [110.217257, 25.219115]], \"road\": \"\", \"time\": 144, \"action\": \"左转\", \"distance\": 180, \"instruction\": \"向东步行180米左转\", \"orientation\": \"东\", \"end_location\": [110.217257, 25.219115], \"start_location\": [110.215629, 25.219575], \"assistant_action\": \"\"}, {\"path\": [[110.217257, 25.21911], [110.217348, 25.219167], [110.217448, 25.219253], [110.217995, 25.219657], [110.218082, 25.219718], [110.218125, 25.219722], [110.218181, 25.219718], [110.218268, 25.219679], [110.218381, 25.219679], [110.218494, 25.219696], [110.218598, 25.219757], [110.218681, 25.219787], [110.219236, 25.219818], [110.219987, 25.219883], [110.220182, 25.219887], [110.220356, 25.21987], [110.220573, 25.219787], [110.220799, 25.219735], [110.220933, 25.219735], [110.221098, 25.219774], [110.221554, 25.219965], [110.221641, 25.220026], [110.221714, 25.220087], [110.22184, 25.220221]], \"road\": \"\", \"time\": 407, \"action\": \"\", \"distance\": 509, \"instruction\": \"向东步行509米到达目的地\", \"orientation\": \"东\", \"end_location\": [110.22184, 25.220221], \"start_location\": [110.217257, 25.21911], \"assistant_action\": \"到达目的地\"}], \"distance\": \"9.67\", \"duration\": 129, \"endAddress\": \"广西壮族自治区桂林市临桂区临桂镇桂林市第十八中学(临桂万福校区)广西桂林国家森林公园\", \"endLocation\": \"110.224378,25.221348\", \"startAddress\": \"广西壮族自治区桂林市临桂区临桂镇临桂大道辅路\", \"startLocation\": \"110.157087,25.250851\"}', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', '123123', '2025-03-21 16:32:49', '2025-03-21 16:32:49');

-- ----------------------------
-- Table structure for sys_scenic
-- ----------------------------
DROP TABLE IF EXISTS `sys_scenic`;
CREATE TABLE `sys_scenic`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `opening_hours` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ticket_price` decimal(10, 2) NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `locations` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_scenic
-- ----------------------------
INSERT INTO `sys_scenic` VALUES (1, '桂林山水', '广西壮族自治区桂林市临桂区桂林市山水公园', '00:00-05:00', 123.00, '桂林山水桂林山水桂林山水桂林山水', '123132123', '2025-03-21 14:39:35', '2025-03-21 14:39:35', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', '110.173238,25.240123');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar_url` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '头像',
  `email` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role_id` int NULL DEFAULT NULL COMMENT '角色  0超级管理员  1管理员 2普通账号',
  `status` tinyint NULL DEFAULT 1 COMMENT '是否有效 1有效 0无效',
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', '管理员', NULL, '', 1, 1, 'admin');
INSERT INTO `sys_user` VALUES (2, 'user', 'user', '用户', NULL, '', 2, 1, 'user');

SET FOREIGN_KEY_CHECKS = 1;
