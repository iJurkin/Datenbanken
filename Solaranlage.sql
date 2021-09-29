-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Solaranlage
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Solaranlage` ;

-- -----------------------------------------------------
-- Schema Solaranlage
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Solaranlage` DEFAULT CHARACTER SET utf8 ;
USE `Solaranlage` ;

-- -----------------------------------------------------
-- Table `Solaranlage`.`Kunde`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Kunde` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Kunde` (
  `idKunde` INT NOT NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  PRIMARY KEY (`idKunde`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Kundenauftrag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Kundenauftrag` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Kundenauftrag` (
  `idKundenauftrag` INT NOT NULL,
  `Nr` VARCHAR(45) NULL,
  `Datum` VARCHAR(45) NULL,
  `Kunde_idKunde` INT NOT NULL,
  PRIMARY KEY (`idKundenauftrag`, `Kunde_idKunde`),
  INDEX `fk_Kundenauftrag_Kunde_idx` (`Kunde_idKunde` ASC) VISIBLE,
  CONSTRAINT `fk_Kundenauftrag_Kunde`
    FOREIGN KEY (`Kunde_idKunde`)
    REFERENCES `Solaranlage`.`Kunde` (`idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Solaranlage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Solaranlage` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Solaranlage` (
  `idSolaranlage` INT NOT NULL,
  `ModelBezeichnung` VARCHAR(45) NULL,
  `ModelNr.` VARCHAR(45) NULL,
  PRIMARY KEY (`idSolaranlage`))
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `Solaranlage`.`Komponente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Komponente` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Komponente` (
  `idKomponente` INT NOT NULL,
  `Art.Nr.` VARCHAR(45) NULL,
  `Maße` VARCHAR(45) NULL,
  `Gewicht` VARCHAR(45) NULL,
  PRIMARY KEY (`idKomponente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Lieferant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Lieferant` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Lieferant` (
  `idLieferant` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `KompArt` VARCHAR(45) NULL,
  PRIMARY KEY (`idLieferant`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`LieferantenAuftrag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`LieferantenAuftrag` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`LieferantenAuftrag` (
  `idLieferantenAuftrag` INT NOT NULL,
  `Nr.` VARCHAR(45) NULL,
  `Datum` VARCHAR(45) NULL,
  `Lieferant_idLieferant` INT NOT NULL,
  PRIMARY KEY (`idLieferantenAuftrag`, `Lieferant_idLieferant`),
  INDEX `fk_LieferantenAuftrag_Lieferant1_idx` (`Lieferant_idLieferant` ASC) VISIBLE,
  CONSTRAINT `fk_LieferantenAuftrag_Lieferant1`
    FOREIGN KEY (`Lieferant_idLieferant`)
    REFERENCES `Solaranlage`.`Lieferant` (`idLieferant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Lieferung`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Lieferung` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Lieferung` (
  `idLieferung` INT NOT NULL,
  `Nr.` VARCHAR(45) NULL,
  `Datum` VARCHAR(45) NULL,
  `Gewicht` VARCHAR(45) NULL,
  `Maße` VARCHAR(45) NULL,
  `Lieferant_idLieferant` INT NOT NULL,
  PRIMARY KEY (`idLieferung`, `Lieferant_idLieferant`),
  INDEX `fk_Lieferung_Lieferant1_idx` (`Lieferant_idLieferant` ASC) VISIBLE,
  CONSTRAINT `fk_Lieferung_Lieferant1`
    FOREIGN KEY (`Lieferant_idLieferant`)
    REFERENCES `Solaranlage`.`Lieferant` (`idLieferant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Solaranlage_has_Kundenauftrag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Solaranlage_has_Kundenauftrag` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Solaranlage_has_Kundenauftrag` (
  `Solaranlage_idSolaranlage` INT NOT NULL,
  `Kundenauftrag_idKundenauftrag` INT NOT NULL,
  `Kundenauftrag_Kunde_idKunde` INT NOT NULL,
  PRIMARY KEY (`Solaranlage_idSolaranlage`, `Kundenauftrag_idKundenauftrag`, `Kundenauftrag_Kunde_idKunde`),
  INDEX `fk_Solaranlage_has_Kundenauftrag_Kundenauftrag1_idx` (`Kundenauftrag_idKundenauftrag` ASC, `Kundenauftrag_Kunde_idKunde` ASC) VISIBLE,
  INDEX `fk_Solaranlage_has_Kundenauftrag_Solaranlage1_idx` (`Solaranlage_idSolaranlage` ASC) VISIBLE,
  CONSTRAINT `fk_Solaranlage_has_Kundenauftrag_Solaranlage1`
    FOREIGN KEY (`Solaranlage_idSolaranlage`)
    REFERENCES `Solaranlage`.`Solaranlage` (`idSolaranlage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solaranlage_has_Kundenauftrag_Kundenauftrag1`
    FOREIGN KEY (`Kundenauftrag_idKundenauftrag` , `Kundenauftrag_Kunde_idKunde`)
    REFERENCES `Solaranlage`.`Kundenauftrag` (`idKundenauftrag` , `Kunde_idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Komponente_has_Solaranlage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Komponente_has_Solaranlage` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Komponente_has_Solaranlage` (
  `Komponente_idKomponente` INT NOT NULL,
  `Solaranlage_idSolaranlage` INT NOT NULL,
  PRIMARY KEY (`Komponente_idKomponente`, `Solaranlage_idSolaranlage`),
  INDEX `fk_Komponente_has_Solaranlage_Solaranlage1_idx` (`Solaranlage_idSolaranlage` ASC) VISIBLE,
  INDEX `fk_Komponente_has_Solaranlage_Komponente1_idx` (`Komponente_idKomponente` ASC) VISIBLE,
  CONSTRAINT `fk_Komponente_has_Solaranlage_Komponente1`
    FOREIGN KEY (`Komponente_idKomponente`)
    REFERENCES `Solaranlage`.`Komponente` (`idKomponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Komponente_has_Solaranlage_Solaranlage1`
    FOREIGN KEY (`Solaranlage_idSolaranlage`)
    REFERENCES `Solaranlage`.`Solaranlage` (`idSolaranlage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`LieferantenAuftrag_has_Komponente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`LieferantenAuftrag_has_Komponente` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`LieferantenAuftrag_has_Komponente` (
  `LieferantenAuftrag_idLieferantenAuftrag` INT NOT NULL,
  `Komponente_idKomponente` INT NOT NULL,
  PRIMARY KEY (`LieferantenAuftrag_idLieferantenAuftrag`, `Komponente_idKomponente`),
  INDEX `fk_LieferantenAuftrag_has_Komponente_Komponente1_idx` (`Komponente_idKomponente` ASC) VISIBLE,
  INDEX `fk_LieferantenAuftrag_has_Komponente_LieferantenAuftrag1_idx` (`LieferantenAuftrag_idLieferantenAuftrag` ASC) VISIBLE,
  CONSTRAINT `fk_LieferantenAuftrag_has_Komponente_LieferantenAuftrag1`
    FOREIGN KEY (`LieferantenAuftrag_idLieferantenAuftrag`)
    REFERENCES `Solaranlage`.`LieferantenAuftrag` (`idLieferantenAuftrag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LieferantenAuftrag_has_Komponente_Komponente1`
    FOREIGN KEY (`Komponente_idKomponente`)
    REFERENCES `Solaranlage`.`Komponente` (`idKomponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solaranlage`.`Lieferung_has_Komponente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Solaranlage`.`Lieferung_has_Komponente` ;

CREATE TABLE IF NOT EXISTS `Solaranlage`.`Lieferung_has_Komponente` (
  `Lieferung_idLieferung` INT NOT NULL,
  `Lieferung_Lieferant_idLieferant` INT NOT NULL,
  `Komponente_idKomponente` INT NOT NULL,
  PRIMARY KEY (`Lieferung_idLieferung`, `Lieferung_Lieferant_idLieferant`, `Komponente_idKomponente`),
  INDEX `fk_Lieferung_has_Komponente_Komponente1_idx` (`Komponente_idKomponente` ASC) VISIBLE,
  INDEX `fk_Lieferung_has_Komponente_Lieferung1_idx` (`Lieferung_idLieferung` ASC, `Lieferung_Lieferant_idLieferant` ASC) VISIBLE,
  CONSTRAINT `fk_Lieferung_has_Komponente_Lieferung1`
    FOREIGN KEY (`Lieferung_idLieferung` , `Lieferung_Lieferant_idLieferant`)
    REFERENCES `Solaranlage`.`Lieferung` (`idLieferung` , `Lieferant_idLieferant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lieferung_has_Komponente_Komponente1`
    FOREIGN KEY (`Komponente_idKomponente`)
    REFERENCES `Solaranlage`.`Komponente` (`idKomponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
