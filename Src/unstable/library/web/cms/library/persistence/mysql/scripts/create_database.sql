SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cms_dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cms_dev` DEFAULT CHARACTER SET latin1 ;
USE `cms_dev` ;

-- -----------------------------------------------------
-- Table `cms_dev`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`users` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `salt` VARCHAR(100) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `creation_date` DATETIME NULL DEFAULT NULL,
  `last_login_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`nodes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `publication_date` DATE NOT NULL,
  `creation_date` DATE NOT NULL,
  `modification_date` DATE NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `summary` TEXT NOT NULL,
  `content` MEDIUMTEXT NOT NULL,
  `author_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `version` INT(10) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `editor_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nodes_users1_idx` (`author_id` ASC),
  INDEX `fk_nodes_users2_idx` (`editor_id` ASC),
  CONSTRAINT `fk_nodes_users1`
    FOREIGN KEY (`author_id`)
    REFERENCES `cms_dev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nodes_users2`
    FOREIGN KEY (`editor_id`)
    REFERENCES `cms_dev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`roles` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `role` (`role` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `roles_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_permissions_roles1_idx` (`roles_id` ASC),
  CONSTRAINT `fk_permissions_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `cms_dev`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`profiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`profiles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(45) NOT NULL,
  `value` VARCHAR(100) NULL DEFAULT NULL,
  `users_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `key_UNIQUE` (`key` ASC),
  INDEX `fk_profiles_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_profiles_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cms_dev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`users_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`users_nodes` (
  `users_id` INT(10) UNSIGNED NOT NULL,
  `nodes_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`, `nodes_id`),
  INDEX `fk_users_has_nodes_nodes1_idx` (`nodes_id` ASC),
  INDEX `fk_users_has_nodes_users_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_nodes_nodes1`
    FOREIGN KEY (`nodes_id`)
    REFERENCES `cms_dev`.`nodes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_nodes_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `cms_dev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cms_dev`.`users_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cms_dev`.`users_roles` (
  `users_id` INT(10) UNSIGNED NOT NULL,
  `roles_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`, `roles_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`roles_id` ASC),
  INDEX `fk_users_has_roles_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `cms_dev`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_roles_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cms_dev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
