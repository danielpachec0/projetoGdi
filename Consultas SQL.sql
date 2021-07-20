/* 1. ALTER TABLE
Descrição: Atualizar o campo telefone da tabela Telefone_ponto, para diminuir o uso de memória para aquele campo. */
ALTER TABLE Telefone_ponto
MODIFY (telefone VARCHAR2(32));

/* 2.CREATE INDEX
Descrição: Criar um índice para os atributos dt_agendamento
 e cpf_paciente na tabela Agendamento, para agilizar consultas envolvendo esses campos. */ 
CREATE INDEX indice_dt_agendamento
ON Agendamento (cpf_paciente, dt_agendamento);

/* 3. INSERT INTO
Descrição: Inserção de uma nova pessoa na tabela Pessoa. */
INSERT INTO Pessoa
(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES
('40', 'Gustavo Galdino', 'gcgm@cin.ufpe.br', to_date('11/05/2001', 'dd/mm/yy'), 'M', '103', '1');

/* 4. UPDATE
Descrição: Atualizar o campo email de uma pessoa na tabela Pessoa. */
UPDATE Pessoa
SET email='gcgm@cin.ufpe.br'
WHERE cpf='7';

/* 5. DELETE 
Descrição: Deletar todas as ocorrências na tabela Agendamento, cujo status for igual a ‘1’,
o que significa que o evento já ocorreu. */
DELETE FROM Agendamento
WHERE (status = '1');

/* 6 & 7. SELECT-FROM-WHERE & BETWEEN 
Descrição: Selecionar a data de agendamento e o cpf do paciente das ocorrências da tabela Agendamento
 onde a data de agendamento está entre 12:00 de 02 de outubro de 2021 e 12:00 de 03 de outubro de 2021. */
SELECT dt_agendamento, cpf_paciente FROM Agendamento
WHERE TO_TIMESTAMP(dt_agendamento)
BETWEEN TO_TIMESTAMP('02-OCT-21 12.00.00.000000 AM') AND TO_TIMESTAMP('03-OCT-21 12.00.00.000000 AM');

/* 8. IN
Descrição: Selecionar as datas de agendamento das ocorrências da tabela Agendamento,
 tais que o funcionário encarregado tem CPF ‘7’ ou ‘9’ */
SELECT cpf_funcionario, dt_agendamento FROM Agendamento
WHERE cpf_funcionario IN ('7', '9');

/* 9. LIKE 
Selecionar, na tabela Pessoa, o nome de todas as pessoas que tem o nome começando com ‘P’. */
SELECT nome FROM Pessoa
WHERE nome LIKE 'P&';

/* 10. IS NULL OU IS NOT NULL
Descrição: Buscar o nome dos funcionários que não possuem nenhum supervisor. */
SELECT P.nome from Funcionario F, Pessoa P
WHERE F.cpf = P.cpf AND F.cpf_supervisor IS NULL;

/* 11. INNER JOIN
Descrição: Buscar o nome na tabela pessoa e CPF
dos funcionários supervisores na tabela Funcionario, sem admitir valores duplicados. */
SELECT DISTINCT P.nome FROM Pessoa P
INNER JOIN Funcionario F
ON P.cpf = F.cpf_supervisor;

/* 12 & 13 & 14 . MAX, MIN, AVG
Descrição: Encontrar o maior salário, o menor salário,
e o salário médio entre todos os funcionários da tabela Funcionario. */
SELECT MAX(salario), MIN(salario), AVG(salario)
FROM Funcionario;

/* 15. COUNT
Descrição: Encontrar, na tabela Funcionario, o número de funcionários que recebem mais do que a média do salário. */
SELECT COUNT(*)
FROM Funcionario
WHERE (salario > (SELECT AVG(salario) from Funcionario));

/* 16. LEFT OU RIGHT OU FULL OUTER JOIN
Descrição: Consultar todos os funcionários, mostrando seu CPF,
e mostrar o plano de saúde daqueles que também são pacientes. */
SELECT F.cpf, P.plano_de_saude
FROM Funcionario F LEFT OUTER JOIN Paciente P
ON F.cpf = P.cpf;

/* 17 & 18. SUBCONSULTA COM OPERADOR RELACIONAL & SUBCONSULTA COM IN
Descrição: Buscar o CPF de todos os funcionários que trabalharão
como supervisores às 12:00 de 02 de outubro de 2021 ou 12:00 de 03 outubro de 2021. */
SELECT F.cpf FROM Funcionario F
WHERE F.cpf IN (SELECT cpf_funcionario
FROM AGENDAMENTO WHERE to_timestamp(dt_agendamento) = to_timestamp('02-OCT-21 12.00.00.000000 AM') OR
to_timestamp(dt_agendamento) = to_timestamp('03-OCT-21 12.00.00.000000 AM'));

/* 19. SUBCONSULTA COM ANY
Descrição: Listar o cpf dos funcionários que possuem salário maior
ou igual do que o salário de pelo menos um funcionário que é supervisor. */
SELECT cpf FROM Funcionario WHERE
salario >= ANY
(SELECT salario FROM Funcionario WHERE cpf IN 
(SELECT cpf_supervisor FROM Funcionario) );

/* 20. SUBCONSULTA COM ALL
Descrição: Listar o cpf dos funcionários supervisores que possuem um salário
 maior ou igual do que o salário de todos os outros funcionários. */
SELECT cpf FROM Funcionario WHERE
cpf IN (SELECT cpf_supervisor FROM Funcionario) AND
salario >= ALL (SELECT salario from Funcionario);

/* 21. ORDER BY
Descrição: Listar o salário de todos os funcionários em ordem crescente. */
SELECT salario FROM Funcionario
ORDER BY salario;

/* 22. GROUP BY
Descrição: Mostrar quantos funcionários possuem salário maior que a média salarial
de todos os funcionários, agrupados por sexo */
SELECT COUNT(salario), P.sexo FROM Funcionario F, Pessoa P
WHERE F.salario > (SELECT AVG(salario) from Funcionario) AND F.cpf = P.cpf
GROUP BY P.sexo;

/* 23. HAVING
Descrição: Mostrar quantos funcionários possuem salário menor que a média salarial
de todos os funcionários, agrupados por sexo, com a condição de que o número de funcionários,
por sexo, com média menor que a média salarial, deve ser superior a 1. */
SELECT COUNT(salario), P.sexo FROM Funcionario F, Pessoa P
WHERE F.salario < (SELECT AVG(salario) from Funcionario) AND F.cpf = P.cpf
GROUP BY P.sexo
HAVING COUNT(salario) > 1;

/* 24. UNION ou INTERSECT ou MINUS
Descrição: Encontrar o nome de todas as pessoas que são funcionários e pacientes ao mesmo tempo. */
SELECT nome FROM Pessoa
WHERE cpf IN (SELECT cpf FROM Funcionario INTERSECT SELECT cpf FROM Paciente);

/* 25. CREATE VIEW
Descrição: Criar uma visão para pessoas do sexo feminino. */
CREATE VIEW visao_pessoas AS
SELECT * FROM Pessoa
WHERE sexo = 'F';

/* 26. GRANT & REVOKE 
Descrição: Garantir privilégios de DELETE e INSERT na tabela Pessoa, para o acesso PUBLIC (todos os usuários),
 e depois utilizar o REVOKE para remover o privilégio de remoção (DELETE). */
GRANT DELETE, INSERT ON Pessoa TO PUBLIC;
REVOKE DELETE ON Pessoa FROM PUBLIC; 





















