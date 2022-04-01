-- //TODO: AÑADIR MÁS DATOS y RELACIONES

USE `culo-de-botella`;

-- DATOS TABLA CLIENTES

INSERT INTO clientes (`nombre`,`direccion-calle`,`direccion-numero`,`direccion-piso`,`direccion-puerta`,`direccion-ciudad`,`direccion-cp`,`direccion-pais`,`telefono`,`email`,`fecha-registro`) 
VALUES  ('Luis Queve','micalle','33','2','2','Santako','08008','España','566888555','eeeeeee@ooooo.com','2020-03-30 00:00:00'),
        ('Cris Gimenez','otraCalle','44','5','A','Barcelona','08888','España','5688884','cgm@oliwi.com','2022-03-25 00:00:00'),
        ('Sara','calle','22','3','3','Bdn','90988','España','334434343','uuuuuuu@uuuuuu.com','2022-03-02');


-- DATOS TABLA EMPLEADOS

INSERT INTO empleados (`nombre`,`DNI`) 
VALUES  ('Empleado Uno','55888888A'),
        ('Empleado Dos','52555888F');


-- DATOS TABLA PROVEEDORES

INSERT INTO proveedores (`nombre`, `direccion-calle`, `direccion-numero`, `direccion-piso`, `direccion-puerta`, `direccion-ciudad`, `direccion-cp`, `direccion-pais`, `telefono`, `fax`, `nif`) 
VALUES  ('Proveedor1', 'sicilia', '22', '3', '4', 'Santa Coloma', '08992', 'España', '33333333', '44545444', '85455444F'),
        ('Proveedor2', 'verdi', '23', '2', '3', 'Badalona', '08955', 'España', '333443333', '44555444', '45454444F'),
        ('Proveedor3', 'florencia', '42', '1', '5', 'Barcelona', '08933', 'Francia', '55333333', '77545444', '65455444F');

-- DATOS TABLA MARCAS

INSERT INTO marcas (`nombre`, `proveedores_idproveedor`) 
VALUES  ('CuchiCuchi', '1'),
        ('EmporioMami', '2'),
        ('RayFan', '1');


-- DATOS TABLA GAFAS
INSERT INTO gafas (`nombre_modelo`, `graduacion-d`, `graduacion-i`, `tipo-montura`, `color-montura`, `color-vidrios`, `precio`, `marcas_idmarca`) 
VALUES  ('Gafotas', '12.5', '12.5', '1', 'Rojo-fuego', 'transparente', '150', '1'),
        ('GafotasPlus', '12.5', '12.5', '2', 'Rojo-pasión', 'semi-transparente', '180', '1');


-- DATOS TABLA PEDIDO

INSERT INTO pedido (`fecha-pedido`, `empleados_idempleado`, `clientes_idcliente`) 
VALUES  ('2022-03-28', '1', '1'),
        ('2022-03-29', '2', '2');


-- DATOS TABLA LINEAS-PEDIDO

INSERT INTO `culo-de-botella`.`lineas-pedido` (`unidades`, `gafas_idgafas`, `pedido_idpedido`) 
VALUES  ('1', '1', '1'),
        ('1', '2', '2'),
        ('1', '2', '1');
