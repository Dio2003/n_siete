/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.4.0 : Database - siete_bd
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `siete_bd`;

/*Table structure for table `asiento` */

DROP TABLE IF EXISTS `asiento`;

CREATE TABLE `asiento` (
  `id_asiento` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `documento` varchar(50) DEFAULT NULL,
  `origen` varchar(50) DEFAULT NULL,
  `deber` decimal(15,2) DEFAULT '0.00',
  `haber` decimal(15,2) DEFAULT '0.00',
  `concepto` varchar(100) DEFAULT NULL,
  `id_usuario` int NOT NULL,
  `id_empresa` int NOT NULL,
  `estado` enum('pendiente','procesado') NOT NULL DEFAULT 'pendiente',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_asiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `asiento` */

LOCK TABLES `asiento` WRITE;

UNLOCK TABLES;

/*Table structure for table `ciudad` */

DROP TABLE IF EXISTS `ciudad`;

CREATE TABLE `ciudad` (
  `id_ciudad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

/*Data for the table `ciudad` */

LOCK TABLES `ciudad` WRITE;

insert  into `ciudad`(`id_ciudad`,`nombre`,`createdAt`,`updatedAt`) values 
(1,'Concepcion','2025-05-01 08:51:40','2025-05-01 08:51:46');

UNLOCK TABLES;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(50) NOT NULL,
  `numero_identificacion` varchar(15) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `cuenta_local` varchar(50) DEFAULT NULL,
  `cuenta_extranjera` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `id_tipo_documento` int NOT NULL,
  `id_tipo_contribuyente` int NOT NULL,
  `id_ciudad` int NOT NULL,
  `id_empresa` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_documento` (`id_tipo_documento`),
  KEY `id_contribuyente` (`id_tipo_contribuyente`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`id_tipo_contribuyente`) REFERENCES `tipo_contribuyente` (`id_tipo_contribuyente`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `clientes_ibfk_3` FOREIGN KEY (`id_tipo_documento`) REFERENCES `tipo_documento` (`id_tipo_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `cliente` */

LOCK TABLES `cliente` WRITE;

insert  into `cliente`(`id_cliente`,`razon_social`,`numero_identificacion`,`direccion`,`telefono`,`correo`,`cuenta_local`,`cuenta_extranjera`,`estado`,`id_tipo_documento`,`id_tipo_contribuyente`,`id_ciudad`,`id_empresa`,`createdAt`,`updatedAt`) values 
(1,'Deolinda','2265730','avda. pinedo','09999372','deo@gmail.com','0102-0123-4567-8901','no posee',1,1,1,1,1,'2025-05-01 10:55:22','2025-05-01 10:55:26'),
(2,'Importadora El Sol','4089345','Ruta 2 Km 45','0972547891','contacto@elsol.com.py','0011-2233-4455-6677','N/A',1,1,3,1,6,'2025-05-01 10:55:29','2025-05-01 10:55:32');

UNLOCK TABLES;

/*Table structure for table `compra` */

DROP TABLE IF EXISTS `compra`;

CREATE TABLE `compra` (
  `id_compra` int unsigned NOT NULL AUTO_INCREMENT,
  `numero_factura` varbinary(15) NOT NULL,
  `numero_timbrado` int NOT NULL,
  `fecha` date NOT NULL,
  `total_factura` decimal(15,2) NOT NULL,
  `exenta` decimal(15,2) NOT NULL,
  `iva_10` decimal(15,2) NOT NULL,
  `iva_5` decimal(15,2) NOT NULL,
  `importe_iva_10` decimal(15,2) NOT NULL,
  `importe_iva_5` decimal(15,2) NOT NULL,
  `condicion` enum('CONTADO','CREDITO') NOT NULL,
  `id_sucursal` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`),
  CONSTRAINT `compra_ibfk_4` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `compra` */

LOCK TABLES `compra` WRITE;

UNLOCK TABLES;

/*Table structure for table `cuenta` */

DROP TABLE IF EXISTS `cuenta`;

CREATE TABLE `cuenta` (
  `id_cuenta` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `nombre_alternativo` varchar(50) DEFAULT NULL,
  `codigo` varchar(50) NOT NULL,
  `asentable` enum('Si','No') NOT NULL,
  `id_padre` int DEFAULT NULL,
  `nivel` int NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_cuenta`),
  UNIQUE KEY `unique_empresa_codigo` (`id_empresa`,`codigo`),
  KEY `id_padre` (`id_padre`),
  CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`id_padre`) REFERENCES `cuenta` (`id_cuenta`) ON DELETE SET NULL,
  CONSTRAINT `cuenta_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `cuenta` */

LOCK TABLES `cuenta` WRITE;

UNLOCK TABLES;

/*Table structure for table `empresa` */

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `ruc` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `id_periodo` int NOT NULL,
  `id_usuario` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `id_periodo` (`id_periodo`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `empresas_ibfk_1` FOREIGN KEY (`id_periodo`) REFERENCES `periodo` (`id_periodo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empresas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `empresa` */

LOCK TABLES `empresa` WRITE;

insert  into `empresa`(`id_empresa`,`nombre`,`ruc`,`sigla`,`estado`,`id_periodo`,`id_usuario`,`createdAt`,`updatedAt`) values 
(1,'DEMSA','80101442-5','S.A.',1,1,1,'2025-04-27 21:19:28','2025-04-27 21:19:30'),
(6,'Santa Cata','800081414-','S.A.',1,1,1,'2025-04-27 21:24:52','2025-04-27 21:24:54'),
(7,'San Jose','800024224','S.A.',1,1,1,'2025-05-08 10:49:04','2025-05-01 10:49:16'),
(8,'Alas S.A','800031114-0','S.A.',1,2,1,'2025-05-01 10:49:10','2025-05-01 10:49:21'),
(9,'AGROCENTER IMPORT. EXPORT. S.R.L.','80061877-7','S.R.L',1,2,1,'2025-05-01 10:49:25','2025-05-01 10:49:13');

UNLOCK TABLES;

/*Table structure for table `periodo` */

DROP TABLE IF EXISTS `periodo`;

CREATE TABLE `periodo` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `nombre_periodo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

/*Data for the table `periodo` */

LOCK TABLES `periodo` WRITE;

insert  into `periodo`(`id_periodo`,`nombre_periodo`,`createdAt`,`updatedAt`) values 
(1,'2025','2025-05-01','2025-05-01'),
(2,'2026','2025-05-01','2025-05-01');

UNLOCK TABLES;

/*Table structure for table `proveedor` */

DROP TABLE IF EXISTS `proveedor`;

CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(100) NOT NULL,
  `numero_identificacion` varchar(15) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `id_ciudad` int NOT NULL,
  `id_empresa` int NOT NULL,
  `id_tipo_contribuyente` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_contribuyente` (`id_tipo_contribuyente`),
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `proveedor_ibfk_2` FOREIGN KEY (`id_tipo_contribuyente`) REFERENCES `tipo_contribuyente` (`id_tipo_contribuyente`),
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `proveedor` */

LOCK TABLES `proveedor` WRITE;

insert  into `proveedor`(`id_proveedor`,`razon_social`,`numero_identificacion`,`direccion`,`telefono`,`correo`,`estado`,`id_ciudad`,`id_empresa`,`id_tipo_contribuyente`,`createdAt`,`updatedAt`) values 
(1,'Alas','89898988-1','avda. asu','09998712','alas@gmail.com',1,1,1,1,'2025-04-28 19:07:46','2025-04-28 19:07:49'),
(2,'Ypane','80029603-6','avda. pinedo','09999372','ypane@gmail.com',1,1,1,2,'2025-05-01 10:45:33','2025-05-01 10:45:20'),
(3,'heladeria','80029603-6','avda. pinedo','09999372','ypane@gmail.com',1,1,1,3,'2025-05-01 10:45:40','2025-05-01 10:45:23'),
(4,'Agrocenter Import Export S.R.L','80061877-7','AL COSTADO DE EX BATALLON KM 8 1/2 CASA N°3','0983122713','Agrocenter@hotmail.com',1,1,6,1,'2025-05-01 10:45:37','2025-05-01 10:45:26');

UNLOCK TABLES;

/*Table structure for table `rol` */

DROP TABLE IF EXISTS `rol`;

CREATE TABLE `rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

/*Data for the table `rol` */

LOCK TABLES `rol` WRITE;

insert  into `rol`(`id_rol`,`nombre_rol`,`createdAt`,`updatedAt`) values 
(1,'ADMINISTRADOR','2025-05-01','2025-05-01'),
(2,'PROFESOR','2025-05-01','2025-05-01'),
(3,'ALUMNO','2025-05-01','2025-05-01');

UNLOCK TABLES;

/*Table structure for table `sucursal` */

DROP TABLE IF EXISTS `sucursal`;

CREATE TABLE `sucursal` (
  `id_sucursal` int NOT NULL AUTO_INCREMENT,
  `codigo_sucursal` varchar(10) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `responsable` varchar(100) DEFAULT NULL,
  `id_empresa` int unsigned NOT NULL,
  `createdAt` date NOT NULL,
  `updatedat` date NOT NULL,
  PRIMARY KEY (`id_sucursal`),
  UNIQUE KEY `codigo_sucursal` (`codigo_sucursal`),
  KEY `sucursales_ibfk_1` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sucursal` */

LOCK TABLES `sucursal` WRITE;

UNLOCK TABLES;

/*Table structure for table `tipo_contribuyente` */

DROP TABLE IF EXISTS `tipo_contribuyente`;

CREATE TABLE `tipo_contribuyente` (
  `id_tipo_contribuyente` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_tipo_contribuyente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

/*Data for the table `tipo_contribuyente` */

LOCK TABLES `tipo_contribuyente` WRITE;

insert  into `tipo_contribuyente`(`id_tipo_contribuyente`,`descripcion`,`createdAt`,`updatedAt`) values 
(1,'FISICO','2025-05-01 10:38:25','2025-05-01 10:38:25'),
(2,'JURIDICO','2025-05-01 10:38:25','2025-05-01 10:38:25'),
(3,'NO CONTRIBUYENTE','2025-05-01 10:38:25','2025-05-01 10:38:25'),
(4,'PUBLICO','2025-05-01 10:38:25','2025-05-01 10:38:25');

UNLOCK TABLES;

/*Table structure for table `tipo_documento` */

DROP TABLE IF EXISTS `tipo_documento`;

CREATE TABLE `tipo_documento` (
  `id_tipo_documento` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  PRIMARY KEY (`id_tipo_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

/*Data for the table `tipo_documento` */

LOCK TABLES `tipo_documento` WRITE;

insert  into `tipo_documento`(`id_tipo_documento`,`descripcion`,`createdAt`,`updatedAt`) values 
(1,'R.U.C','2025-05-01','2025-05-01'),
(2,'C.I.','2025-05-01','2025-05-01'),
(3,'PASAPORTE','2025-05-01','2025-05-01'),
(4,'D.N.I','2025-05-01','2025-05-01'),
(5,'R.I.F','2025-05-01','2025-05-01'),
(6,'NO RESIDENTE','2025-05-01','2025-05-01');

UNLOCK TABLES;

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cedula` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `contra` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `id_rol` int NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `telefono` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

/*Data for the table `usuario` */

LOCK TABLES `usuario` WRITE;

insert  into `usuario`(`id_usuario`,`nombre`,`cedula`,`correo`,`contra`,`id_rol`,`estado`,`telefono`,`createdAt`,`updatedAt`) values 
(1,'RicardoDiana','707080','rick@gmail.com','$2a$10$gATMx.ws0fi1oDYE4pOB7OkGJBa4CeqGiMv.6LTBdwmZgeJ6Z4d82',1,1,'0985137452','2025-04-10','2025-04-14'),
(2,'admin','4124121','prueba14@gmail.com','$2a$10$gATMx.ws0fi1oDYE4pOB7OkGJBa4CeqGiMv.6LTBdwmZgeJ6Z4d82',1,1,'0985137452','2025-04-10','2025-04-14');

UNLOCK TABLES;

/*Table structure for table `venta` */

DROP TABLE IF EXISTS `venta`;

CREATE TABLE `venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(15) NOT NULL,
  `numero_timbrado` int NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `total_factura` decimal(15,2) NOT NULL,
  `exenta` decimal(15,2) NOT NULL,
  `iva_10` decimal(15,2) NOT NULL,
  `iva_5` decimal(15,2) NOT NULL,
  `importe_iva_10` decimal(15,2) NOT NULL,
  `importe_iva_5` decimal(15,2) NOT NULL,
  `condicion` enum('CREDITO','CONTADO') NOT NULL,
  `id_cliente` int NOT NULL,
  `id_sucursal` int NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  KEY `id_venta` (`id_venta`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_4` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `venta` */

LOCK TABLES `venta` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
