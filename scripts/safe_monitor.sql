-- MySQL Script generated by MySQL Workbench
-- Sun Nov 19 12:39:41 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empresa` (
  `empresa` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `razao_social` VARCHAR(255) NOT NULL,
  `telefone_fixo` VARCHAR(14) NULL,
  `telefone_celular` VARCHAR(15) NULL,
  `tipo_instituicao` VARCHAR(30) NOT NULL,
  `privada` VARCHAR(1) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `cidade` VARCHAR(80) NOT NULL,
  `estado` VARCHAR(80) NOT NULL,
  `rua` VARCHAR(150) NOT NULL,
  `numero` INT(5) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(120) NOT NULL,
  `senha` VARCHAR(30) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cargo` VARCHAR(45) NULL,
  `cadastrar` VARCHAR(1) NOT NULL,
  `leitura` VARCHAR(1) NOT NULL,
  `alterar` VARCHAR(1) NOT NULL,
  `deletar` VARCHAR(1) NOT NULL,
  `capturar` VARCHAR(1) NOT NULL,
  `fk_empresa` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_usuario_empresa_idx` (`fk_empresa` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_empresa`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `mydb`.`empresa` (`empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sala_de_aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sala_de_aula` (
  `idSala` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `localizacao` TEXT NOT NULL,
  `fk_usuario` INT GENERATED ALWAYS AS () VIRTUAL,
  `fk_empresa` INT NOT NULL,
  PRIMARY KEY (`idSala`),
  INDEX `fk_sala_de_aula_usuario1_idx` (`fk_usuario` ASC) VISIBLE,
  INDEX `fk_sala_de_aula_empresa1_idx` (`fk_empresa` ASC) VISIBLE,
  CONSTRAINT `fk_sala_de_aula_usuario1`
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sala_de_aula_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `mydb`.`empresa` (`empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`maquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`maquina` (
  `idMaquina` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `numero_serie` VARCHAR(15) NULL,
  `marca` VARCHAR(30) NULL,
  `sistema_operacional` VARCHAR(80) NULL,
  `arquitetura` INT NULL,
  `fabricante` VARCHAR(45) NULL,
  `endereco_ipv4` VARCHAR(16) NULL,
  `endereco_mac` VARCHAR(18) NULL,
  `stt_maquina` VARCHAR(20) NULL,
  `fk_sala` INT NOT NULL,
  `fk_empresa` INT NOT NULL,
  PRIMARY KEY (`idMaquina`),
  INDEX `fk_maquina_sala_de_aula1_idx` (`fk_sala` ASC) VISIBLE,
  INDEX `fk_maquina_empresa1_idx` (`fk_empresa` ASC) VISIBLE,
  CONSTRAINT `fk_maquina_sala_de_aula1`
    FOREIGN KEY (`fk_sala`)
    REFERENCES `mydb`.`sala_de_aula` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maquina_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `mydb`.`empresa` (`empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_notificacao` (
  `idTipo_notificacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `cor` VARCHAR(6) NULL,
  PRIMARY KEY (`idTipo_notificacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`componente` (
  `idComponente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `modelo` TEXT NULL,
  `total` DECIMAL(6,2) NULL,
  `` VARCHAR(45) NULL,
  PRIMARY KEY (`idComponente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_dados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_dados` (
  `idTipoDados` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `limite_inicial` DECIMAL(5,2) NULL,
  `limite_final` DECIMAL(5,2) NULL,
  PRIMARY KEY (`idTipoDados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_componente` (
  `nome` VARCHAR(20) NULL,
  `fk_maquina` INT NOT NULL,
  `fk_componente` INT NOT NULL,
  PRIMARY KEY (`fk_maquina`, `fk_componente`),
  INDEX `fk_maquina_has_componente_componente1_idx` (`fk_componente` ASC) VISIBLE,
  INDEX `fk_maquina_has_componente_maquina1_idx` (`fk_maquina` ASC) VISIBLE,
  CONSTRAINT `fk_maquina_has_componente_maquina1`
    FOREIGN KEY (`fk_maquina`)
    REFERENCES `mydb`.`maquina` (`idMaquina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maquina_has_componente_componente1`
    FOREIGN KEY (`fk_componente`)
    REFERENCES `mydb`.`componente` (`idComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`captura_dados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`captura_dados` (
  `idCaptura` INT NOT NULL,
  `valor_monitorado` DECIMAL(5,2) NULL,
  `dt_hora` DATETIME NULL,
  `fk_tiposDados` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `fk_componente` INT NOT NULL,
  PRIMARY KEY (`idCaptura`, `fk_tiposDados`, `fk_maquina`, `fk_componente`),
  INDEX `fk_componente_has_tipoDados_tipoDados1_idx` (`fk_tiposDados` ASC) VISIBLE,
  INDEX `fk_captura_dados_tipo_componente1_idx` (`fk_maquina` ASC, `fk_componente` ASC) VISIBLE,
  CONSTRAINT `fk_componente_has_tipoDados_tipoDados1`
    FOREIGN KEY (`fk_tiposDados`)
    REFERENCES `mydb`.`tipo_dados` (`idTipoDados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_captura_dados_tipo_componente1`
    FOREIGN KEY (`fk_maquina` , `fk_componente`)
    REFERENCES `mydb`.`tipo_componente` (`fk_maquina` , `fk_componente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notificacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notificacao` (
  `data_hora` DATETIME NULL,
  `fk_tipoNotificacao` INT NOT NULL,
  `fk_captura_tiposDados` INT NOT NULL,
  `fk_captura_maquina` INT NOT NULL,
  `fk_captura_componente` INT NOT NULL,
  `fk_captura` INT NOT NULL,
  PRIMARY KEY (`fk_tipoNotificacao`, `fk_captura_tiposDados`, `fk_captura_maquina`, `fk_captura_componente`, `fk_captura`),
  INDEX `fk_notificacao_tipo_notificacao1_idx` (`fk_tipoNotificacao` ASC) VISIBLE,
  INDEX `fk_notificacao_captura_dados1_idx` (`fk_captura_tiposDados` ASC, `fk_captura_maquina` ASC, `fk_captura_componente` ASC, `fk_captura` ASC) VISIBLE,
  CONSTRAINT `fk_notificacao_tipo_notificacao1`
    FOREIGN KEY (`fk_tipoNotificacao`)
    REFERENCES `mydb`.`tipo_notificacao` (`idTipo_notificacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notificacao_captura_dados1`
    FOREIGN KEY (`fk_captura_tiposDados` , `fk_captura_maquina` , `fk_captura_componente` , `fk_captura`)
    REFERENCES `mydb`.`captura_dados` (`fk_tiposDados` , `fk_maquina` , `fk_componente` , `idCaptura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`janela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`janela` (
  `idJanela` INT NOT NULL AUTO_INCREMENT,
  `pid` INT NULL,
  `titulos` TEXT NULL,
  `comandos` TEXT NULL,
  `dt_hora` DATETIME NULL,
  `stt` VARCHAR(20) NULL,
  `matar` CHAR(1) NULL,
  `fk_maquina` INT NOT NULL,
  PRIMARY KEY (`idJanela`, `fk_maquina`),
  INDEX `fk_janela_maquina1_idx` (`fk_maquina` ASC) VISIBLE,
  CONSTRAINT `fk_janela_maquina1`
    FOREIGN KEY (`fk_maquina`)
    REFERENCES `mydb`.`maquina` (`idMaquina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`historico_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historico_usuarios` (
  `idHistoricoUsuario` INT NOT NULL AUTO_INCREMENT,
  `fk_usuario` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `data_hora` DATETIME NULL,
  PRIMARY KEY (`idHistoricoUsuario`, `fk_usuario`, `fk_maquina`),
  INDEX `fk_usuario_has_maquina_maquina1_idx` (`fk_maquina` ASC) VISIBLE,
  INDEX `fk_usuario_has_maquina_usuario1_idx` (`fk_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_maquina_usuario1`
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_maquina_maquina1`
    FOREIGN KEY (`fk_maquina`)
    REFERENCES `mydb`.`maquina` (`idMaquina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;