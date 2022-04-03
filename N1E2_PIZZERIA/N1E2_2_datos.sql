-- //TODO: AÑADIR MÁS DATOS y RELACIONES

USE `pizza_di_mamma`;


-- DATOS CATEGORIAS_PIZZA

INSERT INTO `categorias_pizza`  (`nombre`) 
VALUES ('Classic'),
       ('Vegie'),
       ('Bio'),
       ('Hot');

-- DATOS PRODUCTOS

INSERT INTO `pizza_di_mamma`.`productos` (`tipo`, `nombre`, `descripcion`, `url_imagen`, `precio`, `categorias_pizza_idcategoria`) 
VALUES  ('1', 'Cuatro Quesos', 'Pizza con 4 quesos exactos', 'http://jbljssksk.com', '12', '1'),
        ('1', 'Del Huerto', 'Pizza con cosas del huerto', 'http:/jdsjkdlkjsdlkjs', '9.95', '2'),
        ('1','Km 0', 'Pizza con cosas de aquí', 'http://jjdkjdkjdkj', '18', '3'),
        ('1','Piche tu madre', 'Pizza muyyyy picante', 'http://jjskjskjs', '10', '4'),
        ('3','Agüita', 'Mineral y tal', 'http://jjskjrrrrr', '2', null),
        ('3','Cola', 'fresquita', 'http://jjskeeerrrr', '2', null),
        ('3','Fanta', 'Naranja', 'http://jjskeee22rr', '2', null);


-- DATOS PROVINCIAS

INSERT INTO `provincias` (`nombre`) 
VALUES  ('Barcelona'),
        ('Girona'),
        ('Tarragona'),
        ('Lleida');


-- DATOS LOCALIDADES

INSERT INTO `localidades` (`nombre`, `provincias_idprovincia`) 
VALUES  ('Badalona', '1'),
        ('Barcelona', '1'),
        ('Calafell', '3'),
        ('Roses', '2'),
        ('Sort', '4');


-- DATOS CLIENTES

INSERT INTO `clientes` (`nombre`, `apellidos`, `direccion`, `cp`, `telefono`, `localidades_idlocalidad`) 
VALUES  ('Nombre1', 'Apellido2', 'c/ bleblele', '08999', '344433221', '1'),
        ('Nombre2', 'Apellido2', 'c/ blublublu', '08877', '23456543', '2');


-- DATOS TIENDAS

INSERT INTO `tiendas` (`nombre`, `direccion`, `cp`, `localidades_idlocalidad`) 
VALUES  ('Tienda Badalona', 'c/ blbeble, 45', '08555', '1'),
        ('Tienda BCN', 'Avda. Diagonal', '555', '2'),
        ('Tienda Calafell', 'c/ blublub, 4', '58558', '3'),
        ('Tienda Roses', 'c/weeee, 5', '25866', '4'),
        ('Tienda de la suerte', 'c/ hooola, 5', '55887', '5');


-- DATOS EMPLEADOS

INSERT INTO `empleados` (`nombre`, `apellidos`, `nif`, `telefono`, `puesto`, `tiendas_idtienda`) 
VALUES  ('Nombre1', 'Apellido1', '46755555F', '456789123', '1', '1'),
        ('Nombre2', 'Apellido2', '14582588A', '564897126', '2', '1'),
        ('Nombre3', 'Apellido3', '45555555C', '457779123', '1', '2'),
        ('Nombre4', 'Apellido4', '46722555B', '456789993', '2', '2');

-- DATOS PEDIDOS

INSERT INTO `pedidos` (`fecha_hora_pedido`, `fecha_hora_entrega`, `tipo`, `clientes_idcliente`, `tiendas_idtienda`, `empleados_idempleado`) 
VALUES  ('2022-04-01 21:05:00', '2022-04-01 21:25:00', '1', '1', '1', '2'),
        ('2022-04-02 21:05:00', '2022-04-01 21:35:00', '1', '1', '1', '2'),
        ('2022-04-03 21:05:00', '2022-04-01 21:19:00', '1', '1', '1', '2'),
        ('2022-04-03 20:05:00', '2022-04-01 20:19:00', '1', '2', '2', '4'),
        ('2022-04-03 20:05:00', '2022-04-01 20:19:00', '1', '2', '2', '4'),
        ('2022-04-03 20:05:00', '2022-04-01 20:19:00', '1', '2', '2', '4');

-- DATOS LINEAS_PEDIDO

INSERT INTO `pizza_di_mamma`.`lineas_pedido` (`unidades`, `pedidos_idpedido`, `productos_idproducto`) 
VALUES  ('1', '1', '1'),
        ('1', '1', '2'),
        ('1', '1', '3'),
        ('1', '1', '5'),
        ('2', '1', '6'),
        ('1', '2', '3'),
        ('1', '2', '2'),
        ('1', '2', '5'),
        ('2', '2', '7'),
        ('1', '3', '1'),
        ('1', '3', '2'),
        ('1', '2', '3'),
        ('1', '4', '5'),
        ('2', '4', '6');

