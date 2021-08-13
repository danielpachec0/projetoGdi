--DROP TABLES-------------------------------------------------------------
DROP TABLE tb_agendamento
/
DROP TABLE tb_vacina
/
DROP TABLE tb_funcionario
/
DROP TABLE tb_paciente
/
DROP TABLE tb_ponto_de_vacinacao
/
DROP TABLE tb_campanha_de_vacinacao
/

--Ponto de vacinacao
CREATE TABLE tb_ponto_de_vacinacao OF tp_ponto_de_vacinacao(
    CNPJ PRIMARY KEY,
    endereco NOT NULL,
    telefones NOT NULL
)NESTED TABLE funcionarios STORE AS lista_funcionarios;

/

--Funcionario
CREATE TABLE tb_funcionario OF tp_funcionario(
    CPF PRIMARY KEY,
    salario NOT NULL
    --supervisor WITH ROWID REFERENCES tp_funcionario --(nao percisa?)
);

/

--paciente
CREATE TABLE tb_paciente OF tp_paciente(
    CPF PRIMARY KEY,
    plano_de_saude NOT NULL,
    dt_cadastro NOT NULL
);

--campanha
CREATE TABLE tb_campanha_de_vacinacao OF tp_campanha_de_vacinacao(
    --id
    nome PRIMARY KEY,
    entidade NOT NULL,
    dt_inicio NOT NULL
);

/


--Vacina
CREATE TABLE tb_vacina OF tp_vacina(
    lote PRIMARY KEY,
    validade NOT NULL,
    nome NOT NULL,
    quantidade NOT NULL,
    ponto WITH ROWID REFERENCES tb_ponto_de_vacinacao
);

/

--agendamento
CREATE TABLE tb_agendamento OF tp_agendamento(
    id PRIMARY KEY,
    dt_agendamento NOT NULL,
    status NOT NULL,
    paciente WITH ROWID REFERENCES tb_paciente NOT NULL,
    funcionario WITH ROWID REFERENCES tb_funcionario NOT NULL,
    vacina WITH ROWID REFERENCES tb_vacina NOT NULL,
    campanha WITH ROWID REFERENCES tb_campanha_de_vacinacao
);