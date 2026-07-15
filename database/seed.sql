-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: bankwebsite
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Dumping data for table `account_subscription`
--

LOCK TABLES `account_subscription` WRITE;
/*!40000 ALTER TABLE `account_subscription` DISABLE KEYS */;
INSERT INTO `account_subscription` VALUES (1,1,'2026-04-26','2031-04-26',5.00,'active','2026-05-26'),(2,1,'2026-05-02','2031-05-02',5.00,'active','2026-06-02'),(3,2,'2026-05-03','2031-05-03',0.00,'active','2026-06-03');
/*!40000 ALTER TABLE `account_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audit_actions`
--

LOCK TABLES `audit_actions` WRITE;
/*!40000 ALTER TABLE `audit_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bank_account`
--

LOCK TABLES `bank_account` WRITE;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` VALUES (1,9,1,9900.00,'active'),(2,9,2,9640.00,'active'),(3,12,3,10060.00,'active');
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan_payment`
--

LOCK TABLES `loan_payment` WRITE;
/*!40000 ALTER TABLE `loan_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `loan_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(3,'customer'),(2,'moderator');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,'standard',5,5.00,1),(2,'student',5,0.00,1),(3,'premium',5,20.00,1);
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `subscription_payment`
--

LOCK TABLES `subscription_payment` WRITE;
/*!40000 ALTER TABLE `subscription_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (33,NULL,2,20.00,'deposit','completed','2026-07-06 13:40:03'),(34,2,NULL,20.00,'withdraw','completed','2026-07-06 13:40:10'),(35,2,NULL,20.00,'withdraw','completed','2026-07-06 13:40:15'),(36,1,NULL,20.00,'withdraw','completed','2026-07-06 13:40:28'),(37,NULL,1,20.00,'deposit','completed','2026-07-06 13:40:44'),(38,2,NULL,20.00,'withdraw','completed','2026-07-06 14:25:51'),(39,2,NULL,20.00,'withdraw','completed','2026-07-08 12:10:43'),(40,1,NULL,20.00,'withdraw','completed','2026-07-08 14:29:26'),(41,1,NULL,20.00,'withdraw','completed','2026-07-08 14:29:35'),(42,1,NULL,20.00,'withdraw','completed','2026-07-08 14:29:49'),(43,2,NULL,20.00,'withdraw','completed','2026-07-08 14:43:19'),(44,2,NULL,20.00,'withdraw','completed','2026-07-08 22:37:03'),(45,NULL,2,20.00,'deposit','completed','2026-07-08 22:39:39'),(46,1,NULL,20.00,'withdraw','completed','2026-07-08 22:58:17'),(47,2,NULL,20.00,'withdraw','completed','2026-07-09 20:06:19'),(48,2,NULL,20.00,'withdraw','completed','2026-07-09 21:28:48'),(49,NULL,2,20.00,'deposit','completed','2026-07-14 15:32:05'),(50,2,3,20.00,'transfer','completed','2026-07-15 10:48:50'),(51,1,3,20.00,'transfer','completed','2026-07-15 11:08:01'),(52,1,NULL,20.00,'withdraw','completed','2026-07-15 13:30:08'),(53,1,3,20.00,'transfer','completed','2026-07-15 13:34:25');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (9,1,'dom07','$2b$10$XZlk3m6CT.I2n5fLKQTLfOefJE1AaD8MTB7DdKlYq.is1jWj6fZIG','Dominik','K','2026-04-10'),(12,3,'leo08','$2b$10$/NUG4F3gCLmFxHClompkjuWWBL8rWGMxJzEDT1euXELWGjtZHslR2','Leo','A','2026-04-10');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-15 18:26:56
