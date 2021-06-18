-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema sistema
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bairro` (
  `baisigla` CHAR(3) NOT NULL,
  `bainome` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`baisigla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`escola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`escola` (
  `esccnpj` CHAR(18) NOT NULL,
  `escnome` VARCHAR(100) NOT NULL,
  `escbaisigla` CHAR(3) NOT NULL,
  PRIMARY KEY (`esccnpj`),
  INDEX `fk_empresa_bairro_idx` (`escbaisigla` ASC),
  CONSTRAINT `fk_empresa_bairro`
    FOREIGN KEY (`escbaisigla`)
    REFERENCES `mydb`.`bairro` (`baisigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor` (
  `procpf` CHAR(14) NOT NULL,
  `pronome` VARCHAR(80) NOT NULL,
  `prodtadmissao` DATE NOT NULL,
  `prodtdemissao` DATE NULL,
  PRIMARY KEY (`procpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`conselho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`conselho` (
  `cnscnpj` CHAR(18) NOT NULL,
  PRIMARY KEY (`cnscnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contrato` (
  `conempcnpj` CHAR(18) NOT NULL,
  `conprocpf` VARCHAR(10) NOT NULL,
  `condtinicio` DATE NOT NULL,
  `condtfim` DATE NULL,
  `condtregistroconselho` DATE NULL,
  `concnscnpj` CHAR(18) NOT NULL,
  PRIMARY KEY (`conempcnpj`, `conprocpf`, `condtinicio`),
  INDEX `fk_contrato_empresa1_idx` (`conempcnpj` ASC),
  INDEX `fk_contrato_funcionario1_idx` (`conprocpf` ASC),
  INDEX `fk_contrato_conselho1_idx` (`concnscnpj` ASC),
  CONSTRAINT `fk_contrato_empresa1`
    FOREIGN KEY (`conempcnpj`)
    REFERENCES `mydb`.`escola` (`esccnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_funcionario1`
    FOREIGN KEY (`conprocpf`)
    REFERENCES `mydb`.`professor` (`procpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_conselho1`
    FOREIGN KEY (`concnscnpj`)
    REFERENCES `mydb`.`conselho` (`cnscnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estatutario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estatutario` (
  `estprocpf` CHAR(14) NOT NULL,
  PRIMARY KEY (`estprocpf`),
  CONSTRAINT `fk_engenheiro_funcionario1`
    FOREIGN KEY (`estprocpf`)
    REFERENCES `mydb`.`professor` (`procpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`temporario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`temporario` (
  `temprocpf` CHAR(14) NOT NULL,
  PRIMARY KEY (`temprocpf`),
  CONSTRAINT `fk_tecnico_funcionario1`
    FOREIGN KEY (`temprocpf`)
    REFERENCES `mydb`.`professor` (`procpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coordenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`coordenador` (
  `cooestprocpf` CHAR(14) NOT NULL,
  PRIMARY KEY (`cooestprocpf`),
  CONSTRAINT `fk_mecanico_engenheiro1`
    FOREIGN KEY (`cooestprocpf`)
    REFERENCES `mydb`.`estatutario` (`estprocpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gerencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gerencia` (
  `gercooestprocpf` CHAR(14) NOT NULL,
  `gertemprocpf` CHAR(14) NOT NULL,
  `gerdtinicio` DATE NOT NULL,
  `gerdtfim` DATE NULL,
  PRIMARY KEY (`gercooestprocpf`, `gertemprocpf`, `gerdtinicio`),
  INDEX `fk_gerencia_tecnico1_idx` (`gertemprocpf` ASC),
  INDEX `fk_gerencia_mecanico1_idx` (`gercooestprocpf` ASC),
  CONSTRAINT `fk_gerencia_tecnico1`
    FOREIGN KEY (`gertemprocpf`)
    REFERENCES `mydb`.`temporario` (`temprocpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gerencia_mecanico1`
    FOREIGN KEY (`gercooestprocpf`)
    REFERENCES `mydb`.`coordenador` (`cooestprocpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`projeto` (
  `prjsigla` CHAR(3) NOT NULL,
  `prjdescricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`prjsigla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `prdsigla` CHAR(3) NOT NULL,
  `prdvalor` DECIMAL(9,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`prdsigla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`atendimento` (
  `ateestprocpf` VARCHAR(10) NOT NULL,
  `ateprjsigla` CHAR(3) NOT NULL,
  `atedata` DATE NOT NULL,
  PRIMARY KEY (`ateestprocpf`, `ateprjsigla`),
  INDEX `fk_atendimento_projeto1_idx` (`ateprjsigla` ASC),
  CONSTRAINT `fk_atendimento_engenheiro1`
    FOREIGN KEY (`ateestprocpf`)
    REFERENCES `mydb`.`estatutario` (`estprocpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atendimento_projeto1`
    FOREIGN KEY (`ateprjsigla`)
    REFERENCES `mydb`.`projeto` (`prjsigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`publicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publicacao` (
  `impprjsigla` CHAR(3) NOT NULL,
  `impprosigla` CHAR(3) NOT NULL,
  `impdtinicio` DATE NOT NULL,
  `impdtfim` DATE NULL,
  `impvalor` DECIMAL(9,2) UNSIGNED NULL,
  `impmecengfunctps` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`impprjsigla`, `impprosigla`),
  INDEX `fk_implantacao_projeto1_idx` (`impprjsigla` ASC),
  INDEX `fk_implantacao_produto1_idx` (`impprosigla` ASC),
  INDEX `fk_implantacao_mecanico1_idx` (`impmecengfunctps` ASC),
  CONSTRAINT `fk_implantacao_projeto1`
    FOREIGN KEY (`impprjsigla`)
    REFERENCES `mydb`.`projeto` (`prjsigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_implantacao_produto1`
    FOREIGN KEY (`impprosigla`)
    REFERENCES `mydb`.`produto` (`prdsigla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_implantacao_mecanico1`
    FOREIGN KEY (`impmecengfunctps`)
    REFERENCES `mydb`.`coordenador` (`cooestprocpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
