/* 
 * Selecionar todos os produtos (e toda a informação a eles referente) de uma 
 * dada categoria (i.e. "Fotografia, Video, Lab Foto")
 */
 
.mode columns
.headers on
.nullvalue NULL

SELECT * FROM Produto WHERE Categoria = "Fotografia, Video, Lab Foto";