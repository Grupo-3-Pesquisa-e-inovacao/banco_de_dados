USE safe_monitor;

-- INSERIR DADOS EMPRESA
INSERT INTO empresa (nome_empresa, cnpj, razao_social, telefone_celular, tipo_instituicao, privada) 
VALUES ("SPTECH", "11.111.111/1111-09", "São Paulo Tech School","(11) 11111-1111", "faculdade", "s");

SELECT * FROM empresa;

-- INSERIR DADOS USUÁRIO
INSERT INTO usuario (`email`, `senha`, `nome`, `cargo`, `cadastrar`, `leitura`, `alterar`, `deletar`, `capturar`, `fk_empresa`) 
	VALUES  ("admin@gmail.com", "12345", "Alessandro", "Presidente", 1, 1, 1, 1, 0, 1),
		    ("funcionario@sptech.school", "12345", "Marcio", "Administrador de TI", 1, 1, 0, 0, 0, 1),
		    ("professor@sptech.school", "12345", "Eduardo", "Professor", 0, 1, 0, 0, 0, 1),
			("melissa@sptech.school", "12345", NULL, NULL, 0, 0, 0, 0, 1, 1);
SELECT * FROM usuario;

INSERT INTO sala_de_aula (`nome`, `localizacao`, `fk_usuario`) 
	VALUES ("Sala 1", "1° andar", 2),
	       ("Sala 5", "6° andar, lado B", 3);
           
SELECT * FROM sala_de_aula;

-- INSERTS MAQUINAS 
INSERT INTO maquina (`idMaquina`, `modelo`, `numero_serie`, `marca`, `sistema_operacional`, `armazenamento_disco`, `espaco_livre_disco`, `endereco_ipv4`, `capacidade_total_ram`, `fk_sala`) 
VALUES (NULL, 'Modelo1', 'Serie1', 'Marca1', 'Windows', 100.0, 50.0, '192.168.1.1', 8.0, 1),
       (NULL, 'Modelo2', 'Serie2', 'Marca2', 'Linux', 200.0, 100.0, '192.168.1.2', '16.0', 2),
       (NULL, 'Modelo3', 'Serie3', 'Marca3', 'MacOS', 300.0, 150.0, '192.168.1.3', '32.0', 1),
       (NULL, 'Modelo4', 'Serie4', 'Marca4', 'Windows', 400.0, 200.0, '192.168.1.4', '64.0', 2);

-- INSERTS PROCESSO
INSERT INTO processo (`idProcesso`, `nome`, `status_proc`, `tempo_execucao`, `data_hora`, `fk_maquina`) 
	VALUES (NULL, 'Processo1', 'Em execução', '2 horas', '2023-10-09 08:00:00', 1),
	       (NULL, 'Processo2', 'Concluído', '1 hora', '2023-10-09 10:30:00', 2);
           
-- INSERT COMPONENTE
INSERT INTO componente (`idComponente`, `nome`, `descricao`, `fk_maquina_proc`) 
						VALUES (NULL, "CPU", NULL, 1),
						       (NULL, "Rede", NULL, 1),
							   (NULL, "Ram", NULL, 1),
                               (NULL, "Disco", NULL, 1);

-- INSERT CAPTURA DE DADOS 
INSERT INTO captura_dados (`idCaptura`, `nome_monitoramento`, `valor_monitorado`, `data_hora`, `fk_componente`, `fk_maquina_captura`) 
						VALUES (NULL, "Uso atual", 23.0, default, 1, 1),
							   (NULL, "Velocidade", 60.0, default, 2, 2),
                               (NULL, "Uso atual", 7.7, default, 3, 3),
							   (NULL, "Velocidade de leitura", 60.0, default, 4, 4);



