CREATE DATABASE  IF NOT EXISTS `db_ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `db_ecommerce`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_ecommerce
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.19-MariaDB

SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS ;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION ;
SET NAMES utf8 ;
SET @OLD_TIME_ZONE=@@TIME_ZONE ;
SET TIME_ZONE='+00:00' ;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 ;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 ;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' ;
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 ;

--
-- Table structure for table `tb_addresses`
--

DROP TABLE IF EXISTS `tb_addresses`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_addresses` (
  `idaddress` int(11) NOT NULL AUTO_INCREMENT,
  `idperson` int(11) NOT NULL,
  `desaddress` varchar(128) NOT NULL,
  `descomplement` varchar(32) DEFAULT NULL,
  `descity` varchar(32) NOT NULL,
  `desstate` varchar(32) NOT NULL,
  `descountry` varchar(32) NOT NULL,
  `nrzipcode` int(11) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idaddress`),
  KEY `fk_addresses_persons_idx` (`idperson`),
  CONSTRAINT `fk_addresses_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_addresses`
--

LOCK TABLES `tb_addresses` WRITE;
ALTER TABLE `tb_addresses` DISABLE KEYS ;
ALTER TABLE `tb_addresses` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_carts` (
  `idcart` int(11) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `idaddress` int(11) DEFAULT NULL,
  `vlfreight` decimal(10,2) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcart`),
  KEY `FK_carts_users_idx` (`iduser`),
  KEY `fk_carts_addresses_idx` (`idaddress`),
  CONSTRAINT `fk_carts_addresses` FOREIGN KEY (`idaddress`) REFERENCES `tb_addresses` (`idaddress`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_carts_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_carts`
--

LOCK TABLES `tb_carts` WRITE;
ALTER TABLE `tb_carts` DISABLE KEYS ;
ALTER TABLE `tb_carts` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_cartsproducts`
--

DROP TABLE IF EXISTS `tb_cartsproducts`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_cartsproducts` (
  `idcartproduct` int(11) NOT NULL AUTO_INCREMENT,
  `idcart` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  `dtremoved` datetime NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcartproduct`),
  KEY `FK_cartsproducts_carts_idx` (`idcart`),
  KEY `FK_cartsproducts_products_idx` (`idproduct`),
  CONSTRAINT `fk_cartsproducts_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartsproducts_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_cartsproducts`
--

LOCK TABLES `tb_cartsproducts` WRITE;
ALTER TABLE `tb_cartsproducts` DISABLE KEYS ;
ALTER TABLE `tb_cartsproducts` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_categories`
--

DROP TABLE IF EXISTS `tb_categories`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_categories` (
  `idcategory` int(11) NOT NULL AUTO_INCREMENT,
  `descategory` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_categories`
--

LOCK TABLES `tb_categories` WRITE;
ALTER TABLE `tb_categories` DISABLE KEYS ;
ALTER TABLE `tb_categories` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_orders`
--

DROP TABLE IF EXISTS `tb_orders`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_orders` (
  `idorder` int(11) NOT NULL AUTO_INCREMENT,
  `idcart` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `idstatus` int(11) NOT NULL,
  `vltotal` decimal(10,2) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idorder`),
  KEY `FK_orders_carts_idx` (`idcart`),
  KEY `FK_orders_users_idx` (`iduser`),
  KEY `fk_orders_ordersstatus_idx` (`idstatus`),
  CONSTRAINT `fk_orders_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_ordersstatus` FOREIGN KEY (`idstatus`) REFERENCES `tb_ordersstatus` (`idstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_orders`
--

LOCK TABLES `tb_orders` WRITE;
ALTER TABLE `tb_orders` DISABLE KEYS ;
ALTER TABLE `tb_orders` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_ordersstatus`
--

DROP TABLE IF EXISTS `tb_ordersstatus`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_ordersstatus` (
  `idstatus` int(11) NOT NULL AUTO_INCREMENT,
  `desstatus` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_ordersstatus`
--

LOCK TABLES `tb_ordersstatus` WRITE;
ALTER TABLE `tb_ordersstatus` DISABLE KEYS ;
INSERT INTO `tb_ordersstatus` VALUES (1,'Em Aberto','2017-03-13 03:00:00'),(2,'Aguardando Pagamento','2017-03-13 03:00:00'),(3,'Pago','2017-03-13 03:00:00'),(4,'Entregue','2017-03-13 03:00:00');
ALTER TABLE `tb_ordersstatus` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_persons`
--

DROP TABLE IF EXISTS `tb_persons`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_persons` (
  `idperson` int(11) NOT NULL AUTO_INCREMENT,
  `desperson` varchar(64) NOT NULL,
  `desemail` varchar(128) DEFAULT NULL,
  `nrphone` bigint(20) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_persons`
--

LOCK TABLES `tb_persons` WRITE;
ALTER TABLE `tb_persons` DISABLE KEYS ;
INSERT INTO `tb_persons` VALUES (1,'JoÃ£o Rangel','admin@hcode.com.br',2147483647,'2017-03-01 03:00:00'),(7,'Suporte','suporte@hcode.com.br',1112345678,'2017-03-15 16:10:27');
ALTER TABLE `tb_persons` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_products` (
  `idproduct` int(11) NOT NULL AUTO_INCREMENT,
  `desproduct` varchar(64) NOT NULL,
  `vlprice` decimal(10,2) NOT NULL,
  `vlwidth` decimal(10,2) NOT NULL,
  `vlheight` decimal(10,2) NOT NULL,
  `vllength` decimal(10,2) NOT NULL,
  `vlweight` decimal(10,2) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_products`
--

LOCK TABLES `tb_products` WRITE;
ALTER TABLE `tb_products` DISABLE KEYS ;
INSERT INTO `tb_products` VALUES (1,'Smartphone Android 7.0',999.95,75.00,151.00,80.00,167.00,'smartphone-android-7.0','2017-03-13 03:00:00'),(2,'SmartTV LED 4K',3925.99,917.00,596.00,288.00,8600.00,'smarttv-led-4k','2017-03-13 03:00:00'),(3,'Notebook 14\" 4GB 1TB',1949.99,345.00,23.00,30.00,2000.00,'notebook-14-4gb-1tb','2017-03-13 03:00:00');
ALTER TABLE `tb_products` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_productscategories`
--

DROP TABLE IF EXISTS `tb_productscategories`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_productscategories` (
  `idcategory` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  PRIMARY KEY (`idcategory`,`idproduct`),
  KEY `fk_productscategories_products_idx` (`idproduct`),
  CONSTRAINT `fk_productscategories_categories` FOREIGN KEY (`idcategory`) REFERENCES `tb_categories` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productscategories_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_productscategories`
--

LOCK TABLES `tb_productscategories` WRITE;
ALTER TABLE `tb_productscategories` DISABLE KEYS ;
ALTER TABLE `tb_productscategories` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_users` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idperson` int(11) NOT NULL,
  `deslogin` varchar(64) NOT NULL,
  `despassword` varchar(256) NOT NULL,
  `inadmin` tinyint(4) NOT NULL DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iduser`),
  KEY `FK_users_persons_idx` (`idperson`),
  CONSTRAINT `fk_users_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
ALTER TABLE `tb_users` DISABLE KEYS ;
INSERT INTO `tb_users` VALUES (1,1,'admin','$2y$12$YlooCyNvyTji8bPRcrfNfOKnVMmZA9ViM2A3IpFjmrpIbp5ovNmga',1,'2017-03-13 03:00:00'),(7,7,'suporte','$2y$12$HFjgUm/mk1RzTy4ZkJaZBe0Mc/BA2hQyoUckvm.lFa6TesjtNpiMe',1,'2017-03-15 16:10:27');
ALTER TABLE `tb_users` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_userslogs`
--

DROP TABLE IF EXISTS `tb_userslogs`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_userslogs` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `deslog` varchar(128) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `desuseragent` varchar(128) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlog`),
  KEY `fk_userslogs_users_idx` (`iduser`),
  CONSTRAINT `fk_userslogs_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_userslogs`
--

LOCK TABLES `tb_userslogs` WRITE;
ALTER TABLE `tb_userslogs` DISABLE KEYS ;
ALTER TABLE `tb_userslogs` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Table structure for table `tb_userspasswordsrecoveries`
--

DROP TABLE IF EXISTS `tb_userspasswordsrecoveries`;
SET @saved_cs_client     = @@character_set_client ;
SET character_set_client = utf8 ;
CREATE TABLE `tb_userspasswordsrecoveries` (
  `idrecovery` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `dtrecovery` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrecovery`),
  KEY `fk_userspasswordsrecoveries_users_idx` (`iduser`),
  CONSTRAINT `fk_userspasswordsrecoveries_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client ;

--
-- Dumping data for table `tb_userspasswordsrecoveries`
--

LOCK TABLES `tb_userspasswordsrecoveries` WRITE;
ALTER TABLE `tb_userspasswordsrecoveries` DISABLE KEYS ;
INSERT INTO `tb_userspasswordsrecoveries` VALUES (1,7,'127.0.0.1',NULL,'2017-03-15 16:10:59'),(2,7,'127.0.0.1','2017-03-15 13:33:45','2017-03-15 16:11:18'),(3,7,'127.0.0.1','2017-03-15 13:37:35','2017-03-15 16:37:12');
ALTER TABLE `tb_userspasswordsrecoveries` ENABLE KEYS ;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_ecommerce'
--
DROP PROCEDURE IF EXISTS `sp_userspasswordsrecoveries_create` ;
SET @saved_cs_client      = @@character_set_client  ;
SET @saved_cs_results     = @@character_set_results  ;
SET @saved_col_connection = @@collation_connection  ;
SET character_set_client  = utf8  ;
SET character_set_results = utf8  ;
SET collation_connection  = utf8_general_ci  ;
SET @saved_sql_mode       = @@sql_mode  ;
SET sql_mode              = 'NO_ENGINE_SUBSTITUTION'  ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_userspasswordsrecoveries_create`(
piduser INT,
pdesip VARCHAR(45)
)
BEGIN
	
	INSERT INTO tb_userspasswordsrecoveries (iduser, desip)
    VALUES(piduser, pdesip);
    
    SELECT * FROM tb_userspasswordsrecoveries
    WHERE idrecovery = LAST_INSERT_ID();
    
END ;;
DELIMITER ;
SET sql_mode              = @saved_sql_mode  ;
SET character_set_client  = @saved_cs_client  ;
SET character_set_results = @saved_cs_results  ;
SET collation_connection  = @saved_col_connection  ;
DROP PROCEDURE IF EXISTS `sp_usersupdate_save` ;
SET @saved_cs_client      = @@character_set_client  ;
SET @saved_cs_results     = @@character_set_results  ;
SET @saved_col_connection = @@collation_connection  ;
SET character_set_client  = utf8  ;
SET character_set_results = utf8  ;
SET collation_connection  = utf8_general_ci  ;
SET @saved_sql_mode       = @@sql_mode  ;
SET sql_mode              = 'NO_ENGINE_SUBSTITUTION'  ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usersupdate_save`(
piduser INT,
pdesperson VARCHAR(64), 
pdeslogin VARCHAR(64), 
pdespassword VARCHAR(256), 
pdesemail VARCHAR(128), 
pnrphone BIGINT, 
pinadmin TINYINT
)
BEGIN
	
    DECLARE vidperson INT;
    
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
    
    UPDATE tb_persons
    SET 
		desperson = pdesperson,
        desemail = pdesemail,
        nrphone = pnrphone
	WHERE idperson = vidperson;
    
    UPDATE tb_users
    SET
		deslogin = pdeslogin,
        despassword = pdespassword,
        inadmin = pinadmin
	WHERE iduser = piduser;
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = piduser;
    
END ;;
DELIMITER ;
SET sql_mode              = @saved_sql_mode  ;
SET character_set_client  = @saved_cs_client  ;
SET character_set_results = @saved_cs_results  ;
SET collation_connection  = @saved_col_connection  ;
DROP PROCEDURE IF EXISTS `sp_users_delete` ;
SET @saved_cs_client      = @@character_set_client  ;
SET @saved_cs_results     = @@character_set_results  ;
SET @saved_col_connection = @@collation_connection  ;
SET character_set_client  = utf8  ;
SET character_set_results = utf8  ;
SET collation_connection  = utf8_general_ci  ;
SET @saved_sql_mode       = @@sql_mode  ;
SET sql_mode              = 'NO_ENGINE_SUBSTITUTION'  ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_delete`(
piduser INT
)
BEGIN
	
    DECLARE vidperson INT;
    
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
    
    DELETE FROM tb_users WHERE iduser = piduser;
    DELETE FROM tb_persons WHERE idperson = vidperson;
    
END ;;
DELIMITER ;
SET sql_mode              = @saved_sql_mode  ;
SET character_set_client  = @saved_cs_client  ;
SET character_set_results = @saved_cs_results  ;
SET collation_connection  = @saved_col_connection  ;
DROP PROCEDURE IF EXISTS `sp_users_save` ;
SET @saved_cs_client      = @@character_set_client  ;
SET @saved_cs_results     = @@character_set_results  ;
SET @saved_col_connection = @@collation_connection  ;
SET character_set_client  = utf8  ;
SET character_set_results = utf8  ;
SET collation_connection  = utf8_general_ci  ;
SET @saved_sql_mode       = @@sql_mode  ;
SET sql_mode              = 'NO_ENGINE_SUBSTITUTION'  ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_save`(
pdesperson VARCHAR(64), 
pdeslogin VARCHAR(64), 
pdespassword VARCHAR(256), 
pdesemail VARCHAR(128), 
pnrphone BIGINT, 
pinadmin TINYINT
)
BEGIN
	
    DECLARE vidperson INT;
    
	INSERT INTO tb_persons (desperson, desemail, nrphone)
    VALUES(pdesperson, pdesemail, pnrphone);
    
    SET vidperson = LAST_INSERT_ID();
    
    INSERT INTO tb_users (idperson, deslogin, despassword, inadmin)
    VALUES(vidperson, pdeslogin, pdespassword, pinadmin);
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = LAST_INSERT_ID();
    
END ;;
DELIMITER ;
SET sql_mode              = @saved_sql_mode  ;
SET character_set_client  = @saved_cs_client  ;
SET character_set_results = @saved_cs_results  ;
SET collation_connection  = @saved_col_connection  ;
SET TIME_ZONE=@OLD_TIME_ZONE ;

SET SQL_MODE=@OLD_SQL_MODE ;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS ;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS ;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT ;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS ;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION ;
SET SQL_NOTES=@OLD_SQL_NOTES ;

-- Dump completed on 2017-04-24 11:50:48
