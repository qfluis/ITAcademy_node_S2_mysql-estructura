-- CONSULTAS OPTICA
-- 1. Llista el total de compres d'un client
SELECT c.nombre, p.`fecha-pedido`, g.nombre_modelo, g.`tipo-montura`, lp.unidades, g.precio 
FROM clientes c LEFT JOIN pedido p
ON c.idcliente = p.clientes_idcliente LEFT JOIN `lineas-pedido` lp 
ON p.idpedido = lp.pedido_idpedido LEFT JOIN gafas g
ON lp.gafas_idgafas = g.idgafas
WHERE c.idcliente = 1;

-- 2. Llista les diferents ulleres que ha venut un empleat durant un any

SELECT e.idempleado, e.nombre, p.`fecha-pedido`, lp.unidades, g.`nombre_modelo`
FROM empleados e INNER JOIN pedido p
ON e.idempleado = p.`empleados_idempleado` INNER JOIN `lineas-pedido` lp
ON p.idpedido = lp.pedido_idpedido INNER JOIN gafas g
ON lp.gafas_idgafas = g.idgafas
WHERE e.idempleado = 1;

-- 3. Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica

SELECT pr.nombre ,COUNT(g.idgafas) AS modelos_vendidos, SUM(lp.unidades) AS unidades_vendidas
FROM proveedores pr INNER JOIN marcas m 
ON pr.idproveedor = m.proveedores_idproveedor INNER JOIN gafas g 
ON m.idmarca = g.marcas_idmarca INNER JOIN `lineas-pedido` lp
ON g.idgafas = lp.gafas_idgafas
GROUP BY pr.nombre
