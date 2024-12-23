-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                      5.5.32 - MySQL Community Server (GPL)
-- 服务器操作系统:                  Linux
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 authbase 的数据库结构
CREATE DATABASE IF NOT EXISTS `authbase` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `authbase`;

-- 导出  表 authbase.syonline 结构
CREATE TABLE IF NOT EXISTS `syonline` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `LOGINNAME` varchar(100) DEFAULT NULL,
  `TYPE` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syonline 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `syonline` DISABLE KEYS */;
/*!40000 ALTER TABLE `syonline` ENABLE KEYS */;

-- 导出  表 authbase.syorganization 结构
CREATE TABLE IF NOT EXISTS `syorganization` (
  `ID` varchar(36) NOT NULL,
  `ADDRESS` varchar(200) DEFAULT NULL,
  `CODE` varchar(200) DEFAULT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `ICONCLS` varchar(100) DEFAULT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `SEQ` int(11) DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `SYORGANIZATION_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_acf7qlb04quthktalwx8c7q69` (`SYORGANIZATION_ID`),
  CONSTRAINT `FK_acf7qlb04quthktalwx8c7q69` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `syorganization` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syorganization 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `syorganization` DISABLE KEYS */;
INSERT INTO `syorganization` (`ID`, `ADDRESS`, `CODE`, `CREATEDATETIME`, `ICONCLS`, `NAME`, `SEQ`, `UPDATEDATETIME`, `SYORGANIZATION_ID`) VALUES
	('0', NULL, NULL, '2016-11-28 10:34:54', 'ext-icon-bricks', '总部', 100, '2016-11-28 10:35:12', NULL);
/*!40000 ALTER TABLE `syorganization` ENABLE KEYS */;

-- 导出  表 authbase.syorganization_syresource 结构
CREATE TABLE IF NOT EXISTS `syorganization_syresource` (
  `SYRESOURCE_ID` varchar(36) NOT NULL,
  `SYORGANIZATION_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SYORGANIZATION_ID`,`SYRESOURCE_ID`),
  KEY `FK_acpjp8a7fjo0cnn02eb0ia6uf` (`SYORGANIZATION_ID`),
  KEY `FK_m4mfglk7odi78d8pk9pif44vc` (`SYRESOURCE_ID`),
  CONSTRAINT `FK_acpjp8a7fjo0cnn02eb0ia6uf` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `syorganization` (`ID`),
  CONSTRAINT `FK_m4mfglk7odi78d8pk9pif44vc` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `syresource` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syorganization_syresource 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `syorganization_syresource` DISABLE KEYS */;
/*!40000 ALTER TABLE `syorganization_syresource` ENABLE KEYS */;

-- 导出  表 authbase.syresource 结构
CREATE TABLE IF NOT EXISTS `syresource` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `ICONCLS` varchar(100) DEFAULT NULL,
  `NAME` varchar(100) NOT NULL,
  `SEQ` int(11) DEFAULT NULL,
  `TARGET` varchar(100) DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `URL` varchar(200) DEFAULT NULL,
  `SYRESOURCE_ID` varchar(36) DEFAULT NULL,
  `SYRESOURCETYPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_n8kk2inhw4y4gax3nra2etfup` (`SYRESOURCE_ID`),
  KEY `FK_93qfpiiuk3rwb32gc5mcmmlgh` (`SYRESOURCETYPE_ID`),
  CONSTRAINT `FK_93qfpiiuk3rwb32gc5mcmmlgh` FOREIGN KEY (`SYRESOURCETYPE_ID`) REFERENCES `syresourcetype` (`ID`),
  CONSTRAINT `FK_n8kk2inhw4y4gax3nra2etfup` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `syresource` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syresource 的数据：~32 rows (大约)
/*!40000 ALTER TABLE `syresource` DISABLE KEYS */;
INSERT INTO `syresource` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `ICONCLS`, `NAME`, `SEQ`, `TARGET`, `UPDATEDATETIME`, `URL`, `SYRESOURCE_ID`, `SYRESOURCETYPE_ID`) VALUES
	('jgbj', '2024-12-15 10:34:53', '编辑机构', 'ext-icon-bullet_wrench', '编辑机构', 2, '', '2024-12-15 10:34:53', '/base/syorganization!update', 'jggl', '1'),
	('jgck', '2024-12-15 10:34:53', '查看机构', 'ext-icon-bullet_wrench', '查看机构', 4, '', '2024-12-15 10:34:53', '/base/syorganization!getById', 'jggl', '1'),
	('jssq', '2024-12-15 10:34:53', '角色授权', 'ext-icon-bullet_wrench', '角色授权', 5, '', '2024-12-15 10:34:53', '/base/syrole!grant', 'jsgl', '1'),
	('zysc', '2024-12-15 10:34:53', '删除资源', 'ext-icon-bullet_wrench', '删除资源', 3, '', '2024-12-15 10:34:53', '/base/syresource!delete', 'zygl', '1'),
	('zytj', '2024-12-15 10:34:53', '添加资源', 'ext-icon-bullet_wrench', '添加资源', 1, '', '2024-12-15 10:34:53', '/base/syresource!save', 'zygl', '1');
/*!40000 ALTER TABLE `syresource` ENABLE KEYS */;

-- 导出  表 authbase.syresourcetype 结构
CREATE TABLE IF NOT EXISTS `syresourcetype` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `NAME` varchar(100) NOT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syresourcetype 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `syresourcetype` DISABLE KEYS */;
INSERT INTO `syresourcetype` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `NAME`, `UPDATEDATETIME`) VALUES
	('0', '2024-12-15 10:34:53', '菜单类型会显示在系统首页左侧菜单中', '菜单', '2024-12-15 10:34:53'),
	('1', '2024-12-15 10:34:53', '功能类型不会显示在系统首页左侧菜单中', '功能', '2024-12-15 10:34:53');
/*!40000 ALTER TABLE `syresourcetype` ENABLE KEYS */;

-- 导出  表 authbase.syrole 结构
CREATE TABLE IF NOT EXISTS `syrole` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `ICONCLS` varchar(100) DEFAULT NULL,
  `NAME` varchar(100) NOT NULL,
  `SEQ` int(11) DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syrole 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `syrole` DISABLE KEYS */;
INSERT INTO `syrole` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `ICONCLS`, `NAME`, `SEQ`, `UPDATEDATETIME`) VALUES
	('0', '2024-12-15 10:34:53', '拥有系统所有权限', NULL, '超管', 0, '2024-12-15 10:34:53'),
	('19f00d46-8f1b-45b5-b7b7-6197d7b8cb33', '2016-11-28 14:24:00', NULL, NULL, '管理员', 100, '2016-11-28 14:24:00');
/*!40000 ALTER TABLE `syrole` ENABLE KEYS */;

-- 导出  表 authbase.syrole_syresource 结构
CREATE TABLE IF NOT EXISTS `syrole_syresource` (
  `SYROLE_ID` varchar(36) NOT NULL,
  `SYRESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SYRESOURCE_ID`,`SYROLE_ID`),
  KEY `FK_kkrartsovl2frhfvriqdi7jwl` (`SYRESOURCE_ID`),
  KEY `FK_r139h669pg4ts6mbvn3ip5472` (`SYROLE_ID`),
  CONSTRAINT `FK_kkrartsovl2frhfvriqdi7jwl` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `syresource` (`ID`),
  CONSTRAINT `FK_r139h669pg4ts6mbvn3ip5472` FOREIGN KEY (`SYROLE_ID`) REFERENCES `syrole` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syrole_syresource 的数据： (大约)
/*!40000 ALTER TABLE `syrole_syresource` DISABLE KEYS */;
INSERT INTO `syrole_syresource` (`SYROLE_ID`, `SYRESOURCE_ID`) VALUES
	('0', 'jgbj'),
	('0', 'jgck'),
	('0', 'zysc'),
	('0', 'zytj');
/*!40000 ALTER TABLE `syrole_syresource` ENABLE KEYS */;

-- 导出  表 authbase.syuser 结构
CREATE TABLE IF NOT EXISTS `syuser` (
  `ID` varchar(36) NOT NULL,
  `AGE` int(11) DEFAULT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `LOGINNAME` varchar(100) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `PHOTO` varchar(200) DEFAULT NULL,
  `PWD` varchar(100) DEFAULT NULL,
  `SEX` varchar(1) DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `EMPLOYDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_eiov1gsncrds3rean3dmu822p` (`LOGINNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syuser 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `syuser` DISABLE KEYS */;
INSERT INTO `syuser` (`ID`, `AGE`, `CREATEDATETIME`, `LOGINNAME`, `NAME`, `PHOTO`, `PWD`, `SEX`, `UPDATEDATETIME`, `EMPLOYDATE`) VALUES
	('0', 30, '2024-12-15 10:34:54', 'admin', '超级管理员', '', 'e10adc3949ba59abbe56e057f20f883e', '1', '2016-09-27 15:41:11', NULL);
/*!40000 ALTER TABLE `syuser` ENABLE KEYS */;

-- 导出  表 authbase.syuser_syorganization 结构
CREATE TABLE IF NOT EXISTS `syuser_syorganization` (
  `SYUSER_ID` varchar(36) NOT NULL,
  `SYORGANIZATION_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SYORGANIZATION_ID`,`SYUSER_ID`),
  KEY `FK_14ewqc5wtscac0dd5rswrm5j2` (`SYORGANIZATION_ID`),
  KEY `FK_63bdmtxwlk259id13rp4iryy` (`SYUSER_ID`),
  CONSTRAINT `FK_14ewqc5wtscac0dd5rswrm5j2` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `syorganization` (`ID`),
  CONSTRAINT `FK_63bdmtxwlk259id13rp4iryy` FOREIGN KEY (`SYUSER_ID`) REFERENCES `syuser` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syuser_syorganization 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `syuser_syorganization` DISABLE KEYS */;
INSERT INTO `syuser_syorganization` (`SYUSER_ID`, `SYORGANIZATION_ID`) VALUES
	('0', '0'),
	('346e8333-b644-4939-8b06-f23654963c6a', '0');
/*!40000 ALTER TABLE `syuser_syorganization` ENABLE KEYS */;

-- 导出  表 authbase.syuser_syrole 结构
CREATE TABLE IF NOT EXISTS `syuser_syrole` (
  `SYUSER_ID` varchar(36) NOT NULL,
  `SYROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SYROLE_ID`,`SYUSER_ID`),
  KEY `FK_j7iwtgslc2esrjx0ptieleoko` (`SYROLE_ID`),
  KEY `FK_1pi4p5h4y5ghbs5f4gdlgn620` (`SYUSER_ID`),
  CONSTRAINT `FK_1pi4p5h4y5ghbs5f4gdlgn620` FOREIGN KEY (`SYUSER_ID`) REFERENCES `syuser` (`ID`),
  CONSTRAINT `FK_j7iwtgslc2esrjx0ptieleoko` FOREIGN KEY (`SYROLE_ID`) REFERENCES `syrole` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- 正在导出表  authbase.syuser_syrole 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `syuser_syrole` DISABLE KEYS */;
INSERT INTO `syuser_syrole` (`SYUSER_ID`, `SYROLE_ID`) VALUES
	('0', '0'),
	('0', '19f00d46-8f1b-45b5-b7b7-6197d7b8cb33'),
	('346e8333-b644-4939-8b06-f23654963c6a', '19f00d46-8f1b-45b5-b7b7-6197d7b8cb33');
/*!40000 ALTER TABLE `syuser_syrole` ENABLE KEYS */;

-- 导出  函数 authbase.to_pinyin 结构
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `to_pinyin`(NAME VARCHAR(255) CHARSET gbk) RETURNS varchar(255) CHARSET gbk
BEGIN
    DECLARE mycode INT;
    DECLARE tmp_lcode VARCHAR(2) CHARSET gbk;
    DECLARE lcode INT;
    DECLARE tmp_rcode VARCHAR(2) CHARSET gbk;
    DECLARE rcode INT;
    DECLARE mypy VARCHAR(255) CHARSET gbk DEFAULT '';
    DECLARE lp INT;
    SET mycode = 0;
    SET lp = 1;
    SET NAME = HEX(NAME);
    WHILE lp < LENGTH(NAME) DO
        SET tmp_lcode = SUBSTRING(NAME, lp, 2);
        SET lcode = CAST(ASCII(UNHEX(tmp_lcode)) AS UNSIGNED); 
        SET tmp_rcode = SUBSTRING(NAME, lp + 2, 2);
        SET rcode = CAST(ASCII(UNHEX(tmp_rcode)) AS UNSIGNED); 
        IF lcode > 128 THEN
            SET mycode =65536 - lcode * 256 - rcode ;
            SELECT CONCAT(mypy,pin_yin_) INTO mypy FROM t_base_pinyin WHERE CODE_ >= ABS(mycode) ORDER BY CODE_ ASC LIMIT 1;
            SET lp = lp + 4;
        ELSE
            SET mypy = CONCAT(mypy,CHAR(CAST(ASCII(UNHEX(SUBSTRING(NAME, lp, 2))) AS UNSIGNED)));
            SET lp = lp + 2;
        END IF;
    END WHILE;
    RETURN LOWER(mypy);
END//
DELIMITER ;

-- 导出  表 authbase.t_base_pinyin 结构
CREATE TABLE IF NOT EXISTS `t_base_pinyin` (
  `pin_yin_` varchar(255) CHARACTER SET gbk NOT NULL,
  `code_` int(11) NOT NULL,
  PRIMARY KEY (`code_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 正在导出表  authbase.t_base_pinyin 的数据：~396 rows (大约)
/*!40000 ALTER TABLE `t_base_pinyin` DISABLE KEYS */;
INSERT INTO `t_base_pinyin` (`pin_yin_`, `code_`) VALUES
	('zhou', 10533),
	('zhong', 10544),
	('zhi', 10587),
	('zheng', 10764),
	('zhen', 10780),
	('zhe', 10790),
	('zhao', 10800),
	('zhang', 10815),
	('a', 20319);
/*!40000 ALTER TABLE `t_base_pinyin` ENABLE KEYS */;

-- 导出  视图 authbase.v_pinyin 结构
-- 创建临时表以解决视图依赖性错误
CREATE TABLE `v_pinyin` (
	`id` VARCHAR(36) NOT NULL COLLATE 'gbk_chinese_ci',
	`py` VARCHAR(255) NULL COLLATE 'gbk_chinese_ci',
	`name` VARCHAR(100) NULL COLLATE 'gbk_chinese_ci'
) ENGINE=MyISAM;

-- 导出  视图 authbase.v_pinyin 结构
-- 移除临时表并创建最终视图结构
DROP TABLE IF EXISTS `v_pinyin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `v_pinyin` AS SELECT
    u.id,
    to_pinyin (u.name) AS py,
    u.name
FROM
    syuser u ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
