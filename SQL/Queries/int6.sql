/*
 * Selecionar o número total de vendas efetuadas no último mês
 * e o total de receitas geradas
 */

.mode columns
.headers on
.nullvalue NULL

SELECT 
	COUNT(id_fatura) AS Num_Total_Vendas,
	SUM(total) AS Total_Receitas
FROM
	Fatura
WHERE 
	data_emissao 
		BETWEEN 
			DATETIME('now', 'start of month') 
		AND 
			DATETIME('now', 'localtime'); 
	