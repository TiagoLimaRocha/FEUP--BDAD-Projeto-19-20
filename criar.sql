DROP TABLE IF EXISTS Visitante;
DROP TABLE IF EXISTS Utilizador;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS Carrinho;
DROP TABLE IF EXISTS Produto;

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
    stock INtEGER,
    img,
    preco FLOAT(4,2) CHECK(preco>0),
    rating INtEGER CHECK(rating >= 0 AND rating <= 5)
);