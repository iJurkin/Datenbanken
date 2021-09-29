-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Veranstaltung
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Veranstaltung
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Veranstaltung` DEFAULT CHARACTER SET utf8 ;
USE `Veranstaltung` ;

-- -----------------------------------------------------
-- Table `Veranstaltung`.`Tournee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Tournee` (
  `idTournee` INT NOT NULL,
  `Datum` VARCHAR(45) NULL,
  `TourneePlan` VARCHAR(45) NULL,
  `Route` VARCHAR(45) NULL,
  `Ende_Datum` VARCHAR(45) NULL,
  PRIMARY KEY (`idTournee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Veranstaltung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Veranstaltung` (
  `idVeranstaltung` INT NOT NULL,
  `Datum` VARCHAR(45) NULL,
  `Ort` VARCHAR(45) NULL,
  `Art` VARCHAR(45) NULL,
  `Tournee_idTournee` INT NOT NULL,
  PRIMARY KEY (`idVeranstaltung`, `Tournee_idTournee`),
  INDEX `fk_Veranstaltung_Tournee_idx` (`Tournee_idTournee` ASC) VISIBLE,
  CONSTRAINT `fk_Veranstaltung_Tournee`
    FOREIGN KEY (`Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Tournee` (`idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Location` (
  `idLocation` INT NOT NULL,
  `Art` VARCHAR(45) NULL,
  `Ort` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Größe` VARCHAR(45) NULL,
  `Veranstaltung_idVeranstaltung` INT NOT NULL,
  `Veranstaltung_Tournee_idTournee` INT NOT NULL,
  PRIMARY KEY (`idLocation`, `Veranstaltung_idVeranstaltung`, `Veranstaltung_Tournee_idTournee`),
  INDEX `fk_Location_Veranstaltung1_idx` (`Veranstaltung_idVeranstaltung` ASC, `Veranstaltung_Tournee_idTournee` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Veranstaltung1`
    FOREIGN KEY (`Veranstaltung_idVeranstaltung` , `Veranstaltung_Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Veranstaltung` (`idVeranstaltung` , `Tournee_idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Künstler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Künstler` (
  `idKünstler` INT NOT NULL,
  `Vorname` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  `Performance` VARCHAR(45) NULL,
  PRIMARY KEY (`idKünstler`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Besucher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Besucher` (
  `idBesucher` INT NOT NULL,
  `Altersspanne` VARCHAR(45) NULL,
  `Menge` VARCHAR(45) NULL,
  PRIMARY KEY (`idBesucher`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Preiskategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Preiskategorie` (
  `idPreiskategorie` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Spanne` VARCHAR(45) NULL,
  PRIMARY KEY (`idPreiskategorie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Künstler_has_Veranstaltung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Künstler_has_Veranstaltung` (
  `Künstler_idKünstler` INT NOT NULL,
  `Veranstaltung_idVeranstaltung` INT NOT NULL,
  `Veranstaltung_Tournee_idTournee` INT NOT NULL,
  PRIMARY KEY (`Künstler_idKünstler`, `Veranstaltung_idVeranstaltung`, `Veranstaltung_Tournee_idTournee`),
  INDEX `fk_Künstler_has_Veranstaltung_Veranstaltung1_idx` (`Veranstaltung_idVeranstaltung` ASC, `Veranstaltung_Tournee_idTournee` ASC) VISIBLE,
  INDEX `fk_Künstler_has_Veranstaltung_Künstler1_idx` (`Künstler_idKünstler` ASC) VISIBLE,
  CONSTRAINT `fk_Künstler_has_Veranstaltung_Künstler1`
    FOREIGN KEY (`Künstler_idKünstler`)
    REFERENCES `Veranstaltung`.`Künstler` (`idKünstler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Künstler_has_Veranstaltung_Veranstaltung1`
    FOREIGN KEY (`Veranstaltung_idVeranstaltung` , `Veranstaltung_Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Veranstaltung` (`idVeranstaltung` , `Tournee_idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Besucher_has_Veranstaltung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Besucher_has_Veranstaltung` (
  `Besucher_idBesucher` INT NOT NULL,
  `Veranstaltung_idVeranstaltung` INT NOT NULL,
  `Veranstaltung_Tournee_idTournee` INT NOT NULL,
  PRIMARY KEY (`Besucher_idBesucher`, `Veranstaltung_idVeranstaltung`, `Veranstaltung_Tournee_idTournee`),
  INDEX `fk_Besucher_has_Veranstaltung_Veranstaltung1_idx` (`Veranstaltung_idVeranstaltung` ASC, `Veranstaltung_Tournee_idTournee` ASC) VISIBLE,
  INDEX `fk_Besucher_has_Veranstaltung_Besucher1_idx` (`Besucher_idBesucher` ASC) VISIBLE,
  CONSTRAINT `fk_Besucher_has_Veranstaltung_Besucher1`
    FOREIGN KEY (`Besucher_idBesucher`)
    REFERENCES `Veranstaltung`.`Besucher` (`idBesucher`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Besucher_has_Veranstaltung_Veranstaltung1`
    FOREIGN KEY (`Veranstaltung_idVeranstaltung` , `Veranstaltung_Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Veranstaltung` (`idVeranstaltung` , `Tournee_idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Veranstaltung_has_Preiskategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Veranstaltung_has_Preiskategorie` (
  `Veranstaltung_idVeranstaltung` INT NOT NULL,
  `Veranstaltung_Tournee_idTournee` INT NOT NULL,
  `Preiskategorie_idPreiskategorie` INT NOT NULL,
  PRIMARY KEY (`Veranstaltung_idVeranstaltung`, `Veranstaltung_Tournee_idTournee`, `Preiskategorie_idPreiskategorie`),
  INDEX `fk_Veranstaltung_has_Preiskategorie_Preiskategorie1_idx` (`Preiskategorie_idPreiskategorie` ASC) VISIBLE,
  INDEX `fk_Veranstaltung_has_Preiskategorie_Veranstaltung1_idx` (`Veranstaltung_idVeranstaltung` ASC, `Veranstaltung_Tournee_idTournee` ASC) VISIBLE,
  CONSTRAINT `fk_Veranstaltung_has_Preiskategorie_Veranstaltung1`
    FOREIGN KEY (`Veranstaltung_idVeranstaltung` , `Veranstaltung_Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Veranstaltung` (`idVeranstaltung` , `Tournee_idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veranstaltung_has_Preiskategorie_Preiskategorie1`
    FOREIGN KEY (`Preiskategorie_idPreiskategorie`)
    REFERENCES `Veranstaltung`.`Preiskategorie` (`idPreiskategorie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veranstaltung`.`Location_has_Preiskategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veranstaltung`.`Location_has_Preiskategorie` (
  `Location_idLocation` INT NOT NULL,
  `Location_Veranstaltung_idVeranstaltung` INT NOT NULL,
  `Location_Veranstaltung_Tournee_idTournee` INT NOT NULL,
  `Preiskategorie_idPreiskategorie` INT NOT NULL,
  PRIMARY KEY (`Location_idLocation`, `Location_Veranstaltung_idVeranstaltung`, `Location_Veranstaltung_Tournee_idTournee`, `Preiskategorie_idPreiskategorie`),
  INDEX `fk_Location_has_Preiskategorie_Preiskategorie1_idx` (`Preiskategorie_idPreiskategorie` ASC) VISIBLE,
  INDEX `fk_Location_has_Preiskategorie_Location1_idx` (`Location_idLocation` ASC, `Location_Veranstaltung_idVeranstaltung` ASC, `Location_Veranstaltung_Tournee_idTournee` ASC) VISIBLE,
  CONSTRAINT `fk_Location_has_Preiskategorie_Location1`
    FOREIGN KEY (`Location_idLocation` , `Location_Veranstaltung_idVeranstaltung` , `Location_Veranstaltung_Tournee_idTournee`)
    REFERENCES `Veranstaltung`.`Location` (`idLocation` , `Veranstaltung_idVeranstaltung` , `Veranstaltung_Tournee_idTournee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Location_has_Preiskategorie_Preiskategorie1`
    FOREIGN KEY (`Preiskategorie_idPreiskategorie`)
    REFERENCES `Veranstaltung`.`Preiskategorie` (`idPreiskategorie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
