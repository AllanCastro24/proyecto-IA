-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: canasta_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inventarios`
--

DROP TABLE IF EXISTS `inventarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventarios` (
  `clave` int(11) NOT NULL AUTO_INCREMENT,
  `c_producto` int(11) NOT NULL,
  `cantidad` double NOT NULL,
  `fecha_compra` datetime NOT NULL,
  `fecha_expiracion` datetime DEFAULT NULL,
  PRIMARY KEY (`clave`),
  KEY `inventarios_FK` (`c_producto`),
  CONSTRAINT `inventarios_FK` FOREIGN KEY (`c_producto`) REFERENCES `productos` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios`
--

LOCK TABLES `inventarios` WRITE;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
INSERT INTO `inventarios` VALUES (1,1,100,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(2,2,25,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(3,3,123,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(4,4,54,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(5,5,23,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(6,6,1,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(7,7,765,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(8,8,1325,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(9,9,1234,'2022-10-18 10:50:00','2023-10-01 01:00:00'),(10,10,7645,'2022-10-18 10:50:00','2023-10-01 01:00:00');
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `clave` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `color` varchar(10) DEFAULT NULL,
  `c_unidad_medida` int(11) NOT NULL,
  `peso_promedio` double DEFAULT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`clave`),
  KEY `productos_FK` (`c_unidad_medida`),
  CONSTRAINT `productos_FK` FOREIGN KEY (`c_unidad_medida`) REFERENCES `unidad_medida` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'MANZANA','#ff0800',1,0.2,29.9),(2,'NARANJA','#FF6600',1,0.15,22),(3,'FRESA','#d53032',1,0.0038,49.9),(4,'PLÁTANO','#ffca3d',1,0.1,12),(5,'KIWI','#d3e7c1',1,0.13,59),(6,'MELÓN','#FBCA7F',1,2.26,31.5),(7,'SANDÍA','#cf5f69',1,4.5,17.9),(8,'UVA','#6F2DA8',1,0.2,52),(9,'ARANDANO','#4F86F7',1,0.1,194),(10,'PERA','#D1E231',1,0.25,34.9);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resumen_compra`
--

DROP TABLE IF EXISTS `resumen_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resumen_compra` (
  `clave` int(11) NOT NULL AUTO_INCREMENT,
  `c_producto` int(11) NOT NULL,
  `cantidad` double NOT NULL,
  `fecha_y_hora` datetime NOT NULL,
  `folio` int(11) NOT NULL,
  PRIMARY KEY (`clave`),
  KEY `resumen_compra_FK` (`c_producto`),
  CONSTRAINT `resumen_compra_FK` FOREIGN KEY (`c_producto`) REFERENCES `productos` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resumen_compra`
--

LOCK TABLES `resumen_compra` WRITE;
/*!40000 ALTER TABLE `resumen_compra` DISABLE KEYS */;
INSERT INTO `resumen_compra` VALUES (1,1,3,'2022-10-18 01:00:00',1),(2,5,10,'2022-10-18 01:00:00',1),(3,7,4,'2022-10-18 01:00:00',1),(4,2,2,'2022-10-18 03:45:00',2),(5,1,8,'2022-10-18 03:45:00',2),(6,4,7,'2022-10-18 03:45:00',2),(7,7,4,'2022-10-18 03:45:00',2),(8,1,1,'2022-10-18 08:30:00',3),(9,2,8,'2022-10-18 08:30:00',3),(10,3,3,'2022-10-18 08:30:00',3);
/*!40000 ALTER TABLE `resumen_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidad_medida`
--

DROP TABLE IF EXISTS `unidad_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidad_medida` (
  `clave` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `nombre_abreviado` varchar(10) NOT NULL,
  PRIMARY KEY (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad_medida`
--

LOCK TABLES `unidad_medida` WRITE;
/*!40000 ALTER TABLE `unidad_medida` DISABLE KEYS */;
INSERT INTO `unidad_medida` VALUES (1,'KILOGRAMOS','KG'),(2,'GRAMOS','G'),(3,'ONZAS','OZ'),(4,'LIBRA','LB'),(5,'LITRO','LT'),(6,'MILILITRO','ML');
/*!40000 ALTER TABLE `unidad_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `clave` int(11) NOT NULL AUTO_INCREMENT,
  `c_resumen_compra` int(11) NOT NULL,
  `total` double NOT NULL,
  `folio_resumen` int(11) NOT NULL,
  PRIMARY KEY (`clave`),
  KEY `ventas_FK` (`c_resumen_compra`),
  CONSTRAINT `ventas_FK` FOREIGN KEY (`c_resumen_compra`) REFERENCES `resumen_compra` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,1,89.7,1),(2,2,590,1),(3,3,17.9,1),(4,4,44,2),(5,5,239.2,2),(6,6,84,2),(7,7,17.9,2),(8,8,29.9,3),(9,9,104,3),(10,10,149.7,3);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'canasta_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-18 22:15:13
