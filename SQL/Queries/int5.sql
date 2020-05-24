.mode columns
.headers on
.nullvalue NULL

--Que utilizadores nunca fizeram uma compra

SELECT username FROM Utilizador
EXCEPT 
SELECT username FROM Utilizador,Fatura WHERE Utilizador.id_utilizador=Fatura.id_utilizador;
