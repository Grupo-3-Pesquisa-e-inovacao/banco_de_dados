use safe_monitor;

SELECT notificacao.data_hora AS "DataHora",
	  tipo.nome AS "Notificação",
      maquina.modelo AS "Máquina",
      componente.nome AS "Componente",
	  captura.nome_monitoramento AS "Monitoramento",
      captura.valor_monitorado AS "Valor Monitorado"
      FROM notificacao JOIN tipo_notificacao AS tipo ON notificacao.fk_TipoNotificacao = tipo.idTipo_notificacao
      JOIN maquina ON notificacao.fk_maquina_notf = maquina.idMaquina
      JOIN componente ON notificacao.fk_componente_notf = componente.idComponente
      JOIN captura_dados AS captura ON componente.idComponente = captura.fk_componente;
      
SELECT * FROM maquina WHERE idMaquina = 2;

SELECT * FROM captura_dados;

SELECT * FROM maquina;
SELECT * FROM componente;