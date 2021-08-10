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
            'PE'
        ),
        10000
    )
)

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
            'PE'
        ),
        tp_plano_de_saude(
            '0001',
            'bradesco',
            '1111'
        )
    