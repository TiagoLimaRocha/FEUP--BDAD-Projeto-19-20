
/*
 * Selecionar o número total de encomendas efectuadas no dia atual
 */
 
.mode columns
.headers on
.nullvalue NULL

SELECT
	COUNT(id_encomenda) AS Num_Total_Encomendas
FROM
	Encomenda
WHERE
	data_envio = CURRENT_DATE;