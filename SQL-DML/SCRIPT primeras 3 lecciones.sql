create DATABASE ventas_jugos;

CREATE SCHEMA IF NOT EXISTS ventas_jugos2;

DROP DATABASE ventas_jugos2;

CREATE SCHEMA IF NOT EXISTS ventas_jugos2 DEFAULT CHARSET utf32;

/*--------------------------------------------------------------------------------*/
CREATE TABLE tb_vendedor(
	MATRICULA VARCHAR(5) NOT NULL,
    NOMBRE VARCHAR(100) NULL,
    BARRIO VARCHAR(50) NULL,
    COMISION FLOAT NULL,
    FECHA_ADMISION DATE NULL,
    DE_VACACIONES BIT(1) NULL,
    PRIMARY KEY (MATRICULA)
);

CREATE TABLE tb_producto(
	CODIGO VARCHAR(10) NOT NULL,
    DESCCRIPCION VARCHAR(100) NULL,
    SABOR VARCHAR(50) NULL,
    TAMANO VARCHAR(50) NULL,
    ENVASE VARCHAR(50) NULL,
    PRECIO_LISTA FLOAT NULL,
    PRIMARY KEY (CODIGO)
    
);

DROP TABLE facturas;


/*---------------------------------------------------------*/
CREATE TABLE tb_venta(
	NUMERO VARCHAR(5) NOT NULL,
    FECHA DATE NULL,
    DNI VARCHAR(11) NOT NULL,
    MATRICULA VARCHAR(5) NOT NULL,
    IMPUESTO FLOAT,
    PRIMARY KEY(NUMERO)
);

ALTER TABLE tb_venta ADD CONSTRAINT FK_CLIENTE
FOREIGN KEY (DNI) REFERENCES tb_cliente(DNI);

ALTER TABLE tb_venta ADD CONSTRAINT FK_VENDENDOR
FOREIGN KEY (MATRICULA) REFERENCES tb_vendedor(MATRICULA);

/*--------------------------------------------------------------*/

ALTER TABLE tb_venta RENAME tb_factura;

/*---------------------------------------------------------------*/

CREATE TABLE tb_items_facturas(
	NUMERO VARCHAR(5) NOT NULL,
    CODIGO VARCHAR(10)NOT NULL,
    CANTIDAD INT,
    PRECIO FLOAT,
    PRIMARY KEY (NUMERO, CODIGO)
);

ALTER TABLE tb_items_facturas ADD CONSTRAINT FK_FACTURA
FOREIGN KEY (NUMERO) REFERENCES tb_factura(NUMERO);

ALTER TABLE tb_items_facturas ADD CONSTRAINT FK_PRODUCTO
FOREIGN KEY (CODIGO) REFERENCES tb_producto(CODIGO);

/*---------------------------------------------------------------------*/

INSERT INTO tb_producto(CODIGO, DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_LISTA) 
VALUES (
	"1050107", "Light", "Sandia", "350 ml", "Lata", 4.56
);

SELECT * FROM tb_producto;

INSERT INTO tb_producto(CODIGO, DESCRIPCION, SABOR, TAMANO,  PRECIO_LISTA, ENVASE) 
VALUES (
	"1050108", "Light", "Guanabana", "350 ml", 4.00, "Lata"
);

INSERT INTO tb_producto 
VALUES 
	("1050109", "Light", "Asaí", "350 ml", "Lata", 5.60), 
	("1050110", "Light", "Manzana", "350 ml", "Lata", 6.00),
	("1050111", "Light", "Mango", "350 ml", "Lata", 5.20);
    
/*----------------------------------------------------------------------------------*/

SELECT * FROM  jugos_ventas.tabla_de_productos;

SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA
FROM jugos_ventas.tabla_de_productos 
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

INSERT INTO tb_producto SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA
FROM jugos_ventas.tabla_de_productos 
WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

SELECT * FROM tb_producto;

/*---------------------------------------------------------------------------------------------*/

SELECT * FROM tb_cliente;

SELECT * FROM jugos_ventas.tabla_de_clientes;

SELECT DNI, NOMBRE, DIRECCION_1 AS DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_DE_NACIMIENTO AS FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUMEN_DE_COMPRA AS VOLUMEN_COMPRA, PRIMERA_COMPRA
FROM jugos_ventas.tabla_de_clientes WHERE DNI NOT IN (SELECT DNI FROM tb_cliente);

INSERT INTO tb_cliente SELECT DNI, NOMBRE, DIRECCION_1 AS DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_DE_NACIMIENTO AS FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUMEN_DE_COMPRA AS VOLUMEN_COMPRA, PRIMERA_COMPRA
FROM jugos_ventas.tabla_de_clientes WHERE DNI NOT IN (SELECT DNI FROM tb_cliente);

SELECT * FROM tb_vendedor
/*-------------------------------------------------------------------------------------------------------------*/