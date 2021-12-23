-- MySQL Workbench Synchronization
-- Generated: 2021-12-23 08:52
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Jordi Borràs i Vivó

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(75) NOT NULL,
  `cognoms` VARCHAR(200) NOT NULL,
  `adresa` VARCHAR(255) NULL DEFAULT NULL,
  `codi_postal` INT(5) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `localitat_id` INT(11) NOT NULL,
  `provincia_id` INT(11) NOT NULL,
  `telefon` INT(9) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `localitat_id`, `provincia_id`),
  INDEX `fk_clients_localitats1_idx` (`localitat_id` ASC),
  INDEX `fk_clients_provincies1_idx` (`provincia_id` ASC),
  CONSTRAINT `fk_clients_localitats1`
    FOREIGN KEY (`localitat_id`)
    REFERENCES `S201_n1_ex2`.`localitats` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clients_provincies1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `S201_n1_ex2`.`provincies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`localitats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(200) NOT NULL,
  `provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `provincia_id`),
  INDEX `fk_localitats_provincies1_idx` (`provincia_id` ASC),
  CONSTRAINT `fk_localitats_provincies1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `S201_n1_ex2`.`provincies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`provincies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`comandes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `data` DATETIME NULL DEFAULT NULL,
  `tipus` ENUM('domicili', 'recollir') NULL DEFAULT NULL,
  `preu_total` DECIMAL(8,2) NULL DEFAULT NULL,
  `botiga_id` INT(11) NOT NULL,
  `repartidor_id` INT(11) NULL DEFAULT NULL,
  `lliurat_hora` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandes_clients1_idx` (`client_id` ASC),
  INDEX `fk_comandes_botigues1_idx` (`botiga_id` ASC),
  INDEX `fk_comandes_treballadors1_idx` (`repartidor_id` ASC),
  CONSTRAINT `fk_comandes_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `S201_n1_ex2`.`clients` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandes_botigues1`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `S201_n1_ex2`.`botigues` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandes_treballadors1`
    FOREIGN KEY (`repartidor_id`)
    REFERENCES `S201_n1_ex2`.`treballadors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`comandes_detall` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `comanda_id` INT(11) NOT NULL,
  `quantitat` INT(11) NOT NULL,
  `producte_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandes_detall_comandes1_idx` (`comanda_id` ASC),
  INDEX `fk_comandes_detall_productes1_idx` (`producte_id` ASC),
  CONSTRAINT `fk_comandes_detall_comandes1`
    FOREIGN KEY (`comanda_id`)
    REFERENCES `S201_n1_ex2`.`comandes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandes_detall_productes1`
    FOREIGN KEY (`producte_id`)
    REFERENCES `S201_n1_ex2`.`productes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`productes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `tipus` ENUM('pizza', 'hamburguesa', 'beguda') NULL DEFAULT NULL,
  `categoria_id` INT(11) NULL DEFAULT NULL,
  `descripcio` MEDIUMTEXT NULL DEFAULT NULL,
  `imatge` MEDIUMBLOB NULL DEFAULT NULL,
  `preu` DECIMAL(5,2) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productes_categories_pizzes1_idx` (`categoria_id` ASC),
  CONSTRAINT `fk_productes_categories_pizzes1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `S201_n1_ex2`.`categories_pizzes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`categories_pizzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`botigues` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `adresa` VARCHAR(255) NOT NULL,
  `codi_postal` INT(5) ZEROFILL UNSIGNED NULL DEFAULT NULL,
  `localitat_id` INT(11) NOT NULL,
  `provincia_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `localitat_id`, `provincia_id`),
  INDEX `fk_botigues_localitats1_idx` (`localitat_id` ASC),
  INDEX `fk_botigues_provincies1_idx` (`provincia_id` ASC),
  CONSTRAINT `fk_botigues_localitats1`
    FOREIGN KEY (`localitat_id`)
    REFERENCES `S201_n1_ex2`.`localitats` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_botigues_provincies1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `S201_n1_ex2`.`provincies` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n1_ex2`.`treballadors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `cognoms` VARCHAR(200) NOT NULL,
  `nif` VARCHAR(10) NULL DEFAULT NULL,
  `telefon` INT(9) NULL DEFAULT NULL,
  `categoria` ENUM('cuiner', 'repartidor') NULL DEFAULT NULL,
  `botiga_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_treballadors_botigues1_idx` (`botiga_id` ASC),
  CONSTRAINT `fk_treballadors_botigues1`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `S201_n1_ex2`.`botigues` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
