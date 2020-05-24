-- @LOGS

-- PRODUTO - CARRINHO LOGS
SELECT * FROM ProdutoCarrinhoLogs;

DELETE FROM
	ProdutoCarrinho
WHERE
	id_produto = 1234 AND id_carrinho = 1;

SELECT * FROM ProdutoCarrinhoLogs;
	