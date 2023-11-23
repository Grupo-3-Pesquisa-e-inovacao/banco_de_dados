USE safe_monitor;
SELECT * FROM usuario;
SELECT * FROM maquina;
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
           
SELECT idSala as id, nome FROM sala_de_aula WHERE fk_empresa = 1;

-- INSERTS MAQUINAS 
INSERT INTO maquina (`idMaquina`, `modelo`, `numero_serie`, `marca`, `fk_sala`, `fk_empresa`, endereco_mac) 
VALUES (NULL, 'Modelo1', 'Serie1', 'Marca1',  1, 1, '1'),
       (NULL, 'Modelo2', 'Serie2', 'Marca2',  2, 1, '2'),
       (NULL, 'Modelo3', 'Serie3', 'Marca3',  1, 1, '3'),
       (NULL, 'Modelo4', 'Serie4', 'Marca4', 2, 1, '4');
       
UPDATE maquina SET endereco_mac = 1 WHERE idMaquina = 1;


DESC componente;
-- INSERT COMPONENTE
DELETE FROM maquina WHERE idMaquina = 5;

INSERT INTO tipo_dados(`nome`) VALUES ("Uso");


                               

SELECT * FROM tipo_componente;
SELECT * FROM componente;
SELECT * FROM maquina;
SELECT * FROM captura_dados;


