-- @LOGS

-- UTILIZADOR LOGS
SELECT * FROM UtilizadorLogs;

UPDATE 
	Utilizador
SET
	username = "Ups, alguém deixou o estagiário mexer na base de dados outra vez"
WHERE
	id_utilizador = 9;

SELECT * FROM UtilizadorLogs;


	