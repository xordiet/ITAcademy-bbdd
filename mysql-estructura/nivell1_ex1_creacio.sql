-- MySQL Workbench Synchronization
-- Generated: 2021-12-16 13:12
-- Model: Optica Cul dAmpolla
-- Version: 1.0
-- Project: IT Academy S201
-- Author: Jordi Borràs i Vivó

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER SCHEMA `S201_n1_ex1`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `test`.`proveidors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `adresa_carrer` VARCHAR(255) NULL DEFAULT NULL,
  `adresa_num` INT(4) NULL DEFAULT NULL,
  `adresa_pis` VARCHAR(15) NULL DEFAULT NULL,
  `adresa_porta` VARCHAR(5) NULL DEFAULT NULL,
  `adresa_altres` VARCHAR(45) NULL DEFAULT NULL,
  `adresa_ciutat` VARCHAR(150) NULL DEFAULT NULL,
  `adresa_cp` INT(5) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `adresa_pais` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_nom` (`nom` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `test`.`ulleres` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `marca_id` INT(11) NULL DEFAULT NULL,
  `gradua_ud` FLOAT(3,2) NULL DEFAULT NULL COMMENT 'graduació ull dret',
  `gradua_ue` FLOAT(3,2) NULL DEFAULT NULL COMMENT 'graduació ull esquerra',
  `tipus_montura` ENUM('flotant', 'pasta', 'metàl·lica') NULL DEFAULT NULL,
  `color_montura` VARCHAR(45) NULL DEFAULT NULL,
  `color_vd` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Color del vidre dret',
  `color_ve` VARCHAR(45) NULL DEFAULT NULL COMMENT 'color del vidre esquerra',
  `preu` FLOAT(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ulleres_marques_idx` (`marca_id` ASC),
  CONSTRAINT `fk_ulleres_marques`
    FOREIGN KEY (`marca_id`)
    REFERENCES `test`.`marques` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `test`.`clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `adresa_postal` TEXT(1024) NULL DEFAULT NULL,
  `telefon` INT(9) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `recomenat_per` INT(11) NULL DEFAULT NULL,
  `data_registre` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_cients_cients_idx` (`recomenat_per` ASC),
  CONSTRAINT `fk_cients_cients`
    FOREIGN KEY (`recomenat_per`)
    REFERENCES `test`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `test`.`marques` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(150) NOT NULL,
  `proveidor_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marques_proveidors_idx` (`proveidor_id` ASC),
  CONSTRAINT `fk_marques_proveidors`
    FOREIGN KEY (`proveidor_id`)
    REFERENCES `test`.`proveidors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `test`.`treballadors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NULL DEFAULT NULL,
  `alta` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `test`.`vendes` (
  `vendes_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ullera_id` INT(11) NULL DEFAULT NULL,
  `venedor_id` INT(11) NULL DEFAULT NULL,
  `client_id` INT(11) NULL DEFAULT NULL,
  `data_venda` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vendes_id`),
  INDEX `fk_vendes_ulleres1_idx` (`ullera_id` ASC),
  INDEX `fk_vendes_treballadors1_idx` (`venedor_id` ASC),
  INDEX `fk_vendes_cients1_idx` (`client_id` ASC),
  CONSTRAINT `fk_vendes_ulleres1`
    FOREIGN KEY (`ullera_id`)
    REFERENCES `test`.`ulleres` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendes_treballadors1`
    FOREIGN KEY (`venedor_id`)
    REFERENCES `test`.`treballadors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendes_cients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `test`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
