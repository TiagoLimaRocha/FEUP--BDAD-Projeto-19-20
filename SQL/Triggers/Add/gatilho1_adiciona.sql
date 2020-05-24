-- @Carrinho
DROP TRIGGER IF EXISTS carregar_carrinho_apos_update;
CREATE TRIGGER IF NOT EXISTS carregar_carrinho_apos_update 
   AFTER UPDATE OF estado ON Utilizador 
   WHEN NEW.estado = 1 
BEGIN
	INSERT INTO 
		Carrinho(id_utilizador, atual, data_inicio, data_fim) 
	VALUES 
		(NEW.id_utilizador, 1, CURRENT_TIMESTAMP, NULL);
END;