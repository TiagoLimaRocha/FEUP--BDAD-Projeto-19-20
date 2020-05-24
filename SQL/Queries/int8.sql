
/*
 * Selecionar o número de produtos de cada categoria com um rating superior a X (i.e. 3,5);
 */
 
.mode columns
.headers on
.nullvalue NULL

SELECT 
	count(id_produto),
    categoria
FROM
	Produto
GROUP BY
	categoria
HAVING 
	rating > 3.5;