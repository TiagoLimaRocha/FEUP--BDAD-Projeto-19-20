/*
 * Selecionar número de produtos vendidos na última semana e 
 * o respetivo valor total de receita gerada
 */
 
.mode columns
.headers on
.nullvalue NULL 
 
SELECT 
	SUM(quantidade) AS Num_Produtos_Vendidos,
	SUM(total) AS Total_Receitas
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
			DATETIME('now', '-6 days') 
		AND 
			DATETIME('now', 'localtime'); 