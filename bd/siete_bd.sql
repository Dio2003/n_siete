/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.7.3-MariaDB : Database - siete_bd
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`siete_bd` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;

USE `siete_bd`;

/*Table structure for table `agendar_pago_personal` */

DROP TABLE IF EXISTS `agendar_pago_personal`;

CREATE TABLE `agendar_pago_personal` (
  `idAgPP` int(10) unsigned NOT NULL,
  `fechaInicioPago` varchar(13) DEFAULT NULL,
  `fechaUltimoPago` varchar(13) DEFAULT NULL,
  `nuevaFechaPago` varchar(13) DEFAULT NULL,
  `monto` int(100) DEFAULT NULL,
  `pago` varchar(15) DEFAULT NULL COMMENT 'semanal, mensual, quincenal',
  `FechaAdelanto` varchar(13) DEFAULT NULL,
  `montoAdelanto` int(20) DEFAULT NULL,
  `idPersonal` int(10) unsigned NOT NULL,
  `motivo` varchar(20) DEFAULT NULL COMMENT 'Salario o Adelanto',
  PRIMARY KEY (`idAgPP`,`idPersonal`),
  KEY `idPersonal` (`idPersonal`),
  CONSTRAINT `agendar_pago_personal_ibfk_1` FOREIGN KEY (`idPersonal`) REFERENCES `personal` (`id_personal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `agendar_pago_personal` */

LOCK TABLES `agendar_pago_personal` WRITE;

insert  into `agendar_pago_personal`(`idAgPP`,`fechaInicioPago`,`fechaUltimoPago`,`nuevaFechaPago`,`monto`,`pago`,`FechaAdelanto`,`montoAdelanto`,`idPersonal`,`motivo`) values 
(0,'11-12-2023','10-12-2023','10-02-2024',0,'Mensual','10-12-2023',500000,0,'Adelanto'),
(3,'23-11-2023','','23-11-2023',20000013,'Mensual','',0,2,NULL),
(4,'03-08-2023','10-12-2023','03-10-2023',0,'Mensual','10-12-2023',200000,1,'Adelanto');

UNLOCK TABLES;

/*Table structure for table `agendarcobrocliente` */

DROP TABLE IF EXISTS `agendarcobrocliente`;

CREATE TABLE `agendarcobrocliente` (
  `idAgCobro` int(10) unsigned NOT NULL,
  `fechaInicioPago` varchar(10) DEFAULT NULL,
  `fechaUltimoPago` varchar(10) DEFAULT NULL,
  `nuevaFechaPago` varchar(10) DEFAULT NULL,
  `montoFactura` int(100) DEFAULT NULL,
  `idCliente` int(10) unsigned NOT NULL,
  `idVenta` int(10) unsigned NOT NULL,
  `idCuota` int(10) unsigned NOT NULL,
  `tipoPago` varchar(13) DEFAULT NULL,
  `pago` varchar(13) DEFAULT NULL,
  `CuotaRestante` int(10) DEFAULT NULL,
  `totalRestante` int(100) DEFAULT NULL,
  PRIMARY KEY (`idAgCobro`,`idCliente`,`idVenta`),
  KEY `idCuota` (`idCuota`),
  KEY `idVenta` (`idVenta`),
  KEY `idCliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `agendarcobrocliente` */

LOCK TABLES `agendarcobrocliente` WRITE;

insert  into `agendarcobrocliente`(`idAgCobro`,`fechaInicioPago`,`fechaUltimoPago`,`nuevaFechaPago`,`montoFactura`,`idCliente`,`idVenta`,`idCuota`,`tipoPago`,`pago`,`CuotaRestante`,`totalRestante`) values 
(0,NULL,NULL,NULL,NULL,2,24,0,NULL,NULL,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `ajuste` */

DROP TABLE IF EXISTS `ajuste`;

CREATE TABLE `ajuste` (
  `idAjuste` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ajuste` char(10) DEFAULT NULL,
  PRIMARY KEY (`idAjuste`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `ajuste` */

LOCK TABLES `ajuste` WRITE;

insert  into `ajuste`(`idAjuste`,`ajuste`) values 
(1,'Positivo'),
(2,'Negativo');

UNLOCK TABLES;

/*Table structure for table `apertura_caja` */

DROP TABLE IF EXISTS `apertura_caja`;

CREATE TABLE `apertura_caja` (
  `id_caja` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` varchar(13) NOT NULL,
  `monto` int(100) NOT NULL,
  `turno` varchar(10) NOT NULL,
  `hora` varchar(13) NOT NULL,
  PRIMARY KEY (`id_caja`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `apertura_caja` */

LOCK TABLES `apertura_caja` WRITE;

insert  into `apertura_caja`(`id_caja`,`fecha`,`monto`,`turno`,`hora`) values 
(1,'12-11-2023',5000,'Mañana','09:00:03');

UNLOCK TABLES;

/*Table structure for table `articulos` */

DROP TABLE IF EXISTS `articulos`;

CREATE TABLE `articulos` (
  `id_articulo` int(100) unsigned NOT NULL AUTO_INCREMENT,
  `cod_articulo` int(100) unsigned DEFAULT NULL,
  `codigo_interno` int(100) DEFAULT NULL,
  `descripcion` varchar(25) DEFAULT NULL,
  `preciocosto` decimal(10,0) DEFAULT NULL,
  `precioventa` decimal(10,0) DEFAULT NULL,
  `stock` int(100) DEFAULT NULL,
  `iva` smallint(5) unsigned DEFAULT NULL,
  `cod_marca` smallint(10) unsigned DEFAULT NULL,
  `cod_categoria` smallint(10) unsigned DEFAULT NULL,
  `cod_familia` smallint(10) unsigned DEFAULT NULL,
  `id_proveedor` int(30) unsigned DEFAULT NULL,
  `id_pais` smallint(10) unsigned DEFAULT NULL,
  `observacion` varchar(50) DEFAULT NULL,
  `ruta_imagen` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_articulo`),
  KEY `iva` (`iva`),
  KEY `cod_categoria` (`cod_categoria`),
  KEY `cod_familia` (`cod_familia`),
  KEY `cod_marca` (`cod_marca`),
  KEY `id_pais` (`id_pais`),
  KEY `id_proveedor` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `articulos` */

LOCK TABLES `articulos` WRITE;

insert  into `articulos`(`id_articulo`,`cod_articulo`,`codigo_interno`,`descripcion`,`preciocosto`,`precioventa`,`stock`,`iva`,`cod_marca`,`cod_categoria`,`cod_familia`,`id_proveedor`,`id_pais`,`observacion`,`ruta_imagen`) values 
(1,1,2,'Celular',2000,2600,90,2,2,1,2,1,1,'',''),
(3,3,3,'Mouse',25000,32500,85,2,2,1,3,1,1,'',''),
(4,4,4,'Teclado',25000,32500,23,1,2,1,3,1,1,'se compró para juan','');

UNLOCK TABLES;

/*Table structure for table `asientos` */

DROP TABLE IF EXISTS `asientos`;

CREATE TABLE `asientos` (
  `id_asiento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `documento` varchar(50) DEFAULT NULL,
  `origen` varchar(50) DEFAULT NULL,
  `deber` decimal(15,2) DEFAULT 0.00,
  `haber` decimal(15,2) DEFAULT 0.00,
  `concepto` varchar(100) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `estado` enum('pendiente','procesado') NOT NULL DEFAULT 'pendiente',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_asiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `asientos` */

LOCK TABLES `asientos` WRITE;

UNLOCK TABLES;

/*Table structure for table `asignar_pago_proveedor` */

DROP TABLE IF EXISTS `asignar_pago_proveedor`;

CREATE TABLE `asignar_pago_proveedor` (
  `id_AsiPago` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fechaInicioPago` varchar(10) DEFAULT NULL,
  `fechaUltimoPago` varchar(10) DEFAULT NULL COMMENT 'Esta fecha irá modificandose',
  `nuevaFechaPago` varchar(10) DEFAULT NULL COMMENT 'Se calculará a partir de la ultima fecha de pago',
  `montoFactura` int(100) DEFAULT NULL COMMENT 'Este monto ira actualizandose en cada pago de cuota',
  `idproveedor` int(10) unsigned NOT NULL,
  `idcompra` int(10) unsigned NOT NULL,
  `id_cuota` int(10) unsigned DEFAULT NULL,
  `tipoPago` varchar(13) DEFAULT NULL COMMENT 'contado o credito',
  `pago` varchar(13) DEFAULT NULL COMMENT 'mensual, semanal,etc',
  `CuotaRestante` int(10) DEFAULT NULL,
  `totalRestante` int(100) DEFAULT NULL,
  PRIMARY KEY (`id_AsiPago`,`idcompra`,`idproveedor`),
  KEY `idcompra` (`idcompra`),
  KEY `idproveedor` (`idproveedor`),
  KEY `id_cuota` (`id_cuota`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `asignar_pago_proveedor` */

LOCK TABLES `asignar_pago_proveedor` WRITE;

insert  into `asignar_pago_proveedor`(`id_AsiPago`,`fechaInicioPago`,`fechaUltimoPago`,`nuevaFechaPago`,`montoFactura`,`idproveedor`,`idcompra`,`id_cuota`,`tipoPago`,`pago`,`CuotaRestante`,`totalRestante`) values 
(11,'14-1-2024','14-01-2024','14-01-2024',75000,2,49,15,'Credito','Mensual',1,37500),
(12,'23-12-2023','','23-12-2023',25000,2,46,0,'Contado','',0,0),
(13,'10-12-2023','','10-12-2023',75000,1,47,0,'Contado','',0,0),
(14,'17-12-2023','','17-12-2023',2380,2,43,0,'Contado','',0,0);

UNLOCK TABLES;

/*Table structure for table `bancos` */

DROP TABLE IF EXISTS `bancos`;

CREATE TABLE `bancos` (
  `id_banco` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `banco` char(25) DEFAULT NULL,
  `nro_cuenta` char(25) DEFAULT NULL,
  `direccion` char(50) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `correo` char(50) DEFAULT NULL,
  `idciudad` smallint(5) unsigned NOT NULL,
  `idpais` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_banco`,`idciudad`,`idpais`),
  KEY `idciudad` (`idciudad`),
  KEY `idpais` (`idpais`),
  CONSTRAINT `bancos_ibfk_1` FOREIGN KEY (`idciudad`) REFERENCES `ciudad` (`cod_ciudad`),
  CONSTRAINT `bancos_ibfk_2` FOREIGN KEY (`idpais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `bancos` */

LOCK TABLES `bancos` WRITE;

insert  into `bancos`(`id_banco`,`banco`,`nro_cuenta`,`direccion`,`telefono`,`correo`,`idciudad`,`idpais`) values 
(1,'UENO','619113512','Pte. Franco','0991775246','ueno@gmail.com',1,1);

UNLOCK TABLES;

/*Table structure for table `bancos_cheque` */

DROP TABLE IF EXISTS `bancos_cheque`;

CREATE TABLE `bancos_cheque` (
  `id_BancCheq` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `id_bancos` smallint(6) unsigned NOT NULL,
  `idCheque` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_BancCheq`,`id_bancos`,`idCheque`),
  KEY `codBancos` (`id_bancos`),
  KEY `idCheque` (`idCheque`),
  CONSTRAINT `bancos_cheque_ibfk_1` FOREIGN KEY (`idCheque`) REFERENCES `cheques` (`id_cheque`),
  CONSTRAINT `codBancos` FOREIGN KEY (`id_bancos`) REFERENCES `bancos` (`id_banco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `bancos_cheque` */

LOCK TABLES `bancos_cheque` WRITE;

UNLOCK TABLES;

/*Table structure for table `cargos` */

DROP TABLE IF EXISTS `cargos`;

CREATE TABLE `cargos` (
  `id_cargos` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `cargos` varchar(50) NOT NULL,
  PRIMARY KEY (`id_cargos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cargos` */

LOCK TABLES `cargos` WRITE;

UNLOCK TABLES;

/*Table structure for table `categorias` */

DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `cod_categoria` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `categorias` */

LOCK TABLES `categorias` WRITE;

insert  into `categorias`(`cod_categoria`,`categoria`) values 
(1,'Electrónica');

UNLOCK TABLES;

/*Table structure for table `cheques` */

DROP TABLE IF EXISTS `cheques`;

CREATE TABLE `cheques` (
  `id_cheque` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_emision` varchar(13) DEFAULT NULL,
  `fecha_cobro` varchar(13) DEFAULT NULL,
  `pagar_a` char(50) DEFAULT NULL,
  `concepto_pago` char(50) DEFAULT NULL,
  `monto` int(11) DEFAULT NULL,
  `tipoCheque` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_cheque`,`tipoCheque`),
  KEY `tipoCheque` (`tipoCheque`),
  CONSTRAINT `cheques_ibfk_1` FOREIGN KEY (`tipoCheque`) REFERENCES `tipo_cheque` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `cheques` */

LOCK TABLES `cheques` WRITE;

insert  into `cheques`(`id_cheque`,`fecha_emision`,`fecha_cobro`,`pagar_a`,`concepto_pago`,`monto`,`tipoCheque`) values 
(1,'10-12-2023','15-01-2024','Humberto Rojas','pagos de salario',1500000,1),
(2,'10-12-2023','10-01-2024','Alas S.R.L','pagos',150000,2),
(3,'12-12-2023','12-01-2024','Estelvina','pago de salario',2000000,2);

UNLOCK TABLES;

/*Table structure for table `cierre_de_caja` */

DROP TABLE IF EXISTS `cierre_de_caja`;

CREATE TABLE `cierre_de_caja` (
  `id_cierre` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` varchar(13) DEFAULT NULL,
  `monto` int(100) DEFAULT NULL,
  `hora` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id_cierre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `cierre_de_caja` */

LOCK TABLES `cierre_de_caja` WRITE;

insert  into `cierre_de_caja`(`id_cierre`,`fecha`,`monto`,`hora`) values 
(1,'10-12-2023',2000,'12:00:20'),
(2,'10-12-2023',400000,'11:45:52');

UNLOCK TABLES;

/*Table structure for table `ciudad` */

DROP TABLE IF EXISTS `ciudad`;

CREATE TABLE `ciudad` (
  `cod_ciudad` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `ciudad` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `ciudad` */

LOCK TABLES `ciudad` WRITE;

insert  into `ciudad`(`cod_ciudad`,`ciudad`) values 
(1,'Concepción');

UNLOCK TABLES;

/*Table structure for table `ciudades` */

DROP TABLE IF EXISTS `ciudades`;

CREATE TABLE `ciudades` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `departamento` enum('Concepción','San Pedro','Cordillera','Guairá','Caaguazú','Caazapá','Itapúa','Misiones','Paraguarí','Alto Paraná','Central','Ñeembucú','Amambay','Canindeyú','Presidente Hayes','Boquerón','Alto Paraguay') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_ciudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `ciudades` */

LOCK TABLES `ciudades` WRITE;

UNLOCK TABLES;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(50) DEFAULT NULL,
  `numero_identificacion` varchar(20) DEFAULT NULL,
  `tipo_documento` enum('RUC','C.I.') DEFAULT NULL,
  `tipo_contribuyente` enum('Físico','Jurídico') DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `cuenta_local` varchar(50) DEFAULT NULL,
  `cuenta_extrangera` varchar(50) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `clientes` */

LOCK TABLES `clientes` WRITE;

UNLOCK TABLES;

/*Table structure for table `cobrocliente` */

DROP TABLE IF EXISTS `cobrocliente`;

CREATE TABLE `cobrocliente` (
  `idCobro` int(10) unsigned NOT NULL,
  `nroComprobante` varchar(50) DEFAULT NULL,
  `cliente` varchar(50) DEFAULT NULL,
  `fechaPago` varchar(10) DEFAULT NULL,
  `cuotasAPagar` int(11) DEFAULT NULL,
  `cuotasPagadas` int(10) DEFAULT NULL,
  `cuotasRestantes` int(11) DEFAULT NULL,
  `totalFactura` int(11) DEFAULT NULL,
  `totalRestante` int(11) DEFAULT NULL,
  `monto` int(100) DEFAULT NULL,
  `idAgCobro` int(10) unsigned NOT NULL,
  `tipoPago` varchar(30) DEFAULT NULL,
  `obs` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idCobro`,`idAgCobro`),
  KEY `idAgCobro` (`idAgCobro`),
  CONSTRAINT `cobrocliente_ibfk_1` FOREIGN KEY (`idAgCobro`) REFERENCES `agendarcobrocliente` (`idAgCobro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cobrocliente` */

LOCK TABLES `cobrocliente` WRITE;

insert  into `cobrocliente`(`idCobro`,`nroComprobante`,`cliente`,`fechaPago`,`cuotasAPagar`,`cuotasPagadas`,`cuotasRestantes`,`totalFactura`,`totalRestante`,`monto`,`idAgCobro`,`tipoPago`,`obs`) values 
(0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `compra2` */

DROP TABLE IF EXISTS `compra2`;

CREATE TABLE `compra2` (
  `id_compras` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_condicionComp` smallint(5) unsigned NOT NULL,
  `id_proveedor` int(11) unsigned NOT NULL,
  `nro_factura` varchar(50) DEFAULT NULL,
  `fechaeEmision` varchar(20) DEFAULT NULL,
  `fechaPago` varchar(20) DEFAULT NULL,
  `timbrado` varchar(20) DEFAULT NULL,
  `valiTimbrado` varchar(20) DEFAULT NULL,
  `totalFactura` double DEFAULT NULL,
  `subtotal` double(10,0) DEFAULT NULL,
  `totalIva` double DEFAULT NULL,
  `estado` int(1) DEFAULT NULL,
  `notaModificar` varchar(200) DEFAULT NULL,
  `notaAnular` varchar(200) DEFAULT NULL,
  `codAnulado` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_compras`,`id_condicionComp`,`id_proveedor`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_condicionComp` (`id_condicionComp`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

/*Data for the table `compra2` */

LOCK TABLES `compra2` WRITE;

insert  into `compra2`(`id_compras`,`id_condicionComp`,`id_proveedor`,`nro_factura`,`fechaeEmision`,`fechaPago`,`timbrado`,`valiTimbrado`,`totalFactura`,`subtotal`,`totalIva`,`estado`,`notaModificar`,`notaAnular`,`codAnulado`) values 
(1,1,2,'0000001','11-12-2023','12-12-2023','2123','12-12-2023',50000,50000,2380,1,'','',0),
(40,1,2,'001','24-12-2023','16-12-2023','4534','08-12-2023',100000,100000,4761,1,'','',0),
(41,1,2,'00000041','28-12-2023','23-12-2023','T00001','08-12-2023',75000,75000,3571,1,'','',1),
(42,1,2,'00100500','12-12-2023','23-12-2023','003003003','12-12-2024',50000,50000,2380,1,'','',1),
(43,1,2,'12345','16-12-2023','17-12-2023','23123','08-12-2023',2380,2380,2380,1,'','anulada',1),
(44,1,1,'1111','10-12-2023','','2312','16-12-2023',25000,25000,1190,1,'','',0),
(45,1,2,'2312','31-12-2023','','3232','22-12-2023',50000,50000,2380,1,'','',0),
(46,1,2,'231232','10-12-2023','23-12-2023','231','09-12-2023',25000,25000,1190,1,'','',0),
(47,1,1,'55555','17-12-2023','10-12-2023','3434','14-12-2023',75000,75000,3571,1,'','',0),
(48,2,2,'324','17-12-2023','16-12-2023','343','17-12-2023',75000,75000,3571,1,'','',0),
(49,2,2,'00100923','14-12-2023','14-01-2024','160001','14-12-2024',75000,75000,3571,1,'','',0);

UNLOCK TABLES;

/*Table structure for table `compras` */

DROP TABLE IF EXISTS `compras`;

CREATE TABLE `compras` (
  `id_compra` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_tipodocumento` int(11) DEFAULT NULL,
  `numero_factura` varbinary(15) DEFAULT NULL,
  `numero_timbrado` int(11) DEFAULT NULL,
  `condicion` enum('contado','credito') CHARACTER SET utf8mb3 DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `total_factura` decimal(15,2) DEFAULT NULL,
  `exenta` decimal(15,2) DEFAULT NULL,
  `iva_10` decimal(15,2) DEFAULT NULL,
  `iva_5` decimal(15,2) DEFAULT NULL,
  `importe_iva_10` decimal(15,2) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `id_tipodocumento` (`id_tipodocumento`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_tipodocumento`) REFERENCES `tipos_documentos` (`id_tipodocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `compras` */

LOCK TABLES `compras` WRITE;

UNLOCK TABLES;

/*Table structure for table `comprobante` */

DROP TABLE IF EXISTS `comprobante`;

CREATE TABLE `comprobante` (
  `id_comprobante` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `comprobante` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_comprobante`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `comprobante` */

LOCK TABLES `comprobante` WRITE;

insert  into `comprobante`(`id_comprobante`,`comprobante`) values 
(1,'Factura Legal'),
(2,'Nota de Venta'),
(3,'Nota de Presupuesto');

UNLOCK TABLES;

/*Table structure for table `condicionfacturas` */

DROP TABLE IF EXISTS `condicionfacturas`;

CREATE TABLE `condicionfacturas` (
  `id_condicion` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `condicion` char(30) DEFAULT NULL,
  PRIMARY KEY (`id_condicion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `condicionfacturas` */

LOCK TABLES `condicionfacturas` WRITE;

insert  into `condicionfacturas`(`id_condicion`,`condicion`) values 
(1,'Contado'),
(2,'Credito');

UNLOCK TABLES;

/*Table structure for table `cuentas` */

DROP TABLE IF EXISTS `cuentas`;

CREATE TABLE `cuentas` (
  `id_cuenta` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `nombre_alternativo` varchar(50) DEFAULT NULL,
  `codigo` int(11) NOT NULL,
  `asentable` enum('Si','No') NOT NULL,
  `moneda` varchar(20) DEFAULT NULL,
  `rubro` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `id_padre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_cuenta`),
  KEY `id_padre` (`id_padre`),
  CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`id_padre`) REFERENCES `cuentas` (`id_cuenta`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `cuentas` */

LOCK TABLES `cuentas` WRITE;

UNLOCK TABLES;

/*Table structure for table `cuotas` */

DROP TABLE IF EXISTS `cuotas`;

CREATE TABLE `cuotas` (
  `id_cuota` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cantidadCuotas` int(11) DEFAULT NULL,
  `fechaCuota` varchar(13) DEFAULT NULL,
  `montoCuota` double DEFAULT NULL,
  `montoEntrega` double DEFAULT NULL,
  `id_proveedor` int(10) unsigned NOT NULL,
  `id_compra` int(10) unsigned NOT NULL,
  `divisionMeses` varchar(10) DEFAULT NULL,
  `cantidadMeses` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_cuota`,`id_proveedor`,`id_compra`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_compra` (`id_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `cuotas` */

LOCK TABLES `cuotas` WRITE;

insert  into `cuotas`(`id_cuota`,`cantidadCuotas`,`fechaCuota`,`montoCuota`,`montoEntrega`,`id_proveedor`,`id_compra`,`divisionMeses`,`cantidadMeses`) values 
(0,NULL,NULL,NULL,NULL,1,1,NULL,NULL),
(14,4,'14-12-2023',2000,NULL,1,1,'Semanal',1),
(15,2,'14-1-2024',37500,0,2,49,'Mensual',2);

UNLOCK TABLES;

/*Table structure for table `cuotascliente` */

DROP TABLE IF EXISTS `cuotascliente`;

CREATE TABLE `cuotascliente` (
  `idCuotaCliente` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cantidadCuota` int(11) DEFAULT NULL,
  `fechaCuota` varchar(13) DEFAULT NULL,
  `montocuota` double DEFAULT NULL,
  `montoEntrega` double DEFAULT NULL,
  `idCliente` int(10) unsigned NOT NULL,
  `idVenta` int(10) unsigned NOT NULL,
  `divisionMeses` varchar(10) DEFAULT NULL,
  `cantidadMeses` int(10) DEFAULT NULL,
  PRIMARY KEY (`idCuotaCliente`,`idCliente`,`idVenta`),
  KEY `idCliente` (`idCliente`),
  KEY `idVenta` (`idVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `cuotascliente` */

LOCK TABLES `cuotascliente` WRITE;

insert  into `cuotascliente`(`idCuotaCliente`,`cantidadCuota`,`fechaCuota`,`montocuota`,`montoEntrega`,`idCliente`,`idVenta`,`divisionMeses`,`cantidadMeses`) values 
(0,NULL,NULL,NULL,NULL,2,24,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `detalle_asiento` */

DROP TABLE IF EXISTS `detalle_asiento`;

CREATE TABLE `detalle_asiento` (
  `id_detalle` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_asiento` int(10) unsigned NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  `monto` decimal(15,2) NOT NULL,
  `tipo_movimiento` enum('D','C') NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_asiento` (`id_asiento`),
  KEY `id_cuenta` (`id_cuenta`),
  CONSTRAINT `detalle_asiento_ibfk_1` FOREIGN KEY (`id_asiento`) REFERENCES `asientos` (`id_asiento`) ON DELETE CASCADE,
  CONSTRAINT `detalle_asiento_ibfk_2` FOREIGN KEY (`id_cuenta`) REFERENCES `cuentas` (`id_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `detalle_asiento` */

LOCK TABLES `detalle_asiento` WRITE;

UNLOCK TABLES;

/*Table structure for table `detallecompras2` */

DROP TABLE IF EXISTS `detallecompras2`;

CREATE TABLE `detallecompras2` (
  `id_detalle` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_compra` int(11) unsigned NOT NULL,
  `id_articulo` int(11) unsigned NOT NULL,
  `nro_factura` varchar(50) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `preciocosto` double(10,0) DEFAULT NULL,
  `total` double(10,0) DEFAULT NULL,
  `iva10` double(10,0) DEFAULT NULL,
  `iva5` double(10,0) DEFAULT NULL,
  `codAnulado` int(1) DEFAULT NULL,
  `estado` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`,`id_compra`,`id_articulo`),
  KEY `id_compra` (`id_compra`),
  KEY `id_articulo` (`id_articulo`),
  CONSTRAINT `detallecompras2_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra2` (`id_compras`),
  CONSTRAINT `detallecompras2_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

/*Data for the table `detallecompras2` */

LOCK TABLES `detallecompras2` WRITE;

insert  into `detallecompras2`(`id_detalle`,`id_compra`,`id_articulo`,`nro_factura`,`cantidad`,`preciocosto`,`total`,`iva10`,`iva5`,`codAnulado`,`estado`) values 
(1,1,4,'0000001',2,NULL,NULL,NULL,NULL,NULL,NULL),
(47,40,3,'1',4,25000,100000,0,4762,0,1),
(48,41,3,'00000041',3,25000,75000,0,3571,1,1),
(49,42,3,'00100500',2,25000,50000,0,2381,1,1),
(50,43,4,'12345',2,25000,50000,0,2381,1,1),
(51,44,4,'1111',1,25000,25000,0,1190,0,1),
(52,45,4,'2312',2,25000,50000,0,2380,0,1),
(53,46,4,'231232',1,25000,25000,0,1190,0,1),
(54,47,4,'55555',3,25000,75000,0,3571,0,1),
(55,48,4,'324',3,25000,75000,0,3571,0,1),
(56,49,4,'00100923',3,25000,75000,0,3571,0,1);

UNLOCK TABLES;

/*Table structure for table `detalleventas2` */

DROP TABLE IF EXISTS `detalleventas2`;

CREATE TABLE `detalleventas2` (
  `id_detalle` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_venta` int(11) unsigned NOT NULL,
  `id_articulos` int(11) unsigned NOT NULL,
  `nro_comprobante` varchar(50) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioVenta` double(10,0) DEFAULT NULL,
  `total` double(10,0) DEFAULT NULL,
  `iva10` double(10,0) DEFAULT NULL,
  `iva5` double(10,0) DEFAULT NULL,
  `codAulado` int(1) DEFAULT NULL,
  `estado` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`,`id_venta`,`id_articulos`),
  KEY `id_venta` (`id_venta`),
  KEY `id_articulos` (`id_articulos`),
  CONSTRAINT `detalleventas2_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas2` (`id_ventas`),
  CONSTRAINT `detalleventas2_ibfk_2` FOREIGN KEY (`id_articulos`) REFERENCES `articulos` (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `detalleventas2` */

LOCK TABLES `detalleventas2` WRITE;

insert  into `detalleventas2`(`id_detalle`,`id_venta`,`id_articulos`,`nro_comprobante`,`cantidad`,`precioVenta`,`total`,`iva10`,`iva5`,`codAulado`,`estado`) values 
(25,24,4,'000001',2,32500,65000,0,3095,0,1),
(26,25,4,'0010025',3,32500,97500,0,4642,0,0),
(27,26,3,'0010026',2,32500,65000,0,3095,0,1),
(28,26,4,'0010026',1,32500,2600,0,1547,0,1),
(29,27,1,'0010027',1,2600,2600,236,0,0,1),
(30,27,1,'0010027',31,2600,80600,7327,0,0,1);

UNLOCK TABLES;

/*Table structure for table `devoluciones` */

DROP TABLE IF EXISTS `devoluciones`;

CREATE TABLE `devoluciones` (
  `idDevoluciones` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` varchar(13) DEFAULT NULL,
  `condicion` varchar(20) DEFAULT NULL,
  `codArtAntigio` varchar(20) DEFAULT NULL,
  `articuloAntiguo` varchar(20) DEFAULT NULL,
  `codArtNuevo` varchar(20) DEFAULT NULL,
  `articuloNuevo` varchar(20) DEFAULT NULL,
  `totalFacturaAnterior` varchar(20) DEFAULT NULL,
  `nuevoTotalFactura` varchar(20) DEFAULT NULL,
  `diferencia` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idDevoluciones`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `devoluciones` */

LOCK TABLES `devoluciones` WRITE;

insert  into `devoluciones`(`idDevoluciones`,`fecha`,`condicion`,`codArtAntigio`,`articuloAntiguo`,`codArtNuevo`,`articuloNuevo`,`totalFacturaAnterior`,`nuevoTotalFactura`,`diferencia`) values 
(1,'13-12-2023','Cambio Directo',NULL,'Teclado',NULL,'Teclado','6000000','5000000','1000000'),
(2,'13-12-2023','Cambio Directo','1','Celular','1','Celular','172900','170300','2600'),
(3,'13-12-2023','Cambio Directo','1','Celular','1','Celular','170300','165100','5200'),
(4,'13-12-2023','Cambio Directo','4','Teclado','1','Celular','165100','5200','159900'),
(5,'13-12-2023','Cambio Directo','4','Teclado','1','Celular','5200','13000','-7800'),
(6,'13-12-2023','Cambio Directo','4','Teclado','1','Celular','13000','28600','-15600'),
(7,'13-12-2023','Cambio Directo','4','Teclado','1','Celular','28600','54600','-26000'),
(8,'13-12-2023','Cambio Directo','1','Celular','1','Celular','54600','67600','-13000'),
(9,'13-12-2023','Cambio Directo','1','Celular','3','Mouse','67600','977600','-910000'),
(10,'13-12-2023','Cambio Directo','3','Mouse','1','Celular','977600','83200','894400');

UNLOCK TABLES;

/*Table structure for table `egresos` */

DROP TABLE IF EXISTS `egresos`;

CREATE TABLE `egresos` (
  `id_egresos` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` varchar(13) NOT NULL,
  `monto` int(100) NOT NULL,
  `observacion` varchar(50) DEFAULT NULL,
  `tipoEgreso` varchar(30) DEFAULT NULL,
  `tipoImporte` varchar(30) DEFAULT NULL,
  `codAnulado` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_egresos`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `egresos` */

LOCK TABLES `egresos` WRITE;

insert  into `egresos`(`id_egresos`,`fecha`,`monto`,`observacion`,`tipoEgreso`,`tipoImporte`,`codAnulado`) values 
(1,'12-11-2023',2000,'pago','CAJA','EFECTIVO',0);

UNLOCK TABLES;

/*Table structure for table `empresas` */

DROP TABLE IF EXISTS `empresas`;

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL AUTO_INCREMENT,
  `empresa` varchar(100) NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `id_periodo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` date DEFAULT NULL,
  `updatedAt` date DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `id_periodo` (`id_periodo`),
  CONSTRAINT `empresas_ibfk_1` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `empresas` */

LOCK TABLES `empresas` WRITE;

insert  into `empresas`(`id_empresa`,`empresa`,`sigla`,`id_periodo`,`estado`,`createdAt`,`updatedAt`) values 
(5,'TechNova','S.A.',1,1,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `estado` */

DROP TABLE IF EXISTS `estado`;

CREATE TABLE `estado` (
  `codestado` smallint(5) NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codestado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `estado` */

LOCK TABLES `estado` WRITE;

insert  into `estado`(`codestado`,`estado`) values 
(1,'Activo'),
(2,'Inactivo');

UNLOCK TABLES;

/*Table structure for table `familias` */

DROP TABLE IF EXISTS `familias`;

CREATE TABLE `familias` (
  `cod_familia` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `familia` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_familia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `familias` */

LOCK TABLES `familias` WRITE;

insert  into `familias`(`cod_familia`,`familia`) values 
(1,'Televisores'),
(2,'Teléfonos inteligentes'),
(3,'elemento electronico');

UNLOCK TABLES;

/*Table structure for table `ingresos` */

DROP TABLE IF EXISTS `ingresos`;

CREATE TABLE `ingresos` (
  `id_ingresos` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `monto` double NOT NULL,
  `fecha` date DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_ingresos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ingresos` */

LOCK TABLES `ingresos` WRITE;

UNLOCK TABLES;

/*Table structure for table `iva` */

DROP TABLE IF EXISTS `iva`;

CREATE TABLE `iva` (
  `id_iva` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `iva` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_iva`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `iva` */

LOCK TABLES `iva` WRITE;

insert  into `iva`(`id_iva`,`iva`) values 
(1,'5'),
(2,'10');

UNLOCK TABLES;

/*Table structure for table `marcas` */

DROP TABLE IF EXISTS `marcas`;

CREATE TABLE `marcas` (
  `cod_marca` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `marca` varchar(100) NOT NULL,
  PRIMARY KEY (`cod_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `marcas` */

LOCK TABLES `marcas` WRITE;

insert  into `marcas`(`cod_marca`,`marca`) values 
(1,'Samsung'),
(2,'Apple'),
(3,'Acer');

UNLOCK TABLES;

/*Table structure for table `nacionalidad` */

DROP TABLE IF EXISTS `nacionalidad`;

CREATE TABLE `nacionalidad` (
  `cod_nacionalidad` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `nacionalidad` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_nacionalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `nacionalidad` */

LOCK TABLES `nacionalidad` WRITE;

insert  into `nacionalidad`(`cod_nacionalidad`,`nacionalidad`) values 
(1,'Paraguaya');

UNLOCK TABLES;

/*Table structure for table `nivelusuario` */

DROP TABLE IF EXISTS `nivelusuario`;

CREATE TABLE `nivelusuario` (
  `cod_nivel` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `nivel` varchar(50) NOT NULL,
  `salario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `nivelusuario` */

LOCK TABLES `nivelusuario` WRITE;

insert  into `nivelusuario`(`cod_nivel`,`nivel`,`salario`) values 
(1,'Administrativo','5000000'),
(2,'Aux. Contable','4000000'),
(3,' Informática','3500000'),
(4,'Ventas','2500000'),
(5,'Ventas/Stock','2500000');

UNLOCK TABLES;

/*Table structure for table `pago_funcionarios` */

DROP TABLE IF EXISTS `pago_funcionarios`;

CREATE TABLE `pago_funcionarios` (
  `id_pagofun` smallint(100) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_pago` varchar(13) DEFAULT NULL,
  `monto` int(10) NOT NULL,
  `idAgPP` int(10) unsigned NOT NULL,
  `motivo` varchar(20) DEFAULT NULL COMMENT 'Adelanto o Salario',
  `tipoPago` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_pagofun`,`idAgPP`),
  KEY `idAgPP` (`idAgPP`),
  CONSTRAINT `pago_funcionarios_ibfk_1` FOREIGN KEY (`idAgPP`) REFERENCES `agendar_pago_personal` (`idAgPP`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pago_funcionarios` */

LOCK TABLES `pago_funcionarios` WRITE;

insert  into `pago_funcionarios`(`id_pagofun`,`fecha_pago`,`monto`,`idAgPP`,`motivo`,`tipoPago`) values 
(0,NULL,200,0,NULL,NULL),
(1,'10-12-2023',200000,4,'Adelanto','EFECTIVO'),
(2,'11-01-2024',5000000,0,'Salario','EFECTIVO'),
(3,'10-12-2023',500000,0,'Adelanto','EFECTIVO'),
(4,'10-11-2023',10000,0,'Salario','EFECTIVO');

UNLOCK TABLES;

/*Table structure for table `pago_proveedor` */

DROP TABLE IF EXISTS `pago_proveedor`;

CREATE TABLE `pago_proveedor` (
  `id_pago` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nro_factura` varchar(15) DEFAULT NULL,
  `proveedor` varchar(50) DEFAULT NULL,
  `fechaPago` varchar(10) DEFAULT NULL,
  `cuotasApagar` int(11) DEFAULT NULL COMMENT 'las cuotas que faltan',
  `cuotasPagadas` int(10) DEFAULT NULL COMMENT 'la cantidad de cuotas que se pago',
  `CuotasRestantes` int(10) DEFAULT NULL,
  `totalFactura` int(11) DEFAULT NULL COMMENT 'el total de la factura',
  `totalRestante` int(11) DEFAULT NULL COMMENT 'es lo que va quedando de la factura con cada pago (es totalFactura-monto)',
  `monto` int(100) DEFAULT NULL COMMENT 'es el monto',
  `id_Asipago` int(100) unsigned NOT NULL,
  `tipoPago` varchar(30) DEFAULT NULL COMMENT 'efectivo, tarjeta,cheque, transfrencia',
  `obs` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_pago`,`id_Asipago`),
  KEY `id_proveedor` (`proveedor`),
  KEY `id_Asipago` (`id_Asipago`),
  CONSTRAINT `pago_proveedor_ibfk_1` FOREIGN KEY (`id_Asipago`) REFERENCES `asignar_pago_proveedor` (`id_AsiPago`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `pago_proveedor` */

LOCK TABLES `pago_proveedor` WRITE;

insert  into `pago_proveedor`(`id_pago`,`nro_factura`,`proveedor`,`fechaPago`,`cuotasApagar`,`cuotasPagadas`,`CuotasRestantes`,`totalFactura`,`totalRestante`,`monto`,`id_Asipago`,`tipoPago`,`obs`) values 
(2,'100923','informatica','14-01-2024',2,1,1,75000,37500,37500,11,'EFECTIVO','');

UNLOCK TABLES;

/*Table structure for table `pais` */

DROP TABLE IF EXISTS `pais`;

CREATE TABLE `pais` (
  `id_pais` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(50) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pais` */

LOCK TABLES `pais` WRITE;

insert  into `pais`(`id_pais`,`pais`) values 
(1,'paraguay'),
(2,'Argentina');

UNLOCK TABLES;

/*Table structure for table `periodos` */

DROP TABLE IF EXISTS `periodos`;

CREATE TABLE `periodos` (
  `id_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_periodo` varchar(50) CHARACTER SET utf8mb3 NOT NULL,
  `createdAt` date DEFAULT NULL,
  `updatedAt` date DEFAULT NULL,
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `periodos` */

LOCK TABLES `periodos` WRITE;

insert  into `periodos`(`id_periodo`,`nombre_periodo`,`createdAt`,`updatedAt`) values 
(1,'2025',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `idPermisos` smallint(10) unsigned NOT NULL,
  `ciUsuario` int(13) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `CrearUsuario` varchar(1) NOT NULL,
  `HabPermisos` varchar(1) NOT NULL,
  `CrearNivel` varchar(1) NOT NULL,
  `CrearPersonal` varchar(1) NOT NULL,
  `CrearArticulo` varchar(1) NOT NULL,
  `CrearCategoria` varchar(1) NOT NULL,
  `CrearFamilia` varchar(1) NOT NULL,
  `CrearMarca` varchar(1) NOT NULL,
  `AjusteStock` varchar(1) NOT NULL,
  `CargarProveedor` varchar(1) NOT NULL,
  `CargarPais` varchar(1) NOT NULL,
  `GenerarCompra` varchar(1) NOT NULL,
  `AnularCompra` varchar(1) NOT NULL,
  `ModificarCompra` varchar(1) NOT NULL,
  `CargarCliente` varchar(1) NOT NULL,
  `CargarNcionalidad` varchar(1) NOT NULL,
  `CargarCiudad` varchar(1) NOT NULL,
  `AperturaCaja` varchar(1) NOT NULL,
  `CierreCaja` varchar(1) NOT NULL,
  `Egresos` varchar(1) NOT NULL,
  `GenerarVenta` varchar(1) NOT NULL,
  `AnularVenta` varchar(1) NOT NULL,
  `Devoluciones` varchar(1) NOT NULL,
  `CargarBancos` varchar(1) NOT NULL,
  `cheques` varchar(1) NOT NULL,
  `PagoPersonal` varchar(1) NOT NULL,
  `PagoProv` varchar(1) NOT NULL,
  `CobroClientes` varchar(1) NOT NULL,
  `HistorialMov` varchar(1) NOT NULL,
  `CopiaSeguridad` varchar(1) NOT NULL,
  `Consultas` varchar(1) NOT NULL,
  `Informes` varchar(1) NOT NULL,
  PRIMARY KEY (`idPermisos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `permisos` */

LOCK TABLES `permisos` WRITE;

insert  into `permisos`(`idPermisos`,`ciUsuario`,`usuario`,`CrearUsuario`,`HabPermisos`,`CrearNivel`,`CrearPersonal`,`CrearArticulo`,`CrearCategoria`,`CrearFamilia`,`CrearMarca`,`AjusteStock`,`CargarProveedor`,`CargarPais`,`GenerarCompra`,`AnularCompra`,`ModificarCompra`,`CargarCliente`,`CargarNcionalidad`,`CargarCiudad`,`AperturaCaja`,`CierreCaja`,`Egresos`,`GenerarVenta`,`AnularVenta`,`Devoluciones`,`CargarBancos`,`cheques`,`PagoPersonal`,`PagoProv`,`CobroClientes`,`HistorialMov`,`CopiaSeguridad`,`Consultas`,`Informes`) values 
(0,0,'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
(1,7070380,'Ricardo','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','1','1','1','1','1','1','0','1','1','1','1'),
(2,5868524,'Mar','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1');

UNLOCK TABLES;

/*Table structure for table `personal` */

DROP TABLE IF EXISTS `personal`;

CREATE TABLE `personal` (
  `id_personal` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ci` int(13) DEFAULT NULL,
  `razonSocial` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(13) DEFAULT NULL,
  `codsexo` smallint(5) DEFAULT NULL,
  `id_ciudad` smallint(10) unsigned DEFAULT NULL,
  `id_nacionalidad` smallint(10) unsigned DEFAULT NULL,
  `fechaInicio` varchar(13) DEFAULT NULL,
  `salario` int(30) DEFAULT NULL,
  `ocupacion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_personal`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_nacionalidad` (`id_nacionalidad`),
  KEY `codsexo` (`codsexo`),
  CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`cod_ciudad`),
  CONSTRAINT `personal_ibfk_3` FOREIGN KEY (`id_nacionalidad`) REFERENCES `nacionalidad` (`cod_nacionalidad`),
  CONSTRAINT `personal_ibfk_4` FOREIGN KEY (`codsexo`) REFERENCES `sexo` (`codsexo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `personal` */

LOCK TABLES `personal` WRITE;

insert  into `personal`(`id_personal`,`ci`,`razonSocial`,`direccion`,`telefono`,`codsexo`,`id_ciudad`,`id_nacionalidad`,`fechaInicio`,`salario`,`ocupacion`) values 
(0,5868524,'Maria','VillaAlta','0982431344',1,1,1,'11-12-2023',NULL,'no seleccionado'),
(1,7070380,'Ricardo','Itacurubi','0987324323',2,1,1,'03-08-2023',NULL,'no seleccionado'),
(2,8080621,'José','Santa Rosa','0983233212',2,1,1,'23-11-2023',2000000,'De Salon'),
(3,34323,'Marta','09806745','ara',1,1,1,'10-12-2023',2000000,'De Salon');

UNLOCK TABLES;

/*Table structure for table `proveedores` */

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `id_proveedor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(100) NOT NULL,
  `numero_identificacion` varchar(20) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `proveedores` */

LOCK TABLES `proveedores` WRITE;

UNLOCK TABLES;

/*Table structure for table `reportes` */

DROP TABLE IF EXISTS `reportes`;

CREATE TABLE `reportes` (
  `id_reporte` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  `tipo` enum('Ciudades Cargadas','Clientes','Sucursales','Usuarios','Empresas','Asientos','Compras','Ventas','Periodos','Plan de Cuentas','Proveedores') DEFAULT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `rango_fecha` varchar(10) DEFAULT NULL,
  `formato_exportacion` enum('PDF','Exel') DEFAULT NULL,
  PRIMARY KEY (`id_reporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `reportes` */

LOCK TABLES `reportes` WRITE;

UNLOCK TABLES;

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) CHARACTER SET utf8mb3 NOT NULL,
  `createdAt` date DEFAULT NULL,
  `updatedAt` date DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `roles` */

LOCK TABLES `roles` WRITE;

insert  into `roles`(`id_rol`,`nombre_rol`,`createdAt`,`updatedAt`) values 
(1,'Administrador',NULL,NULL),
(2,'Profesor',NULL,NULL),
(3,'Alumno',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `sexo` */

DROP TABLE IF EXISTS `sexo`;

CREATE TABLE `sexo` (
  `codsexo` smallint(5) NOT NULL AUTO_INCREMENT,
  `sexo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codsexo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `sexo` */

LOCK TABLES `sexo` WRITE;

insert  into `sexo`(`codsexo`,`sexo`) values 
(1,'Femenino'),
(2,'Masculino');

UNLOCK TABLES;

/*Table structure for table `stock` */

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `cod_ajuste` smallint(10) unsigned NOT NULL AUTO_INCREMENT,
  `catidadAjustada` int(100) NOT NULL,
  `observacion` varchar(50) DEFAULT NULL,
  `fecha` varchar(20) DEFAULT NULL,
  `CantidadActual` int(100) NOT NULL,
  `id_articulo` int(11) unsigned NOT NULL,
  `id_usuario` smallint(10) unsigned DEFAULT NULL,
  `id_TipoStock` smallint(5) unsigned DEFAULT NULL,
  `Ajuste` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_ajuste`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_articulo` (`id_articulo`),
  KEY `id_TipoStock` (`id_TipoStock`),
  KEY `id_Ajuste` (`Ajuste`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

/*Data for the table `stock` */

LOCK TABLES `stock` WRITE;

insert  into `stock`(`cod_ajuste`,`catidadAjustada`,`observacion`,`fecha`,`CantidadActual`,`id_articulo`,`id_usuario`,`id_TipoStock`,`Ajuste`) values 
(1,0,'0','23/10/23',0,1,1,1,'Positivo'),
(2,4,'','',3,3,2,1,'Positivo'),
(3,5,'','01-11-2023',30,4,2,6,'Negativo'),
(4,4,'','05-12-2023',16,4,2,1,'Positivo'),
(5,6,'','',20,4,2,4,'Negativo'),
(6,4,'','05-12-2023',-14,4,2,1,'Positivo'),
(7,4,'','',10,3,2,6,'Negativo'),
(8,7,'','',6,3,2,5,'Negativo'),
(9,3,'','05-12-2023',0,1,2,1,'Positivo'),
(10,6,'','07-12-2023',0,4,2,1,'Positivo'),
(11,7,'','07-12-2023',0,3,2,1,'Positivo'),
(12,5,'','12-12-2023',0,1,2,1,'Positivo'),
(13,9,'','12-12-2023',0,1,2,1,'Positivo'),
(14,60,'','12-12-2023',0,3,2,1,'Positivo'),
(15,45,'','12-12-2023',0,1,2,1,'Positivo'),
(16,40,'','13-12-2023',0,4,2,1,'Positivo'),
(17,20,'','13-12-2023',40,4,2,5,'Negativo');

UNLOCK TABLES;

/*Table structure for table `sucursales` */

DROP TABLE IF EXISTS `sucursales`;

CREATE TABLE `sucursales` (
  `id_sucursal` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_sucursal` varchar(10) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`),
  KEY `id_ciudad` (`id_ciudad`),
  CONSTRAINT `sucursales_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudades` (`id_ciudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `sucursales` */

LOCK TABLES `sucursales` WRITE;

UNLOCK TABLES;

/*Table structure for table `tipo_cheque` */

DROP TABLE IF EXISTS `tipo_cheque`;

CREATE TABLE `tipo_cheque` (
  `id_tipo` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` char(10) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `tipo_cheque` */

LOCK TABLES `tipo_cheque` WRITE;

insert  into `tipo_cheque`(`id_tipo`,`tipo`) values 
(1,'Diferido'),
(2,'Vista');

UNLOCK TABLES;

/*Table structure for table `tipoajuste` */

DROP TABLE IF EXISTS `tipoajuste`;

CREATE TABLE `tipoajuste` (
  `idTipo` smallint(11) unsigned NOT NULL AUTO_INCREMENT,
  `Tipo` char(15) DEFAULT NULL,
  PRIMARY KEY (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `tipoajuste` */

LOCK TABLES `tipoajuste` WRITE;

insert  into `tipoajuste`(`idTipo`,`Tipo`) values 
(1,'ajuste inicial'),
(2,'bonificacion'),
(3,'de inventario'),
(4,'merma'),
(5,'por venta'),
(6,'robo'),
(7,'averiados');

UNLOCK TABLES;

/*Table structure for table `tipodepagos` */

DROP TABLE IF EXISTS `tipodepagos`;

CREATE TABLE `tipodepagos` (
  `id_tipo` smallint(5) unsigned NOT NULL,
  `tipopago` char(14) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tipodepagos` */

LOCK TABLES `tipodepagos` WRITE;

insert  into `tipodepagos`(`id_tipo`,`tipopago`) values 
(1,'Transferencia'),
(2,'Cheque'),
(3,'Efectivo');

UNLOCK TABLES;

/*Table structure for table `tipos_documentos` */

DROP TABLE IF EXISTS `tipos_documentos`;

CREATE TABLE `tipos_documentos` (
  `id_tipodocumento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipodocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tipos_documentos` */

LOCK TABLES `tipos_documentos` WRITE;

UNLOCK TABLES;

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 NOT NULL,
  `cedula` varchar(8) CHARACTER SET utf8mb3 NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb3 NOT NULL,
  `contra` varchar(100) CHARACTER SET utf8mb3 NOT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `telefono` varchar(10) CHARACTER SET utf8mb3 NOT NULL,
  `createdAt` date NOT NULL,
  `updatedAt` date NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

LOCK TABLES `usuarios` WRITE;

insert  into `usuarios`(`id_usuario`,`nombre`,`cedula`,`correo`,`contra`,`id_rol`,`estado`,`telefono`,`createdAt`,`updatedAt`) values 
(1,'maria','5898524','mar14@gmail.com','$2a$10$gATMx.ws0fi1oDYE4pOB7OkGJBa4CeqGiMv.6LTBdwmZgeJ6Z4d82',1,1,'0985137452','2025-04-10','2025-04-14');

UNLOCK TABLES;

/*Table structure for table `vendedor` */

DROP TABLE IF EXISTS `vendedor`;

CREATE TABLE `vendedor` (
  `id_vendedor` int(100) unsigned NOT NULL AUTO_INCREMENT,
  `cedulaVend` int(10) DEFAULT NULL,
  `Nombre_App` varchar(50) DEFAULT NULL,
  `telefono` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `vendedor` */

LOCK TABLES `vendedor` WRITE;

insert  into `vendedor`(`id_vendedor`,`cedulaVend`,`Nombre_App`,`telefono`) values 
(0,NULL,NULL,NULL),
(1,423423,'Jose Torres','0982341345'),
(2,5623412,'Victor Gonzalez','0976478354');

UNLOCK TABLES;

/*Table structure for table `ventas` */

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `id_venta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_tipodoc` int(11) DEFAULT NULL,
  `numero_factura` varchar(15) DEFAULT NULL,
  `numero_timbrado` int(11) DEFAULT NULL,
  `condicion` enum('credito','contado') CHARACTER SET utf8mb3 DEFAULT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `total_factura` decimal(15,2) DEFAULT NULL,
  `exenta` decimal(15,2) DEFAULT NULL,
  `iva_10` decimal(15,2) DEFAULT NULL,
  `iva_5` decimal(15,2) DEFAULT NULL,
  `importe_iva_10` decimal(15,2) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  KEY `id_venta` (`id_venta`),
  KEY `id_tipodoc` (`id_tipodoc`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_tipodoc`) REFERENCES `tipos_documentos` (`id_tipodocumento`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `ventas` */

LOCK TABLES `ventas` WRITE;

UNLOCK TABLES;

/*Table structure for table `ventas2` */

DROP TABLE IF EXISTS `ventas2`;

CREATE TABLE `ventas2` (
  `id_ventas` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_condicionVentas` smallint(11) unsigned NOT NULL,
  `id_cliente` int(11) unsigned NOT NULL,
  `id_comprobante` smallint(10) unsigned DEFAULT NULL,
  `nro_Comprobante` varchar(50) DEFAULT NULL,
  `fechaEmision` varchar(20) DEFAULT NULL,
  `FechaPresupuesto` varchar(20) DEFAULT NULL,
  `timbrado` varchar(11) DEFAULT NULL,
  `vali_timbrado` varchar(20) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `totalIVA` double DEFAULT NULL,
  `totalFactura` double DEFAULT NULL,
  `notaAnular` varchar(200) DEFAULT NULL,
  `codAnulado` int(1) DEFAULT NULL,
  `estado` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_ventas`,`id_cliente`,`id_condicionVentas`),
  KEY `ventas2_ibfk_1` (`id_condicionVentas`),
  KEY `id_comprobante` (`id_comprobante`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `ventas2` */

LOCK TABLES `ventas2` WRITE;

insert  into `ventas2`(`id_ventas`,`id_condicionVentas`,`id_cliente`,`id_comprobante`,`nro_Comprobante`,`fechaEmision`,`FechaPresupuesto`,`timbrado`,`vali_timbrado`,`subtotal`,`totalIVA`,`totalFactura`,`notaAnular`,`codAnulado`,`estado`) values 
(24,1,2,1,'000001','12-12-2023',NULL,'000001','12-12-2024',65000,3095.239990234375,65000,'',0,1),
(25,1,1,1,'0010025','12-12-2023',NULL,'1600025','12-12-2024',97500,4642,97500,'',0,0),
(26,1,2,1,'0010026','12-12-2023',NULL,'1600026','12-12-2024',67600,1547,67600,'',0,1),
(27,1,1,1,'0010027','12-12-2023',NULL,'1600027','12-12-2024',83200,116590,83200,'',0,1);

UNLOCK TABLES;

/* Procedure structure for procedure `ComprasPorFechaEmision` */

/*!50003 DROP PROCEDURE IF EXISTS  `ComprasPorFechaEmision` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ComprasPorFechaEmision`(IN `criterio` VARCHAR(30), IN `fechaIniEmision` DATE, IN `fechaFinEmision` DATE)
BEGIN
    IF criterio = 'Buscar' THEN
        SELECT c.nro_factura, p.razon_social, n.condicion, c.fechaeEmision, c.fechaPago, c.timbrado, c.valiTimbrado, c.totalFactura, c.subtotal, c.totalIva
        FROM compra2 c
        INNER JOIN proveedores p ON c.id_proveedor = p.id_proveedor
        INNER JOIN condicionfacturas n ON n.id_condicion = c.id_condicionComp
        WHERE (c.fechaeEmision >= fechaIniEmision AND c.fechaeEmision <= fechaFinEmision)AND c.codAnulado != 1
        ORDER BY c.id_compras DESC;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ComprasPorFechaEmisionAnuladas` */

/*!50003 DROP PROCEDURE IF EXISTS  `ComprasPorFechaEmisionAnuladas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ComprasPorFechaEmisionAnuladas`(IN `criterio` VARCHAR(30), IN `fechaIniEmisionAnulada` DATE, IN `fechaFinEmisionAnulada` DATE)
BEGIN
    IF criterio = 'Buscar' THEN
        SELECT c.nro_factura, p.razon_social, n.condicion, c.fechaeEmision, c.fechaPago, c.timbrado, c.valiTimbrado, c.totalFactura, c.subtotal, c.totalIva
        FROM compra2 c
        INNER JOIN proveedores p ON c.id_proveedor = p.id_proveedor
        INNER JOIN condicionfacturas n ON n.id_condicion = c.id_condicionComp
        WHERE (c.fechaeEmision >= fechaIniEmisionAnulada AND c.fechaeEmision <= fechaFinEmisionAnulada) AND c.codAnulado = 1
        ORDER BY c.id_compras DESC;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ComprasPorFechaPago` */

/*!50003 DROP PROCEDURE IF EXISTS  `ComprasPorFechaPago` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ComprasPorFechaPago`(IN `criterio` VARCHAR(30), IN `fechaIniPago` DATE, IN `fechaFinPago` DATE)
BEGIN
    IF criterio = 'Buscar' THEN
        SELECT c.nro_factura, p.razon_social, n.condicion, c.fechaeEmision, c.fechaPago, c.timbrado, c.valiTimbrado, c.totalFactura, c.subtotal, c.totalIva
        FROM compra2 c
        INNER JOIN proveedores p ON c.id_proveedor = p.id_proveedor
        INNER JOIN condicionfacturas n ON n.id_condicion = c.id_condicionComp
        WHERE (c.fechaPago >= fechaIniPago AND c.fechaPago <= fechaFinPago) AND c.codAnulado != 1
        ORDER BY c.id_compras DESC;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ComprasPorFechaPagoAnuladas` */

/*!50003 DROP PROCEDURE IF EXISTS  `ComprasPorFechaPagoAnuladas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `ComprasPorFechaPagoAnuladas`(IN `criterio` VARCHAR(30), IN `fechaIniPagoAnulada` DATE, IN `fechaFinPagoAnulada` DATE)
BEGIN
    IF criterio = 'Buscar' THEN
        SELECT c.nro_factura, p.razon_social, n.condicion, c.fechaeEmision, c.fechaPago, c.timbrado, c.valiTimbrado, c.totalFactura, c.subtotal, c.totalIva
        FROM compra2 c
        INNER JOIN proveedores p ON c.id_proveedor = p.id_proveedor
        INNER JOIN condicionfacturas n ON n.id_condicion = c.id_condicionComp
        WHERE (c.fechaPago >= fechaIniPagoAnulada AND c.fechaPago <= fechaFinPagoAnulada) AND c.codAnulado = 1
        ORDER BY c.id_compras DESC;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockPorFechas` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockPorFechas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `StockPorFechas`(IN `criterio` VARCHAR(30), IN `fechaIniStock` DATE, IN `fechaFinStock` DATE)
BEGIN
    IF criterio = 'Buscar' THEN
    SELECT a.cod_articulo, a.descripcion,s.CantidadActual, s.catidadAjustada,  s.fecha, u.usuario, t.Tipo, c.Ajuste, s.observacion 
    FROM stock s 
    inner join usuarios u on u.codigo=s.id_usuario 
    inner join articulos a on a.id_articulo=s.id_articulo 
    inner join Ajuste c on c.idAjuste=s.id_Ajuste 
    inner join TipoAjuste t on t.idTipo=s.id_TipoStock 
    WHERE (s.fecha >= fechaIniStock AND s.fecha <= fechaFinStock)
    order by s.cod_ajuste DESC;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UltimoIdCompra` */

/*!50003 DROP PROCEDURE IF EXISTS  `UltimoIdCompra` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UltimoIdCompra`()
    NO SQL
BEGIN
	SELECT MAX(id_compras) AS id FROM compra2;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UltimoIdVentas` */

/*!50003 DROP PROCEDURE IF EXISTS  `UltimoIdVentas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UltimoIdVentas`()
    NO SQL
BEGIN
	SELECT MAX(id_ventas) AS id FROM `ventas2`;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
