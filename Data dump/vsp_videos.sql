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
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `video_id` int NOT NULL,
  `channel_id` int NOT NULL,
  `video_name` varchar(64) DEFAULT NULL,
  `views` int DEFAULT NULL,
  `upload_date` date DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `length` time DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES (1,1,'I Opened a French Bakery for 24 Hours!',928,'2025-04-27',59,'00:22:12'),(2,1,'I Burried $100,000, Go Find It',16000,'2022-08-02',600,'00:11:42'),(3,2,'7 Days Stranded At Sea',355000,'2023-08-05',7900,'00:18:04'),(4,3,'I installed Linux (so should you)',3401,'2023-04-26',160,'00:22:52'),(5,5,'How to fix your cars',5000,'2012-12-24',2,'00:35:40'),(6,6,'Testing What Happens If You Jump On A Moving Train',10571625,'2025-04-12',247326,'00:18:15'),(7,6,'Vortex Cannon vs Drone',29387933,'2024-04-20',591585,'00:20:43'),(8,6,'My Secret Warehouse Tour',36072083,'2022-06-15',863866,'00:17:15'),(9,7,'Tortoise vs. Hare - Who Wins?',3829665,'2025-04-26',67667,'00:14:59'),(10,7,'Dude Perfect vs Keanu Reeves (150 MPH)',5153086,'2025-01-25',157236,'00:26:27'),(11,8,'HANSIUS FLYTTAR IN | Edvin Törnblom',457757,'2025-04-27',12552,'01:12:17'),(12,8,'HANSIUS FLYTTAR IN hos HAMPUS HEDSTRÖM',2258103,'2020-03-29',22894,'00:46:36'),(13,9,'NBA Playoff Reaction',154482,'2025-05-05',1605,'00:16:33'),(14,9,'Jake Paul vs. Mike Tyson FIGHT HIGHLIGHTS',36494447,'2024-11-16',274955,'00:02:34'),(15,10,'⁠SIDEMEN $5,000,000 SCAVENGER HUNT',6070085,'2025-04-27',209666,'01:39:08'),(16,10,'⁠SIDEMEN TEST VIRAL TIKTOK FOODS',7279502,'2025-03-16',196721,'01:28:10'),(17,11,'⁠Dream VS Daquavis $100,000 PvP Duel',6038479,'2025-05-03',469305,'00:35:25'),(18,11,'Minecraft Speedrunner VS 3 Hunters GRAND FINALE',136120019,'2020-08-07',4902654,'00:41:47'),(19,12,'THIS ISN’T GOOD | Schedule I',1272868,'2025-04-30',42208,'01:20:10'),(20,12,'MY FIRST DEALER | Schedule I',2600696,'2025-04-04',132436,'01:30:52');
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
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
