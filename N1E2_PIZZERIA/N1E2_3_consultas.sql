-- CONSULTAS PIZZERIA

-- 1. Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat
SELECT l.nombre, count(lp.idlineas_pedido) AS Unidades_Bebida_Vendidas
FROM productos p INNER JOIN lineas_pedido lp
ON p.idproducto = lp.productos_idproducto INNER JOIN pedidos pd
ON lp.pedidos_idpedido = pd.idpedido INNER JOIN tiendas t
ON pd.tiendas_idtienda = t.idtienda INNER JOIN localidades l
ON t.localidades_idlocalidad = l.idlocalidad
WHERE p.tipo = 3
GROUP BY l.nombre;


-- 2. Llista quantes comandes ha efectuat un determinat empleat

-- OPCIÓN A - Empleado con un id en concreto

SELECT CONCAT(e.nombre,' ', e.apellidos ) AS Empleado, count(p.idpedido) AS `Número de pedidos`
FROM empleados e INNER JOIN pedidos p
ON e.idempleado = p.empleados_idempleado
WHERE e.idempleado = 2;


-- OPCIÓN B - TODOS LOS EMPLEADOS Y SUS PEDIDOS
SELECT CONCAT(e.nombre,' ', e.apellidos ) AS Empleado, count(p.idpedido) AS `Número de pedidos`
FROM empleados e INNER JOIN pedidos p
ON e.idempleado = p.empleados_idempleado
GROUP BY Empleado