DROP TABLE telefone_pessoa;
DROP TABLE telefone_Ponto;
DROP TABLE participa;
DROP TABLE agendamento;
DROP TABLE funcionario;
DROP TABLE paciente;
DROP TABLE pessoa;
DROP TABLE vacina;
DROP TABLE ponto_de_vacinacao;
DROP TABLE cep;
DROP TABLE plano_de_saude;
DROP TABLE campanha_de_vacinacao;

CREATE TABLE Cep(
    cep VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL, 
    CONSTRAINT cep_pk PRIMARY KEY (cep)
);

CREATE TABLE Plano_de_saude(
    cns VARCHAR2(255) NOT NULL,
    seguradora VARCHAR2(255) NOT NULL,
    numero_de_cadastro VARCHAR2(255) NOT NULL,
    CONSTRAINT plano_de_saude_pk PRIMARY KEY (cns)
);

CREATE TABLE Campanha_de_vacinacao(
    nome VARCHAR2(255) NOT NULL,
    orgao_responsavel VARCHAR2(255) NOT NULL, 
    data_de_inicio DATE NOT NULL,
    data_de_termino DATE,
    CONSTRAINT campanha_de_vacinacao_pk PRIMARY KEY (nome)
);

CREATE TABLE Pessoa(
    cpf VARCHAR2(11) NOT NULL,
    nome VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    dt_nascimento DATE NOT NULL,
    sexo char(1) NOT NULL,
    cep VARCHAR2(255) NOT NULL,
    numero VARCHAR2(255) NOT NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_fk FOREIGN KEY (cep) REFERENCES Cep(cep)
);

CREATE TABLE Ponto_de_vacinacao(
    cnpj VARCHAR2(14) NOT NULL,
    cep VARCHAR2(255) NOT NULL,
    numero VARCHAR2(255) NOT NULL,
    CONSTRAINT Ponto_de_vacinacao_pk PRIMARY KEY (cnpj),
    CONSTRAINT Ponto_de_vacinacao_fk FOREIGN KEY (cep) REFERENCES Cep(cep)
);

CREATE TABLE Funcionario(
    cpf VARCHAR2(11) NOT NULL, 
    cnpj VARCHAR2(14) NOT NULL,
    salario NUMBER CHECK (Salario >= 1000.00),
    cpf_supervisor VARCHAR2(255), -- REFERENCIA cpf de funcionario(CONFIRMAR)
    CONSTRAINT funcionario_pk PRIMARY KEY (cpf),
    CONSTRAINT funcionario_fk1 FOREIGN KEY (cpf) REFERENCES Pessoa(cpf),
    CONSTRAINT funcionario_fk2 FOREIGN KEY (cnpj) REFERENCES Ponto_de_vacinacao(cnpj),
    CONSTRAINT funcionario_fk3 FOREIGN KEY (cpf_supervisor) REFERENCES Pessoa(cpf)
);

CREATE TABLE Paciente(
    cpf VARCHAR2(11) NOT NULL,
    dt_cadastro DATE NOT NULL,
    plano_de_saude VARCHAR(255) NOT NULL, 
    CONSTRAINT paciente_pk PRIMARY KEY (cpf),
    CONSTRAINT paciente_fk1 FOREIGN KEY (cpf) REFERENCES Pessoa(cpf),
    CONSTRAINT paciente_fk2 FOREIGN KEY (plano_de_saude) REFERENCES Plano_de_saude(cns)
); 


CREATE TABLE Vacina(
    lote VARCHAR2(255) NOT NULL,
    cnpj VARCHAR2(14) NOT NULL, --REFERENCIA cnpj ponto
    nome VARCHAR2(255) NOT NULL,
    validade DATE NOT NULL,
    quantidade NUMBER NOT NULL,
    CONSTRAINT vacina_pk PRIMARY KEY (cnpj, lote),
    CONSTRAINT vacina_fk FOREIGN KEY (cnpj) REFERENCES Ponto_de_vacinacao(cnpj)
);

CREATE TABLE Agendamento( 
    id INTEGER NOT NULL,
    cpf_paciente VARCHAR2(11) NOT NULL, 
    cpf_funcionario VARCHAR2(11) NOT NULL,
    cnpj VARCHAR2(14) NOT NULL, 
    lote VARCHAR2(255) NOT NULL,
    dt_agendamento TIMESTAMP NOT NULL, -- CONFIRMA TIPO
    status CHAR(1) NOT NULL,
    CONSTRAINT agendamento_pk PRIMARY KEY (id),
    CONSTRAINT agendamento_fk1 FOREIGN KEY (cpf_paciente) REFERENCES Paciente(cpf),
    CONSTRAINT agendamento_fk2 FOREIGN KEY (cpf_funcionario) REFERENCES Funcionario(cpf),
    CONSTRAINT agendamento_fk3 FOREIGN KEY (cnpj, lote) REFERENCES Vacina(cnpj, lote)
);

CREATE TABLE Participa(
    id_agendamento INTEGER NOT NULL,
    nome_campanha VARCHAR2(255) NOT NULL,
    CONSTRAINT participa_pk PRIMARY KEY (id_agendamento),
    CONSTRAINT participa_fk1 FOREIGN KEY (id_agendamento) REFERENCES Agendamento(id),
    CONSTRAINT participa_fk2 FOREIGN KEY (nome_campanha) REFERENCES Campanha_de_vacinacao(nome)
);

CREATE TABLE Telefone_pessoa(
    cpf VARCHAR2(11) NOT NULL,
    telefone VARCHAR2(255) NOT NULL,
    CONSTRAINT telefone_pessoa_pk PRIMARY KEY (cpf, telefone),
    CONSTRAINT telefone_pessoa_fk FOREIGN KEY (cpf) REFERENCES Pessoa(cpf)
);

CREATE TABLE Telefone_ponto(
    cnpj VARCHAR2(14) NOT NULL,
    telefone VARCHAR2(255) NOT NULL,
    CONSTRAINT telefone_ponto_pk PRIMARY KEY (cnpj, telefone),
    CONSTRAINT telefone_ponto_fk FOREIGN KEY (cnpj) REFERENCES Ponto_de_vacinacao(cnpj)
);