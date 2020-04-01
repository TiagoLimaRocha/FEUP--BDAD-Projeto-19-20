DROP TABLE IF EXISTS Visitante;
DROP TABLE IF EXISTS Utilizador;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS Carrinho;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS Encomenda;
DROP TABLE IF EXISTS ProdutoEncomenda;
DROP TABLE IF EXISTS ProdutoCarrinho;
DROP TABLE IF EXISTS Fatura;
DROP TABLE IF EXISTS Pagamento;
DROP TABLE IF EXISTS PayPal;
DROP TABLE IF EXISTS CartaodeCredito;

CREATE TABLE Visitante (
    endereco_IP NUMBER PRIMARY KEY,
    localizacao TEXT,
    data DATE,
    tempo_visita NUMBER
);

CREATE TABLE Utilizador (
    id_utilizador INTEGER AUTOINCREMENT,
    username CHAR(30) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email TEXT, 
    nome_proprio CHAR(15),
    sobrenome CHAR(15),
    nif INTEGER,
    morada VARCHAR(255) UNIQUE,
    cod_postal,
    data_nasc DATE,
    genero CHAR(20),
    endereco_IP NUMBER REFERENCES Visitante(endereco_IP),
    PRIMARY KEY(id_utilizador, endereco_IP)
);

CREATE TABLE Administrador (
    id_utilizador INTEGER REFERENCES Utilizador(id_utilizador) PRIMARY KEY
);

CREATE TABLE Carrinho (
    id_carrinho INTEGER AUTOINCREMENT,
    data_inicio DATE,
    data_fim DATE,
    id_utilizador INTEGER REFERENCES Utilizador(id_utilizador),
    PRIMARY KEY (id_carrinho, id_utilizador)
);

CREATE TABLE Produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    categoria CHAR(30),
    nome CHAR(30),
    descricao VARCHAR(65535),
    stock INTEGER,
    img IMAGE, 
    preco FLOAT(6,2) CHECK(preco>0),
    rating FLOAT(2,1) --CHECK(rating >= 0 AND rating <= 5)
);

CREATE TABLE Rating (
    -- id_rating INTEGER AUTOINCREMENT,
    valor INTEGER CHECK (valor >= 0 AND valor <= 5),
    id_utilizador INTEGER REFERENCES Utilizador(id_utilizador),
    id_produto INTEGER REFERENCES Produto(id_produto),
    PRIMARY KEY (id_utilizador, id_produto)
);

CREATE TABLE Encomenda (
    id_encomenda INTEGER AUTOINCREMENT,
    portes FLOAT(5,2),
    estado DATETIME, --talvez?
    data_envio DATE,
    data_entrega DATE,
    CHECK (data_envio < data_entrega),
    id_fatura INTEGER REFERENCES Fatura(id_fatura),
    PRIMARY KEY (id_encomenda, id_fatura)
);

CREATE TABLE ProdutoEncomenda (
    id_encomenda INTEGER REFERENCES Encomenda(id_encomenda),
    id_produto INTEGER REFERENCES Produto(id_produto),
    quantidade INTEGER,
    PRIMARY KEY (id_encomenda, id_produto)
);

CREATE TABLE ProdutoCarrinho (
    id_produto INTEGER REFERENCES Produto(id_produto),
    id_carrinho INTEGER REFERENCES Carrinho(id_carrinho),
    PRIMARY KEY (id_produto, id_carrinho)
);

CREATE TABLE Fatura (
    id_fatura INTEGER AUTOINCREMENT,
    pagamento CHAR(20), --talvez?
    total FLOAT(10,2),
    data_emissao DATE,
    id_utilizador INTEGER REFERENCES Utilizador(id_utilizador),
    PRIMARY KEY (id_fatura, id_utilizador)
);

CREATE TABLE Pagamento (
    id_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_de_pagamento, --check how to do disjointed classes
    atual BOOLEAN
);

CREATE TABLE PayPal (
    nome
);

CREATE TABLE CartaodeCredito (
    tipo,
    data_validade,
    numero,
    iban,
    cod
);