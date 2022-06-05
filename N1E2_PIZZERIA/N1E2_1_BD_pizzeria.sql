-- Elimina BD si existe
DROP SCHEMA IF EXISTS `pizza_di_mamma` ;
-- Crear BD
CREATE SCHEMA `pizza_di_mamma` DEFAULT CHARACTER SET utf8mb4 ;
USE `pizza_di_mamma` ;

CREATE TABLE `provincias` (
  `idprovincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprovincia`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE
);

CREATE TABLE `localidades` (
  `idlocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `provincias_idprovincia` INT NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_localidades_provincias1`
    FOREIGN KEY (`provincias_idprovincia`)
    REFERENCES `provincias` (`idprovincia`)
);

CREATE TABLE `clientes` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `direccion` VARCHAR(90) NULL,
  `cp` VARCHAR(10) NULL,
  `telefono` VARCHAR(12) NULL,
  `localidades_idlocalidad` INT NULL,
  PRIMARY KEY (`idcliente`),
  CONSTRAINT `fk_clientes_localidades`
    FOREIGN KEY (`localidades_idlocalidad`)
    REFERENCES `localidades` (`idlocalidad`)
);

CREATE TABLE `tiendas` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(60) NULL,
  `cp` VARCHAR(12) NULL,
  `localidades_idlocalidad` INT NOT NULL,
  PRIMARY KEY (`idtienda`),
  CONSTRAINT `fk_tiendas_localidades1`
    FOREIGN KEY (`localidades_idlocalidad`)
    REFERENCES `localidades` (`idlocalidad`)
);

CREATE TABLE `empleados` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `nif` VARCHAR(12) NULL,
  `telefono` VARCHAR(12) NULL,
  `puesto` ENUM('cocinero/a', 'repartidor/a') NULL,
  `tiendas_idtienda` INT NULL,
  PRIMARY KEY (`idempleado`),
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tiendas_idtienda`)
    REFERENCES `tiendas` (`idtienda`)
);

CREATE TABLE `pedidos` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora_pedido` DATETIME NULL,
  `fecha_hora_entrega` DATETIME NULL,
  `tipo` ENUM('domicilio', 'tienda') NULL,
  `clientes_idcliente` INT NOT NULL,
  `tiendas_idtienda` INT NOT NULL,
  `empleados_idempleado` INT NULL,
  PRIMARY KEY (`idpedido`),
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_idcliente`)
    REFERENCES `clientes` (`idcliente`),
  CONSTRAINT `fk_pedidos_tiendas1`
    FOREIGN KEY (`tiendas_idtienda`)
    REFERENCES `tiendas` (`idtienda`),
  CONSTRAINT `fk_pedidos_empleados1`
    FOREIGN KEY (`empleados_idempleado`)
    REFERENCES `empleados` (`idempleado`)
);

CREATE TABLE `categorias_pizza` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoria`)
);

CREATE TABLE `productos` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('pizza', 'hamburguesa', 'bebida') NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(90) NULL,
  `url_imagen` VARCHAR(90) NULL,
  `precio` DECIMAL NULL,
  `categorias_pizza_idcategoria` INT NULL,
  PRIMARY KEY (`idproducto`),
  CONSTRAINT `fk_productos_categorias_pizza1`
    FOREIGN KEY (`categorias_pizza_idcategoria`)
    REFERENCES `categorias_pizza` (`idcategoria`)
);

CREATE TABLE `lineas_pedido` (
  `idlineas_pedido` INT NOT NULL AUTO_INCREMENT,
  `unidades` INT NOT NULL,
  `pedidos_idpedido` INT NOT NULL,
  `productos_idproducto` INT NOT NULL,
  PRIMARY KEY (`idlineas_pedido`),
  CONSTRAINT `fk_lineas_pedido_pedidos1`
    FOREIGN KEY (`pedidos_idpedido`)
    REFERENCES `pedidos` (`idpedido`),
  CONSTRAINT `fk_lineas_pedido_productos1`
    FOREIGN KEY (`productos_idproducto`)
    REFERENCES `productos` (`idproducto`)
);
