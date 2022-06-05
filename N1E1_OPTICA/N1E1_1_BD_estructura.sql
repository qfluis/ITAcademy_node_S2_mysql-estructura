-- Elimina BD si existe
DROP SCHEMA IF EXISTS `culo-de-botella` ;
-- Crear BD
CREATE SCHEMA `culo-de-botella` DEFAULT CHARACTER SET utf8mb4 ;
USE `culo-de-botella` ;

CREATE TABLE `proveedores` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `direccion-calle` VARCHAR(45) NULL,
  `direccion-numero` VARCHAR(10) NULL,
  `direccion-piso` VARCHAR(10) NULL,
  `direccion-puerta` VARCHAR(10) NULL,
  `direccion-ciudad` VARCHAR(60) NULL,
  `direccion-cp` VARCHAR(10) NULL,
  `direccion-pais` VARCHAR(45) NULL,
  `telefono` VARCHAR(12) NULL,
  `fax` VARCHAR(12) NULL,
  `nif` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idproveedor`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE
);

CREATE TABLE `marcas` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `proveedores_idproveedor` INT NOT NULL,
  PRIMARY KEY (`idmarca`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_marcas_proveedores1`
    FOREIGN KEY (`proveedores_idproveedor`)
    REFERENCES `proveedores` (`idproveedor`)
);

CREATE TABLE `gafas` (
  `idgafas` INT NOT NULL AUTO_INCREMENT,
  `nombre_modelo` VARCHAR(45) NOT NULL,
  `graduacion-d` VARCHAR(12) NULL,
  `graduacion-i` VARCHAR(12) NULL,
  `tipo-montura` ENUM('flotante', 'pasta', 'metalica') NULL,
  `color-montura` VARCHAR(30) NULL,
  `color-vidrios` VARCHAR(30) NULL,
  `precio` DECIMAL NULL,
  `marcas_idmarca` INT NOT NULL,
  PRIMARY KEY (`idgafas`),
  CONSTRAINT `fk_gafas_marcas1`
    FOREIGN KEY (`marcas_idmarca`)
    REFERENCES `marcas` (`idmarca`)
);

CREATE TABLE `clientes` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `direccion-calle` VARCHAR(45) NULL,
  `direccion-numero` VARCHAR(10) NULL,
  `direccion-piso` VARCHAR(10) NULL,
  `direccion-puerta` VARCHAR(10) NULL,
  `direccion-ciudad` VARCHAR(60) NULL,
  `direccion-cp` VARCHAR(10) NULL,
  `direccion-pais` VARCHAR(45) NULL,
  `telefono` VARCHAR(12) NULL,
  `email` VARCHAR(60) NULL,
  `fecha-registro` TIMESTAMP NULL,
  `clientes_idcliente_recomendador` INT NULL,
  PRIMARY KEY (`idcliente`),
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`clientes_idcliente_recomendador`)
    REFERENCES `clientes` (`idcliente`)
);

CREATE TABLE `empleados` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `DNI` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idempleado`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE
);

CREATE TABLE `pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha-pedido` TIMESTAMP NOT NULL,
  `empleados_idempleado` INT NOT NULL,
  `clientes_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  CONSTRAINT `fk_pedido_empleados1`
    FOREIGN KEY (`empleados_idempleado`)
    REFERENCES `empleados` (`idempleado`),
  CONSTRAINT `fk_pedido_clientes1`
    FOREIGN KEY (`clientes_idcliente`)
    REFERENCES `clientes` (`idcliente`)
);

CREATE TABLE `lineas-pedido` (
  `idlinea-pedido` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NULL,
  `gafas_idgafas` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  PRIMARY KEY (`idlinea-pedido`),
  CONSTRAINT `fk_lineas-pedido_gafas1`
    FOREIGN KEY (`gafas_idgafas`)
    REFERENCES `gafas` (`idgafas`),
  CONSTRAINT `fk_lineas-pedido_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `pedido` (`idpedido`)
);
