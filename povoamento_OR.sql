--Povoamento Funcionarios ---------------------------------------------------
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '2',
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
        10000
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
        )
    )
);

/
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
        tp_arr_telefone(tp_telefone('99999999')),
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
        to_date('09/11/2009', 'dd/mm/yy'),
        '0' 
    )
);

/

SELECT * FROM tb_funcionario;
SELECT * FROM tb_paciente;
SELECT * FROM tb_ponto_de_vacinacao;
SELECT * FROM tb_campanha_de_vacinacao;
SELECT * FROM tb_vacina;
SELECT * FROM tb_agendamento;