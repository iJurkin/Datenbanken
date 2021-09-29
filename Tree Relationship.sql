-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bbqdatenbank
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbqdatenbank` ;

-- -----------------------------------------------------
-- Schema bbqdatenbank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbqdatenbank` DEFAULT CHARACTER SET utf8 ;
USE `bbqdatenbank` ;

-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Stadt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Stadt` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Stadt` (
  `idStadt` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Flaeche` VARCHAR(45) NULL,
  `BewohnerAnz` VARCHAR(45) NULL,
  PRIMARY KEY (`idStadt`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Adressen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Adressen` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Adressen` (
  `idAdressen` INT NOT NULL,
  `Strasse` VARCHAR(45) NULL,
  `PLZ` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `fk_idStadt` INT NOT NULL,
  PRIMARY KEY (`idAdressen`, `fk_idStadt`),
  INDEX `fk_Adressen_Stadt1_idx` (`fk_idStadt` ASC) VISIBLE,
  CONSTRAINT `fk_Adressen_Stadt1`
    FOREIGN KEY (`fk_idStadt`)
    REFERENCES `bbqdatenbank`.`Stadt` (`idStadt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Gebauede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Gebauede` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Gebauede` (
  `idGebauede` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Etagen` VARCHAR(45) NULL,
  `Flaeche` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `fk_idAdressen` INT NOT NULL,
  PRIMARY KEY (`idGebauede`, `fk_idAdressen`),
  INDEX `fk_Gebauede_Adressen1_idx` (`fk_idAdressen` ASC) VISIBLE,
  CONSTRAINT `fk_Gebauede_Adressen1`
    FOREIGN KEY (`fk_idAdressen`)
    REFERENCES `bbqdatenbank`.`Adressen` (`idAdressen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Etage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Etage` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Etage` (
  `idEtage` INT NOT NULL,
  `Gebauede` VARCHAR(45) NULL,
  `EtagenNr` VARCHAR(45) NULL,
  `RaumenAnzahl` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `fk_idGebauede` INT NOT NULL,
  PRIMARY KEY (`idEtage`, `fk_idGebauede`),
  INDEX `fk_Etage_Gebaude1_idx` (`fk_idGebauede` ASC) VISIBLE,
  CONSTRAINT `fk_Etage_Gebaude1`
    FOREIGN KEY (`fk_idGebauede`)
    REFERENCES `bbqdatenbank`.`Gebauede` (`idGebauede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Raum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Raum` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Raum` (
  `idRaum` INT NOT NULL,
  `RaumNr` VARCHAR(45) NULL,
  `Groesse` VARCHAR(45) NULL,
  `AnzPlaetze` VARCHAR(45) NULL,
  `Etage` VARCHAR(45) NULL,
  `Gebauede` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `fk_idEtage` INT NOT NULL,
  PRIMARY KEY (`idRaum`, `fk_idEtage`),
  INDEX `fk_Raum_Etage1_idx` (`fk_idEtage` ASC) VISIBLE,
  CONSTRAINT `fk_Raum_Etage1`
    FOREIGN KEY (`fk_idEtage`)
    REFERENCES `bbqdatenbank`.`Etage` (`idEtage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Kurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Kurs` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Kurs` (
  `idKurs` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Raum` VARCHAR(45) NULL,
  `Etage` VARCHAR(45) NULL,
  `Gebauede` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `fk_idRaum` INT NOT NULL,
  PRIMARY KEY (`idKurs`, `fk_idRaum`),
  INDEX `fk_Kurs_Raum1_idx` (`fk_idRaum` ASC) VISIBLE,
  CONSTRAINT `fk_Kurs_Raum1`
    FOREIGN KEY (`fk_idRaum`)
    REFERENCES `bbqdatenbank`.`Raum` (`idRaum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Teilnehmer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Teilnehmer` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Teilnehmer` (
  `idTeilnehmer` INT NOT NULL,
  `Vorname Name` VARCHAR(45) NULL,
  `Kurs` VARCHAR(45) NULL,
  `Fach` VARCHAR(45) NULL,
  `if_idKurs` INT NOT NULL,
  PRIMARY KEY (`idTeilnehmer`, `if_idKurs`),
  INDEX `fk_Teilnehmer_Kurs1_idx` (`if_idKurs` ASC) VISIBLE,
  CONSTRAINT `fk_Teilnehmer_Kurs1`
    FOREIGN KEY (`if_idKurs`)
    REFERENCES `bbqdatenbank`.`Kurs` (`idKurs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Fach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Fach` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Fach` (
  `idFach` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  PRIMARY KEY (`idFach`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Dozenten`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Dozenten` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Dozenten` (
  `idDozenten` INT NOT NULL,
  `Vorname_Name` VARCHAR(45) NULL,
  `Fach` VARCHAR(45) NULL,
  `Kurs` VARCHAR(45) NULL,
  `Gebauede` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Stadt` VARCHAR(45) NULL,
  `if_idKurs` INT NOT NULL,
  PRIMARY KEY (`idDozenten`, `if_idKurs`),
  INDEX `fk_Dozenten_Kurs1_idx` (`if_idKurs` ASC) VISIBLE,
  CONSTRAINT `fk_Dozenten_Kurs1`
    FOREIGN KEY (`if_idKurs`)
    REFERENCES `bbqdatenbank`.`Kurs` (`idKurs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Dozenten_has_Fach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Dozenten_has_Fach` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Dozenten_has_Fach` (
  `if_idDozenten` INT NOT NULL,
  `if_idFach` INT NOT NULL,
  PRIMARY KEY (`if_idDozenten`, `if_idFach`),
  INDEX `fk_Dozenten_has_Fach_Fach1_idx` (`if_idFach` ASC) VISIBLE,
  INDEX `fk_Dozenten_has_Fach_Dozenten1_idx` (`if_idDozenten` ASC) VISIBLE,
  CONSTRAINT `fk_Dozenten_has_Fach_Dozenten1`
    FOREIGN KEY (`if_idDozenten`)
    REFERENCES `bbqdatenbank`.`Dozenten` (`idDozenten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dozenten_has_Fach_Fach1`
    FOREIGN KEY (`if_idFach`)
    REFERENCES `bbqdatenbank`.`Fach` (`idFach`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bbqdatenbank`.`Fach_has_Teilnehmer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbqdatenbank`.`Fach_has_Teilnehmer` ;

CREATE TABLE IF NOT EXISTS `bbqdatenbank`.`Fach_has_Teilnehmer` (
  `fk_idFach` INT NOT NULL,
  `fk_idTeilnehmer` INT NOT NULL,
  PRIMARY KEY (`fk_idFach`, `fk_idTeilnehmer`),
  INDEX `fk_Fach_has_Teilnehmer_Teilnehmer1_idx` (`fk_idTeilnehmer` ASC) VISIBLE,
  INDEX `fk_Fach_has_Teilnehmer_Fach1_idx` (`fk_idFach` ASC) VISIBLE,
  CONSTRAINT `fk_Fach_has_Teilnehmer_Fach1`
    FOREIGN KEY (`fk_idFach`)
    REFERENCES `bbqdatenbank`.`Fach` (`idFach`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fach_has_Teilnehmer_Teilnehmer1`
    FOREIGN KEY (`fk_idTeilnehmer`)
    REFERENCES `bbqdatenbank`.`Teilnehmer` (`idTeilnehmer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
