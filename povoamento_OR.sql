--Povoamento Ponto de vacinacao

INSERT INTO tb_ponto_de_vacinacao VALUES(
    tp_ponto_de_vacinacao(
        '1001',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999'))
    )
);
/
--Povoamento Funcionarios ---------------------------------------------------
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '2',
        'Gabriel Meireles',
        'gasm@mail.com',
        to_date('01/2/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '232',
            'rua aurora',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999998')),
        20000,
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1001'),
        null
    )
);
/
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '1',
        'Charles Gabriel',
        'cgcm@mail.com',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        10000,
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1001'),
        (SELECT REF(F) FROM tb_funcionario F WHERE F.CPF ='2')
    )
);
/
--Povoamento Pacientes -----------------------------------------------------
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '1',
        'Charles Gabriel',
        'cgcm@mail.com',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        tp_plano_de_saude(
            '0001',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/
--Campanha de vacinacao
INSERT INTO tb_campanha_de_vacinacao VALUES(
    tp_campanha_de_vacinacao(
        1,
        'covid19',
        'Governo de PE',
        to_date('09/11/2009', 'dd/mm/yy'),
        to_date('09/11/2010', 'dd/mm/yy')
    )
);
/
--Vacina
INSERT INTO tb_vacina VALUES(
    tp_vacina(
        '1',
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1001'),
        to_date('09/11/2009', 'dd/mm/yy'),
        'coronavac',
        10
    )
);
/
--Agendamento
INSERT INTO tb_agendamento VALUES(
    tp_agendamento(
        1,
        (SELECT REF(P) FROM tb_paciente P WHERE P.CPF ='1'),
        (SELECT REF(F) FROM tb_funcionario F WHERE F.CPF ='2'),
        (SELECT REF(V) FROM tb_vacina V WHERE V.lote ='1'),
        NULL,
        to_date('09/11/2009', 'dd/mm/yy'),
        '0' 
    )
);
/
SELECT C.nome, C.email, C.DT_NASCIMENTO, C.endereco.cep,C.endereco.rua, C.endereco.bairro, C.endereco.cidade, C.endereco.estado, C.endereco.numero, DEREF(C.ponto).CNPJ, T.*  FROM tb_funcionario C, TABLE(C.telefones) T;
-- SELECT * FROM tb_funcionario; incosistente por referencia
SELECT * FROM tb_paciente;
SELECT * FROM tb_ponto_de_vacinacao;
SELECT * FROM tb_campanha_de_vacinacao;
-- SELECT * FROM tb_vacina; incosistente por referencia
SELECT V.lote, DEREF(V.ponto).CNPJ FROM tb_vacina V;
--SELECT * FROM tb_agendamento; incosistente por referencia
SELECT A.id, DEREF(A.paciente).nome, DEREF(A.funcionario).nome, DEREF(A.vacina).lote FROM tb_agendamento A;
SELECT A.id, DEREF(DEREF(A.vacina).ponto).cnpj ,DEREF(A.paciente).nome, DEREF(A.funcionario).nome, DEREF(A.vacina).lote FROM tb_agendamento A;