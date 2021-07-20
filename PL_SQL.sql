/* 1. USO DE RECORD
Descrição: Vamos utilizar o RECORD para criar um record type_pessoa,
definindo os mesmos campos presentes na tabela Pessoa,
atribuir valores para cada um desses campos, e por fim, inserir este record na tabela Pessoa. */
<<record_block>>
DECLARE
    type type_pessoa IS RECORD
    (cpf varchar(11)  ,
    nome varchar(255)  ,
    email varchar(255)  ,
    dt_nascimento DATE,
    sexo char(1),
    cep varchar(255),
    numero varchar(255));
    pessoa1 type_pessoa;
BEGIN
    pessoa1.cpf := '12345678901';
    pessoa1.nome := 'Gustavo Galdino';
    pessoa1.email := 'pdm@cin.ufpe.br';
    pessoa1.dt_nascimento := to_date('11/05/2001', 'dd/mm/yy');
    pessoa1.sexo := 'M';
    pessoa1.cep := '110';
    pessoa1.numero := '420';
    INSERT INTO Pessoa VALUES pessoa1;
END record_block;

/* 2 & 6 & 12 (TABLE, %TYPE, FOR IN LOOP).
Descrição: Vamos criar uma tabela contendo uma única coluna, correspondente ao CPF de uma pessoa.
Para isso vamos usar Pessoa.cpf%TYPE em cima da tabela já existente no banco de dados, Pessoa.
Por fim, vamos utilizar um FOR IN LOOP para mostrar que a TABLE em PL SQL criada contém o cpf de todas as pessoas. */
<<pessoa_cpf_block>>
DECLARE
    TYPE pessoa_cpf_type IS TABLE OF Pessoa.cpf%type
    INDEX BY BINARY_INTEGER;
    pessoa_cpf_table pessoa_cpf_type;
    i BINARY_INTEGER;
BEGIN
    i := 1;
    FOR current_row IN (SELECT cpf FROM Pessoa) LOOP
        pessoa_cpf_table(i) := current_row.cpf;
        i := i + 1;
    END LOOP;
    FOR j IN 1..i-1 LOOP
        DBMS_OUTPUT.Put_line(pessoa_cpf_table(j));
    END LOOP;
END pessoa_cpf_block;

/* 3. BLOCO ANÔNIMO
Descrição: Vamos criar um bloco anônimo, e dentro deste bloco, criar um RECORD do tipo pessoa
contendo os campos nome e cpf, e utilizar o DBMS_OUTPUT.Put_line para mostrar o valor do campo pessoa neste RECORD. */
DECLARE
    type type_pessoa_simples IS RECORD
    (cpf VARCHAR(11),
    nome VARCHAR(100));
    pessoa_simples_01 type_pessoa_simples;
BEGIN
    pessoa_simples_01.cpf := '09876543212';
    pessoa_simples_01.nome := 'Bruno';
    DBMS_OUTPUT.Put_line(pessoa_simples_01.nome);
END;


/* 10 & 14 & 15 (LOOP EXIT WHEN, CURSOR(OPEN,FETCH,CLOSE), EXCEPTION WHEN) */
DECLARE
    v_nome Pessoa.nome%TYPE;
    v_salario Funcionario.salario%TYPE;
    v_cpf Funcionario.cpf%TYPE;
    v_cpf_supervisor Funcionario.cpf_supervisor%TYPE := 6;
    
    CURSOR cursor_funcionario IS
        SELECT P.nome, F.salario, F.cpf
        FROM Pessoa P, Funcionario F
        WHERE F.cpf_supervisor = v_cpf_supervisor AND P.cpf = F.cpf;
    
BEGIN
    OPEN cursor_funcionario;
    LOOP
        FETCH  cursor_funcionario INTO v_nome, v_salario, v_cpf;
        EXIT WHEN cursor_funcionario%NOTFOUND;
        DBMS_OUTPUT.Put_line('Informações do funcionário:' || ' ' || TO_CHAR(v_nome) || ' ' || TO_CHAR(v_salario) || ' ' || TO_CHAR(v_cpf));
    END LOOP;
    CLOSE cursor_funcionario;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.Put_line('Exceção! manipulação inválida do cursor');
END;


-- TRIGGER de linha
-- Cria um trigger que levanta uma exception quando se tenta inserir vacinas fora do prazo de validade no BD
CREATE OR REPLACE TRIGGER fora_da_validade
BEFORE INSERT ON Vacina
FOR EACH ROW
DECLARE 
    fora_da_validade EXCEPTION; 
BEGIN
    IF :NEW.validade < SYSDATE() THEN
        DBMS_OUTPUT.PUT_LINE('FORA DA VALIDADE');
        RAISE fora_da_validade;
    END IF;
EXCEPTION 
    WHEN fora_da_validade THEN 
    Raise_application_error(-20324,'Vacina fora da validade-' || 'Não é possível inserir vacinas fora da validade dentro do banco de dados.');
END;

--TRIGGER de comando
-- Cria um trigger que quando é tentado fazer um agendamento fora do horario definido levanta uma exception
CREATE OR REPLACE TRIGGER fora_do_expediente
BEFORE INSERT ON Agendamento
DECLARE 
    agendar_fora_de_horario EXCEPTION; 
BEGIN 
    IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 
    THEN 
        RAISE agendar_fora_de_horario; 
    END IF; 
EXCEPTION 
 WHEN agendar_fora_de_horario THEN 
    Raise_application_error(-20324,'FORA DO EXPEDIENTE-' || 'Não é possível agendar fora do horário do expediente.'); 
END;

--FUNÇãO
-- FUNÇÂO que recebe o id de um agendamento e retorna uma string dizendo se o agendamento ja foi ou não concluido
CREATE OR REPLACE FUNCTION statusAgendamento(v_id Agendamento.id%type)
RETURN VARCHAR2
IS
	status Agendamento.status%type;
	dt Agendamento.dt_agendamento %type;
	r VARCHAR2(20);
BEGIN
	SELECT a.status INTO status
	FROM Agendamento a
 	WHERE a.id = v_id;

	IF status is NULL THEN
		r := 'Inexistente';
	ELSIF status = '1' THEN
		r := Agendamento ;
	ELSE
        r := 'Agendamento ainda não foi concluido ';
	END IF;
	RETURN r;
END statusAgendamento;


-- PACKAGE + PROCEDURE
-- PACKAGE que contem Procedures para realizar inserções de elementos do tipo CEP e PESSOA na tabela

CREATE OR REPLACE PACKAGE cadastros AS
PROCEDURE novoCep(aux Cep%rowtype);
PROCEDURE novaPessoa(p_cpf Pessoa.cpf%TYPE,
    p_nome Pessoa.nome%TYPE,
    p_email Pessoa.email%TYPE,
    p_dt_nascimento Pessoa.dt_nascimento%TYPE,
    p_sexo Pessoa.sexo%TYPE,
    p_cep Pessoa.cep%TYPE,
    p_numero Pessoa.numero%TYPE
);
END cadastros;


CREATE OR REPLACE PACKAGE BODY cadastros AS
PROCEDURE novoCep(aux Cep%rowtype) IS
BEGIN
    INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES (aux.cep, aux.rua, aux.bairro, aux.cidade, aux.estado);
END novoCep;

PROCEDURE novaPessoa(p_cpf Pessoa.cpf%TYPE,
    p_nome Pessoa.nome%TYPE,
    p_email Pessoa.email%TYPE,
    p_dt_nascimento Pessoa.dt_nascimento%TYPE,
    p_sexo Pessoa.sexo%TYPE,
    p_cep Pessoa.cep%TYPE,
    p_numero Pessoa.numero%TYPE
) IS
BEGIN
    INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES (p_cpf, p_nome, p_email, p_dt_nascimento, p_sexo, p_cep, p_numero);
END novaPessoa;

END cadastros;

-- WHILE LOOP + CASE WHEN
-- Bloco de codigo que checa quantos agendamentos foram marcados(Concluidos ou não) de duas vacinas especificas
DECLARE
    aux_count BINARY_INTEGER;
    i BINARY_INTEGER;
    q BINARY_INTEGER;
    aux_lote Agendamento.lote%type;
    aux_cnpj Agendamento.cnpj%type;
    aux_nome Vacina.nome%type;
BEGIN
    aux_count := 0;
    i := 1;
    SELECT COUNT(*) INTO q FROM Agendamento;
    WHILE i < q LOOP
        SELECT a.cnpj INTO aux_cnpj
        FROM Agendamento a
        WHERE a.id = i;
        SELECT b.lote INTO aux_lote 
        FROM Agendamento b
        WHERE b.id = i;
        SELECT x.nome INTo Aux_nome
        FROM Vacina x
        WHERE x.lote = aux_lote AND x.cnpj = Aux_cnpj;
        -- DBMS_OUTPUT.Put_line(aux_cnpj);
        -- DBMS_OUTPUT.Put_line(aux_lote);
        -- DBMS_OUTPUT.Put_line(aux_nome);
        CASE Aux_nome
            WHEN 'CoronaVac' THEN
                aux_count := aux_count + 1;
            WHEN 'Pfizer' THEN
                aux_count := aux_count + 1;
            ELSE
                aux_count := aux_count + 0;
        END CASE;
        i := i + 1;
    END LOOP;
    DBMS_OUTPUT.Put_line(aux_count);
END aux1;
