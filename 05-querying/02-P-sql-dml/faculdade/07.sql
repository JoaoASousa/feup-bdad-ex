SELECT Nome FROM Aluno NATURAL JOIN (
    SELECT DISTINCT nr FROM Cadeira NATURAL JOIN Prova
    WHERE curso='IS'
);