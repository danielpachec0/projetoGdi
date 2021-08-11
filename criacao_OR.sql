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
--DROP TYPES---------------------------------------------------------------
DROP TYPE tp_agendamento
/
DROP TYPE tp_vacina
/
DROP TYPE tp_funcionario
/
DROP TYPE tp_paciente
/
DROP TYPE tp_pessoa
/
DROP TYPE tp_ponto_de_vacinacao
/
DROP TYPE tp_arr_telefone
/
DROP TYPE tp_telefone
/
DROP TYPE tp_campanha_de_vacinacao
/
DROP TYPE tp_plano_de_saude
/
DROP TYPE tp_endereco
/
-- TIPOS ---------------------------------------------------------

--endereco
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    CEP VARCHAR(100),
    rua VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    numero NUMBER
);

/

--plano de saude
CREATE OR REPLACE TYPE tp_plano_de_saude AS OBJECT(
    CNS VARCHAR(100),
    seguradora VARCHAR(100),
    numero_de_cadastro varchar(100)
);

/

--telefone
CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    numero VARCHAR(100)
);

/
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY(5) OF tp_telefone;
/

--pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    CPF VARCHAR(100),
    nome VARCHAR(100),
    email VARCHAR(100),
    dt_nascimento DATE,
    sexo char(1),
    endereco tp_endereco,
    telefones tp_arr_telefone
)NOT FINAL;

/

--ponto de vacinacao
CREATE OR REPLACE TYPE tp_ponto_de_vacinacao AS OBJECT(
    CNPJ VARCHAR(100),
    endereco tp_endereco,
    telefones tp_arr_telefone
);

/

--funcionario
CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    salario NUMBER,
    ponto REF tp_ponto_de_vacinacao,--adcionar referencia ponto
    supervisor REF tp_funcionario--adcionar ref supervisor
);

/

--paciente
CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa(
    plano_de_saude tp_plano_de_saude,
    dt_cadastro DATE
);

/

--vacina
CREATE OR REPLACE TYPE tp_vacina AS OBJECT(
    lote VARCHAR(100),
    ponto REF tp_ponto_de_vacinacao,
    validade DATE,
    nome VARCHAR(100),
    quantidade NUMBER
);

/

--campanha de vacinacao
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    id NUMBER,
    nome  varchar(100),
    entidade varchar(100),
    dt_inicio DATE,
    dt_termino DATE
);

/

--agendamento
CREATE OR REPLACE TYPE tp_agendamento AS OBJECT(
    id INTEGER,
    paciente REF tp_paciente,--paciente REF tp_paciente
    funcionario REF tp_funcionario,--funcionario REF tp_funcionario
    --ponto REF tp_ponto_de_vacinacao, --checar se precisa
    vacina REF tp_vacina,--vacina REF vacina,
    campanha REF tp_campanha_de_vacinacao,
    dt_agendamento TIMESTAMP,
    status CHAR(1)
);

/

--agendamento com campanha
-- CREATE OR REPLACE TYPE tp_agendamento_com_campanha, AS OBJECT(  
-- );

/

-- TABELAS ---------------------------------------------------------

--Ponto de vacinacao
CREATE TABLE tb_ponto_de_vacinacao OF tp_ponto_de_vacinacao(
    CNPJ PRIMARY KEY
);

;

--Funcionario
CREATE TABLE tb_funcionario OF tp_funcionario(
    CPF PRIMARY KEY,
    --supervisor SCOPE IS tp_funcionario, (nao percisa?)
    ponto SCOPE IS tb_ponto_de_vacinacao
);

/

--paciente
CREATE TABLE tb_paciente OF tp_paciente(
    CPF PRIMARY KEY
);

--campanha

CREATE TABLE tb_campanha_de_vacinacao OF tp_campanha_de_vacinacao(
    nome PRIMARY KEY
);

/

--Vacina
CREATE TABLE tb_vacina OF tp_vacina(
    lote PRIMARY KEY,
    ponto SCOPE IS tb_ponto_de_vacinacao
);

/

--agendamento
CREATE TABLE tb_agendamento OF tp_agendamento(
    id PRIMARY KEY,
    paciente SCOPE IS tb_paciente,
    funcionario SCOPE IS tb_funcionario,
    vacina SCOPE IS tb_vacina,
    campanha SCOPE IS tb_campanha_de_vacinacao
);