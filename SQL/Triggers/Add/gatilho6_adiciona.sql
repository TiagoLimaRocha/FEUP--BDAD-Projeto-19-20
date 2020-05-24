-- UTILIZADOR
DROP TRIGGER IF EXISTS utilizador_validar_email;
CREATE TRIGGER utilizador_validar_email 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN NEW.email NOT LIKE '%_@__%.__%' 
			THEN RAISE (ABORT,'Invalid email address!')
      END;
END;