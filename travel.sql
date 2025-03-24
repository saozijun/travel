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

 Date: 24/03/2025 14:39:08
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
INSERT INTO `sys_cuisine` VALUES (2, '桂林米粉', 1, 123.00, '桂林米粉', '2025-03-21 15:51:42', '2025-03-21 15:51:42', 'http://localhost:9091/file/947f3f98793b43d1829725f13650a8aa.jpg');

-- ----------------------------
-- Table structure for sys_feedback
-- ----------------------------
DROP TABLE IF EXISTS `sys_feedback`;
CREATE TABLE `sys_feedback`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `scenic_id` int NOT NULL COMMENT '景区ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '反馈内容',
  `rate` int NULL DEFAULT NULL COMMENT '评分（1-5分）',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `scenic_id`(`scenic_id` ASC) USING BTREE,
  CONSTRAINT `sys_feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sys_feedback_ibfk_2` FOREIGN KEY (`scenic_id`) REFERENCES `sys_scenic` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '景区反馈表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_feedback
-- ----------------------------
INSERT INTO `sys_feedback` VALUES (1, 1, 1, '挺好的', 5, '2025-03-24 11:52:51', '2025-03-24 11:52:51');
INSERT INTO `sys_feedback` VALUES (2, 1, 3, '不好玩啊', 5, '2025-03-24 14:14:28', '2025-03-24 14:14:28');

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
) ENGINE = InnoDB AUTO_INCREMENT = 183 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '文件上传的列表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_file` VALUES (177, 'd4845f13f2c7df7473c69cc4cfe82b905e7e246d481be-CCRMhG_fw1200.jpg', 'http://localhost:9091/file/4413c227dba84775bb68dae091e4e901.jpg', 'jpg', '1102afce786c4accb70dd6150d5c366a', 195, 1, '2025-03-24 11:08:24', '2025-03-24 11:08:24', 0);
INSERT INTO `sys_file` VALUES (178, 'fe53302f12a8772813be53ea7d73e5bff7e0225969e79-59YnXD_fw658webp.webp', 'http://localhost:9091/file/bb8818df3ec842cfa58e40fd3026acd3.webp', 'webp', '82b542871beb9b0af06527f5ea03e8a0', 148, 1, '2025-03-24 11:14:22', '2025-03-24 11:14:22', 0);
INSERT INTO `sys_file` VALUES (179, '7c8b9ebdbb878235fe6d6b2f6e2ef048fb53c9dd107806-kFjmu1_fw1200.jpg', 'http://localhost:9091/file/947f3f98793b43d1829725f13650a8aa.jpg', 'jpg', 'edd5f71d0cd2974591c22d484f2196a6', 504, 1, '2025-03-24 11:15:02', '2025-03-24 11:15:02', 0);
INSERT INTO `sys_file` VALUES (180, '7c8b9ebdbb878235fe6d6b2f6e2ef048fb53c9dd107806-kFjmu1_fw1200.jpg', 'http://localhost:9091/file/947f3f98793b43d1829725f13650a8aa.jpg', 'jpg', 'edd5f71d0cd2974591c22d484f2196a6', 504, 1, '2025-03-24 11:15:49', '2025-03-24 11:15:49', 0);
INSERT INTO `sys_file` VALUES (181, 'haha.png', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', 'png', 'bdd105b70cfff4e65ee42125f33f8ea0', 5, 1, '2025-03-24 14:12:50', '2025-03-24 14:12:50', 0);
INSERT INTO `sys_file` VALUES (182, 'banner.jpg', 'http://localhost:9091/file/5730f65540454c8e9462dddfcaab78fc.jpg', 'jpg', '76d8f5ff435fd87084949a651dc3e223', 73, 1, '2025-03-24 14:13:48', '2025-03-24 14:13:48', 0);

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
INSERT INTO `sys_route` VALUES (1, '测试路线', 1, '{\"type\": \"walk\", \"steps\": [{\"path\": [[110.168234, 25.243937], [110.16839, 25.244201], [110.16839, 25.244201], [110.168563, 25.244497], [110.16865, 25.244618], [110.168702, 25.244692], [110.168741, 25.244718]], \"road\": \"\", \"time\": 80, \"action\": \"向右前方行走\", \"distance\": 100, \"instruction\": \"向东北步行100米向右前方行走\", \"orientation\": \"东北\", \"end_location\": [110.168741, 25.244718], \"start_location\": [110.168234, 25.243937], \"assistant_action\": \"\"}, {\"path\": [[110.168741, 25.244718], [110.168759, 25.244731], [110.168889, 25.244774]], \"road\": \"\", \"time\": 13, \"action\": \"右转\", \"distance\": 16, \"instruction\": \"向东步行16米右转\", \"orientation\": \"东\", \"end_location\": [110.168889, 25.244774], \"start_location\": [110.168741, 25.244718], \"assistant_action\": \"\"}, {\"path\": [[110.168889, 25.244774], [110.169162, 25.244666], [110.169301, 25.244618], [110.169978, 25.24444], [110.170521, 25.24431], [110.170521, 25.24431], [110.170768, 25.244253], [110.172309, 25.243954], [110.172309, 25.243954], [110.173251, 25.243772], [110.173251, 25.243772], [110.174666, 25.243498], [110.175056, 25.243416], [110.175391, 25.243359], [110.175547, 25.243338], [110.175794, 25.243372], [110.175794, 25.243372], [110.175903, 25.243359], [110.176259, 25.243329], [110.176936, 25.243268], [110.176936, 25.243268], [110.177487, 25.243216]], \"road\": \"公园北路\", \"time\": 708, \"action\": \"右转\", \"distance\": 885, \"instruction\": \"沿公园北路向东步行885米右转\", \"orientation\": \"东\", \"end_location\": [110.177487, 25.243216], \"start_location\": [110.168889, 25.244774], \"assistant_action\": \"\"}, {\"path\": [[110.177487, 25.243212], [110.177474, 25.24283], [110.177474, 25.24283], [110.177378, 25.241003], [110.177378, 25.241003], [110.177361, 25.24079], [110.177361, 25.24079], [110.177357, 25.240729], [110.177357, 25.240729], [110.177253, 25.240404], [110.177192, 25.239905], [110.177192, 25.239905], [110.177157, 25.23964], [110.177157, 25.23964], [110.177096, 25.239193], [110.177114, 25.239036], [110.177114, 25.239036], [110.177122, 25.23898], [110.177122, 25.23898], [110.177066, 25.238546], [110.177066, 25.238546], [110.176901, 25.237396]], \"road\": \"西城大道\", \"time\": 515, \"action\": \"左转\", \"distance\": 644, \"instruction\": \"沿西城大道向南步行644米左转\", \"orientation\": \"南\", \"end_location\": [110.176901, 25.237396], \"start_location\": [110.177487, 25.243212], \"assistant_action\": \"\"}, {\"path\": [[110.176897, 25.237391], [110.177101, 25.23737], [110.177101, 25.23737], [110.178516, 25.237205], [110.178516, 25.237205], [110.178776, 25.237174], [110.178776, 25.237174], [110.179479, 25.237092], [110.179479, 25.237092], [110.180174, 25.237014], [110.180174, 25.237014], [110.180282, 25.237001], [110.180282, 25.237001], [110.180959, 25.236923], [110.180959, 25.236923], [110.181606, 25.236845], [110.181606, 25.236845], [110.182691, 25.236714], [110.182691, 25.236714], [110.182782, 25.236706]], \"road\": \"锦秀路\", \"time\": 474, \"action\": \"直行\", \"distance\": 593, \"instruction\": \"沿锦秀路步行593米直行\", \"orientation\": \"\", \"end_location\": [110.182782, 25.236706], \"start_location\": [110.176897, 25.237391], \"assistant_action\": \"\"}, {\"path\": [[110.182782, 25.236701], [110.182878, 25.236697], [110.182878, 25.236697], [110.18296, 25.236693]], \"road\": \"锦绣路\", \"time\": 14, \"action\": \"右转\", \"distance\": 17, \"instruction\": \"沿锦绣路步行17米右转\", \"orientation\": \"\", \"end_location\": [110.18296, 25.236693], \"start_location\": [110.182782, 25.236701], \"assistant_action\": \"\"}, {\"path\": [[110.18296, 25.236688], [110.182812, 25.235299], [110.182812, 25.235299], [110.182786, 25.234996]], \"road\": \"宏谋大道\", \"time\": 150, \"action\": \"\", \"distance\": 188, \"instruction\": \"沿宏谋大道向南步行188米到达目的地\", \"orientation\": \"南\", \"end_location\": [110.182786, 25.234996], \"start_location\": [110.18296, 25.236688], \"assistant_action\": \"到达目的地\"}], \"distance\": \"2.44\", \"duration\": 33, \"endAddress\": \"广西壮族自治区桂林市临桂区临桂镇桂林市第十八中学(临桂万福校区)广西桂林国家森林公园\", \"endLocation\": \"110.182951,25.234981\", \"startAddress\": \"广西壮族自治区桂林市临桂区临桂镇临桂大道辅路\", \"startLocation\": \"110.168079,25.244013\"}', 'http://localhost:9091/file/bb8818df3ec842cfa58e40fd3026acd3.webp', '123123', '2025-03-21 16:32:49', '2025-03-21 16:32:49');

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
  `rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_scenic
-- ----------------------------
INSERT INTO `sys_scenic` VALUES (1, '桂林山水', '广西壮族自治区桂林市临桂区桂林市山水公园', '00:00-05:00', 123.00, '桂林山水桂林山水桂林山水桂林山水', '123132123', '2025-03-21 14:39:35', '2025-03-21 14:39:35', 'http://localhost:9091/file/4413c227dba84775bb68dae091e4e901.jpg', '110.173238,25.240123', '4');
INSERT INTO `sys_scenic` VALUES (2, '测试', '广西壮族自治区桂林市象山区平山街道广西桂林国家森林公园', '01:00-07:00', 150.00, '好好哦啊', '1511651651616', '2025-03-24 14:12:55', '2025-03-24 14:12:55', 'http://localhost:9091/file/a9ab383e65964464bfb83a3439f79cff.png', '110.247896,25.223988', '2');
INSERT INTO `sys_scenic` VALUES (3, '测试景区', '广西壮族自治区桂林市七星区漓东街道穿山东路167号穿山景区', '13:00-19:00', 10.00, '456456464644', '34531234534', '2025-03-24 14:13:52', '2025-03-24 14:13:52', 'http://localhost:9091/file/5730f65540454c8e9462dddfcaab78fc.jpg', '110.307044,25.250979', '5');

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
