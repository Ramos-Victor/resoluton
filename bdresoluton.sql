-- MySQL Script generated by MySQL Workbench
-- Sat Sep 21 17:28:45 2024
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
-- Table `mydb`.`tb_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_usuario` (
  `cd_usuario` INT NOT NULL AUTO_INCREMENT,
  `nm_usuario` VARCHAR(50) NOT NULL,
  `nm_email` VARCHAR(100) NOT NULL,
  `cd_senha` VARCHAR(255) NOT NULL,
  `dt_cadastro` DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  PRIMARY KEY (`cd_usuario`),
  UNIQUE INDEX `usuario_email_UNIQUE` (`nm_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_unidade` (
  `cd_unidade` INT NOT NULL AUTO_INCREMENT,
  `nm_unidade` VARCHAR(100) NOT NULL,
  `dt_unidade` DATETIME NOT NULL DEFAULT current_timestamp,
  `codigo_unidade` VARCHAR(255) NOT NULL,
  `id_criador` INT NOT NULL,
  PRIMARY KEY (`cd_unidade`),
  INDEX `fk_tb_unidade_tb_usuario1_idx` (`id_criador` ASC) VISIBLE,
  CONSTRAINT `fk_tb_unidade_tb_usuario1`
    FOREIGN KEY (`id_criador`)
    REFERENCES `mydb`.`tb_usuario` (`cd_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_usuario_unidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_usuario_unidade` (
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  `cargo_usuario` ENUM('admin', 'suporte', 'comum') NOT NULL,
  `dt_entrada` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id_usuario`, `id_unidade`),
  INDEX `fk_tb_usuario_has_tb_unidade_tb_unidade1_idx` (`id_unidade` ASC) VISIBLE,
  INDEX `fk_tb_usuario_has_tb_unidade_tb_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_tb_usuario_has_tb_unidade_tb_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `mydb`.`tb_usuario` (`cd_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_usuario_has_tb_unidade_tb_unidade1`
    FOREIGN KEY (`id_unidade`)
    REFERENCES `mydb`.`tb_unidade` (`cd_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_sala` (
  `cd_sala` INT NOT NULL AUTO_INCREMENT,
  `nr_sala` VARCHAR(45) NOT NULL,
  `localizacao_sala` VARCHAR(255) NOT NULL,
  `dt_sala` DATETIME NOT NULL DEFAULT current_timestamp,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_sala`),
  UNIQUE INDEX `nr_sala_UNIQUE` (`nr_sala` ASC) VISIBLE,
  INDEX `fk_tb_sala_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_sala_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_equipamento_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_equipamento_categoria` (
  `cd_categoria` INT NOT NULL AUTO_INCREMENT,
  `categoria_nm` VARCHAR(100) NOT NULL,
  `dt_categoria` DATETIME NOT NULL DEFAULT current_timestamp,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_categoria`),
  INDEX `fk_tb_equipamento_categoria_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_equipamento_categoria_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_equipamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_equipamento` (
  `cd_equipamento` INT NOT NULL AUTO_INCREMENT,
  `equipamento_nm` VARCHAR(45) NOT NULL,
  `equipamento_ds` LONGTEXT NOT NULL,
  `equipamento_dt` DATETIME NOT NULL DEFAULT current_timestamp,
  `st_equipamento` ENUM('Funcionando', 'Manuntenção', 'Desativado') NOT NULL DEFAULT 'Funcionando',
  `id_sala` INT NOT NULL,
  `id_categoria` INT NULL,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_equipamento`),
  INDEX `fk_tb_equipamento_tb_sala1_idx` (`id_sala` ASC) VISIBLE,
  INDEX `fk_tb_equipamento_tb_equipamento_categoria1_idx` (`id_categoria` ASC) VISIBLE,
  INDEX `fk_tb_equipamento_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_equipamento_tb_sala1`
    FOREIGN KEY (`id_sala`)
    REFERENCES `mydb`.`tb_sala` (`cd_sala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_equipamento_tb_equipamento_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `mydb`.`tb_equipamento_categoria` (`cd_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_equipamento_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_chamado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_chamado` (
  `cd_chamado` INT NOT NULL AUTO_INCREMENT,
  `nm_chamado` VARCHAR(45) NOT NULL,
  `ds_chamado` LONGTEXT NOT NULL,
  `dt_abertura` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fechamento` DATETIME NULL,
  `st_chamado` CHAR(1) NOT NULL,
  `id_equipamento` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_chamado`),
  INDEX `fk_tb_chamado_tb_equipamento1_idx` (`id_equipamento` ASC) VISIBLE,
  INDEX `fk_tb_chamado_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_chamado_tb_equipamento1`
    FOREIGN KEY (`id_equipamento`)
    REFERENCES `mydb`.`tb_equipamento` (`cd_equipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_chamado_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_categoria_faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_categoria_faq` (
  `cd_categoria_faq` INT NOT NULL AUTO_INCREMENT,
  `nm_categoria_faq` VARCHAR(45) NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_categoria_faq`),
  INDEX `fk_tb_categoria_faq_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_categoria_faq_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_faq` (
  `cd_faq` INT NOT NULL AUTO_INCREMENT,
  `nm_pergunta_faq` VARCHAR(45) NOT NULL,
  `ds_resposta_faq` LONGTEXT NOT NULL,
  `dt_cadastro_faq` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_categoria_faq` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`cd_faq`),
  INDEX `fk_tb_faq_tb_categoria_faq1_idx` (`id_categoria_faq` ASC) VISIBLE,
  INDEX `fk_tb_faq_tb_usuario_unidade1_idx` (`id_usuario` ASC, `id_unidade` ASC) VISIBLE,
  CONSTRAINT `fk_tb_faq_tb_categoria_faq1`
    FOREIGN KEY (`id_categoria_faq`)
    REFERENCES `mydb`.`tb_categoria_faq` (`cd_categoria_faq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_faq_tb_usuario_unidade1`
    FOREIGN KEY (`id_usuario` , `id_unidade`)
    REFERENCES `mydb`.`tb_usuario_unidade` (`id_usuario` , `id_unidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
