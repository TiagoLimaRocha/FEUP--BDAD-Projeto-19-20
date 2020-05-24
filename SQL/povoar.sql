PRAGMA	foreign_keys = ON;

-- @Visitante
/*
 * No mundo real, para simular um endereço de IP verdadeiro,
 * seria assim uma possível maneira correta de o fazer (em SQL SERVER):
 
DECLARE @i INT = 0;
WHILE @i < 100
BEGIN
	INSERT INTO  Visitante (endereco_ip, localizacao, data_entrada, tempo_visita) 
		VALUES (STR(RAND()*(255-0))+"."+STR(RAND()*(99-0))+"."+STR(RAND()*(255-0))+".1",
				"Lisboa, Portugal",
				2020-11-11 13:23:44,
				90);
	
	SET @i = @i + 1;
END;


 * Ou em MySQL com for loop:
DROP PROCEDURE IF EXISTS load_visitante_test_data;

DELIMITER #
CREATE PROCEDURE load_visitante_test_data()

	BEGIN
		DECLARE i INT DEFAULT 0;
		for: LOOP
			SET i=i+1;
			INSERT INTO  Visitante (endereco_ip, localizacao, data_entrada, tempo_visita) 
				VALUES (STR(RAND()*(255-0))+"."+STR(RAND()*(99-0))+"."+STR(RAND()*(255-0))+".1",
						"Lisboa, Portugal",
						2020-11-11 13:23:44,
						90);
			ITERATE for;
			IF i > 100
				LEAVE for
			END IF
	END LOOP;
END #

 * Ou em MySQL com while loop:
DROP PROCEDURE IF EXISTS load_visitante_test_data;

DELIMITER #
CREATE PROCEDURE load_visitante_test_data()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i < 100 DO
		SET i=i+1;
		INSERT INTO  Visitante (endereco_ip, localizacao, data_entrada, tempo_visita) 
			VALUES (STR(RAND()*(255-0))+"."+STR(RAND()*(99-0))+"."+STR(RAND()*(255-0))+".1",
					"Lisboa, Portugal",
					2020-11-11 13:23:44,
					90);
	END WHILE;
END #
	
 */

-- Contudo, aqui iremos simplificar e usar como endereço 
-- de IP números inteiros positivos;
-- em SQL lite usando common table expressions recursivas (rcte) fica: 

WITH RECURSIVE
  	FOR(ip, loc, dat, tem) AS (VALUES(254122341, "Lisboa, Portugal", CURRENT_TIMESTAMP, 90) 
		UNION ALL 
	SELECT ip+1, loc, dat, tem FROM FOR WHERE ip < 254122441)
INSERT INTO Visitante SELECT * FROM FOR;
 

-- @Utilizador 
INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(1, "user_1", "!pwd1", "email1@example.com", "first name 1", "last name 1", 111111111, 
								 "address 1", "1111-111", "1999-12-20", 1, 254122341);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(1, "user_2", "!pwd2", "email1@example.com", "first name 1", "last name 1", 222222222, 
								 "address 2", "1111-111", "1999-12-20", 0, 254122342);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(1, "user_3", "!pwd3", "email1@example.com", "first name 2", "last name 1", 333333333, 
								 "address 3", "1111-111", "1999-12-20", 1, 254122343);								 

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_4", "!pwd4", "email1@example.com", "first name 3", "last name 1", 444444444, 
								 "address 4", "1111-111", "1999-12-20", 0, 254122344);	

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_5", "!pwd5", "email1@example.com", "first name 4", "last name 1", 555555555, 
								 "address 5", "1111-111", "1999-12-20", 0, 254122345);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_6", "!pwd6", "email1@example.com", "first name 5", "last name 1", 666666666, 
								 "address 6", "1111-111", "1999-12-20", 1, 254122346);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_7", "!pwd7", "email1@example.com", "first name 6", "last name 1", 777777777, 
								 "address 7", "1111-111", "1999-12-20", 1, 254122347);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_8", "!pwd8", "email1@example.com", "first name 7", "last name 1", 888888888, 
								 "address 8", "1111-111", "1999-12-20", 1, 254122348);

INSERT INTO Utilizador (estado, username, password, email, nome_proprio, sobrenome, nif, morada, cod_postal, data_nasc, genero, endereco_ip) 
	VALUES(2, "user_9", "!pwd9", "email1@example.com", "first name 8", "last name 1", 999999999, 
								 "address 9", "1111-111", "1999-12-20", 0, 254122349);								 


-- @Administrador
INSERT INTO Administrador(id_utilizador) VALUES (1);


-- @Pagamento
-- Utilizador 1
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (1, "PayPal", 1);
INSERT INTO PayPal(id_pagamento, nome) VALUES (1, "PayPal Utilizador 1");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (1, "Cartão de Crédito", 0);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (2, "Visa", "2022-12-12", "1111 1111 1111 1111", 111);

-- Utilizador 2
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (2, "PayPal", 1);
INSERT INTO PayPal(id_pagamento, nome) VALUES (3, "PayPal Utilizador 2");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (2, "Cartão de Crédito", 0);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (4, "Visa", "2022-12-12", "2222 2222 2222 2222", 222);

-- Utilizador 3
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (3, "PayPal", 0);
INSERT INTO PayPal(id_pagamento, nome) VALUES (5, "PayPal Utilizador 3");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (3, "Cartão de Crédito", 1);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (6, "MasterCard", "2022-12-12", "3333 3333 3333 3333", 333);

-- Utilizador 4
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (4, "PayPal", 0);
INSERT INTO PayPal(id_pagamento, nome) VALUES (7, "PayPal Utilizador 4");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (4, "Cartão de Crédito", 1);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (8, "Maestro", "2022-12-12", "4444 4444 4444 4444", 444);

-- Utilizador 5
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (5, "PayPal", 0);
INSERT INTO PayPal(id_pagamento, nome) VALUES (9, "PayPal Utilizador 5");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (5, "Cartão de Crédito", 1);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (10, "Visa", "2022-12-12", "5555 5555 5555 5555", 555);

-- Utilizador 6
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (6, "PayPal", 1);
INSERT INTO PayPal(id_pagamento, nome) VALUES (11, "PayPal Utilizador 6");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (6, "Cartão de Crédito", 0);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (12, "MasterCard", "2022-12-12", "6666 6666 6666 6666", 666);

-- Utilizador 7
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (7, "PayPal", 0);
INSERT INTO PayPal(id_pagamento, nome) VALUES (13, "PayPal Utilizador 7");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (7, "Cartão de Crédito", 1);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (14, "Visa", "2022-12-12", "7777 7777 7777 7777", 777);
	
-- Utilizador 8
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (8, "PayPal", 0);
INSERT INTO PayPal(id_pagamento, nome) VALUES (15, "PayPal Utilizador 8");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (8, "Cartão de Crédito", 1);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (16, "Visa", "2022-12-12", "8888 8888 8888 8888", 888);
	
-- Utilizador 9
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (9, "PayPal", 1);
INSERT INTO PayPal(id_pagamento, nome) VALUES (17, "PayPal Utilizador 9");
INSERT INTO Pagamento(id_utilizador, tipo_pagamento, atual) VALUES (9, "Cartão de Crédito", 0);
INSERT INTO CartaoDeCredito(id_pagamento, tipo, data_validade, numero, cod)
	VALUES (18, "Maestro", "2022-12-12", "9999 9999 9999 9999", 998);


-- @Produto 
WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(1234, "Informatica, Portáteis, Tablets", "Produto Informática", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 99.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 1334)
INSERT INTO Produto SELECT * FROM FOR;	

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(2234, "Fotografia, Video, Lab Foto", "Produto Fotografia", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 199.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 2334)
INSERT INTO Produto SELECT * FROM FOR;	

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(3234, "Smartphones e Conectáveis", "Produto Smartphones", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 299.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 3334)
INSERT INTO Produto SELECT * FROM FOR;	

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(4234, "TV e Home Cinema", "Produto TV", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 699.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 4334)
INSERT INTO Produto SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(5234, "Música, CDs, Vinil", "Produto Música", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 25.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 5334)
INSERT INTO Produto SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(6234, "Gaming, Jogos, Consolas", "Produto Gaming", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 59.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 6334)
INSERT INTO Produto SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_produto, categoria, nome, descricao, stock, img, preco, rating) AS (
		VALUES(7234, "Som, Colunas, Auscultadores", "Produto Gaming", 
			   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ullamcorper vel augue ac efficitur. Quisque efficitur volutpat mollis. Curabitur justo magna, pharetra ut vulputate et, dapibus non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec bibendum nisl nec nibh commodo pulvinar. Duis id magna sollicitudin, mollis elit ut, hendrerit velit. Morbi et fermentum mi, dignissim posuere orci. Mauris quis posuere nunc.",
			   100, "img/some_image.png", 149.99, 0)
		UNION ALL
	SELECT id_produto+1, categoria, nome, descricao, stock, img, preco, rating FROM FOR WHERE id_produto < 7334)
INSERT INTO Produto SELECT * FROM FOR;


-- @Rating
-- User 1
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1, 1, 1234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 100 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(101, 1, 2234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 200 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(201, 1, 3234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 300 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(301, 1, 4234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 400 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(401, 1, 5234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 500 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(501, 1, 6234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 600 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(601, 1, 7234, 4)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 700 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 2
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(701, 2, 1234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 800 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(801, 2, 2234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 900 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(901, 2, 3234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1000 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1001, 2, 4234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1100 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1101, 2, 5234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1200 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1201, 2, 6234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1300 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1301, 2, 7234, 4.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1400 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 3
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1401, 3, 1234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1500 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1501, 3, 2234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1600 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1701, 3, 3234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1800 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1801, 3, 4234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 1900 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(1901, 3, 5234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2000 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2001, 3, 6234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2100 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2101, 3, 7234, 3.6)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2200 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 4
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2201, 4, 1234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2300 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2301, 4, 2234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2400 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2401, 4, 3234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2500 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2501, 4, 4234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2600 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2601, 4, 5234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2700 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2701, 4, 6234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2800 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2801, 4, 7234, 3.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 2900 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 5
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(2901, 5, 1234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3000 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3001, 5, 2234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3100 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3101, 5, 3234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3200 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3201, 5, 4234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3300 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3301, 5, 5234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3400 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3401, 5, 6234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3500 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3501, 5, 7234, 5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3600 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 6
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3601, 6, 1234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3700 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3701, 6, 2234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3800 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3801, 6, 3234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 3900 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(3901, 6, 4234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4000 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4001, 6, 5234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4100 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4101, 6, 6234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4200 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4201, 6, 7234, 4.3)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4300 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 7
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4301, 7, 1234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4400 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4401, 7, 2234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4500 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4501, 7, 3234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4600 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4601, 7, 4234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4700 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4701, 7, 5234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4800 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4801 ,7, 6234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 4900 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(4901, 7, 7234, 2.7)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5000 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 8
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5001, 8, 1234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5100 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5101, 8, 2234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5200 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5201, 8, 3234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5300 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5301, 8, 4234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5400 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5401, 8, 5234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5500 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5501, 8, 6234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5600 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5601, 8, 7234, 4.1)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5700 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;

-- User 9
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5701, 9, 1234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5800 AND id_p < 1334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5801, 9, 2234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 5900 AND id_p < 2334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(5901, 9, 3234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 6000 AND id_p < 3334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(6001, 9, 4234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 6100 AND id_p < 4334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(6101, 9, 5234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 6200 AND id_p < 5334)
INSERT INTO Rating SELECT * FROM FOR;

WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(6201, 9, 6234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 6300 AND id_p < 6334)
INSERT INTO Rating SELECT * FROM FOR;
	
WITH RECURSIVE 
	FOR (id_r, id_u, id_p, val) AS (VALUES(6301, 9, 7234, 3.5)
		UNION ALL
	SELECT id_r+1, id_u, id_p+1, val FROM FOR WHERE id_r < 6400 AND id_p < 7334)
INSERT INTO Rating SELECT * FROM FOR;


-- UPDATE Rating @Produto
-- Como, neste caso, cada utilizador deu o mesmo rating a todos os produtos 
-- e são muitas as entradas na tabelas Rating e Produtos, podemos usar rcte para atribuir
-- a todas as entradas da tabela Produto o valor médio do seu respetivo rating
WITH RECURSIVE 
	FOR (id_p, val) AS (VALUES(1234, (SELECT AVG(valor) FROM Rating WHERE id_produto = 1234))
		UNION ALL
	SELECT id_p+1, val FROM FOR WHERE id_p < 7334)
UPDATE Produto SET rating = (SELECT val FROM FOR);

/*
 * Caso contrário teria de ser feito produto a produto desta forma: 
 
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 1234) WHERE id_produto = 1234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 2234) WHERE id_produto = 2234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 3234) WHERE id_produto = 3234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 4234) WHERE id_produto = 4234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 5234) WHERE id_produto = 5234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 6234) WHERE id_produto = 6234;
UPDATE Produto SET rating=(SELECT AVG(valor) FROM Rating WHERE id_produto = 7234) WHERE id_produto = 7234;
*/

-- @ProdutoCarrinho

INSERT INTO ProdutoCarrinho(id_carrinho, id_produto, quantidade) 
	VALUES 
		(1, 1234, 1),
		(1, 2292, 1),
		(1, 3236, 1);
		
INSERT INTO ProdutoCarrinho(id_carrinho, id_produto, quantidade) 
	VALUES 
		(2, 3250, 1),
		(2, 4264, 1),
		(2, 5288, 1),
		(2, 5289, 1);

INSERT INTO ProdutoCarrinho(id_carrinho, id_produto, quantidade) 
	VALUES 
		(3, 6331, 2),
		(3, 6332, 3);
		
		
-- @Fatura
INSERT INTO Fatura(total, data_emissao, id_utilizador) 
	VALUES((SELECT SUM(preco) 
				FROM Produto 
					WHERE id_produto = 3236 
						OR id_produto = 1234 
						OR id_produto = 2292), 
		   CURRENT_DATE, 
		   1);
		   
INSERT INTO Fatura(total, data_emissao, id_utilizador) 
	VALUES((SELECT SUM(preco) 
				FROM Produto 
					WHERE id_produto = 3250 
						OR id_produto = 4264 
						OR id_produto = 5288
						OR id_produto = 5289), 
		   CURRENT_DATE,
		   2);
		   
INSERT INTO Fatura(total, data_emissao, id_utilizador) 
	VALUES((SELECT preco FROM Produto WHERE id_produto = 6331)*2 
			+
		   (SELECT preco FROM Produto WHERE id_produto = 6332)*3, 
		   CURRENT_DATE,
		   3);


-- @Encomenda
INSERT INTO 
	Encomenda(
		portes, 
		estado, 
		data_envio, 
		data_entrega, 
		id_fatura
	) 
	VALUES (
		0, 
		1, 
		CURRENT_DATE, 
		DATE("now", "+15 days"), 
		1
	);
		
INSERT INTO 
	Encomenda(
		portes, 
		estado, 
		data_envio, 
		data_entrega, 
		id_fatura
	) 
	VALUES(
		0, 
		1, 
		CURRENT_DATE, 
		DATE("now", "+15 days"), 
		2
	);
	
INSERT INTO 
	Encomenda(
		portes, 
		estado, 
		data_envio, 
		data_entrega, 
		id_fatura
	) 
	VALUES(
		0, 
		1, 
		CURRENT_DATE, 
		DATE("now", "+15 days"), 
		3
	);


-- @ProdutoEncomenda
INSERT INTO ProdutoEncomenda(id_encomenda, id_produto, quantidade) 
	VALUES
		(1, 1234, 1),
		(1, 2292, 1),
		(1, 3236, 1);
		
INSERT INTO ProdutoEncomenda(id_encomenda, id_produto, quantidade) 
	VALUES
		(2, 3250, 1),
		(2, 4264, 1),
		(2, 5288, 1),
		(2, 5289, 1);
		
INSERT INTO ProdutoEncomenda(id_encomenda, id_produto, quantidade) 
	VALUES
		(3, 6331, 2),
		(3, 6332, 3);
		
