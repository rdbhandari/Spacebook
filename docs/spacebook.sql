-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: spacebook
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
  `c_id` int NOT NULL AUTO_INCREMENT,
  `p_id` int DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  `c_desc` varchar(200) DEFAULT NULL,
  `c_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_id`),
  KEY `u_id` (`u_id`),
  KEY `p_id` (`p_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `post` (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (3,5,1,'Great Post !','2023-07-17 13:28:35');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `u1_id` int DEFAULT NULL,
  `u2_id` int DEFAULT NULL,
  `f_sts` tinyint(1) DEFAULT NULL,
  KEY `u1_id` (`u1_id`),
  KEY `u2_id` (`u2_id`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`u1_id`) REFERENCES `user` (`u_id`),
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`u2_id`) REFERENCES `user` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (2,3,1),(3,1,1),(3,2,1),(4,3,0),(4,1,0),(1,2,1),(1,3,1),(2,4,0);
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `p_id` int DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  KEY `u_id` (`u_id`),
  KEY `p_id` (`p_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `post` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (3,1),(5,1);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `p_id` int NOT NULL AUTO_INCREMENT,
  `p_desc` varchar(1000) DEFAULT NULL,
  `p_img` varchar(200) DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  `p_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`p_id`),
  KEY `u_id` (`u_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (2,'&#128248; Check out this amazing view from my recent hiking trip! &#128525; Nature never fails to amaze me. Feeling grateful for the opportunity to explore and connect with the outdoors. &#127794;&#127795; #NatureLovers #HikingAdventures #Grateful #BeautifulScenery #OutdoorEnthusiast \r\n\r\nChatGPT\r\n Image by RÜ&#350;TÜ BOZKU&#350; from Pixabay','P_1_1689527901478.jpg',1,'2023-07-16 22:27:07'),(3,'&#128227; Exciting Tech Breakthrough! &#127775;&#128300;\r\nIntroducing the \"Quantum Leap\" &#128640;&#128161;, a groundbreaking innovation that promises to revolutionize computing! &#127760;&#128302; Combining quantum computing and artificial intelligence, this cutting-edge technology opens up a realm of possibilities. From solving complex problems to advancing scientific research, get ready to witness the future! &#127756;&#127757; #QuantumLeap #TechBreakthrough ChatGPT Image by Michael Schwarzenberger from Pixabay','P_1_1689528411272.jpg',1,'2023-07-16 22:56:51'),(4,'&#127916; Lights, camera, action! &#127909;&#127871; Dive into the mesmerizing world of movies, where dreams come alive and emotions run wild. From heartwarming romances to spine-tingling thrillers, there\'s a film for every mood. Grab your popcorn and immerse yourself in the magic of cinema! &#127775;&#127902;&#65039;&#10024;\r\nCharGPT Image by Igor Ovsyannykov from Pixabay','P_2_1689530107488.jpg',2,'2023-07-16 23:25:07'),(5,'Cricket, a captivating sport cherished by millions worldwide, combines athleticism and strategy. The clash of bat and ball, the thrill of runs, and the artistry of fielding create an electrifying atmosphere. Whether played on grand stadiums or humble street corners, cricket unites people in the spirit of competition and camaraderie.  ChatGPT Image by Yogendra Singh from Pixabay','P_3_1689530381621.jpg',3,'2023-07-16 23:29:41'),(6,'Technology continues to shape our lives, revolutionizing how we communicate, work, and explore the world. From smartphones to artificial intelligence, it has become an inseparable part of our daily existence. With advancements like virtual reality and blockchain, the possibilities are endless. Here\'s an image representing the diverse realm of technology. ChatGPT Image by WikiImages from Pixabay','P_4_1689530588840.jpg',4,'2023-07-16 23:33:08');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `p_id` int DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  KEY `u_id` (`u_id`),
  KEY `p_id` (`p_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `post` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (6,2),(3,3);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `u_id` int NOT NULL AUTO_INCREMENT,
  `u_email` varchar(255) DEFAULT NULL,
  `u_name` varchar(50) DEFAULT NULL,
  `u_img` varchar(100) DEFAULT NULL,
  `u_dob` date DEFAULT NULL,
  `u_gender` varchar(6) DEFAULT NULL,
  `u_pswd` varchar(256) DEFAULT NULL,
  `u_sts` tinyint(1) DEFAULT '1',
  `u_banfor` datetime DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'rahul@deb.bhandari','Rahul Deb Bhandari','D_1689527742357.jpg','2000-07-11','Male','11111111',2,'2023-07-18 13:37:56'),(2,'John@Wick.Com','John Wick ','D_1689529193153.png','1993-07-15','Male','11111111',1,NULL),(3,'Mahendra@Singh.Dhoni','Mahendra Singh Dhoni','D_1689529471267.png','1976-07-07','Male','11111111',1,NULL),(4,'Elon@Reeve.Musk','Elon Reeve Musk','D_1689529794163.png','1985-08-15','Male','11111111',1,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'spacebook'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-17 13:55:01
