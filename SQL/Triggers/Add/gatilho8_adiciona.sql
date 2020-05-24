-- @LOGS

-- PRODUTO - CARRINHO LOGS
DROP TRIGGER IF EXISTS log_produto_carrinho_apos_update;
CREATE TRIGGER IF NOT EXISTS log_produto_carrinho_apos_update 
	AFTER DELETE ON ProdutoCarrinho
BEGIN
	INSERT INTO ProdutoCarrinhoLogs (
		old_id_produto,
		old_id_carrinho,
		old_quantidade,
		data_remocao 
	)
	VALUES(
		OLD.id_produto,
		OLD.id_carrinho,
		OLD.quantidade,
		CURRENT_TIMESTAMP
	);
END;
	