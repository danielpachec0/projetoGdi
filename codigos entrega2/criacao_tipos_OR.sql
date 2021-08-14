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
DROP TYPE tp_nt_vacina
/
DROP TYPE tp_ponto_de_vacinacao
/
DROP TYPE tp_nt_trabalha
/
DROP TYPE tp_trabalha
/
DROP TYPE tp_funcionario
/
DROP TYPE tp_paciente
/
DROP TYPE tp_pessoa
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

--plano de saude-----------------------------------------------------
CREATE OR REPLACE TYPE tp_plano_de_saude AS OBJECT(
    CNS VARCHAR(100),
    seguradora VARCHAR(100),
    numero_de_cadastro varchar(100)
);

/

--telefone----------------------------------------------------------
CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    numero VARCHAR(100)
);
/
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY(5) OF tp_telefone;
/

--pessoa-------------------------------------------------------------
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    CPF VARCHAR(100),
    nome VARCHAR(100),
    --email VARCHAR(100),
    dt_nascimento DATE,
    sexo char(1),
    endereco tp_endereco,
    telefones tp_arr_telefone,
    MEMBER PROCEDURE print_info,
    FINAL MAP MEMBER FUNCTION compara_quantidade_vacina return NUMBER
)NOT FINAL NOT INSTANTIABLE;

/

CREATE OR REPLACE TYPE BODY tp_funcionario AS
FINAL MAP MEMBER FUNCTION compara_quantidade_vacina return NUMBER IS
    BEGIN
        RETURN COUNT_ELEMENTS(telefones)
    END;
END;
/

--funcionario-------------------------------------------------------------
CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    salario NUMBER,
    supervisor REF tp_funcionario,
    MEMBER PROCEDURE novo_salario(SELF IN OUT NOCOPY tp_funcionario, input NUMBER),
    MEMBER FUNCTION salario_anual RETURN NUMBER,
    OVERRIDING MEMBER PROCEDURE print_info 
);

/

CREATE OR REPLACE TYPE BODY tp_funcionario AS
    MEMBER PROCEDURE novo_salario(SELF IN OUT NOCOPY tp_funcionario, input NUMBER) IS
    BEGIN  
        self.salario := input;
    END;
    MEMBER FUNCTION salario_anual RETURN NUMBER IS
    BEGIN
        RETURN salario * 12;
    END;
    OVERRIDING MEMBER PROCEDURE print_info IS
    BEGIN
        DBMS_OUTPUT.Put_line(nome);
        DBMS_OUTPUT.Put_line(cpf);
        DBMS_OUTPUT.Put_line(salario);
    END;
END;


/

--paciente------------------------------------------------------------------
CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa(
    plano_de_saude tp_plano_de_saude,
    dt_cadastro DATE,
    OVERRIDING MEMBER PROCEDURE print_info
);
/
CREATE OR REPLACE TYPE BODY tp_paciente AS
    OVERRIDING MEMBER PROCEDURE print_info IS
    BEGIN
        DBMS_OUTPUT.Put_line(nome);
        DBMS_OUTPUT.Put_line(cpf);
        DBMS_OUTPUT.Put_line(plano_de_saude.cns);
    END;
END;
/
-----------------------------------------------------------------------------------
ALTER TYPE tp_pessoa ADD ATTRIBUTE (email VARCHAR2(100))CASCADE;
-----
/
CREATE OR REPLACE TYPE tp_trabalha AS OBJECT(
    funcionario REF tp_funcionario
)NOT FINAL;--tirar?

/

CREATE OR REPLACE TYPE tp_nt_trabalha AS TABLE OF tp_trabalha;

/

--vacina---------------------------------------------------------------------------
CREATE OR REPLACE TYPE tp_vacina AS OBJECT(
    lote NUMBER,
    validade DATE,
    nome VARCHAR(100),
    quantidade NUMBER,
    --ponto REF tp_ponto_de_vacinacao
    MAP MEMBER FUNCTION compara_quantidade_vacina return NUMBER
);
/
CREATE OR REPLACE TYPE BODY tp_vacina AS   
    MAP MEMBER FUNCTION compara_quantidade_vacina RETURN NUMBER IS

    BEGIN
        IF validade < SYSDATE() THEN
            RETURN 0;
        ELSE 
            RETURN quantidade;
        END IF;
    END compara_quantidade_vacina;
END;
/

--ponto de vacinacao
CREATE OR REPLACE TYPE tp_ponto_de_vacinacao AS OBJECT(
    CNPJ VARCHAR(100),
    endereco tp_endereco,
    telefones tp_arr_telefone,
    funcionarios tp_nt_trabalha
);

/
ALTER TYPE tp_vacina ADD ATTRIBUTE (ponto REF tp_ponto_de_vacinacao)CASCADE;
/

--campanha de vacinacao
CREATE OR REPLACE TYPE tp_campanha_de_vacinacao AS OBJECT(
    id NUMBER,
    nome  varchar(100),
    entidade varchar(100),
    dt_inicio DATE,
    dt_termino DATE,
    CONSTRUCTOR FUNCTION tp_campanha_de_vacinacao
    (SELF IN OUT NOCOPY tp_campanha_de_vacinacao, iid NUMBER, inome VARCHAR2, ientidade VARCHAR2, idt DATE)
    RETURN SELF AS RESULT
);
/
CREATE OR REPLACE TYPE BODY tp_campanha_de_vacinacao AS
    CONSTRUCTOR FUNCTION tp_campanha_de_vacinacao
    (SELF IN OUT NOCOPY tp_campanha_de_vacinacao, iid NUMBER, inome VARCHAR2, ientidade VARCHAR2, idt DATE)
    RETURN SELF AS RESULT IS
    BEGIN
        SELF.id := iid;
        SELF.nome := inome;
        SELF.entidade := ientidade;
        SELF.dt_inicio := idt;
        SELF.dt_termino := null;
        RETURN;
    END;
END;
/

--agendamento
CREATE OR REPLACE TYPE tp_agendamento AS OBJECT(
    id INTEGER,
    paciente REF tp_paciente,
    funcionario REF tp_funcionario,
    vacina REF tp_vacina,
    campanha REF tp_campanha_de_vacinacao,
    dt_agendamento TIMESTAMP,
    status CHAR(1),
    ORDER MEMBER FUNCTION aux(SELF IN OUT NOCOPY tp_agendamento, x tp_agendamento) RETURN DECIMAL
);
/
CREATE OR REPLACE TYPE BODY tp_agendamento AS
    ORDER MEMBER FUNCTION aux(SELF IN OUT NOCOPY tp_agendamento, x tp_agendamento) RETURN NUMBER IS
    BEGIN
        IF SELF.dt_agendamento < x.dt_agendamento THEN
            RETURN -1;               
        ELSIF SELF.dt_agendamento > x.dt_agendamento THEN 
            RETURN 1;                
        ELSE 
            RETURN 0;
        END IF;
    END;
END;/

