-- @FATURA

/*
 * Atualiza automaticamente o valor total a pagar na fatura sempre que é dada
 * uma nova entrada na tabela ProdutoEncomenda
 */

DROP TRIGGER IF EXISTS atualizacao_do_valor_total_da_fatura;
CREATE TRIGGER IF NOT EXISTS atualizacao_do_valor_total_da_fatura
	AFTER INSERT ON ProdutoEncomenda
BEGIN	
	UPDATE
		Fatura
	SET 
		total = (SELECT preco FROM Produto WHERE id_produto = NEW.id_produto) * NEW.quantidade 
					+ 
				(SELECT total FROM Fatura WHERE id_fatura = 
					(SELECT id_fatura FROM Encomenda WHERE id_encomenda = NEW.id_encomenda))
	WHERE 
		id_utilizador = (
			SELECT id_utilizador FROM Fatura WHERE id_fatura = (
				SELECT id_fatura FROM Encomenda WHERE id_encomenda = (
					SELECT id_encomenda FROM ProdutoEncomenda WHERE id_encomenda = NEW.id_encomenda AND id_produto = NEW.id_produto)));
END;


	