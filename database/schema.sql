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
-- Table structure for table `account_subscription`
--

DROP TABLE IF EXISTS `account_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_subscription` (
  `account_subscription_id` int unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` int unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `agreed_price` decimal(10,2) NOT NULL,
  `status` enum('active','paused','completed','past_due','canceled') NOT NULL,
  `next_payment_date` date DEFAULT NULL,
  PRIMARY KEY (`account_subscription_id`),
  KEY `fk_account_subscription_subscription_id` (`subscription_id`),
  CONSTRAINT `fk_account_subscription_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscription` (`subscription_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_actions`
--

DROP TABLE IF EXISTS `audit_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_actions` (
  `action_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`action_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `action_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_audit_log_action_id` (`action_id`),
  KEY `fk_audit_log_user_id` (`user_id`),
  CONSTRAINT `fk_audit_log_action_id` FOREIGN KEY (`action_id`) REFERENCES `audit_actions` (`action_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_audit_log_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `bank_account_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `account_subscription_id` int unsigned NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('active','frozen','inactive','closed','restricted') NOT NULL,
  PRIMARY KEY (`bank_account_id`),
  KEY `fk_bank_account_user_id` (`user_id`),
  KEY `fk_bank_account_account_subscription_id` (`account_subscription_id`),
  CONSTRAINT `fk_bank_account_account_subscription_id` FOREIGN KEY (`account_subscription_id`) REFERENCES `account_subscription` (`account_subscription_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bank_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `principal_amount` decimal(10,2) NOT NULL,
  `interest_rate` decimal(5,4) NOT NULL,
  `remaining_balance` decimal(10,2) NOT NULL,
  `monthly_payment` decimal(10,2) NOT NULL,
  `next_payment_date` date DEFAULT NULL,
  `status` enum('active','paid_off','paused','delinquent') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`),
  KEY `fk_loan_user_id` (`user_id`),
  CONSTRAINT `fk_loan_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_interest_rate` CHECK (((`interest_rate` < 1) and (`interest_rate` > 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan_payment`
--

DROP TABLE IF EXISTS `loan_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_payment` (
  `loan_payment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `loan_id` int unsigned NOT NULL,
  `transaction_id` int unsigned DEFAULT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  `interest_part` decimal(10,2) unsigned NOT NULL,
  `principal_part` decimal(10,2) unsigned NOT NULL,
  `status` enum('paid','failed','overdue','pending') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_payment_id`),
  KEY `fk_loan_payment_loan_id` (`loan_id`),
  KEY `fk_loan_payment_transaction_id` (`transaction_id`),
  CONSTRAINT `fk_loan_payment_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_loan_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `uq_roles_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `subscription_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('standard','student','premium') NOT NULL,
  `duration_years` int NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_payment`
--

DROP TABLE IF EXISTS `subscription_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_payment` (
  `subscription_payment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `account_subscription_id` int unsigned NOT NULL,
  `transaction_id` int unsigned DEFAULT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  `status` enum('paid','failed','overdue','pending') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`subscription_payment_id`),
  KEY `fk_subscription_payment_account_subscription_id` (`account_subscription_id`),
  KEY `fk_subscription_payment_transaction_id` (`transaction_id`),
  CONSTRAINT `fk_subscription_payment_account_subscription_id` FOREIGN KEY (`account_subscription_id`) REFERENCES `account_subscription` (`account_subscription_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_subscription_payment_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int unsigned NOT NULL AUTO_INCREMENT,
  `from_account` int unsigned DEFAULT NULL,
  `to_account` int unsigned DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` enum('deposit','withdraw','transfer','subscription_payment','loan_payment') NOT NULL,
  `status` enum('failed','completed','processing') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_from_account` (`from_account`),
  KEY `fk_transations_to_account` (`to_account`),
  CONSTRAINT `fk_transactions_from_account` FOREIGN KEY (`from_account`) REFERENCES `bank_account` (`bank_account_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transations_to_account` FOREIGN KEY (`to_account`) REFERENCES `bank_account` (`bank_account_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_users_username` (`username`),
  KEY `fk_roles_role_id` (`role_id`),
  CONSTRAINT `fk_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-15 18:16:13
