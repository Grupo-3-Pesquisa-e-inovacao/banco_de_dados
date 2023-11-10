USE safe_monitor;

-- INSERIR DADOS EMPRESA
INSERT INTO empresa (nome_empresa, cnpj, razao_social, telefone_celular, tipo_instituicao, privada) 
VALUES ("SPTECH", "11.111.111/1111-09", "São Paulo Tech School","(11) 11111-1111", "faculdade", "s");

SELECT * FROM empresa;

-- INSERIR DADOS USUÁRIO
INSERT INTO usuario (`email`, `senha`, `nome`, `cargo`, `cadastrar`, `leitura`, `alterar`, `deletar`, `capturar`, `fk_empresa`) 
	VALUES  ("admin@gmail.com", "12345", "Alessandro", "Presidente", 1, 1, 1, 1, 1, 1),
		    ("admin@sptech.school", "12345", "Marcio", "Administrador de TI", 1, 1, 1, 1, 1, 1),
			("melissa@sptech.school", "12345", "Melissa", NULL, 0, 0, 0, 0, 1, 1);
SELECT * FROM usuario;

INSERT INTO sala_de_aula (nome, localizacao, fk_usuario, fk_empresa) 
	VALUES ("Sala 1", "1° andar", 2, 1),
	       ("Sala 5", "6° andar, lado B", 3, 1);
           
           
SELECT * FROM sala_de_aula;

-- INSERTS MAQUINAS 
INSERT INTO maquina (`idMaquina`, `modelo`, `numero_serie`, `marca`, `fk_sala`, `fk_empresa`) 
VALUES (NULL, 'Modelo1', 'Serie1', 'Marca1',  1, 1),
       (NULL, 'Modelo2', 'Serie2', 'Marca2',  2, 1),
       (NULL, 'Modelo3', 'Serie3', 'Marca3',  1, 1),
       (NULL, 'Modelo4', 'Serie4', 'Marca4', 2, 1);


-- INSERT COMPONENTE
INSERT INTO componente (`nome`) VALUES ("Processador"),
										("Rede"),
										("Ram"),
										("Disco");
SELECT * FROM componente WHERE nome = "Rede";

									
-- INSERT TIPO COMPONENTES
INSERT INTO tipo_componente (`fk_componente`, `fk_maquina`) VALUES (1, 1), (2, 1), (3, 1), (4,1);
INSERT INTO tipo_componente (`fk_componente`, `fk_maquina`) VALUES (1, 2), (2, 2), (3, 2), (4,2);
INSERT INTO tipo_componente (`fk_componente`, `fk_maquina`) VALUES (1, 3), (2, 3), (3, 3), (4,3);
INSERT INTO tipo_componente (`fk_componente`, `fk_maquina`) VALUES (1, 4), (2, 4), (3, 4), (4,4);


INSERT INTO tipo_dados(`nome`) 
					VALUES ("Uso CPU"),
						   ("Uso Disco"),
						   ("Uso Ram"),
						   ("Pacotes Enviados"),
                           ("Pacotes Recibidos");
                           
SELECT * FROM tipo_dados;

                               

