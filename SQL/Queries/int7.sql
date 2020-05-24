
/*
 * Selecionar todos os produtos que foram comprados quando um determinado produto 
 * foi vendido (i.e. Produto com ID 1234)
 */
 
.mode columns
.headers on
.nullvalue NULL

SELECT 
	id_encomenda,
	categoria,
	Produto.id_produto,
	Produto.nome,
	quantidade
FROM
	ProdutoEncomenda 
		INNER JOIN
			Produto
		ON
			Produto.id_produto = ProdutoEncomenda.id_produto
WHERE
	id_encomenda IN (
    	SELECT 
      		id_encomenda 
      	FROM 
      		ProdutoEncomenda
      	WHERE
      		id_produto = 1234
    );
	
	