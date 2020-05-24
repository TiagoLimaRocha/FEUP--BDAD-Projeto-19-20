
/*
 * Selecionar o valor de todas as compras efetuada no dia atual por um determinado 
 * utilizador e o seu respetivo nome, morada e email
 */

.mode columns
.headers on
.nullvalue NULL

SELECT 
	total,
	nome_proprio,
	sobrenome,
	morada,
	email
FROM
	Fatura
	INNER JOIN
		Utilizador
	ON
		Utilizador.id_utilizador = Fatura.id_utilizador
WHERE
	data_emissao = CURRENT_DATE;
	