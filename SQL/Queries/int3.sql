.mode columns
.headers on
.nullvalue NULL

-- Quais os produtos e respectiva categoria cujo preço é menor que 100

SELECT DISTINCT nome, categoria, preco, rating FROM Produto WHERE preco < 100;