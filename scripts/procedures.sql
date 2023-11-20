USE safe_monitor;

-- PROCEDURE EXIBIR SALAS DE AULA
DELIMITER $$
CREATE PROCEDURE procedure_salas (idEmpresaVar INT)
BEGIN 
	SELECT nome, idSala, localizacao FROM sala_de_aula WHERE fk_empresa = idEmpresaVar;
END $$


-- PROCEDURE EXIBIR MÁQUINAS
DELIMITER $$
CREATE PROCEDURE procedure_maquina (idSalaVar INT)
BEGIN 
	 SELECT * FROM maquina WHERE fk_sala = idSalaVar;
END $$

-- PROCEDURE EXIBIR MÁQUINAS LIGADAS E DESLIGADAS
DELIMITER $$
CREATE PROCEDURE procedure_maquinas_lig_deslg (idSalaVar INT)
BEGIN 

	    SELECT sala_de_aula.nome as nomeSala, 
        (select count(*) from maquina where fk_sala = idSalaVar) AS totalMaquina, 
        (select count(*) from maquina where fk_sala = idSalaVar AND ligada = "S") AS maquinasLigadas,
        (select count(*) from maquina where fk_sala = idSalaVar AND ligada = "N") AS maquinasDesligadas
        FROM sala_de_aula WHERE idSala = idSalaVar;

END $$

-- PROCEDURE EXIBIR MÁQUINAS LIGADAS E DESLIGADAS
DELIMITER $$
CREATE PROCEDURE ultimo_valor_captura(componenteVar INT, tipoDados INT, maquina INT)
BEGIN 
	SELECT c.nome as componente, td.nome as dadoCapturado, dt_hora, valor_monitorado as valor   
	FROM captura_dados  AS cd JOIN tipo_componente AS c ON c.idTipoComponente = cd.fk_componente
	JOIN  tipo_dados AS td ON td.idTipoDados = cd.fk_tiposDados
	WHERE fk_tipoComponente = componenteVar AND fk_maquina = maquina AND fk_tiposDados = tipoDados ORDER BY dt_hora DESC 
	LIMIT 1;
END $$

DELIMITER $$
CREATE PROCEDURE graficos_especificos(componenteVar INT, maquinaVar INT, limitVar INT)
BEGIN 
	SELECT 	valor_monitorado as valor, dt_hora FROM captura_dados 
    WHERE fk_maquina = maquinaVar AND fk_tipoComponente = componenteVar 
    ORDER BY dt_hora DESC LIMIT limitVar;
END $$

DELIMITER $$
CREATE PROCEDURE info_componente(componenteVar INT, maquinaVar INT)
BEGIN 
	select * from componente WHERE fk_maquina = maquinaVar AND fk_tipoComponente = componenteVar;
END $$

