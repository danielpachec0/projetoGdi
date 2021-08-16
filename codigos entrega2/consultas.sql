-- Seleciona o nome o cns e o a seguradora dos pacientes
SELECT A.nome, A.plano_de_saude.cns, A.plano_de_saude.seguradora
FROM tb_paciente A;

-- Seleciona  os agendamentos em que a vacina foi 'astra' e aplicada pelo funcionario de CPF '2'
SELECT A.id
FROM tb_agendamento A
WHERE DEREF(A.vacina).nome = 'astra' AND DEREF(A.funcionario).cpf = '2';

-- Seleciona o nome, cpf e os telefones
SELECT P.CPF,P.nome, T.*
FROM tb_funcionario P, TABLE(P.telefones) T;

-- Seleciona os funcionarios que trablham no ponto de vacinacao
SELECT DEREF(A.funcionario).nome 
FROM TABLE(SELECT X.funcionarios FROM tb_ponto_de_vacinacao X WHERE X.cnpj = '1002') A;

-- Seleciona os Funcionarios que nao possuem supervisor
SELECT F.nome
FROM tb_funcionario F
WHERE F.supervisor IS null;

-- Seleciona os agendamentos que estao cadastrados com as vacinas 'astra' ou 'coronavac' e n'ao est'ao participando de campnhas de vacinacao
SELECT A.id
FROM tb_agendamento A
WHERE (DEREF(A.vacina).nome = 'astra' OR DEREF(A.vacina).nome = 'coronavac') AND DEREF(A.campanha).nome IS NULL;