/*
 * Selecionar os 10 produtos mais vendidos no último mês, respetivos nomes, IDs e categorias,
 * bem como os seus preços e rating
 */
 
.mode columns
.headers on
.nullvalue NULL 
 
SELECT 
	Produto.id_produto,
    preco, 
    quantidade,
	nome,
	rating
FROM
	Fatura
	INNER JOIN 
		Encomenda
	ON	
		Encomenda.id_fatura = Fatura.id_fatura
	INNER JOIN
		ProdutoEncomenda
	ON	
		ProdutoEncomenda.id_encomenda = Encomenda.id_encomenda
	INNER JOIN
		Produto
	ON
		Produto.id_produto = ProdutoEncomenda.id_produto 
WHERE 
	data_emissao 
		BETWEEN 
			DATETIME('now', 'start of month') 
		AND 
			DATETIME('now', 'localtime')
ORDER BY 
	quantidade DESC
LIMIT 10;