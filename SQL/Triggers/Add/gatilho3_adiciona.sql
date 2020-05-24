-- @LOGS

/*
 * Como ambas estas tabelas contêm informação sensível que não pode ser perdida, 
 * e por fins de utilizade mas também para comparações estatísticas e como medida métrica,  
 * é importante armazenar esta informação em tabelas separadas `logs`, para isso usamos estes dois triggers.
 * No caso da tabela Produto-Carrinho é interessante saber quais os produtos que os utilizadores decidiram remover do carrinho
 */

-- UTILIZADOR LOGS
DROP TRIGGER IF EXISTS log_utilizador_apos_update;
CREATE TRIGGER IF NOT EXISTS log_utilizador_apos_update 
	AFTER UPDATE ON Utilizador
		WHEN OLD.email <> NEW.email
			OR OLD.username <> NEW.username
			OR OLD.password <> NEW.password
			OR OLD.nome_proprio <> NEW.nome_proprio
			OR OLD.sobrenome <> NEW.sobrenome
			OR OLD.nif <> NEW.nif
			OR OLD.morada <> NEW.morada
			OR OLD.cod_postal <> NEW.cod_postal
BEGIN
	INSERT INTO 
		UtilizadorLogs (
			old_id_utilizador,
			new_id_utilizador,
			old_email,
			new_email,
			old_username,
			new_username,
			old_password,
			new_password,
			old_nome_proprio,
			new_nome_proprio,
			old_sobrenome,
			new_sobrenome,
			old_nif,
			new_nif,
			old_morada,
			new_morada,
			old_cod_postal,
			new_cod_postal
		) 
		VALUES (
			OLD.id_utilizador,
			NEW.id_utilizador,
			OLD.email,
			NEW.email,
			OLD.username,
			NEW.username,
			OLD.password,
			NEW.password,
			OLD.nome_proprio,
			NEW.nome_proprio,
			OLD.sobrenome,
			NEW.sobrenome,
			OLD.nif,
			NEW.nif,
			OLD.morada,
			NEW.morada,
			OLD.cod_postal,
			NEW.cod_postal
		);
END;

	