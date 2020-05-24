/* 
 * Por defeito o SQLite não providencia uma implementação para o comparador de 
 * expressões regulares REGEXP; isso é feito ao implementar a funcção nativa do SQL regexp(),
 * uma possível implementação em Java seria algo do género: 
	
	Function.create(connection, "REGEXP", new Function() {
	  @Override
	  protected void xFunc() throws SQLException {
		String expression = value_text(0);
		String value = value_text(1);
		if (value == null)
		  value = "";

		Pattern pattern=Pattern.compile(expression);
		result(pattern.matcher(value).find() ? 1 : 0);
	  }
	});

 * Admitindo que se criou essa implementação poder-se-ia utilizar os seguintes triggers
 * para validar o username e a password de cada utilizador:
 
DROP TRIGGER IF EXISTS utilizador_validar_username;
CREATE TRIGGER utilizador_validar_username 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN (SELECT username FROM Utilizador WHERE username REGEXP "^[-\w\.\$@\*\!]{1,30}$") > 0
			THEN RAISE (ABORT,'Invalid username!')
      END;
END;

DROP TRIGGER IF EXISTS utilizador_validar_password;
CREATE TRIGGER utilizador_validar_password 
   BEFORE INSERT ON Utilizador
BEGIN
   SELECT
      CASE
		WHEN (SELECT password FROM Utilizador WHERE password REGEXP "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{16,}$") > 0
			THEN RAISE (ABORT,'Invalid password!')
      END;
END;
*/