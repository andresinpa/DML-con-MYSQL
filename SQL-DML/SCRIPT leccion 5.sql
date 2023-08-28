USE ventas_jugos;
CREATE TABLE tb_identificacion(
	ID INT AUTO_INCREMENT NOT NULL,
    DESCRIPCION VARCHAR(50) NULL,
    PRIMARY KEY (ID)
);

SELECT * FROM tb_identificacion;

INSERT INTO tb_identificacion(DESCRIPCION)
VALUES ('Cliente A');

INSERT INTO tb_identificacion(DESCRIPCION)
VALUES ('Cliente B');

INSERT INTO tb_identificacion(DESCRIPCION)
VALUES ('Cliente C');

DELETE FROM tb_identificacion WHERE DESCRIPCION = 'Cliente C';

INSERT INTO tb_identificacion(ID, DESCRIPCION)
VALUES (100, 'Cliente h');

INSERT INTO tb_identificacion(DESCRIPCION)
VALUES ('Cliente k');
/*---------------------------------------------------------------------------*/

CREATE TABLE tb_default(
	ID INT AUTO_INCREMENT,
    DESCRIPCION VARCHAR(50) NOT NULL,
    DIRECCION VARCHAR(100) NULL,
    CIUDAD VARCHAR(50) DEFAULT 'Monterrey', 
    FECHA_CREACION TIMESTAMP DEFAULT current_timestamp(),
    PRIMARY KEY(ID)
);

INSERT INTO tb_default(DESCRIPCION, DIRECCION, CIUDAD, FECHA_CREACION) VALUES (
	'Cliente X', "Calle Sol, 525", 'Cancún', '2021-01-01'
);

SELECT * FROM tb_default;

INSERT INTO tb_default(DESCRIPCION) VALUES (
	'Cliente Y'
);

/*----------------------------------------------------------------------------------*/
CREATE TABLE tb_facturacion(
	FECHA DATE NULL,
    VENTA_TOTAL FLOAT
);

CREATE TABLE `tb_factura1` (
  `NUMERO` varchar(5) NOT NULL,
  `FECHA` date DEFAULT NULL,
  `DNI` varchar(11) NOT NULL,
  `MATRICULA` varchar(5) NOT NULL,
  `IMPUESTO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`),
  KEY `FK_CLIENTE1` (`DNI`),
  KEY `FK_VENDENDOR1` (`MATRICULA`),
  CONSTRAINT `FK_CLIENTE1` FOREIGN KEY (`DNI`) REFERENCES `tb_cliente` (`DNI`),
  CONSTRAINT `FK_VENDENDOR1` FOREIGN KEY (`MATRICULA`) REFERENCES `tb_vendedor` (`MATRICULA`)
);
CREATE TABLE `tb_items_facturas1` (
  `NUMERO` varchar(5) NOT NULL,
  `CODIGO` varchar(10) NOT NULL,
  `CANTIDAD` int DEFAULT NULL,
  `PRECIO` float DEFAULT NULL,
  PRIMARY KEY (`NUMERO`,`CODIGO`),
  KEY `FK_PRODUCTO1` (`CODIGO`),
  CONSTRAINT `FK_FACTURA1` FOREIGN KEY (`NUMERO`) REFERENCES `tb_factura1` (`NUMERO`),
  CONSTRAINT `FK_PRODUCTO1` FOREIGN KEY (`CODIGO`) REFERENCES `tb_producto` (`CODIGO`)
);


SELECT * FROM tb_items_facturas1;
SELECT * FROM tb_factura1;
SELECT * FROM tb_factura;
SELECT * FROM tb_cliente;
SELECT * FROM tb_vendedor;
SELECT * FROM tb_producto;

INSERT INTO tb_factura1
	VALUES(
			'0100', '2021-01-01', '1471156710', '235', 0.2
    );
    
INSERT INTO tb_items_facturas1
	VALUES
    ('0100', '1002767', 100, 25),
    ('0100', '1004327', 12, 25),
	('0100', '1013793', 400, 25);

SELECT 	A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
FROM tb_factura1 A
inner join
tb_items_facturas1 B
ON A.NUMERO = B.NUMERO
GROUP BY
A.FECHA;

INSERT INTO tb_factura1
	VALUES(
			'0101', '2021-01-01', '1471156710', '235', 0.2
    );
    
INSERT INTO tb_items_facturas1
	VALUES
    ('0101', '1002767', 100, 25),
    ('0101', '1004327', 12, 25),
	('0101', '1013793', 400, 25);
/*------------------------------------------------------------------------------*/

DELIMITER // 

CREATE TRIGGER TG_FACTURACION_INSERT
AFTER INSERT ON tb_items_facturas1
FOR EACH ROW BEGIN
	DELETE FROM tb_facturacion;
	INSERT INTO tb_facturacion 
	SELECT 	A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
	FROM tb_factura1 A
	inner join
	tb_items_facturas1 B
	ON A.NUMERO = B.NUMERO
	GROUP BY
	A.FECHA;
END //

INSERT INTO tb_factura1
	VALUES(
			'0104', '2021-01-01', '1471156710', '235', 0.2
    );

INSERT INTO tb_items_facturas1
	VALUES
    ('0104', '1002767', 233, 25),
    ('0104', '1004327', 344, 25),
	('0104', '1013793', 122, 25);

SELECT * FROM tb_facturacion;

SELECT DNI, EDAD, FECHA_NACIMIENTO, timestampdiff(YEAR, FECHA_NACIMIENTO, NOW()) AS ANOS FROM tb_cliente;
DELIMITER //
CREATE TRIGGER TG_EDAD_CLIENTES_INSERT 
BEFORE INSERT ON tb_cliente
FOR EACH ROW BEGIN
SET NEW.EDAD = timestampdiff(YEAR, NEW.FECHA_NACIMIENTO, NOW());
END//

/*---------------------------------------------------------------------------*/

SELECT * FROM tb_facturacion;
SELECT * FROM tb_factura1;
SELECT * FROM tb_items_facturas1;

UPDATE tb_items_facturas1 SET CANTIDAD = 600
WHERE NUMERO = '0101' and CODIGO = '1002767';

DELETE FROM tb_items_facturas1
WHERE NUMERO = '0104' and CODIGO = '1004327'; 

DELIMITER // 

CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON tb_items_facturas1
FOR EACH ROW BEGIN
	DELETE FROM tb_facturacion;
	INSERT INTO tb_facturacion 
	SELECT 	A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
	FROM tb_factura1 A
	inner join
	tb_items_facturas1 B
	ON A.NUMERO = B.NUMERO
	GROUP BY
	A.FECHA;
END //

DELIMITER // 

CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON tb_items_facturas1
	FOR EACH ROW BEGIN
		DELETE FROM tb_facturacion;
		INSERT INTO tb_facturacion 
		SELECT 	A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
		FROM tb_factura1 A
		inner join
		tb_items_facturas1 B
		ON A.NUMERO = B.NUMERO
		GROUP BY
		A.FECHA;
END //

UPDATE tb_items_facturas1 SET CANTIDAD = 800
WHERE NUMERO = '0101' and CODIGO = '1002767';

DELETE FROM tb_items_facturas1
WHERE NUMERO = '0100' and CODIGO = '1002767';