-- @CLASSES

-- VISITANTE
DROP TABLE IF EXISTS Visitante;
CREATE TABLE Visitante (
    endereco_IP INT NOT NULL PRIMARY KEY,
    localizacao VARCHAR(255),
    data_entrada DATETIME,
    tempo_visita INT
);

-- UTILIZADOR
DROP TABLE IF EXISTS Utilizador;
CREATE TABLE Utilizador (
    id_utilizador BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255), 
    nome_proprio VARCHAR(255),
    sobrenome VARCHAR(255),
    nif INT,
    morada VARCHAR(255) UNIQUE,
    cod_postal CHAR(10),
    data_nasc DATE,
    genero CHAR(20),
    endereco_IP INT FOREIGN KEY REFERENCES Visitante(endereco_IP)
);

-- ADMINISTRADOR
DROP TABLE IF EXISTS Administrador;
CREATE TABLE Administrador (
    id_utilizador BIGINT FOREIGN KEY REFERENCES Utilizador(id_utilizador),
	PRIMARY KEY (id_utilizador)
);

-- CARRINHO
DROP TABLE IF EXISTS Carrinho;
CREATE TABLE Carrinho (
    id_carrinho BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    id_utilizador BIGINT FOREIGN KEY REFERENCES Utilizador(id_utilizador)
);

-- PRODUTO
DROP TABLE IF EXISTS Produto;
CREATE TABLE Produto (
    id_produto BIGINT NOT NULL PRIMARY KEY,
    categoria VARCHAR(255),
    nome VARCHAR(255),
    descricao TEXT,
    stock INT,
    img VARCHAR(255), 
    preco FLOAT(6,2) CHECK (preco > 0),
    rating FLOAT(2,1)
);

-- RATING
DROP TABLE IF EXISTS Rating;
CREATE TABLE Rating (
    id_rating BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    valor INT CHECK (valor >= 0 AND valor <= 5),
    id_utilizador BIGINT FOREIGN KEY REFERENCES Utilizador(id_utilizador),
    id_produto BIGINT FOREIGN KEY REFERENCES Produto(id_produto)
);

-- FATURA
DROP TABLE IF EXISTS Fatura;
CREATE TABLE Fatura (
    id_fatura BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    pagamento VARCHAR(255),
    total FLOAT(10,2),
    data_emissao DATE,
    id_utilizador BIGINT FOREIGN KEY REFERENCES Utilizador(id_utilizador)
);

-- ENCOMENDA
DROP TABLE IF EXISTS Encomenda;
CREATE TABLE Encomenda (
    id_encomenda BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    portes FLOAT(5,2),
    estado TINYINT CHECK (estado > 0 AND estado <= 5), 
    data_envio DATE,
    data_entrega DATE CHECK(data_envio < data_entrega),
    id_fatura BIGINT FOREIGN KEY REFERENCES Fatura(id_fatura)
);

-- PAGAMENTO
DROP TABLE IF EXISTS Pagamento; 
CREATE TABLE Pagamento (
    id_pagamento BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    tipo_de_pagamento VARCHAR(255), 
    atual BOOLEAN
);

-- PAYPAL
DROP TABLE IF EXISTS PayPal;
CREATE TABLE PayPal (
	id_paypal BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_pagamento BIGINT FOREIGN KEY REFERENCES Pagamento(id_pagamento),
    nome VARCHAR(255)
);

-- CARTAODECREDITO
DROP TABLE IF EXISTS CartaoDeCredito;
CREATE TABLE CartaodeCredito (
	id_cartao_credito BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    tipo VARCHAR(255),
    data_validade DATE,
    numero BIGINT,
    iban BIGINT,
    cod TINYINT,
	id_pagamento BIGINT FOREIGN KEY REFERENCES Pagamento(id_pagamento)
);

-- @ASSOCIAÇÕES

-- PRODUTO - ENCOMENDA
DROP TABLE IF EXISTS ProdutoEncomenda;
CREATE TABLE ProdutoEncomenda (
    id_encomenda BIGINT FOREIGN KEY REFERENCES Encomenda(id_encomenda),
    id_produto BIGINT FOREIGN KEY REFERENCES Produto(id_produto),
    quantidade INT,
    PRIMARY KEY (id_encomenda, id_produto)
);

-- PRODUTO - CARRINHO
DROP TABLE IF EXISTS ProdutoCarrinho;
CREATE TABLE ProdutoCarrinho (
    id_produto BIGINT FOREIGN KEY REFERENCES Produto(id_produto),
    id_carrinho BIGINT FOREIGN KEY REFERENCES Carrinho(id_carrinho),
    PRIMARY KEY (id_produto, id_carrinho)
);