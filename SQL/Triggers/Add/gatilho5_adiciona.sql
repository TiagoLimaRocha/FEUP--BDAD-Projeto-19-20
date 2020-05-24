-- @ProdutoCarrinho
DROP TRIGGER IF EXISTS check_quantidade;
CREATE TRIGGER IF NOT EXISTS check_quantidade 
   BEFORE INSERT ON ProdutoCarrinho 
BEGIN
   SELECT
      CASE
		WHEN NEW.quantidade > (SELECT stock FROM Produto WHERE id_produto = NEW.id_produto)
			THEN RAISE (ABORT,'ERRO: quantidade maior que o stock!')
      END;
END;