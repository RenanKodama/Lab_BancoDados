/* 
  Universidade Federal do Paraná
  Renan Kodama Rodrigues 1602098
  Laboratorio de Banco de Dados

  Problema 04
*/

/*Deletando Tabelas*/
DROP TABLE IF EXISTS Cliente CASCADE;
DROP TABLE IF EXISTS Pedido CASCADE;
DROP TABLE IF EXISTS Fornecedor CASCADE;
DROP TABLE IF EXISTS Produto CASCADE;
DROP TABLE IF EXISTS Fornecedor_Produto CASCADE;
DROP TABLE IF EXISTS Pedidos_Tem_Produtos CASCADE;
DROP FUNCTION valortotal_pedido;

/*Criando Tabelas*/
CREATE TABLE Cliente(
	num_cliente 	INTEGER NOT NULL,
	nome			VARCHAR(100) NOT NULL,		
	endereco		VARCHAR(100),
	num_telefone	VARCHAR(100),
	pais			VARCHAR(100),
	
	PRIMARY KEY(num_cliente));


CREATE TABLE Pedido(
	num_pedido 		INTEGER NOT NULL,
	num_cliente		INTEGER NOT NULL,

	PRIMARY KEY(num_pedido, num_cliente),
	FOREIGN KEY(num_cliente) REFERENCES Cliente(num_cliente) ON DELETE CASCADE);


CREATE TABLE Fornecedor(
	num_fornecedor		INTEGER NOT NULL,
	nome 				VARCHAR(100),
	endereco			VARCHAR(100),
	num_telefone		VARCHAR(100),
	pais				VARCHAR(100),
	
	PRIMARY KEY(num_fornecedor));


CREATE TABLE Produto(
	id_produto			INTEGER NOT NULL,
	marca				VARCHAR(100),
	tamanho				VARCHAR(100),

	PRIMARY KEY(id_produto));


CREATE TABLE Fornecedor_Produto(
	num_fornecedor		INTEGER NOT NULL,
	id_produto			INTEGER NOT NULL,

	PRIMARY KEY(num_fornecedor, id_produto),
	FOREIGN KEY(num_fornecedor) REFERENCES Fornecedor(num_fornecedor) ON DELETE CASCADE,
	FOREIGN KEY(id_produto) REFERENCES Produto(id_produto) ON DELETE CASCADE);


CREATE TABLE Pedidos_Tem_Produtos(
	num_pedido			INTEGER NOT NULL,
	num_cliente			INTEGER NOT NULL,
	num_fornecedor		INTEGER NOT NULL,
	id_produto			INTEGER NOT NULL,
	data_pedido			VARCHAR(100),
	quantidade			INTEGER,
	preco 				REAL,
	subTotal			REAL,
   	 
	PRIMARY KEY(num_pedido, num_fornecedor, id_produto, num_cliente),
	FOREIGN KEY(num_pedido, num_cliente) REFERENCES Pedido(num_pedido, num_cliente),
	FOREIGN KEY(num_fornecedor, id_produto) REFERENCES Fornecedor_Produto(num_fornecedor, id_produto));


/*Populando Tabelas*/
INSERT INTO Cliente(num_cliente, nome, endereco, num_telefone, pais)
		VALUES(1602098, 'Renan Kodama Rodrigues', 'Campo Mourão', '3322-7630', 'Brasil');

INSERT INTO Pedido(num_pedido, num_cliente)
		VALUES(2098, 1602098);

INSERT INTO Fornecedor(num_fornecedor, nome, endereco, num_telefone, pais)
		VALUES(7777, 'Jesus Cristo', 'Heaven', '777-777', 'Depois Da Morte');
INSERT INTO Fornecedor(num_fornecedor, nome, endereco, num_telefone, pais)
		VALUES(6666, 'Lucifer StarLight', 'Hell', '666-666', 'Depois Da Morte');

INSERT INTO Produto(id_produto, marca, tamanho)
		VALUES(77, 'Pão Centeio', '7');		
INSERT INTO Produto(id_produto, marca, tamanho)
		VALUES(66, 'Cachaça', '6');

INSERT INTO Fornecedor_Produto(num_fornecedor, id_produto)
		VALUES(7777, 77);
INSERT INTO Fornecedor_Produto(num_fornecedor, id_produto)
		VALUES(7777, 66);
INSERT INTO Fornecedor_Produto(num_fornecedor, id_produto)
		VALUES(6666, 66);

INSERT INTO Pedidos_Tem_Produtos(num_pedido, num_cliente, num_fornecedor, id_produto, data_pedido, quantidade, preco)
		VALUES(2098, 1602098, 7777, 77, '10-04-2019', 7, 2);
INSERT INTO Pedidos_Tem_Produtos(num_pedido, num_cliente, num_fornecedor, id_produto, data_pedido, quantidade, preco)
		VALUES(2098, 1602098, 6666, 66, '10-04-2019', 6, 2);


/*Procedimentos*/
CREATE OR REPLACE FUNCTION valorTotal_Pedido (id_cliente IN INTEGER, num_pedido1 IN INTEGER)
RETURNS REAL AS
$BODY$																																																																																																																																																																																																																	
DECLARE
	precoTotal REAL;
BEGIN 
	IF EXISTS (SELECT PTP.num_pedido FROM Pedidos_Tem_Produtos AS PTP WHERE PTP.num_pedido = num_pedido1) THEN
		SELECT SUM(PTP.preco*PTP.quantidade) INTO precoTotal FROM Pedidos_Tem_Produtos AS PTP
		WHERE PTP.num_cliente = id_cliente AND 
			PTP.num_pedido = num_pedido1;
		
		RETURN precoTotal;
	ELSE
		RETURN -1;
	END IF;

	/*Solução do prof. André*/
	/*SELECT SUM(PTP.preco) INTO precoTotal FROM Pedidos_Tem_Produtos AS PTP
	WHERE PTP.num_cliente = id_cliente AND 
	      PTP.num_pedido = num_pedido1;																																			

	IF precoTotal > 0 THEN
		RETURN precoTotal;
	ELSE
		RETURN -1;
	END IF;*/
END;
$BODY$
LANGUAGE plpgsql;

/*
CREATE OR REPLACE TRIGGER trigger_LucroAnual
	AFTER 
		INSERT OR 
		UPDATE 
	ON Pedidos_Tem_Produtos 
BEGIN
	CASE
		WHEN INSERTING THEN
			Pedidos_Tem_Produtos.subTotal = old
*/ 

/*Chamando Funções e Triggers*/
SELECT valorTotal_Pedido(1602098, 2098);

