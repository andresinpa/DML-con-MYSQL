SELECT * FROM tb_producto;

UPDATE tb_producto SET PRECIO_LISTA = 5 WHERE CODIGO = '1000889';

UPDATE tb_producto SET 
	DESCRIPCION = 'Sabor de la montaña',
	TAMANO='1 Litro', 
    ENVASE = 'Botella PET'
	WHERE CODIGO = '1000889';

SELECT * FROM tb_cliente;

UPDATE tb_cliente SET VOLUMEN_COMPRA = VOLUMEN_COMPRA/10;

UPDATE tb_cliente SET 
DIRECCION = 'Jorge Emilio 23',
BARRIO = 'San Antonio',
CIUDAD = 'Guadalajara',
ESTADO = 'JC',
CP = '44700000'
WHERE DNI = '5840119709'

/*---------------------------------------------------------------------------------------------*/

SELECT * FROM tb_vendedor;

SELECT * FROM jugos_ventas.tabla_de_vendedores;

SELECT * FROM tb_vendedor A 
INNER JOIN
jugos_ventas.tabla_de_vendedores B
ON A.MATRICULA = SUBSTRING(B.MATRICULA, 3,3);

UPDATE tb_vendedor A 
INNER JOIN
jugos_ventas.tabla_de_vendedores B
ON A.MATRICULA = SUBSTRING(B.MATRICULA, 3,3)
SET A.DE_VACACIONES = B.VACACIONES;

/*---------------------------------------------------------------------------------------------*/
INSERT INTO tb_producto (CODIGO,DESCRIPCION,SABOR,TAMANO,ENVASE,PRECIO_LISTA)
     VALUES ('1001001','Sabor Alpino','Mango','700 ml','Botella',7.50),
         ('1001000','Sabor Alpino','Melón','700 ml','Botella',7.50),
         ('1001002','Sabor Alpino','Guanábana','700 ml','Botella',7.50),
         ('1001003','Sabor Alpino','Mandarina','700 ml','Botella',7.50),
         ('1001004','Sabor Alpino','Banana','700 ml','Botella',7.50),
         ('1001005','Sabor Alpino','Asaí','700 ml','Botella',7.50),
         ('1001006','Sabor Alpino','Mango','1 Litro','Botella',7.50),
         ('1001007','Sabor Alpino','Melón','1 Litro','Botella',7.50),
         ('1001008','Sabor Alpino','Guanábana','1 Litro','Botella',7.50),
         ('1001009','Sabor Alpino','Mandarina','1 Litro','Botella',7.50),
         ('1001010','Sabor Alpino','Banana','1 Litro','Botella',7.50),
         ('1001011','Sabor Alpino','Asaí','1 Litro','Botella',7.50);
         
SELECT * FROM tb_producto WHERE DESCRIPCION = 'Sabor Alpino';

DELETE FROM tb_producto WHERE CODIGO = '1001000';

DELETE FROM tb_producto WHERE TAMANO = '1 Litro';

SELECT CODIGO_DEL_PRODUCTO FROM jugos_ventas.tabla_de_productos;

SELECT CODIGO FROM tb_producto 
WHERE CODIGO NOT IN (SELECT CODIGO_DEL_PRODUCTO FROM jugos_ventas.tabla_de_productos);

DELETE FROM tb_producto 
WHERE CODIGO 
NOT IN (SELECT CODIGO_DEL_PRODUCTO 
FROM jugos_ventas.tabla_de_productos);

DELETE A FROM tb_factura A
INNER JOIN 
tb_cliente B 
ON A.DNI = B.DNI
WHERE B.EDAD < 18;

SELECT * FROM tb_factura;

/*.-------------------------------------------------------------------------------------*/
CREATE TABLE `tb_producto2` (
  `CODIGO` varchar(10) NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  `SABOR` varchar(50) DEFAULT NULL,
  `TAMANO` varchar(50) DEFAULT NULL,
  `ENVASE` varchar(50) DEFAULT NULL,
  `PRECIO_LISTA` float DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
);

SELECT * FROM tb_producto2;



INSERT INTO tb_producto2
SELECT * FROM tb_producto;

DELETE FROM tb_producto2;

UPDATE tb_producto2 SET PRECIO_LISTA = PRECIO_LISTA * 1.15;
/*------------------------------------------------------------------------------------------*/
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('256',
'Fernando Gutierrez',
'Oblatos',
'0.1',
'2015-06-12',
0);

SELECT * FROM  tb_vendedor;

START TRANSACTION;
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('259',
'Camila Gutierrez',
'Oblatos',
'0.1',
'2015-06-12',
0);
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`MATRICULA`,
`NOMBRE`,
`BARRIO`,
`COMISION`,
`FECHA_ADMISION`,
`DE_VACACIONES`)
VALUES
('260',
'Luciana Torres',
'Del Valle',
'0.18',
'2015-06-12',
0);

UPDATE tb_vendedor SET COMISION = COMISION * 1.05;

/*ROLLBACK;*/

COMMIT;