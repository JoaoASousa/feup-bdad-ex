SELECT SUM(custo) FROM (
    SELECT idReparacao, custoFuncionario+custoPeca AS custo FROM (
        -- Custo de cada reparação em termos de funcionários
        SELECT Reparacao.idReparacao, IFNULL(custoFuncionario, 0) AS custoFuncionario FROM Reparacao LEFT JOIN (
            SELECT idReparacao, SUM(numHoras*custoHorario) AS custoFuncionario FROM FuncionarioReparacao, Funcionario, Especialidade
            WHERE FuncionarioReparacao.idFuncionario=Funcionario.idFuncionario
            AND Funcionario.idEspecialidade=Especialidade.idEspecialidade
            GROUP BY idReparacao
        ) AS T1 ON Reparacao.idReparacao=T1.idReparacao
    ) NATURAL JOIN (
        -- Custo de cada reparação em termos de peças
        SELECT Reparacao.idReparacao, IFNULL(custoPeca, 0) AS custoPeca FROM Reparacao LEFT JOIN (
            SELECT idReparacao, SUM(ReparacaoPeca.quantidade*custoUnitario) AS custoPeca FROM ReparacaoPeca, Peca
            WHERE ReparacaoPeca.idPeca=Peca.idPeca
            GROUP BY idReparacao
        ) AS T1 ON Reparacao.idReparacao=T1.idReparacao
    )
) WHERE custo > 60;