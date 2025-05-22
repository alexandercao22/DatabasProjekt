-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: vsp
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `channel_id` int NOT NULL,
  `channel_name` varchar(64) NOT NULL,
  `creation_date` date DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
INSERT INTO `channels` VALUES (1,'Ludwig','2011-08-15','USA'),(2,'MrBeast','2012-02-20','USA'),(3,'PewDiePie','2010-04-29','Japan'),(4,'SampeV2','2013-03-04','Sweden'),(5,'ILIKEcars','2012-07-12','Albania'),(6,'Mark Rober','2011-10-20','USA'),(7,'Dude Perfect','2009-03-17','USA'),(8,'Emil Hansius','2016-08-03','Sweden'),(9,'ESPN','2005-11-01','USA'),(10,'Sidemen','2015-06-14','UK'),(11,'Dream','2014-02-08','USA'),(12,'jacksepticeye','2007-02-01','Ireland'),(13,'Asmongold TV','2019-12-09','USA'),(14,'MrBeast Gaming','2020-04-07','USA'),(15,'Anomaly','2007-03-21','Sweden'),(16,'VanossGaming','2011-09-15','USA'),(17,'SMii7Y','2011-04-18','Canada'),(18,'Linus Tech Tips','2008-11-25','Canada'),(19,'Expressen','2008-10-06','Sweden'),(20,'HowToBasic','2011-12-08','Australia');
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-22 16:04:56
