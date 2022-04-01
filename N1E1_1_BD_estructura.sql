-- // TODO: PREGUNTAR SOBRE ESTRUCTURA...

-- MySQL Script generated by MySQL Workbench
-- Fri Apr  1 12:42:44 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema culo-de-botella
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema culo-de-botella
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culo-de-botella` DEFAULT CHARACTER SET utf8 ;
USE `culo-de-botella` ;

-- -----------------------------------------------------
-- Table `culo-de-botella`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`proveedores` (
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
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`marcas` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `proveedores_idproveedor` INT NOT NULL,
  PRIMARY KEY (`idmarca`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_marcas_proveedores1_idx` (`proveedores_idproveedor` ASC) VISIBLE,
  CONSTRAINT `fk_marcas_proveedores1`
    FOREIGN KEY (`proveedores_idproveedor`)
    REFERENCES `culo-de-botella`.`proveedores` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`gafas`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `culo-de-botella`.`gafas` (
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
  INDEX `fk_gafas_marcas1_idx` (`marcas_idmarca` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_marcas1`
    FOREIGN KEY (`marcas_idmarca`)
    REFERENCES `culo-de-botella`.`marcas` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`clientes` (
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
  INDEX `fk_clientes_clientes1_idx` (`clientes_idcliente_recomendador` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`clientes_idcliente_recomendador`)
    REFERENCES `culo-de-botella`.`clientes` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`empleados` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `DNI` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idempleado`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha-pedido` TIMESTAMP NOT NULL,
  `empleados_idempleado` INT NOT NULL,
  `clientes_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_empleados1_idx` (`empleados_idempleado` ASC) VISIBLE,
  INDEX `fk_pedido_clientes1_idx` (`clientes_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_empleados1`
    FOREIGN KEY (`empleados_idempleado`)
    REFERENCES `culo-de-botella`.`empleados` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_clientes1`
    FOREIGN KEY (`clientes_idcliente`)
    REFERENCES `culo-de-botella`.`clientes` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culo-de-botella`.`lineas-pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culo-de-botella`.`lineas-pedido` (
  `idlinea-pedido` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NULL,
  `gafas_idgafas` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  PRIMARY KEY (`idlinea-pedido`),
  INDEX `fk_lineas-pedido_gafas1_idx` (`gafas_idgafas` ASC) VISIBLE,
  INDEX `fk_lineas-pedido_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  CONSTRAINT `fk_lineas-pedido_gafas1`
    FOREIGN KEY (`gafas_idgafas`)
    REFERENCES `culo-de-botella`.`gafas` (`idgafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lineas-pedido_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `culo-de-botella`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
