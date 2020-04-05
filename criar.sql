PRAGMA foreign_keys = OF;

BEGIN TRANSACTION;

-- @CLASSES

-- VISITANTE
DROP TABLE IF EXISTS Visitante;
CREATE TABLE Visitante (
    endereco_IP VARCHAR(255) PRIMARY KEY,
    localizacao VARCHAR(255),
    data_entrada DATETIME,
    tempo_visita INT CHECK(tempo_visita > 0)
);

-- UTILIZADOR
DROP TABLE IF EXISTS Utilizador;
CREATE TABLE Utilizador (
    id_utilizador INTEGER PRIMARY KEY AUTOINCREMENT,
	estado TINYINT CHECK (estado > 0 AND estado < 3),
    username VARCHAR(255), 
    password VARCHAR(255), 
    email VARCHAR(255), 
	nome_proprio VARCHAR(255),
    sobrenome VARCHAR(255),
    nif INT,
    morada VARCHAR(255) UNIQUE,
    cod_postal CHAR(10) CHECK (LENGTH(cod_postal) = 8),
    data_nasc DATE,
    genero BOOLEAN CHECK (genero = 0 OR genero = 1),
	endereco_IP INT,
    FOREIGN KEY (endereco_IP) REFERENCES Visitante(endereco_IP)
);

DROP TRIGGER IF EXISTS utilizador_validar_email;
CREATE TRIGGER utilizador_validar_email 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN NEW.email NOT LIKE '%_@__%.__%' 
			THEN RAISE (ABORT,'Invalid email address!')
      END;
END;

/* 
 * Por defeito o SQLite não providencia uma implementação para o comparador de 
 * expressões regulares REGEXP; isso é feito ao implementar a funcção nativa do SQL regexp(),
 * uma possível implementação em Java seria algo do género: 
	
	Function.create(connection, "REGEXP", new Function() {
	  @Override
	  protected void xFunc() throws SQLException {
		String expression = value_text(0);
		String value = value_text(1);
		if (value == null)
		  value = "";

		Pattern pattern=Pattern.compile(expression);
		result(pattern.matcher(value).find() ? 1 : 0);
	  }
	});

 * Admitindo que se criou essa implementação poder-se-ia utilizar os seguintes triggers
 * para validar o username e a password de cada utilizador:
 
DROP TRIGGER IF EXISTS utilizador_validar_username;
CREATE TRIGGER utilizador_validar_username 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN (SELECT username FROM Utilizador WHERE username REGEXP "^[-\w\.\$@\*\!]{1,30}$") > 0
			THEN RAISE (ABORT,'Invalid username!')
      END;
END;

DROP TRIGGER IF EXISTS utilizador_validar_password;
CREATE TRIGGER utilizador_validar_password 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN (SELECT password FROM Utilizador WHERE password REGEXP "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{16,}$") > 0
			THEN RAISE (ABORT,'Invalid password!')
      END;
END;
*/

-- ADMINISTRADOR
DROP TABLE IF EXISTS Administrador;
CREATE TABLE Administrador (
	id_utilizador INTEGER,
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
	PRIMARY KEY (id_utilizador)
);

-- CARRINHO
DROP TABLE IF EXISTS Carrinho;
CREATE TABLE Carrinho (
    id_carrinho INTEGER PRIMARY KEY AUTOINCREMENT,
	id_utilizador INTEGER,
    data_inicio DATE,
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);

-- PRODUTO
DROP TABLE IF EXISTS Produto;
CREATE TABLE Produto (
    id_produto INTEGER NOT NULL PRIMARY KEY,
    categoria VARCHAR(255),
    nome VARCHAR(255),
    descricao TEXT,
    stock INT,
    img VARCHAR(255), 
    preco FLOAT(6,2) CHECK (preco > 0),
    rating FLOAT(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5)
);

-- RATING
DROP TABLE IF EXISTS Rating;
CREATE TABLE Rating (
    id_rating INTEGER PRIMARY KEY AUTOINCREMENT,
	id_utilizador INTEGER,
	id_produto INTEGER,
    valor INT CHECK (valor >= 0 AND valor <= 5),
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- FATURA
DROP TABLE IF EXISTS Fatura;
CREATE TABLE Fatura (
    id_fatura INTEGER PRIMARY KEY AUTOINCREMENT,
    total FLOAT(10,2),
    data_emissao DATE,
	id_utilizador INTEGER,
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);

-- ENCOMENDA
DROP TABLE IF EXISTS Encomenda;
CREATE TABLE Encomenda (
    id_encomenda INTEGER PRIMARY KEY AUTOINCREMENT,
    portes FLOAT(5,2),
    estado TINYINT CHECK (estado > 0 AND estado <= 5), 
    data_envio DATE,
    data_entrega DATE CHECK(data_envio < data_entrega),
	id_fatura INTEGER,
    FOREIGN KEY (id_fatura) REFERENCES Fatura(id_fatura)
);

-- PAGAMENTO
DROP TABLE IF EXISTS Pagamento; 
CREATE TABLE Pagamento (
    id_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
	id_utilizador INTEGER,
    tipo_pagamento VARCHAR(255), 
    atual BOOLEAN,
	FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador)
);

-- PAYPAL
DROP TABLE IF EXISTS PayPal;
CREATE TABLE PayPal (
    id_pagamento INTEGER,
    nome VARCHAR(255),
	FOREIGN KEY (id_pagamento) REFERENCES Pagamento(id_pagamento),
	PRIMARY KEY (id_pagamento)
);

-- CARTAODECREDITO
DROP TABLE IF EXISTS CartaoDeCredito;
CREATE TABLE CartaodeCredito (
	id_pagamento INTEGER,
    tipo VARCHAR(255),
    data_validade DATE,
    numero VARCHAR(255) CHECK (LENGTH(numero) < 20),
    cod INT CHECK (cod < 999),
	FOREIGN KEY (id_pagamento) REFERENCES Pagamento(id_pagamento),
	PRIMARY KEY (id_pagamento)
);


-- @ASSOCIAÇÕES

-- PRODUTO - ENCOMENDA
DROP TABLE IF EXISTS ProdutoEncomenda;
CREATE TABLE ProdutoEncomenda (
	id_encomenda INTEGER,
	id_produto INTEGER,
    quantidade INT,
    FOREIGN KEY (id_encomenda) REFERENCES Encomenda(id_encomenda),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    PRIMARY KEY (id_encomenda, id_produto)
);

-- PRODUTO - CARRINHO
DROP TABLE IF EXISTS ProdutoCarrinho;
CREATE TABLE ProdutoCarrinho (
    id_produto INTEGER,
	id_carrinho INTEGER,
	quantidade INT,
	FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_carrinho) REFERENCES Carrinho(id_carrinho),
    PRIMARY KEY (id_produto, id_carrinho)
);

COMMIT TRANSACTION;
