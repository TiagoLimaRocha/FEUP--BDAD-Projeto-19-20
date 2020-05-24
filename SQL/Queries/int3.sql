/*
 * Selecionar todas as encomendas entregues do último mês de uma dada categoria (i.e ),
 * cuja média dos produtos é superior a X (i.e. 3), interrogando quais os nomes dos produtos,
 * respetivos IDs e rating, e o total pago em cada encomenda
 */
 
.mode columns
.headers on
.nullvalue NULL 
 
SELECT 
	Produto.id_produto,
    Encomenda.id_encomenda,
	total,
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
	rating > 3
AND	
	data_emissao 
		BETWEEN 
			DATETIME('now', 'start of month') 
		AND 
			DATETIME('now', 'localtime'); 
	
		