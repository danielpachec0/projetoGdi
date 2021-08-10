--endereco
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    CEP VARCHAR(),
    rua VARCHAR(),
    bairro VARCHAR(),
    cidade VARCHAR(),
    estado VARCHAR()
);

/
--plano de saude
CREATE OR REPLACE TYPE tp_plano_de_saude AS OBJECT(
    CNS VARCHAR(),
    seguradora VARCHAR(),
    numero_de_cadastro varchar()
);

/

--telefone
CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    ????
);

/

--pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    CPF VARCHAR(),
    nome VARCHAR(),
    email VARCHAR(),
    dt_nascimento DATE,
    sexo char(1),
    endereco tp_endereco,
    tlefone tp_telefone
)NOT FINAL;

/

--ponto de vacinacao
CREATE OR REPLACE TYPE tp_ponto_de_vacinacao AS OBJECT(
    CNPJ VARCHAR(),
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
    telefone tp
);

/

--vacina
CREATE OR REPLACE TYPE tp_vacina AS OBJECT(
    lote  varchar(),
    ponto REF tp_ponto_de_vacinacao,
    validade DATE,
    nome
    quantidade NUMBER
);

/

--campanha de vacinacao
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    --id
    nome  varchar(),
    entidade varchar(),
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