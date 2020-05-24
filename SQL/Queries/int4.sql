.mode columns
.headers on
.nullvalue NULL

--Quais os produtos mais vendidos

SELECT nome FROM Produto, ProdutoCarrinho WHERE Produto.id_produto = ProdutoCarrinho.id_produto ORDER BY ProdutoCarrinho.quantidade DESC;