SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema roc_cms
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `roc_cms` ;
CREATE SCHEMA IF NOT EXISTS `roc_cms` DEFAULT CHARACTER SET latin1 ;
USE `roc_cms` ;

-- -----------------------------------------------------
-- Table `roc_cms`.`nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roc_cms`.`nodes` ;

CREATE TABLE IF NOT EXISTS `roc_cms`.`nodes` (
  `nid` INT(11) NOT NULL AUTO_INCREMENT,
  `version` INT(11) NULL DEFAULT NULL,
  `type` INT(11) NULL DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `summary` TEXT NOT NULL,
  `content` MEDIUMTEXT NOT NULL,
  `author` INT(11) NULL DEFAULT NULL,
  `publish` DATETIME NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `changed` DATETIME NOT NULL,
  PRIMARY KEY (`nid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `roc_cms`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roc_cms`.`users` ;

CREATE TABLE IF NOT EXISTS `roc_cms`.`users` (
  `uid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(100) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `signed` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE INDEX `name` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `roc_cms`.`users_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roc_cms`.`users_roles` ;

CREATE TABLE IF NOT EXISTS `roc_cms`.`users_roles` (
  `rid` INT(11) NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE INDEX `role` (`role` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
