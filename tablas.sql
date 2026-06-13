-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Proyecto1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Proyecto1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Proyecto1` ;
USE `Proyecto1` ;

-- -----------------------------------------------------
-- Table `Proyecto1`.`Veterinarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Veterinarios` (
  
  `Carnet_Veterinario` VARCHAR(11) NOT NULL,
  -- carnet solo numeros
   CONSTRAINT check_carnet CHECK (`Carnet_Veterinario` NOT LIKE '%[^0-9]%'),
   
  `Cedula_Veterinario` VARCHAR(11) NOT NULL,
  `Nombre_Veterinario` VARCHAR(50) NOT NULL,
  `Apellido_Veterinario` VARCHAR(50) NOT NULL,
  
  `Numero_Telefono` VARCHAR(12) NOT NULL,
  -- telefono solo numeros:
   CONSTRAINT check_telefono CHECK (`Numero_Telefono` NOT LIKE '%[^0-9]%'),
   
  `Direccion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`Carnet_Veterinario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_Tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_Tipos` (
  `ID_TipoMascota` VARCHAR(10) NOT NULL,
  `Tipo_Mascota` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_TipoMascota`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_Razas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_Razas` (
  `ID_RazaMascota` VARCHAR(10) NOT NULL,
  `Raza_Mascota` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_RazaMascota`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Dueños`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Dueños` (
  `Cedula_Dueño` VARCHAR(11) NOT NULL,
  `Nombre_Dueño` VARCHAR(50) NOT NULL,
  `Apellido_Dueño` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(300) NULL,
  PRIMARY KEY (`Cedula_Dueño`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Mascotas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Mascotas` (
  `ID_Mascota` VARCHAR(10) NOT NULL,
  `Cedula_Dueño` VARCHAR(11) NOT NULL,
  `Nombre_Mascota` VARCHAR(50) NULL,
  `Fecha_Nacimiento` DATE NULL,
  `Edad_Estimada` INT(3) NULL,
  `ID_TipoMascota` VARCHAR(10) NOT NULL,
  `ID_RazaMascota` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ID_Mascota`),
  CONSTRAINT `fk_MascotasXTipos`
    FOREIGN KEY (`ID_TipoMascota`)
    REFERENCES `Proyecto1`.`Catalogo_Tipos` (`ID_TipoMascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MascotasXRazas`
    FOREIGN KEY (`ID_RazaMascota`)
    REFERENCES `Proyecto1`.`Catalogo_Razas` (`ID_RazaMascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MascotasXDueños`
    FOREIGN KEY (`Cedula_Dueño`)
    REFERENCES `Proyecto1`.`Dueños` (`Cedula_Dueño`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_MascotasXTipos` ON `Proyecto1`.`Mascotas` (`ID_TipoMascota` ASC) VISIBLE;

CREATE INDEX `fk_idx_MascotasXRazas` ON `Proyecto1`.`Mascotas` (`ID_RazaMascota` ASC) VISIBLE;

CREATE INDEX `fk_idx_MascotasXDueños` ON `Proyecto1`.`Mascotas` (`Cedula_Dueño` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Expediente_Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Expediente_Medico` (
  `ID_Expediente` VARCHAR(10) NOT NULL,
  `ID_Mascota` VARCHAR(10) NOT NULL,
  `Carnet_Veterinario` VARCHAR(11) NOT NULL,
  `Numero_Revision` VARCHAR(10) NULL,
  `Motivo_Visita` VARCHAR(2000) NULL,
  `Sintomas` VARCHAR(2000) NULL,
  `Consideraciones_Importantes` VARCHAR(2000) NULL,
  `Diagnostico` VARCHAR(2000) NULL,
  PRIMARY KEY (`ID_Expediente`),
  CONSTRAINT `fk_ExpedienteXMascota`
    FOREIGN KEY (`ID_Mascota`)
    REFERENCES `Proyecto1`.`Mascotas` (`ID_Mascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExpedienteXVeterinarios`
    FOREIGN KEY (`Carnet_Veterinario`)
    REFERENCES `Proyecto1`.`Veterinarios` (`Carnet_Veterinario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_ExpedienteXMascota` ON `Proyecto1`.`Expediente_Medico` (`ID_Mascota` ASC) VISIBLE;

CREATE INDEX `fk_idx_ExpedienteXVeterinarios` ON `Proyecto1`.`Expediente_Medico` (`Carnet_Veterinario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_Examenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_Examenes` (
  `ID_TipoExamen` VARCHAR(10) NOT NULL,
  `Tipo_Examen` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_TipoExamen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Control_Examenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Control_Examenes` (
  `ID_Expediente` VARCHAR(10) NOT NULL,
  `ID_TipoExamen` VARCHAR(10) NOT NULL,
  `Fecha_Examen` DATE NULL,
  `Hallazgos` VARCHAR(1000) NULL,
  PRIMARY KEY (`ID_Expediente`),
  CONSTRAINT `fk_ExamenXCatalogoEX`
    FOREIGN KEY (`ID_TipoExamen`)
    REFERENCES `Proyecto1`.`Catalogo_Examenes` (`ID_TipoExamen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExamenesXExpediente`
    FOREIGN KEY (`ID_Expediente`)
    REFERENCES `Proyecto1`.`Expediente_Medico` (`ID_Expediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_ExamenXCatalogoEX` ON `Proyecto1`.`Control_Examenes` (`ID_TipoExamen` ASC) VISIBLE;

CREATE INDEX `fk_idx_ExamenesXExpediente` ON `Proyecto1`.`Control_Examenes` (`ID_Expediente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Control_Medicamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Control_Medicamentos` (
  `ID_Expediente` VARCHAR(10) NOT NULL,
  `Medicamento_Dosis` VARCHAR(500) NULL,
  PRIMARY KEY (`ID_Expediente`),
  CONSTRAINT `fk_MedicamentosXExpediente`
    FOREIGN KEY (`ID_Expediente`)
    REFERENCES `Proyecto1`.`Expediente_Medico` (`ID_Expediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_MedicamentosXExpediente` ON `Proyecto1`.`Control_Medicamentos` (`ID_Expediente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_Vacunas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_Vacunas` (
  `ID_TipoVacuna` VARCHAR(10) NOT NULL,
  `Tipo_Vacuna` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_TipoVacuna`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Control_Vacunas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Control_Vacunas` (
  `ID_Expediente` VARCHAR(10) NOT NULL,
  `ID_TipoVacuna` VARCHAR(10) NOT NULL,
  `Fecha_Vacunacion` DATE NULL,
  `Comentario` VARCHAR(200) NULL,
  `Carnet_Veterinario` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`ID_Expediente`),
  CONSTRAINT `fk_VacunasXVeterinario`
    FOREIGN KEY (`Carnet_Veterinario`)
    REFERENCES `Proyecto1`.`Veterinarios` (`Carnet_Veterinario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VacunasXCatalogoVA`
    FOREIGN KEY (`ID_TipoVacuna`)
    REFERENCES `Proyecto1`.`Catalogo_Vacunas` (`ID_TipoVacuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VacunasXExpediente`
    FOREIGN KEY (`ID_Expediente`)
    REFERENCES `Proyecto1`.`Expediente_Medico` (`ID_Expediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_VacunasXVeterinario` ON `Proyecto1`.`Control_Vacunas` (`Carnet_Veterinario` ASC) VISIBLE;

CREATE INDEX `fk_idx_VacunasXCatalogoVA` ON `Proyecto1`.`Control_Vacunas` (`ID_TipoVacuna` ASC) VISIBLE;

CREATE INDEX `fk_idx_VacunasXExpediente` ON `Proyecto1`.`Control_Vacunas` (`ID_Expediente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_EmailsClientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_EmailsClientes` (
  `ID_Email` VARCHAR(10) NOT NULL,
  `Cedula_Dueño` VARCHAR(11) NOT NULL,
  `Email` VARCHAR(60) NULL,
  PRIMARY KEY (`ID_Email`),
  CONSTRAINT `fk_EmailXDueños`
    FOREIGN KEY (`Cedula_Dueño`)
    REFERENCES `Proyecto1`.`Dueños` (`Cedula_Dueño`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Email_UNIQUE` ON `Proyecto1`.`Catalogo_EmailsClientes` (`Email` ASC) VISIBLE;

CREATE INDEX `fk_idx_EmailsXDueños` ON `Proyecto1`.`Catalogo_EmailsClientes` (`Cedula_Dueño` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Agenda` (
  `Numero_Cita` VARCHAR(10) NOT NULL,
  `ID_Mascota` VARCHAR(10) NOT NULL,
  `ID_Email` VARCHAR(10) NOT NULL,
  `Dia_Cita` DATE NOT NULL,
  
  `Hora_Cita` TIME NOT NULL,
  -- citas solo cada 30 minutos
   CONSTRAINT check_minute CHECK ( EXTRACT(MINUTE FROM Hora_Cita) = '0' OR EXTRACT(MINUTE FROM Hora_Cita) = '30' ),
   
  -- citas solo de 9am a 5pm
   CONSTRAINT check_hour CHECK ( EXTRACT(HOUR FROM Hora_Cita) >= '9' AND EXTRACT(HOUR FROM Hora_Cita) < '17' ),
  
  -- solo dos pacientes
  -- ??????????????????

  PRIMARY KEY (`Numero_Cita`),
  CONSTRAINT `fk_AgendaXMascota`
    FOREIGN KEY (`ID_Mascota`)
    REFERENCES `Proyecto1`.`Mascotas` (`ID_Mascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AgendaXEmails`
    FOREIGN KEY (`ID_Email`)
    REFERENCES `Proyecto1`.`Catalogo_EmailsClientes` (`ID_Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_idx_AgendaXMascota` ON `Proyecto1`.`Agenda` (`ID_Mascota` ASC) VISIBLE;

CREATE INDEX `fk_idx_AgendaXEmail` ON `Proyecto1`.`Agenda` (`ID_Email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Proyecto1`.`Catalogo_TelefonosClientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto1`.`Catalogo_TelefonosClientes` (
  `ID_Telefono` VARCHAR(10) NOT NULL,
  `Cedula_Dueño` VARCHAR(11) NOT NULL,
  `Numero_Telefono` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`ID_Telefono`),
  CONSTRAINT `fk_Catalogo_TelefonosClientes_Dueños1`
    FOREIGN KEY (`Cedula_Dueño`)
    REFERENCES `Proyecto1`.`Dueños` (`Cedula_Dueño`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Numero_Telefono_UNIQUE` ON `Proyecto1`.`Catalogo_TelefonosClientes` (`Numero_Telefono` ASC) VISIBLE;

CREATE INDEX `fk_TelefonosXDueños` ON `Proyecto1`.`Catalogo_TelefonosClientes` (`Cedula_Dueño` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;