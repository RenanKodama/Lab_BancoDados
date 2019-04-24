/* 
  Universidade Federal do Paraná
  Renan Kodama Rodrigues 1602098
  Laboratorio de Banco de Dados

  Problema 03
*/

DROP TABLE IF EXISTS no_inscreve CASCADE;
DROP TABLE IF EXISTS inscreve CASCADE;
DROP TABLE IF EXISTS alunos CASCADE;
DROP TABLE IF EXISTS nalunos CASCADE;
DROP TABLE IF EXISTS palestra CASCADE;
DROP TABLE IF EXISTS palestrante CASCADE;
DROP VIEW IF EXISTS listagens;

/*Criando Tabelas*/
	CREATE TABLE alunos(
		ra 	VARCHAR(100) NOT NULL,
		nome 	VARCHAR(100) NOT NULL,
		PRIMARY KEY(ra));

	CREATE TABLE nalunos(
		nome 		VARCHAR(100) NOT NULL,
		rg		VARCHAR(100) NOT NULL,
		orgaoExp 	VARCHAR(100) NOT NULL,
		PRIMARY KEY(rg, orgaoExp));

	CREATE TABLE palestrante(
		nome	VARCHAR(100),
		dados	VARCHAR(100),
		PRIMARY KEY(nome));

	CREATE TABLE palestra(
		dadosPalestrante	VARCHAR(100),
		titulo			VARCHAR(100),
		resumo	 		VARCHAR(500),
		nome			VARCHAR(100),
		tempoDuracao		TIME,
		PRIMARY KEY(titulo),

		FOREIGN KEY(nome) REFERENCES palestrante(nome));

	CREATE TABLE inscreve(
		ra 	VARCHAR(100),
		titulo	VARCHAR(100),
		PRIMARY KEY(ra, titulo),

		FOREIGN KEY(ra) REFERENCES alunos(ra) ON DELETE CASCADE,
		FOREIGN KEY(titulo) REFERENCES palestra(titulo) ON DELETE CASCADE);

	CREATE TABLE no_inscreve(
		rg		VARCHAR(100),
		orgaoExp	VARCHAR(100),
		titulo		VARCHAR(100),
		PRIMARY KEY(rg, orgaoExp, titulo),
		
		FOREIGN KEY(rg, orgaoExp) REFERENCES nalunos ON DELETE CASCADE,
		FOREIGN KEY(titulo) REFERENCES palestra(titulo) ON DELETE CASCADE);


/*Inserindo Valores*/
	INSERT INTO alunos(ra, nome)
		VALUES ('1602098', 'Renan Kodama Rodrigues');
	INSERT INTO alunos(ra, nome)
		VALUES ('1602099', 'Jesus Jeová Messias');
	INSERT INTO alunos(ra, nome)
		VALUES ('1602100', 'Lucifer Luz Baphomet');

	
	INSERT INTO nalunos(rg, nome, orgaoExp)
		VALUES ('66666666', 'Lilith Old Eva', 'SHELL');
	INSERT INTO nalunos(rg, nome, orgaoExp)
		VALUES ('66666667', 'Gabriel Arcanjo', 'SHEAV');
	INSERT INTO nalunos(rg, nome, orgaoExp)
		VALUES ('66666668', 'Mortal Burro', 'STERR');


	INSERT INTO palestrante(nome, dados)
		VALUES ('Palestrante01', 'nada a declarar');
	INSERT INTO palestrante(nome, dados)
		VALUES ('Palestrante02', 'nada a declarar');
	INSERT INTO palestrante(nome, dados)
		VALUES ('Palestrante03', 'nada a declarar');


	INSERT INTO palestra(dadosPalestrante, titulo, resumo, nome, tempoDuracao)
		VALUES('nada a declarar', 'Como Dominar o Mundo', 'Começo meio e Fim', 'Palestrante02', '1:30:00');
	INSERT INTO palestra(dadosPalestrante, titulo, resumo, nome, tempoDuracao)
		VALUES('nada a declarar', 'Algum Titulo Legal', 'Começo meio e Fim', 'Palestrante03', '2:30:00');
	INSERT INTO palestra(dadosPalestrante, titulo, resumo, nome, tempoDuracao)
		VALUES('nada a declarar', 'Algum Titulo Ruim', 'Começo meio e Fim', 'Palestrante01', '3:30:00');
	INSERT INTO palestra(dadosPalestrante, titulo, resumo, nome, tempoDuracao)
		VALUES('nada a declarar', 'Paz', 'Começo meio e Fim', 'Palestrante02', '1:30:00');


	INSERT INTO inscreve(ra, titulo)
		VALUES('1602098','Como Dominar o Mundo');
	INSERT INTO inscreve(ra, titulo)
		VALUES('1602099','Como Dominar o Mundo');
	INSERT INTO inscreve(ra, titulo)
		VALUES('1602100','Como Dominar o Mundo');

	INSERT INTO no_inscreve(rg, orgaoExp, titulo)
		VALUES('66666666', 'SHELL', 'Como Dominar o Mundo');
	INSERT INTO no_inscreve(rg, orgaoExp, titulo)
		VALUES('66666667', 'SHEAV', 'Como Dominar o Mundo');

		
	INSERT INTO inscreve(ra, titulo)
		VALUES('1602098','Paz');
		
	INSERT INTO no_inscreve(rg, orgaoExp, titulo)
		VALUES('66666668', 'STERR', 'Paz');

	
	INSERT INTO inscreve(ra, titulo)
		VALUES('1602098','Algum Titulo Legal');
	INSERT INTO no_inscreve(rg, orgaoExp, titulo)
		VALUES('66666668', 'STERR', 'Algum Titulo Ruim');

/*VENDO VALORES*/
	SELECT * FROM alunos;
	SELECT * FROM nalunos;
	SELECT * FROM palestrante;
	SELECT * FROM palestra;	
	SELECT * FROM inscreve;
	SELECT * FROM no_inscreve;

/*CRIANDO VIEWS*/
	CREATE OR REPLACE VIEW listagens AS(
		SELECT concat(A.nome, ' ', A.ra) AS documento, Titulo AS Palestra FROM alunos AS A
		NATURAL JOIN inscreve

		UNION 

		SELECT concat(NA.nome, ' ', NA.rg, '/', NA.orgaoExp) AS documento, Titulo AS Palestra FROM nalunos AS NA
		NATURAL JOIN no_inscreve

		ORDER BY documento
	);

	SELECT * FROM listagens;



	




