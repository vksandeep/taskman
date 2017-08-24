-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tasks
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tasks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tasks` DEFAULT CHARACTER SET utf8 ;
USE `tasks` ;

-- -----------------------------------------------------
-- Table `tasks`.`person_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`person_master` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FIRST_NAME` VARCHAR(40) NOT NULL,
  `LAST_NAME` VARCHAR(40) NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `AUTH_KEY` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`project_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`project_master` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PROJECT_NAME` VARCHAR(40) NOT NULL,
  `PROJECT_DESC` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `PROJECT_NAME_UNIQUE` (`PROJECT_NAME` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`project_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`project_role` (
  `PROJECT_ID` INT(11) NOT NULL,
  `PERSON_ID` INT(11) NOT NULL,
  `ROLE` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`PROJECT_ID`, `PERSON_ID`),
  INDEX `PROJECT_ID_idx` (`PROJECT_ID` ASC),
  INDEX `FK_PERSON_ID_idx` (`PERSON_ID` ASC),
  CONSTRAINT `FK_PERSON_ID`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `tasks`.`person_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PROJECT_ID`
    FOREIGN KEY (`PROJECT_ID`)
    REFERENCES `tasks`.`project_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`tag_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`tag_master` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`task` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `SUMMARY` VARCHAR(80) NOT NULL,
  `DESCRIPTION` VARCHAR(500) NULL DEFAULT NULL,
  `CREATED_ON` DATETIME NOT NULL,
  `DUE_ON` DATETIME NOT NULL,
  `STARTED_ON` DATETIME NULL DEFAULT NULL,
  `COMPLETED_ON` DATETIME NULL DEFAULT NULL,
  `HELD_ON` DATETIME NULL DEFAULT NULL,
  `CREATED_BY` INT(11) NOT NULL,
  `ASSIGNED_TO` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IDX_CREATED_ON` (`CREATED_ON` ASC),
  INDEX `IDX_DUE_ON` (`DUE_ON` ASC),
  INDEX `FK_CREATED_BY_idx` (`CREATED_BY` ASC),
  INDEX `FK_ASSIGNED_TO_idx` (`ASSIGNED_TO` ASC),
  CONSTRAINT `FK_ASSIGNED_TO`
    FOREIGN KEY (`ASSIGNED_TO`)
    REFERENCES `tasks`.`person_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CREATED_BY`
    FOREIGN KEY (`CREATED_BY`)
    REFERENCES `tasks`.`person_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`task_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`task_tag` (
  `TASK_ID` INT(11) NOT NULL,
  `TAG_ID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`TASK_ID`),
  INDEX `FK_TAG_ID_idx` (`TAG_ID` ASC),
  CONSTRAINT `FK_TASK_TAG_TAG_ID`
    FOREIGN KEY (`TAG_ID`)
    REFERENCES `tasks`.`tag_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_TASK_TAG_TASK_ID`
    FOREIGN KEY (`TASK_ID`)
    REFERENCES `tasks`.`task` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tasks`.`task_watcher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tasks`.`task_watcher` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `TASK_ID` INT(11) NULL DEFAULT NULL,
  `PERSON_ID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_TASK_ID_idx` (`TASK_ID` ASC),
  INDEX `FK_WATCHER_ID_idx` (`PERSON_ID` ASC),
  CONSTRAINT `FK_TASK_ID`
    FOREIGN KEY (`TASK_ID`)
    REFERENCES `tasks`.`task` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_WATCHER_ID`
    FOREIGN KEY (`PERSON_ID`)
    REFERENCES `tasks`.`person_master` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
