CREATE DATABASE safe_monitor;
USE safe_monitor;

CREATE TABLE empresa (
   IdEmpresa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome_empresa VARCHAR(255) NOT NULL,
   cnpj VARCHAR(45) NOT NULL,
   razao_social VARCHAR(255) NOT NULL,
   telefone_celular VARCHAR(15) NOT NULL,
   telefone_fixo VARCHAR(14) NULL,
   telefone2_celular VARCHAR(15) NULL,
   tipo_instituicao VARCHAR(30) NOT NULL,
   privada VARCHAR(1) NOT NULL,
   cep VARCHAR(9) NULL,
   cidade VARCHAR(80) NULL,
   estado VARCHAR(80) NULL,
   rua VARCHAR(150) NULL,
   numero INT(5) NULL,
   complemento VARCHAR(45) NULL,
   bairro VARCHAR(45) NULL,
   CONSTRAINT chkTipoInstituicao CHECK(tipo_instituicao in ("escola", "faculdade", "universidade")),
   CONSTRAINT chkPrivada CHECK (privada in ("s", "n"))
   );


CREATE TABLE usuario (
   idUsuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   email  VARCHAR(120) NOT NULL,
   senha VARCHAR(30) NOT NULL,
   nome  VARCHAR(45) NULL,
   cargo VARCHAR(45) NULL,
   cadastrar TINYINT NOT NULL,
   leitura TINYINT NOT NULL,
   alterar TINYINT NOT NULL,
   deletar TINYINT NOT NULL,
   capturar TINYINT NOT NULL,
   fk_empresa INT NOT NULL,
   CONSTRAINT chk_cadastro CHECK (cadastrar IN (0, 1)), 
   CONSTRAINT chk_leitura CHECK (leitura IN (0, 1)), 
   CONSTRAINT chk_alterar CHECK (alterar IN (0, 1)), 
   CONSTRAINT chk_deletar CHECK (deletar IN (0, 1)), 
   CONSTRAINT chk_capturar CHECK (capturar IN (0, 1)), 
   CONSTRAINT const_fkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa (IdEmpresa) ON DELETE CASCADE
);

CREATE TABLE sala_de_aula (
   idSala INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45) NOT NULL,
   localizacao TEXT NOT NULL,
   fk_usuario INT NOT NULL,
   fk_empresa INT NOT NULL,
   CONSTRAINT const_fkUsuario FOREIGN KEY (fk_usuario)  REFERENCES usuario(idUsuario) ON DELETE NO ACTION,
   CONSTRAINT const_sala_fkEmpresa FOREIGN KEY (fk_empresa)  REFERENCES empresa(idEmpresa) ON DELETE CASCADE
  );


CREATE TABLE maquina (
   idMaquina INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45),
   modelo VARCHAR(45) NULL,
   numero_serie VARCHAR(15) NULL,
   marca  VARCHAR(30) NULL,
   sistema_operacional VARCHAR(15) NULL,
   arquitetura INT NULL,
   fabricante VARCHAR(50) NULL,
   ligada CHAR(1) NULL,
   endereco_ipv4 VARCHAR(16), 
   endereco_mac VARCHAR(18), 
   fk_sala INT NOT NULL,
   fk_empresa INT NOT NULL,
   CONSTRAINT chkLigada CHECK (ligada IN("S", "N")),
   CONSTRAINT const_fkSala FOREIGN KEY (fk_sala) REFERENCES sala_de_aula (idSala) ON DELETE CASCADE,
   CONSTRAINT const_maquina_fkEmpresa FOREIGN KEY (fk_empresa)  REFERENCES empresa(idEmpresa) ON DELETE CASCADE
);

CREATE TABLE historico_usuarios (
  idHistoricoUsuario INT NOT NULL AUTO_INCREMENT,
  fk_usuario INT NOT NULL,
  fk_maquina INT NOT NULL,
  data_hora DATETIME default current_timestamp,
  PRIMARY KEY (idHistoricoUsuario, fk_usuario, fk_maquina),
  CONSTRAINT FOREIGN KEY (fk_usuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE,
  CONSTRAINT fk_historicoUsuarios_maquina FOREIGN KEY (fk_maquina) REFERENCES maquina (idMaquina) ON DELETE CASCADE);
  
SELECT * FROM janela;
CREATE TABLE IF NOT EXISTS janela (
  idJanela INT NOT NULL AUTO_INCREMENT,
  pid INT NULL,
  titulos TEXT NULL,
  comandos TEXT NULL,
  dt_hora DATETIME default current_timestamp,
  stt VARCHAR(20),
  matar TINYINT(1) NULL, 
  fk_maquina INT NOT NULL,
  PRIMARY KEY (idJanela, fk_maquina),
  CONSTRAINT chk_stt CHECK (stt IN ("Fechada", "Aberta")),
  CONSTRAINT const_fk_maquina FOREIGN KEY (fk_maquina)REFERENCES maquina (idMaquina) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS tipo_componente (
  `idTipoComponente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `decricao` TEXT NULL,
  PRIMARY KEY (`idTipoComponente`));

CREATE TABLE IF NOT EXISTS componente (
  `idComponente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  `modelo` VARCHAR(255) NULL,
  `total` DECIMAL(6,2) NULL,
  `fk_maquina` INT NOT NULL,
  `fk_tipoComponente` INT NOT NULL,
  PRIMARY KEY (`idComponente`, `fk_maquina`, `fk_tipoComponente`),
  INDEX `fk_maquina_has_componente_componente1_idx` (`fk_tipoComponente` ASC) VISIBLE,
  INDEX `fk_maquina_has_componente_maquina1_idx` (`fk_maquina` ASC) VISIBLE,
  CONSTRAINT `fk_maquina_has_componente_maquina1`
    FOREIGN KEY (`fk_maquina`)
    REFERENCES maquina (`idMaquina`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_maquina_has_componente_componente1`
    FOREIGN KEY (`fk_tipoComponente`)
    REFERENCES tipo_componente (`idTipoComponente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

  CREATE TABLE tipo_dados (
  idTipoDados INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  limite_inicial DECIMAL(5,2) NULL,
  limite_final DECIMAL(5,2) NULL
  );
  
  
CREATE TABLE IF NOT EXISTS captura_dados (
  `idCaptura` INT NOT NULL AUTO_INCREMENT,
  `valor_monitorado` DECIMAL(5,2) NULL,
  `dt_hora` DATETIME NULL,
  `fk_tiposDados` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `fk_componente` INT NOT NULL,
  `fk_tipoComponente` INT NOT NULL,
  PRIMARY KEY (`idCaptura`, `fk_tiposDados`, `fk_maquina`, `fk_componente`, `fk_tipoComponente`),
  CONSTRAINT `fk_componente_has_tipoDados_tipoDados` FOREIGN KEY (`fk_tiposDados`) REFERENCES tipo_dados (`idTipoDados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_captura_dados_maquina` FOREIGN KEY (`fk_maquina` )
    REFERENCES componente (`fk_maquina` ),
  CONSTRAINT `fk_captura_dados_tipo_componente` FOREIGN KEY ( `fk_tipoComponente` )
    REFERENCES componente (`fk_tipoComponente`),
  CONSTRAINT `fk_captura_dados_componente` FOREIGN KEY (`fk_componente`)
    REFERENCES componente (`idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
  
CREATE TABLE tipo_notificacao(
  idTipo_notificacao INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  cor VARCHAR(6) NULL
);

CREATE TABLE IF NOT EXISTS notificacao (
  `data_hora` DATETIME NULL,
  `fk_tipoNotificacao` INT NOT NULL,
  `fk_captura_tiposDados` INT NOT NULL,
  `fk_captura_maquina` INT NOT NULL,
  `fk_captura_componente` INT NOT NULL,
  `fk_captura` INT NOT NULL,
  `fk_tipoComponente` INT NULL,
  PRIMARY KEY (`fk_tipoNotificacao`, `fk_captura_tiposDados`, `fk_captura_maquina`, `fk_captura_componente`, `fk_captura`),
  CONSTRAINT `fk_notificacao_tipo_notificacao1`
    FOREIGN KEY (`fk_tipoNotificacao`) 
    REFERENCES tipo_notificacao (`idTipo_notificacao`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_notificacao_captura_dados`
    FOREIGN KEY (`fk_captura`)
    REFERENCES captura_dados (`idCaptura`) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  CONSTRAINT `fk_notificacao_tipoDados`
    FOREIGN KEY (`fk_captura_tiposDados`)
    REFERENCES captura_dados (`fk_tiposDados`) ON DELETE NO ACTION ON UPDATE NO ACTION, 
  CONSTRAINT `fk_notificacao_maquina`
    FOREIGN KEY ( `fk_captura_maquina`)
    REFERENCES captura_dados (`fk_maquina` ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_notificacao_componente`
    FOREIGN KEY (`fk_captura_componente`)
    REFERENCES captura_dados (`fk_componente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_notificacao_tipoComonente`
    FOREIGN KEY (`fk_tipoComponente`)
    REFERENCES captura_dados (`fk_tipoComponente`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );


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

-- INSERT TIPO COMPONENTE
INSERT INTO tipo_componente (`nome`) VALUES ("Processador"), ("Ram"), ("Disco");