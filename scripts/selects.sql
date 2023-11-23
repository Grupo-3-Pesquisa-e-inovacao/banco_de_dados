USE safe_monitor;
TRUNCATE TABLE janela;
SELECT * FROM janela; 
DESC janela;
SELECT * FROM  maquina;

UPDATE maquina SET hostName = "ooo" WHERE idMaquina = 9;
TRUNCATE TABLE janela;
DELETE FROM maquina WHERE idMaquina = 9;
	DESC maquina;
    

DELETE FROM componente WHERE idComponente = 9;
SELECT * FROM componente;
SELECT * FROM tipo_dados;
SELECT * FROM janela WHERE fk_maquina = 2 AND stt = 'Fechada';

SELECT * FROM componente;


-- CRUD USUÁRIOS
-- AUTENTICAR 
SELECT * FROM usuario WHERE email = "admin@gmail.com" AND senha = "12345";
UPDATE janela SET matar = 1 WHERE idJanela = 9;
-- LISTAR 
SELECT * FROM usuario WHERE fk_empresa = 1;

-- CRIAR 
INSERT INTO usuario (email, senha, nome, cargo, cadastrar, leitura, alterar, deletar, capturar, fk_empresa)
	VALUES ("teste@email.com", "12345", "Teste", "cargo", 1, 0, 0, 0, 0, 1);
    
-- DELETAR 
DELETE FROM usuario WHERE idUsuario = 1;

-- CRUD MÁQUINAS
-- LISTAR 
SELECT * FROM maquina WHERE fk_empresa = 1;

-- CRIAR 
INSERT INTO usuario (email, senha, nome, cargo, cadastrar, leitura, alterar, deletar, capturar, fk_empresa)
	VALUES ("teste@email.com", "12345", "Teste", "cargo", 1, 0, 0, 0, 0, 1);
    
-- DELETAR 
DELETE FROM usuario WHERE idUsuario = 1;


DESC maquina;
-- INSERIR MÁQUINA
  INSERT INTO maquina (nome, modelo, numero_serie, marca, fk_empresa, fk_sala)
	    VALUE("DESKTOP 02", "MODELO 08", "12347", "Lenovo", 1, 2);
        
        
-- LISTAR MÁQUINAS 
SELECT * FROM maquina WHERE fk_sala = 1 AND fk_empresa = 1;

-- DELETAR MÁQUINAS
DELETE FROM tipo_componente WHERE fk_maquina = 3;
DELETE FROM maquina WHERE idMaquina = 3;

DESC sala_de_aula;

SELECT * FROM sala_de_aula;

select * from maquina;
SELECT * FROM captura_dados;

SELECT idComponente as id, nome FROM componente WHERE fk_tipoComponente = 1 AND fk_maquina = 1;

select count(*) from maquina where fk_sala = 1;

SELECT * FROM maquina WHERE fk_sala = 1;

SELECT * FROM sala_de_aula;
TRUNCATE TABLE janela;
SELECT * FROM janela;

