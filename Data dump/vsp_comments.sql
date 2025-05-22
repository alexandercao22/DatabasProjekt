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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL,
  `video_id` int NOT NULL,
  `channel_id` int NOT NULL,
  `upload_date` date DEFAULT NULL,
  `text` varchar(256) DEFAULT NULL,
  `likes` int DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `video_id` (`video_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,4,'2025-04-27','I like baguettes!',420),(2,1,2,'2025-04-28','Oui oui, merci sacre bleu',59),(3,4,18,'2025-05-01','I use Arch btw',21050),(4,4,12,'2025-05-03','Honestly the reactor setup is immaculate. Super cool vibe.',215),(5,1,2,'2022-08-03','This is my new second channel',6410),(6,1,6,'2024-05-22','This video... aged like fine wine... dont delete it lud',14),(7,12,8,'2020-03-29','Jååå, vilken youtuber ska jag flytta in hos härnäst?',297),(8,12,4,'2020-04-02','Fan vad bra kemi ni har fortsätt med det här!',55),(9,8,20,'2024-09-17','If I made something this cool I would never be able to keep it a secret for years lol',2071),(10,6,13,'2025-04-13','This is actually wild. Love the slow-mo shots!',632),(11,7,16,'2025-04-26','Imagine losing to a tortoise',1583),(12,14,11,'2024-11-17','They both swing like Minecraft players tbh',4805),(13,3,17,'2023-08-06','Bro this gave me Subnautica PTSD',893),(14,2,1,'2022-08-03','I did find it... just not $100,000',672),(15,16,18,'2025-03-17','TikTok food vs Linus Tech Tips tech – who wins?',1741),(16,15,10,'2025-04-28','I walked 10 miles for one of these clues... worth it.',12906),(17,5,15,'2012-12-25','My dad watches your channel while fixing the car, thanks lol',8),(18,18,14,'2020-08-08','Best manhunt ever. Peak Minecraft.',24933),(19,19,9,'2025-05-06','Not the best playoff take but I respect it.',522),(20,20,3,'2025-04-05','Schedule I arc is getting dark',712),(21,13,10,'2025-05-06','We need a Sidemen x NBA collab now ',2940),(22,3,5,'2023-08-06','I wouldn’t survive 7 minutes at sea',203),(23,11,17,'2025-04-27','Edvin carried this episode fr',578),(24,6,3,'2025-04-13','Jumping on a moving train? Classic YouTube.',1999),(25,14,1,'2024-11-17','I trained for this moment my entire life',367),(26,9,19,'2025-04-26','Tortoise had better stats ngl',127),(27,10,7,'2025-01-26','Keanu really pulled up like it’s John Wick 5',9485),(28,17,16,'2025-05-04','Daquavis got combo’d out of existence',6934),(29,20,15,'2025-04-05','That ending tho… never saw it coming',1944),(30,4,6,'2023-04-27','PewDiePie switching to Linux is my villain origin story',3821),(31,8,18,'2022-06-16','Warehouse setup: 10/10. Cable management: 3/10.',10945),(32,2,13,'2022-08-03','Did anyone actually find it? Asking for a friend.',881),(33,15,12,'2025-04-27','Scavenger hunt better than most movies tbh',7210),(34,1,14,'2025-04-28','MrBeast Gaming takes over French bakeries now?',542),(35,12,11,'2025-05-01','“PvP Duel” was intense. My palms were sweating.',3201),(36,7,4,'2025-04-27','This rabbit should join Dude Perfect',144),(37,16,2,'2024-04-21','You guys have officially won YouTube.',33128),(38,18,20,'2023-04-26','Linux gang rise up.',2503),(39,19,8,'2025-04-27','Imponerande. Ni får gärna flytta in hos oss på Expressen!',191),(40,13,17,'2025-04-13','Train jump felt like a GTA stunt jump bonus',652);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
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
