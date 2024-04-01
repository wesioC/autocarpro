-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: carapp
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `proprietarios`
--

DROP TABLE IF EXISTS `proprietarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proprietarios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `sexo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proprietarios`
--

LOCK TABLES `proprietarios` WRITE;
/*!40000 ALTER TABLE `proprietarios` DISABLE KEYS */;
INSERT INTO `proprietarios` VALUES (1,'Pedro dos Santos','123.456.789-10','Feminino'),(2,'Carlos Petros','232.489.789-10','Feminino'),(3,'Jonh James','674.345.376-10','Masculino'),(4,'Laryssa Barbosa','987.654.321-00','Feminino'),(15,'Luan de Bucho','121.212.121-22','Masculino');
/*!40000 ALTER TABLE `proprietarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisoes`
--

DROP TABLE IF EXISTS `revisoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisoes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `veiculo_id` int DEFAULT NULL,
  `data_revisao` date DEFAULT NULL,
  `descricao` text,
  `valor` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisoes`
--

LOCK TABLES `revisoes` WRITE;
/*!40000 ALTER TABLE `revisoes` DISABLE KEYS */;
INSERT INTO `revisoes` VALUES (1,1,'2023-01-15','Troca de óleo e filtro',150.00),(2,1,'2023-06-20','Revisão geral',300.00),(3,2,'2023-03-10','Troca de pneus',500.00),(4,2,'2023-09-05','Reparo na suspensão',400.00),(5,3,'2023-02-15','Troca de fluidos',200.00),(6,3,'2023-07-25','Substituição de freios',350.00),(7,4,'2023-04-15','Revisão anual',250.00),(8,4,'2023-10-30','Troca de filtros',100.00),(9,10,'2024-02-24','Troca de Buchas',340.88),(10,5,'2024-02-25','Troca de rolamento',89.78),(11,5,'2024-03-09','Troca de amortecedor',634.43),(12,11,'2024-02-27','Troca de coreia dentada',123.67),(13,8,'2024-03-27','corrente dentada 2',666.99),(14,NULL,'2024-02-25','Cabo do acelerador',89.34),(15,12,'2024-02-08','cabo do acelerador',122.87),(16,12,'2024-02-24','aa',1212.99),(17,1,'2024-02-27','Limpeza das velas',89.45);
/*!40000 ALTER TABLE `revisoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculos`
--

DROP TABLE IF EXISTS `veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `proprietario_id` int DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `ano` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculos`
--

LOCK TABLES `veiculos` WRITE;
/*!40000 ALTER TABLE `veiculos` DISABLE KEYS */;
INSERT INTO `veiculos` VALUES (1,1,'Toyota','Corolla Cross XRX 1.8 16V Aut. (Híbrido)',2018),(2,1,'Honda','Civic',2019),(3,2,'Ford','Focus',2020),(4,2,'Honda','City',2020),(5,3,'Ford','Ka',2017),(6,3,'Chevrolet','Celta',2014),(7,2,'Ford','Ranger',2017),(8,4,'Chevrolet','Onix',2024),(9,1,'Asia Motors','Topic Carga 2.7 Diesel (furgão)',2012),(10,1,'Acura','Integra GS 1.8',1222),(11,4,'BMW','120iA Sport 2.0/ActiveFlex 16V Aut.',2019),(12,4,'Citroën','C3 Attraction Pure Tech 1.2 Flex 12V Mec',2010);
/*!40000 ALTER TABLE `veiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'carapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-31 23:00:55
