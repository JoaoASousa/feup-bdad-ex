SELECT Nome, cod, MAX(nota) AS maxNota FROM Prova NATURAL JOIN Aluno GROUP BY cod;