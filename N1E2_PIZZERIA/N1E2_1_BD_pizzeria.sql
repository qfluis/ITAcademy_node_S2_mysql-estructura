-- MySQL Script generated by MySQL Workbench
-- Mon Apr  4 21:29:09 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizza_di_mamma
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizza_di_mamma
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza_di_mamma` DEFAULT CHARACTER SET utf8mb4 ;
USE `pizza_di_mamma` ;

-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`provincias` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincia`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`localidades` (
  `idlocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `provincias_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_localidades_provincias1_idx` (`provincias_idprovincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidades_provincias1`
    FOREIGN KEY (`provincias_idprovincia`)
    REFERENCES `pizza_di_mamma`.`provincias` (`idprovincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`clientes` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `direccion` VARCHAR(90) NULL,
  `cp` VARCHAR(10) NULL,
  `telefono` VARCHAR(12) NULL,
  `localidades_idlocalidad` INT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_clientes_localidades_idx` (`localidades_idlocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_localidades`
    FOREIGN KEY (`localidades_idlocalidad`)
    REFERENCES `pizza_di_mamma`.`localidades` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`tiendas` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(60) NULL,
  `cp` VARCHAR(12) NULL,
  `localidades_idlocalidad` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  INDEX `fk_tiendas_localidades1_idx` (`localidades_idlocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_tiendas_localidades1`
    FOREIGN KEY (`localidades_idlocalidad`)
    REFERENCES `pizza_di_mamma`.`localidades` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`empleados` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `nif` VARCHAR(12) NULL,
  `telefono` VARCHAR(12) NULL,
  `puesto` ENUM('cocinero/a', 'repartidor/a') NULL,
  `tiendas_idtienda` INT NULL,
  PRIMARY KEY (`idempleado`),
  INDEX `fk_empleados_tiendas1_idx` (`tiendas_idtienda` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tiendas_idtienda`)
    REFERENCES `pizza_di_mamma`.`tiendas` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`pedidos` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora_pedido` DATETIME NULL,
  `fecha_hora_entrega` DATETIME NULL,
  `tipo` ENUM('domicilio', 'tienda') NULL,
  `clientes_idcliente` INT NOT NULL,
  `tiendas_idtienda` INT NOT NULL,
  `empleados_idempleado` INT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_idcliente` ASC) VISIBLE,
  INDEX `fk_pedidos_tiendas1_idx` (`tiendas_idtienda` ASC) VISIBLE,
  INDEX `fk_pedidos_empleados1_idx` (`empleados_idempleado` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_idcliente`)
    REFERENCES `pizza_di_mamma`.`clientes` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tiendas1`
    FOREIGN KEY (`tiendas_idtienda`)
    REFERENCES `pizza_di_mamma`.`tiendas` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_empleados1`
    FOREIGN KEY (`empleados_idempleado`)
    REFERENCES `pizza_di_mamma`.`empleados` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`categorias_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`categorias_pizza` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`productos` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(90) NULL,
  `url_imagen` VARCHAR(90) NULL,
  `precio` DECIMAL NULL,
  `categorias_pizza_idcategoria` INT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_productos_categorias_pizza1_idx` (`categorias_pizza_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias_pizza1`
    FOREIGN KEY (`categorias_pizza_idcategoria`)
    REFERENCES `pizza_di_mamma`.`categorias_pizza` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_di_mamma`.`lineas_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_di_mamma`.`lineas_pedido` (
  `idlineas_pedido` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NOT NULL,
  `pedidos_idpedido` INT NOT NULL,
  `productos_idproducto` INT NOT NULL,
  PRIMARY KEY (`idlineas_pedido`),
  INDEX `fk_lineas_pedido_pedidos1_idx` (`pedidos_idpedido` ASC) VISIBLE,
  INDEX `fk_lineas_pedido_productos1_idx` (`productos_idproducto` ASC) VISIBLE,
  CONSTRAINT `fk_lineas_pedido_pedidos1`
    FOREIGN KEY (`pedidos_idpedido`)
    REFERENCES `pizza_di_mamma`.`pedidos` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lineas_pedido_productos1`
    FOREIGN KEY (`productos_idproducto`)
    REFERENCES `pizza_di_mamma`.`productos` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
