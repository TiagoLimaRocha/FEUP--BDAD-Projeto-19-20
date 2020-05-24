-- @Carrinho
DROP TRIGGER IF EXISTS carregar_carrinho_apos_insert;
CREATE TRIGGER IF NOT EXISTS carregar_carrinho_apos_insert 
   AFTER INSERT ON Utilizador 
   WHEN NEW.estado = 1
BEGIN
	INSERT INTO 
		Carrinho(id_utilizador, data_inicio, data_fim) 
	VALUES 
		(NEW.id_utilizador, CURRENT_TIMESTAMP, NULL);
END;