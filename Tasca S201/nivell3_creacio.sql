-- MySQL Workbench Synchronization
-- Generated: 2021-12-29 19:10
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Jordi Borràs i Vivó

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `S201_n3`.`usuaris` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `premium` TINYINT(4) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `username` VARCHAR(150) NOT NULL,
  `naixement` DATE NULL DEFAULT NULL,
  `sexe` ENUM('home', 'dona', 'no definit') NOT NULL,
  `pais` INT(11) NOT NULL,
  `codi_postal` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_usuaris_paisos_idx` (`pais` ASC),
  CONSTRAINT `fk_usuaris_paisos`
    FOREIGN KEY (`pais`)
    REFERENCES `S201_n3`.`paisos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`paisos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `codi_ISO` VARCHAR(2) NOT NULL,
  `pais` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`subscripcions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `data_inici` DATE NOT NULL,
  `data_renovacio` DATE NOT NULL,
  `pagament` ENUM('targeta', 'paypal') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscripcions_usuaris1_idx` (`usuari_id` ASC),
  CONSTRAINT `fk_subscripcions_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n3`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`credit_cards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` BIGINT(16) NOT NULL,
  `mes_cad` INT(2) ZEROFILL NOT NULL,
  `any_cad` INT(2) ZEROFILL NOT NULL,
  `cvv` INT(3) ZEROFILL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`paypal` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_pp` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`pagaments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `subscripcio_id` INT(11) NOT NULL,
  `targeta_id` INT(11) NULL DEFAULT NULL,
  `pp_id` INT(11) NULL DEFAULT NULL,
  `data` DATE NOT NULL,
  `total` DECIMAL(5,2) NOT NULL,
  `tipus` ENUM('targeta', 'paypal') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagaments_subscripcions1_idx` (`subscripcio_id` ASC),
  INDEX `fk_pagaments_credit_cards1_idx` (`targeta_id` ASC),
  INDEX `fk_pagaments_paypal1_idx` (`pp_id` ASC),
  CONSTRAINT `fk_pagaments_subscripcions1`
    FOREIGN KEY (`subscripcio_id`)
    REFERENCES `S201_n3`.`subscripcions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pagaments_credit_cards1`
    FOREIGN KEY (`targeta_id`)
    REFERENCES `S201_n3`.`credit_cards` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pagaments_paypal1`
    FOREIGN KEY (`pp_id`)
    REFERENCES `S201_n3`.`paypal` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(150) NOT NULL,
  `num_cancons` INT(11) NOT NULL DEFAULT 0,
  `creacio` DATE NOT NULL,
  `eliminada` TINYINT(4) NOT NULL DEFAULT 0,
  `data_eliminacio` DATE NULL DEFAULT NULL,
  `usuari_creador` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuaris1_idx` (`usuari_creador` ASC),
  CONSTRAINT `fk_playlist_usuaris1`
    FOREIGN KEY (`usuari_creador`)
    REFERENCES `S201_n3`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`playlist_detalls` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `llista_id` INT(11) NOT NULL,
  `canco_id` INT(11) NOT NULL,
  `afegit_per` INT(11) NOT NULL,
  `data_addicio` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_llista_cancons_cancons1_idx` (`canco_id` ASC),
  INDEX `fk_llista_cancons_usuaris1_idx` (`afegit_per` ASC),
  INDEX `fk_llista_cancons_playlist1_idx` (`llista_id` ASC),
  CONSTRAINT `fk_llista_cancons_cancons1`
    FOREIGN KEY (`canco_id`)
    REFERENCES `S201_n3`.`cancons` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_llista_cancons_usuaris1`
    FOREIGN KEY (`afegit_per`)
    REFERENCES `S201_n3`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_llista_cancons_playlist1`
    FOREIGN KEY (`llista_id`)
    REFERENCES `S201_n3`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`cancons` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(255) NOT NULL,
  `durada` TIME NOT NULL,
  `artista` INT(11) NOT NULL,
  `album` INT(11) NOT NULL,
  `reproduccions` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cancons_artistes1_idx` (`artista` ASC),
  INDEX `fk_cancons_albums1_idx` (`album` ASC),
  CONSTRAINT `fk_cancons_artistes1`
    FOREIGN KEY (`artista`)
    REFERENCES `S201_n3`.`artistes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancons_albums1`
    FOREIGN KEY (`album`)
    REFERENCES `S201_n3`.`albums` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`artistes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`albums` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `artista` INT(11) NULL DEFAULT NULL,
  `titol` VARCHAR(255) NOT NULL,
  `any_publicacio` INT(4) NOT NULL,
  `img_portada` BLOB NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_albums_artistes1_idx` (`artista` ASC),
  CONSTRAINT `fk_albums_artistes1`
    FOREIGN KEY (`artista`)
    REFERENCES `S201_n3`.`artistes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`seguiments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `artista_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_seguiments_usuaris1_idx` (`usuari_id` ASC),
  INDEX `fk_seguiments_artistes1_idx` (`artista_id` ASC),
  CONSTRAINT `fk_seguiments_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n3`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_seguiments_artistes1`
    FOREIGN KEY (`artista_id`)
    REFERENCES `S201_n3`.`artistes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`artistes_relacionats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `artista_base` INT(11) NOT NULL,
  `artista_relacionat` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_artistes_relacionats_artistes1_idx` (`artista_base` ASC),
  INDEX `fk_artistes_relacionats_artistes2_idx` (`artista_relacionat` ASC),
  CONSTRAINT `fk_artistes_relacionats_artistes1`
    FOREIGN KEY (`artista_base`)
    REFERENCES `S201_n3`.`artistes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artistes_relacionats_artistes2`
    FOREIGN KEY (`artista_relacionat`)
    REFERENCES `S201_n3`.`artistes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n3`.`favorits` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `album_id` INT(11) NULL DEFAULT NULL,
  `canco_id` INT(11) NULL DEFAULT NULL,
  `tipus` ENUM('album', 'canço') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_favorits_usuaris1_idx` (`usuari_id` ASC),
  INDEX `fk_favorits_albums1_idx` (`album_id` ASC),
  INDEX `fk_favorits_cancons1_idx` (`canco_id` ASC),
  CONSTRAINT `fk_favorits_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n3`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_favorits_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `S201_n3`.`albums` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_favorits_cancons1`
    FOREIGN KEY (`canco_id`)
    REFERENCES `S201_n3`.`cancons` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
