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

SELECT * FROM tipo_dados;
SELECT * FROM  tipo_notificacao;

-- NÃO ESQUECE DE COLOCAR NO JAVAAAA
INSERT INTO limites (fk_notificacao, fk_tipoDados) VALUES (1, 5), (1, 6), (1, 7), (2, 5), (2, 6), (2, 7);

UPDATE limites SET limite = 10 WHERE fk_notificacao = 1 AND fk_tipoDados = 5;


INSERT INTO notificacao (data_hora, fk_idCaptura, fk_tipoDados, fk_componente, fk_maquina, fk_tipoComponente, fk_tipoNotificacao) 
VALUES (now(), NULL, NULL, NULL, NULL, NULL, NULL);

SELECT * FROM notificacao;
SELECT COUNT(*) as totalDia, 
       HOUR(data_hora) as hora 
FROM notificacao 
WHERE fk_tipoNotificacao = 2 
GROUP BY hora
LIMIT 10;
UPDATE notificacao SET fk_tipoNotificacao = 1 WHERE fk_tipoDados = 5;

SELECT COUNT(*) as total, 
    HOUR(data_hora) as hora, fk_tipoNotificacao as tipoNot
FROM notificacao 
GROUP BY hora, tipoNot , data_hora
ORDER BY data_hora
LIMIT 10;
DESC maquina;
SELECT count(*) as total, stt_maquina AS stt 
FROM maquina WHERE fk_empresa = 1 
GROUP BY stt;

SELECT count(*) as total, ligada 
FROM maquina WHERE fk_empresa = 1 
GROUP BY ligada;

SELECT * FROM notificacao;


   SELECT COUNT(*) as total, 
    HOUR(data_hora) as hora, fk_tipoNotificacao as tipoNot
    FROM notificacao 
    GROUP BY hora, tipoNot , ;
    
SELECT * FROM tipo_componente;
use safe_monitor;
DESC notificacao;
CALL procedures_not();
SELECT * FROM captura_dados;

DROP DATABASE safe_monitor;
UPDATE maquina SET stt_maquina = "OK" WHERE idMaquina = 4;
UPDATE maquina SET ligada = "S" WHERE idMaquina = 4;
UPDATE janela SET matar =1 WHERE idJanela = 25;
SELECT * FROM alerta;

CALL procedures_not();

SELECT * FROM alerta;

UPDATE alerta SET verificado = "S" WHERE idAlerta = 3;

CALL procedures_not(1);

SELECT
  HOUR(data_hora) as hora,
  (SELECT COUNT(*) FROM alerta WHERE fk_tipoAlerta = 1 AND HOUR(data_hora) = hora) AS totalAviso,
  (SELECT COUNT(*) FROM alerta WHERE fk_tipoAlerta = 2 AND HOUR(data_hora) = hora) AS totalUrgente
FROM alerta
GROUP BY hora;
 SELECT * FROM alerta WHERE fk_maquina = 1 AND fk_tipoAlerta = 1;


TRUNCATE TABLE alerta;
    select  HOUR(data_hora) as hora, count(*) from alerta where fk_tipoAlerta = 1 GROUP BY hora;
    select  HOUR(data_hora) as hora, count(*) from alerta where fk_tipoAlerta = 2 GROUP BY hora;