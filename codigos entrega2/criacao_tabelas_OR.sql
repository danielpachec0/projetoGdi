--Ponto de vacinacao
CREATE TABLE tb_ponto_de_vacinacao OF tp_ponto_de_vacinacao(
    CNPJ PRIMARY KEY,
    endereco NOT NULL,
    telefones NOT NULL
);

;

--Funcionario
CREATE TABLE tb_funcionario OF tp_funcionario(
    CPF PRIMARY KEY,
    --ponto NOT NULL,
    salario NOT NULL,
    --supervisor SCOPE IS tp_funcionario, (nao percisa?)
    ponto SCOPE IS tb_ponto_de_vacinacao NOT NULL
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
    ponto SCOPE IS tb_ponto_de_vacinacao NOT NULL --chave primaria??
);

/

--agendamento
CREATE TABLE tb_agendamento OF tp_agendamento(
    id PRIMARY KEY,
    dt_agendamento NOT NULL,
    status NOT NULL,
    paciente SCOPE IS tb_paciente NOT NULL,
    funcionario SCOPE IS tb_funcionario NOT NULL,
    vacina SCOPE IS tb_vacina NOT NULL,
    campanha SCOPE IS tb_campanha_de_vacinacao
);