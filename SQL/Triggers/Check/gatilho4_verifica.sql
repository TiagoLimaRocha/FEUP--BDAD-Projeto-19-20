-- @FATURA

SELECT * FROM Fatura;

INSERT INTO 
	ProdutoEncomenda
		(id_encomenda, id_produto, quantidade) 
	VALUES
		(1, 2307, 1);

SELECT * FROM Fatura;