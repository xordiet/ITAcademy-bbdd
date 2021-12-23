-- MySQL Workbench Synchronization
-- Generated: 2021-12-23 17:38
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Jordi Borràs i Vivó

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `S201_n2`.`usuaris` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `username` VARCHAR(200) NOT NULL,
  `data_naixement` DATE NULL DEFAULT NULL,
  `sexe` ENUM('home', 'dona', 'no especificat') NULL DEFAULT NULL,
  `pais_id` INT(11) NULL DEFAULT NULL,
  `codi_postal` INT(5) ZEROFILL NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_usuaris_paisos_idx` (`pais_id` ASC),
  CONSTRAINT `fk_usuaris_paisos`
    FOREIGN KEY (`pais_id`)
    REFERENCES `S201_n2`.`paisos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`paisos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`videos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `estat` ENUM('públic', 'ocult', 'privat') NOT NULL,
  `titol` VARCHAR(255) NOT NULL,
  `descripcio` TEXT NULL DEFAULT NULL,
  `grandaria` INT(11) NOT NULL,
  `nom_arxiu` VARCHAR(255) NOT NULL,
  `durada` TIME NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `reproduccions` INT(11) NULL DEFAULT NULL,
  `likes` INT(11) NULL DEFAULT NULL,
  `dislikes` INT(11) NULL DEFAULT NULL,
  `publicat` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_videos_usuaris1_idx` (`usuari_id` ASC),
  CONSTRAINT `fk_videos_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`etiquetes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `etiqueta` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`set_etiquetes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `video_id` INT(11) NOT NULL,
  `etiqueta_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_set_etiquetes_videos1_idx` (`video_id` ASC),
  INDEX `fk_set_etiquetes_etiquetes1_idx` (`etiqueta_id` ASC),
  CONSTRAINT `fk_set_etiquetes_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `S201_n2`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_set_etiquetes_etiquetes1`
    FOREIGN KEY (`etiqueta_id`)
    REFERENCES `S201_n2`.`etiquetes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`canals` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(200) NOT NULL,
  `descripcio` TEXT NULL DEFAULT NULL,
  `creador` INT(11) NOT NULL,
  `creacio` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canals_usuaris1_idx` (`creador` ASC),
  CONSTRAINT `fk_canals_usuaris1`
    FOREIGN KEY (`creador`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`subscripcions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari` INT(11) NOT NULL,
  `canal` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscripcions_usuaris1_idx` (`usuari` ASC),
  INDEX `fk_subscripcions_canals1_idx` (`canal` ASC),
  CONSTRAINT `fk_subscripcions_usuaris1`
    FOREIGN KEY (`usuari`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscripcions_canals1`
    FOREIGN KEY (`canal`)
    REFERENCES `S201_n2`.`canals` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`likes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipus` ENUM('like', 'dislike') NOT NULL,
  `usuari_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `moment` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_likes_usuaris1_idx` (`usuari_id` ASC),
  INDEX `fk_likes_videos1_idx` (`video_id` ASC),
  CONSTRAINT `fk_likes_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `S201_n2`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `creador` INT(11) NOT NULL,
  `nom` VARCHAR(150) NOT NULL,
  `creacio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `publica` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuaris1_idx` (`creador` ASC),
  CONSTRAINT `fk_playlist_usuaris1`
    FOREIGN KEY (`creador`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`playlist_content` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `playlist_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `afegit` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_content_playlist1_idx` (`playlist_id` ASC),
  INDEX `fk_playlist_content_videos1_idx` (`video_id` ASC),
  CONSTRAINT `fk_playlist_content_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `S201_n2`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_content_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `S201_n2`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`comentaris` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `text` MEDIUMTEXT NOT NULL,
  `publicat` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_comentaris_usuaris1_idx` (`usuari_id` ASC),
  INDEX `fk_comentaris_videos1_idx` (`video_id` ASC),
  CONSTRAINT `fk_comentaris_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comentaris_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `S201_n2`.`videos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `S201_n2`.`comment_like` (
  `id` INT(11) NOT NULL,
  `tipus` ENUM('like', 'dislike') NOT NULL,
  `usuari_id` INT(11) NOT NULL,
  `comentari_id` INT(11) NOT NULL,
  `moment` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_like_usuaris1_idx` (`usuari_id` ASC),
  INDEX `fk_comment_like_comentaris1_idx` (`comentari_id` ASC),
  CONSTRAINT `fk_comment_like_usuaris1`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `S201_n2`.`usuaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_like_comentaris1`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `S201_n2`.`comentaris` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
