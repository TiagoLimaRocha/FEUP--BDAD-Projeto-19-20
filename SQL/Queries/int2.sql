.mode columns
.headers on
.nullvalue NULL

--Qual o total gasto por cada utilizador na plataforma?

SELECT Utilizador.username, Fatura.total AS TotalGasto FROM Utilizador,Fatura WHERE Utilizador.id_utilizador=Fatura.id_utilizador;