--DROP TABLES-------------------------------------------------------------
DROP TABLE tb_agendamento
/
DROP TABLE Vacina
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
DROP TYPE tp_telefone
/
DROP TYPE tp_campanha_de_vacinacao
/
DROP TYPE tp_plano_de_saude
/
DROP TYPE tp_endereco

-- TIPOS ---------------------------------------------------------

--endereco
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    CEP VARCHAR(100),
    rua VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(100)
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
    ????
);

/

--pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    CPF VARCHAR(100),
    nome VARCHAR(100),
    email VARCHAR(100),
    dt_nascimento DATE,
    sexo char(1),
    endereco tp_endereco,
    --tlefone tp_telefone
)NOT FINAL;

/

--ponto de vacinacao
CREATE OR REPLACE TYPE tp_ponto_de_vacinacao AS OBJECT(
    CNPJ VARCHAR(100),
    endereco tp_endereco,
    telefone tp_telefone
);

/

--funcionario
CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    salario NUMBER
);

--paciente
CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa(
    plano_de_saude tp_plano_de_saude,
);

/

--vacina
CREATE OR REPLACE TYPE tp_vacina AS OBJECT(
    lote  varchar(100),
    ponto REF tp_ponto_de_vacinacao,
    validade DATE,
    nome
    quantidade NUMBER
);

/

--campanha de vacinacao
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    --id
    nome  varchar(100),
    entidade varchar(100),
    dt_inicio DATE,
    dt_termino DATE
);

/

--agendamento
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    id INTEGER;
    paciente REF tp_paciente,
    funcionario REF tp_funcionario,
    ponto REF tp_ponto_de_vacinacao, --checar se precisa
    vacina REF vacina,
    dt_agendamento TIMESTAMP,
    status CHAR(1)
);

--agendamento com campanha
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    id INTEGER;
    paciente REF tp_paciente,
    funcionario REF tp_funcionario,
    ponto REF tp_ponto_de_vacinacao, --checar se precisa
    vacina REF vacina,
    dt_agendamento TIMESTAMP,
    status CHAR(1),
    campanha REF tp_campanha_de_vacinacao
);

-- TABELAS ---------------------------------------------------------

--Funcionario
CREATE TABLE tb_funcionario OF tp_funcionario(
    CPF PRIMARY KEY
);

/

--paciente
CREATE TABLE tb_paciente OF tp_paciente(
    CPF PRIMARY KEY
);