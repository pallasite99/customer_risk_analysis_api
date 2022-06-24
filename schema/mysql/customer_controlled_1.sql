CREATE DATABASE  IF NOT EXISTS `customer_schema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `customer_schema`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: customer_schema
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `risky_creditcard`
--

DROP TABLE IF EXISTS `risky_creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risky_creditcard` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `creditcard` varchar(12) NOT NULL DEFAULT 'ABCDEFGHIJK1',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `creditcard_UNIQUE` (`creditcard`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risky_creditcard`
--

LOCK TABLES `risky_creditcard` WRITE;
/*!40000 ALTER TABLE `risky_creditcard` DISABLE KEYS */;
INSERT INTO `risky_creditcard` VALUES (4,'PPCB76888AC'),(2,'XXX2345128YY'),(1,'XZB4444987BB');
/*!40000 ALTER TABLE `risky_creditcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risky_email`
--

DROP TABLE IF EXISTS `risky_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risky_email` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risky_email`
--

LOCK TABLES `risky_email` WRITE;
/*!40000 ALTER TABLE `risky_email` DISABLE KEYS */;
INSERT INTO `risky_email` VALUES (4,'lowscore@gmail.com'),(2,'risky_user@gmail.com'),(1,'test@gmail.com');
/*!40000 ALTER TABLE `risky_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risky_phone`
--

DROP TABLE IF EXISTS `risky_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `risky_phone` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `phone` bigint NOT NULL DEFAULT '1234567890',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risky_phone`
--

LOCK TABLES `risky_phone` WRITE;
/*!40000 ALTER TABLE `risky_phone` DISABLE KEYS */;
INSERT INTO `risky_phone` VALUES (1,8830327194),(2,9158649984),(4,9423009331),(3,9423569360);
/*!40000 ALTER TABLE `risky_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `test_view`
--

DROP TABLE IF EXISTS `test_view`;
/*!50001 DROP VIEW IF EXISTS `test_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `test_view` AS SELECT 
 1 AS `customer_id`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `creditcard`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'customer_schema'
--

--
-- Dumping routines for database 'customer_schema'
--

--
-- Final view structure for view `test_view`
--

/*!50001 DROP VIEW IF EXISTS `test_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `test_view` AS select `risky_email`.`customer_id` AS `customer_id`,`risky_email`.`email` AS `email`,`risky_phone`.`phone` AS `phone`,`risky_creditcard`.`creditcard` AS `creditcard` from ((`risky_email` join `risky_phone`) join `risky_creditcard`) where ((`risky_creditcard`.`customer_id` = `risky_phone`.`customer_id`) and (`risky_email`.`customer_id` = `risky_creditcard`.`customer_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-24  9:35:30
