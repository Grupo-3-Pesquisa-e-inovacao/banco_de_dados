CREATE DATABASE safe_monitor;
USE safe_monitor;

CREATE TABLE IF NOT EXISTS empresa (
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


CREATE TABLE IF NOT EXISTS usuario (
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

CREATE TABLE IF NOT EXISTS sala_de_aula (
   idSala INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   nome VARCHAR(45) NOT NULL,
   localizacao TEXT NOT NULL,
   fk_usuario INT NOT NULL,
   fk_empresa INT NOT NULL,
   CONSTRAINT const_fkUsuario FOREIGN KEY (fk_usuario)  REFERENCES usuario(idUsuario) ON DELETE NO ACTION,
   CONSTRAINT const_sala_fkEmpresa FOREIGN KEY (fk_empresa)  REFERENCES empresa(idEmpresa) ON DELETE CASCADE
  );


CREATE TABLE IF NOT EXISTS maquina (
   idMaquina INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   hostName VARCHAR(80) NOT NULL,
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


CREATE TABLE IF NOT EXISTS historico_usuarios (
  idHistoricoUsuario INT NOT NULL AUTO_INCREMENT,
  fk_usuario INT NOT NULL,
  fk_maquina INT NOT NULL,
  data_hora DATETIME default current_timestamp,
  PRIMARY KEY (idHistoricoUsuario, fk_usuario, fk_maquina),
  CONSTRAINT FOREIGN KEY (fk_usuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE,
  CONSTRAINT fk_historicoUsuarios_maquina FOREIGN KEY (fk_maquina) REFERENCES maquina (idMaquina) ON DELETE CASCADE);
  

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
  idTipoComponente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  decricao TEXT NULL,
  PRIMARY KEY (idTipoComponente));


CREATE TABLE IF NOT EXISTS componente (
  idComponente INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NULL,
  modelo VARCHAR(255) NULL,
  total DECIMAL(6,2) NULL,
  fk_maquina INT NOT NULL,
  fk_tipoComponente INT NOT NULL,
  PRIMARY KEY (idComponente, fk_maquina, fk_tipoComponente),
  CONSTRAINT fk_componente_fk_maquina FOREIGN KEY (fk_maquina)
    REFERENCES maquina (idMaquina) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_componente_tipoComponente FOREIGN KEY (fk_tipoComponente)
    REFERENCES tipo_componente (idTipoComponente) ON DELETE CASCADE ON UPDATE CASCADE
);					


CREATE TABLE IF NOT EXISTS tipo_dados (
  idTipoDados INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  fk_componente INT,
  fk_maquina INT,
  fk_tipoComponente INT ,
  PRIMARY KEY (idTipoDados, fk_componente, fk_maquina, fk_tipoComponente),
  CONSTRAINT fk_tipo_dados_componente FOREIGN KEY (fk_componente)
  REFERENCES componente (idComponente) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tipo_dados_maquina FOREIGN KEY (fk_maquina)
  REFERENCES componente (fk_maquina) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tipo_dados_tipoComponente FOREIGN KEY (fk_tipoComponente)
  REFERENCES componente (fk_tipoComponente) ON DELETE CASCADE ON UPDATE CASCADE
  );  
  
CREATE TABLE IF NOT EXISTS tipo_notificacao(
  idTipo_notificacao INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  cor VARCHAR(6) NULL
);

CREATE TABLE IF NOT EXISTS limites (
   limite DECIMAL(6,2) NULL,
   fk_notificacao INT NOT NULL,
   fk_tipoDados INT NOT NULL,
  PRIMARY KEY (fk_notificacao, fk_tipoDados),
  CONSTRAINT fk_limites_fk_noticiacao FOREIGN KEY (fk_notificacao)
  REFERENCES tipo_notificacao (idTipo_notificacao) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT  fk_limites_tipoDados FOREIGN KEY (fk_tipoDados) REFERENCES tipo_dados (idTipoDados)
  ON DELETE CASCADE ON UPDATE CASCADE);
  
  
CREATE TABLE IF NOT EXISTS captura_dados (
  idCaptura INT NOT NULL AUTO_INCREMENT,
  valor_monitorado DECIMAL(5,2) NULL,
  dt_hora DATETIME NULL,
  fk_tipoDados INT NOT NULL,
  fk_componente INT NOT NULL,
  fk_maquina INT NOT NULL,
  fk_tipoComponente INT NOT NULL,
  PRIMARY KEY (idCaptura, fk_tipoDados, fk_componente, fk_maquina, fk_tipoComponente),
  CONSTRAINT fk_captura_tipo_dados FOREIGN KEY (fk_tipoDados)
    REFERENCES tipo_dados (idTipoDados) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_captura_componente FOREIGN KEY (fk_componente)
    REFERENCES tipo_dados (fk_componente) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_captura_maquina FOREIGN KEY (fk_maquina)
    REFERENCES tipo_dados (fk_maquina)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_captura_tipoComponente FOREIGN KEY (fk_tipoComponente)
    REFERENCES tipo_dados (fk_tipoComponente) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS notificacao (
  data_hora DATETIME NULL,
  fk_idCaptura INT NOT NULL,
  fk_tipoDados INT NOT NULL,
  fk_componente INT NOT NULL,
  fk_maquina INT NOT NULL,
  fk_tipoComponente INT NOT NULL,
  fk_limites_notificacao INT NOT NULL,
  fk_limites_tipoDados INT NOT NULL,
  PRIMARY KEY (fk_idCaptura, fk_tipoDados, fk_componente, fk_maquina, fk_tipoComponente, fk_limites_notificacao, fk_limites_tipoDados),
  CONSTRAINT fk_notificacao_captura FOREIGN KEY (fk_idCaptura) REFERENCES captura_dados (idCaptura)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_notificacao_tipoDados FOREIGN KEY (fk_tipoDados) REFERENCES captura_dados (fk_tipoDados)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_notificacao_componente FOREIGN KEY (fk_componente) REFERENCES captura_dados (fk_componente)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_notificacao_maquina FOREIGN KEY (fk_maquina) REFERENCES captura_dados (fk_maquina)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_notificacao_limites FOREIGN KEY (fk_limites_notificacao)
    REFERENCES limites (fk_notificacao) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tipoDados_limites FOREIGN KEY (fk_limites_tipoDados)
    REFERENCES limites (fk_tipoDados) ON DELETE CASCADE ON UPDATE CASCADE);

DROP TABLE notificacao;



