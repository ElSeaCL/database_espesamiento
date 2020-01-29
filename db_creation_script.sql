-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema espesamiento3N
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema espesamiento3N
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `espesamiento3N` DEFAULT CHARACTER SET utf8 ;
USE `espesamiento3N` ;

-- -----------------------------------------------------
-- Table `espesamiento3N`.`pre_espesador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`pre_espesador` (
  `id_pre_espesador` INT NOT NULL AUTO_INCREMENT,
  `equipo` CHAR NOT NULL,
  PRIMARY KEY (`id_pre_espesador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`origen_lodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`origen_lodo` (
  `lodo` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`lodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`centrifuga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`centrifuga` (
  `idcentrifuga` INT NOT NULL AUTO_INCREMENT,
  `equipo` CHAR NOT NULL,
  `tipo_lodo_lodo` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idcentrifuga`, `tipo_lodo_lodo`),
  INDEX `fk_centrifuga_tipo_lodo1_idx` (`tipo_lodo_lodo` ASC) VISIBLE,
  CONSTRAINT `fk_centrifuga_tipo_lodo1`
    FOREIGN KEY (`tipo_lodo_lodo`)
    REFERENCES `espesamiento3N`.`origen_lodo` (`lodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`fecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`fecha` (
  `dia` DATE NOT NULL,
  PRIMARY KEY (`dia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`valor_pre_espesador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`valor_pre_espesador` (
  `salida_SS` DECIMAL(3,1) NULL,
  `salida_caudal` DECIMAL(5,1) NULL,
  `pre_espesador_id_pre_espesador` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`pre_espesador_id_pre_espesador`, `fecha_dia`),
  INDEX `fk_valores_pre_espesador_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_valores_pre_espesador_pre_espesador1`
    FOREIGN KEY (`pre_espesador_id_pre_espesador`)
    REFERENCES `espesamiento3N`.`pre_espesador` (`id_pre_espesador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valores_pre_espesador_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `espesamiento3N`.`turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`turno` (
  `id_turno` INT NOT NULL AUTO_INCREMENT,
  `turno` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_turno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`valor_cam_mezcla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`valor_cam_mezcla` (
  `salida_SS` INT NOT NULL,
  `turno_id_turno` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`turno_id_turno`, `fecha_dia`),
  INDEX `fk_valores_cam_mezcla_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_valores_cam_mezcla_turno1`
    FOREIGN KEY (`turno_id_turno`)
    REFERENCES `espesamiento3N`.`turno` (`id_turno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valores_cam_mezcla_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`unidad_polimero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`unidad_polimero` (
  `id_unidad` INT NOT NULL AUTO_INCREMENT,
  `unidad_polimerocol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_unidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`valor_centrifuga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`valor_centrifuga` (
  `entrada_lodo` DECIMAL(5,1) NULL,
  `entrada_polimero` DECIMAL(4,1) NULL,
  `vr` DECIMAL(3,1) NULL,
  `torque` DECIMAL(3,1) NULL,
  `va` DECIMAL(5,1) NULL,
  `centrifuga_id_centrifuga` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  `unidad_polimero_id_unidad` INT NOT NULL,
  PRIMARY KEY (`centrifuga_id_centrifuga`, `fecha_dia`),
  INDEX `fk_valores_centrifuga_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  INDEX `fk_valores_centrifuga_unidad_polimero1_idx` (`unidad_polimero_id_unidad` ASC) VISIBLE,
  CONSTRAINT `fk_valores_centrifuga_centrifuga1`
    FOREIGN KEY (`centrifuga_id_centrifuga`)
    REFERENCES `espesamiento3N`.`centrifuga` (`idcentrifuga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valores_centrifuga_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valores_centrifuga_unidad_polimero1`
    FOREIGN KEY (`unidad_polimero_id_unidad`)
    REFERENCES `espesamiento3N`.`unidad_polimero` (`id_unidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`muestra_centrifuga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`muestra_centrifuga` (
  `salida_sequedad` DECIMAL(3,1) NULL,
  `salida_centrado` DECIMAL(6,1) NULL,
  `turno_id_turno` INT NOT NULL,
  `centrifuga_id_centrifuga` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`turno_id_turno`, `centrifuga_id_centrifuga`, `fecha_dia`),
  INDEX `fk_muestras_centrifuga_turno_idx` (`turno_id_turno` ASC) VISIBLE,
  INDEX `fk_muestras_centrifuga_centrifuga1_idx` (`centrifuga_id_centrifuga` ASC) VISIBLE,
  INDEX `fk_muestras_centrifuga_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_muestras_centrifuga_turno`
    FOREIGN KEY (`turno_id_turno`)
    REFERENCES `espesamiento3N`.`turno` (`id_turno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_muestras_centrifuga_centrifuga1`
    FOREIGN KEY (`centrifuga_id_centrifuga`)
    REFERENCES `espesamiento3N`.`centrifuga` (`idcentrifuga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_muestras_centrifuga_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`tipo_polimero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`tipo_polimero` (
  `id_polimero` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_polimero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`preparacion_polimero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`preparacion_polimero` (
  `peso` DECIMAL(5,1) NULL,
  `caudal_agua` DECIMAL(5,1) NULL,
  `unidad_polimero_id_unidad` INT NOT NULL,
  `tipo_polimero_id_polimero` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`unidad_polimero_id_unidad`, `tipo_polimero_id_polimero`, `fecha_dia`),
  INDEX `fk_preparacion_polimero_tipo_polimero1_idx` (`tipo_polimero_id_polimero` ASC) VISIBLE,
  INDEX `fk_preparacion_polimero_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_preparacion_polimero_unidad_polimero1`
    FOREIGN KEY (`unidad_polimero_id_unidad`)
    REFERENCES `espesamiento3N`.`unidad_polimero` (`id_unidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preparacion_polimero_tipo_polimero1`
    FOREIGN KEY (`tipo_polimero_id_polimero`)
    REFERENCES `espesamiento3N`.`tipo_polimero` (`id_polimero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preparacion_polimero_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`horario_muestra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`horario_muestra` (
  `hora` TIME NOT NULL,
  PRIMARY KEY (`hora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`manto_lodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`manto_lodo` (
  `valor` DECIMAL(2,1) NULL,
  `pre_espesador_id_pre_espesador` INT NOT NULL,
  `horario_muestra_hora` TIME NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`pre_espesador_id_pre_espesador`, `horario_muestra_hora`, `fecha_dia`),
  INDEX `fk_manto_lodo_horario_muestra1_idx` (`horario_muestra_hora` ASC) VISIBLE,
  INDEX `fk_manto_lodo_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_manto_lodo_pre_espesador1`
    FOREIGN KEY (`pre_espesador_id_pre_espesador`)
    REFERENCES `espesamiento3N`.`pre_espesador` (`id_pre_espesador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manto_lodo_horario_muestra1`
    FOREIGN KEY (`horario_muestra_hora`)
    REFERENCES `espesamiento3N`.`horario_muestra` (`hora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manto_lodo_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`mesa` (
  `idmesa` INT NOT NULL,
  `equipo` CHAR NOT NULL,
  PRIMARY KEY (`idmesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`valor_mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`valor_mesa` (
  `entrada_lodo` DECIMAL(4,1) NULL,
  `entrada_polimero` DECIMAL(3,1) NULL,
  `fecha_dia` DATE NOT NULL,
  `mesa_idmesa` INT NOT NULL,
  `unidad_polimero_id_unidad` INT NOT NULL,
  PRIMARY KEY (`fecha_dia`, `mesa_idmesa`),
  INDEX `fk_valor_mesa_mesa1_idx` (`mesa_idmesa` ASC) VISIBLE,
  INDEX `fk_valor_mesa_unidad_polimero1_idx` (`unidad_polimero_id_unidad` ASC) VISIBLE,
  CONSTRAINT `fk_valor_mesa_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valor_mesa_mesa1`
    FOREIGN KEY (`mesa_idmesa`)
    REFERENCES `espesamiento3N`.`mesa` (`idmesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valor_mesa_unidad_polimero1`
    FOREIGN KEY (`unidad_polimero_id_unidad`)
    REFERENCES `espesamiento3N`.`unidad_polimero` (`id_unidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`ELD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`ELD` (
  `idELD` INT NOT NULL,
  `estanque` CHAR NULL,
  PRIMARY KEY (`idELD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `espesamiento3N`.`valor_eld`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `espesamiento3N`.`valor_eld` (
  `salida_sequedad` DECIMAL(3,1) NULL,
  `salida_volatil` DECIMAL(3,1) NULL,
  `ELD_idELD` INT NOT NULL,
  `fecha_dia` DATE NOT NULL,
  PRIMARY KEY (`ELD_idELD`, `fecha_dia`),
  INDEX `fk_valor_eld_fecha1_idx` (`fecha_dia` ASC) VISIBLE,
  CONSTRAINT `fk_valor_eld_ELD1`
    FOREIGN KEY (`ELD_idELD`)
    REFERENCES `espesamiento3N`.`ELD` (`idELD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valor_eld_fecha1`
    FOREIGN KEY (`fecha_dia`)
    REFERENCES `espesamiento3N`.`fecha` (`dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
