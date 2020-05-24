
/*
 * Selecionar o tempo médio de visita no site
 */
 
.mode columns
.headers on
.nullvalue NULL

SELECT
	AVG(tempo_visita) as Media_Tempo_Visita,
	localizacao
FROM
	Visitante
GROUP BY	
	localizacao;