--Sequencia de id para Agendamento

CREATE SEQUENCE seq INCREMENT by 1 START WITH 1;

-- Povoamento Cep

INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('101', 'rua estrela', 'Casa forte', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('102', 'rua do bonfim', 'Monteiro', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('103', 'rua aurora', 'Poço', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('104', 'rua da luz', 'Casa forte', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('105', 'rua do cinema', 'Casa amarela', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('106', 'rua da lira', 'Monteiro', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('107', 'rua nortelandia', 'Parnamirin', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('108', 'rua condado', 'Parnamirin', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('109', 'rua padre roma', 'Torre', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('110', 'rua da hora', 'Espinheiro', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('201', 'rua amelia', 'Aflitos', 'Recife', 'PE');
INSERT INTO Cep(cep, rua, bairro, cidade, estado) VALUES ('202', 'rua do futuro', 'Aflitos', 'Recife', 'PE');

-- Povoamento plano de saude

INSERT INTO Plano_de_saude(cns, seguradora, numero_de_cadastro) VALUES ('1', 'Sulamerica', '1');
INSERT INTO Plano_de_saude(cns, seguradora, numero_de_cadastro) VALUES ('2', 'Sulamerica', '2');
INSERT INTO Plano_de_saude(cns, seguradora, numero_de_cadastro) VALUES ('3', 'Hapvida', '1');
INSERT INTO Plano_de_saude(cns, seguradora, numero_de_cadastro) VALUES ('4', 'Bradesco', '1');
INSERT INTO Plano_de_saude(cns, seguradora, numero_de_cadastro) VALUES ('5', 'Unimed', '7');

-- Povoamento Campanha de Vacinação

INSERT INTO Campanha_de_vacinacao(nome, orgao_responsavel, data_de_inicio, data_de_termino) VALUES ('Vacina Brasil 2021', 'Ministerio da Saude', to_date('01/01/2021', 'dd/mm/yy'), to_date('31/12/2021', 'dd/mm/yy'));
INSERT INTO Campanha_de_vacinacao(nome, orgao_responsavel, data_de_inicio) VALUES ('Vacinacao Covid-19', 'Secretaria de saude de Pernambuco', to_date('01/01/2020', 'dd/mm/yy'));

-- Povoamento Pessoa

INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('1', 'Charles Gabriel', 'cgcm@mail.com', to_date('09/11/2001', 'dd/mm/yy'), 'M', '107', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('2', 'Gabriel Meireles', 'gasm@mail.com', to_date('06/02/2001', 'dd/mm/yy'), 'M', '108', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('3', 'Pedro Didier', 'pdm@mail.com', to_date('27/05/2001', 'dd/mm/yy'), 'M', '109', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('4', 'Lorena Carla', 'lcjbv@mail.com', to_date('13/01/2000', 'dd/mm/yy'), 'F', '110', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('5', 'Pedro Tenorio', 'ptl@mail.com', to_date('02/05/2001', 'dd/mm/yy'), 'M', '101', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('6', 'Thais Couto', 'tvc@mail.com', to_date('01/12/2001', 'dd/mm/yy'), 'F', '102', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('7', 'Anna Luiza', 'alcaf@mail.com', to_date('12/10/2000', 'dd/mm/yy'), 'F', '103', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('8', 'Gabriel Pessoa', 'gop@mail.com', to_date('30/03/2001', 'dd/mm/yy'), 'M', '104', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('9', 'Paulo Henrique', 'phltc@mail.com', to_date('21/02/2001', 'dd/mm/yy'), 'M', '105', '1');
INSERT INTO Pessoa(cpf, nome, email, dt_nascimento, sexo, cep, numero) VALUES ('10', 'Nilo Benfica ', 'nbmcd@mail.com', to_date('01/12/2000', 'dd/mm/yy'), 'M', '106', '1');

-- Povoamento Ponto de vacinação

INSERT INTO Ponto_de_vacinacao(cnpj, cep, numero) VALUES ('100', '201', '15');
INSERT INTO Ponto_de_vacinacao(cnpj, cep, numero) VALUES ('200', '202', '108');

-- Povoamento Funcionario

INSERT INTO Funcionario(cpf, cnpj, salario) VALUES ('1', '100', 2000.00);
INSERT INTO Funcionario(cpf, cnpj, salario, cpf_supervisor) VALUES ('2', '100', 1000.00, '1');
INSERT INTO Funcionario(cpf, cnpj, salario, cpf_supervisor) VALUES ('3', '100', 1000.00, '1');
INSERT INTO Funcionario(cpf, cnpj, salario) VALUES ('6', '200', 2000.00);
INSERT INTO Funcionario(cpf, cnpj, salario, cpf_supervisor) VALUES ('7', '200', 1000.00, '6');
INSERT INTO Funcionario(cpf, cnpj, salario, cpf_supervisor) VALUES ('9', '200', 1000.00, '6');

-- Povoamento Paciente

INSERT INTO Paciente(cpf, dt_cadastro, plano_de_saude) VALUES ('4',  to_date('01/01/2020', 'dd/mm/yy'),'1');
INSERT INTO Paciente(cpf, dt_cadastro, plano_de_saude) VALUES ('5',  to_date('01/01/2020', 'dd/mm/yy'),'2');
INSERT INTO Paciente(cpf, dt_cadastro, plano_de_saude) VALUES ('8',  to_date('01/01/2020', 'dd/mm/yy'),'3');
INSERT INTO Paciente(cpf, dt_cadastro, plano_de_saude) VALUES ('10', to_date('01/01/2020', 'dd/mm/yy'), '4');
INSERT INTO Paciente(cpf, dt_cadastro, plano_de_saude) VALUES ('7',  to_date('01/01/2020', 'dd/mm/yy'),'5');

-- Povoamento Vacina

INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (1, '100', 'Vop', to_date('21/12/2021', 'dd/mm/yy'), 4);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (2, '100', 'Tetravalente', to_date('13/2/2022', 'dd/mm/yy'), 21);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (3, '100', 'Pfizer', to_date('21/01/2023', 'dd/mm/yy'), 23);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (4, '100', 'CoronaVac', to_date('03/02/2023', 'dd/mm/yy'), 33);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (5, '100', 'AstraZeneca', to_date('13/11/2023', 'dd/mm/yy'), 12);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (1, '200', 'Vop', to_date('21/11/2022', 'dd/mm/yy'), 7);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (2, '200', 'Triplice Viral', to_date('11/08/2023', 'dd/mm/yy'), 21);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (3, '200', 'Pfizer', to_date('01/05/2021', 'dd/mm/yy'), 3);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (6, '200', 'Pfizer', to_date('01/12/2023', 'dd/mm/yy'), 21);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (5, '200', 'CoronaVac', to_date('05/12/2021', 'dd/mm/yy'), 13);
INSERT INTO Vacina(lote, cnpj, nome, validade, quantidade) VALUES (4, '200', 'AstraZeneca', to_date('01/02/2023', 'dd/mm/yy'), 22);

-- Povoamento Agendamento

INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '4', '2', '100', 4, to_date('2/10/2021', 'dd/mm/yy'), 0);
INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '5', '3', '100', 4, to_date('7/10/2021', 'dd/mm/yy'), 0);
INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '4', '3', '100', 2, to_date('2/05/2021', 'dd/mm/yy'), 1);
INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '8', '7', '200', 6, to_date('25/10/2021', 'dd/mm/yy'), 0);
INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '10', '7', '200', 5, to_date('3/10/2021', 'dd/mm/yy'), 0);
INSERT INTO Agendamento(id, cpf_paciente, cpf_funcionario, cnpj, lote, dt_agendamento, status) VALUES (seq.NEXTVAL, '10', '9', '200', 2, to_date('3/10/2021', 'dd/mm/yy'), 0);

-- Povoamento Participa

INSERT INTO participa(id_agendamento, nome_campanha) VALUES (1, 'Vacinacao Covid-19');
INSERT INTO participa(id_agendamento, nome_campanha) VALUES (2, 'Vacinacao Covid-19');
INSERT INTO participa(id_agendamento, nome_campanha) VALUES (4, 'Vacinacao Covid-19');
INSERT INTO participa(id_agendamento, nome_campanha) VALUES (5, 'Vacinacao Covid-19');

-- Povoamento Telefone pessoa

INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('1', '99999991');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('2', '99999992');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('3', '99999993');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('4', '99999994');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('5', '99999995');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('6', '99999996');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('7', '99999997');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('8', '99999998');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('9', '99999999');
INSERT INTO Telefone_pessoa(cpf, telefone) VALUES ('10', '99999990');

-- Povoamento telefone Ponto de vacinação

INSERT INTO Telefone_ponto(cnpj, telefone) VALUES ('100', '19999999');
INSERT INTO Telefone_ponto(cnpj, telefone) VALUES ('200',  '29999999');