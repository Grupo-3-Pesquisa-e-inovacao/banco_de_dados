USE safe_monitor;
-- INSERIR DADOS EMPRESA
INSERT INTO empresa (nome_empresa, cnpj, razao_social, telefone_celular, tipo_instituicao, privada) 
VALUES ("SPTECH", "11.111.111/1111-09", "São Paulo Tech School","(11) 11111-1111", "faculdade", "s");

-- INSERIR DADOS USUÁRIO
INSERT INTO usuario (`email`, `senha`, `nome`, `cargo`, `cadastrar`, `leitura`, `alterar`, `deletar`, `capturar`, `fk_empresa`) 
	VALUES  ("admin@gmail.com", "12345", "Alessandro", "Presidente", 1, 1, 1, 1, 1, 1),
		    ("admin@sptech.school", "12345", "Marcio", "Administrador de TI", 1, 1, 1, 1, 1, 1),
			("melissa@sptech.school", "12345", "Melissa", NULL, 0, 0, 0, 0, 1, 1);

INSERT INTO sala_de_aula (nome, localizacao, fk_usuario, fk_empresa) 
	VALUES ("Sala 1", "1° andar", 2, 1),
	       ("Sala 5", "6° andar, lado B", 3, 1);