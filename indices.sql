-- Estos indices fueron creados con base en los "intereses" de Vets4Pets que figuran en las instrucciones del proyecto.
-- ____________________________________________________________________________________________________________________


-- INTERES 0: ACELERAR TODO TIPO DE CONSULTAS REFERENTES A LOS DUEÑOS
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_DUEÑOS` ON `Proyecto1`.`Dueños` (`Cedula_Dueño`,`Nombre_Dueño`, `Apellido_Dueño` ASC);




-- INTERES 1: EXPEDIENTE DE MASCOTA.
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_EXPEDIENTE+MASCOTA` ON `Proyecto1`.`Expediente_Medico` (`ID_Expediente`,`ID_Mascota`ASC);




-- INTERES 3: HISTORIAL DE MASCOTAS Y SUS VACUNAS
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_EXPEDIENTES+VACUNAS` ON `Proyecto1`.`Control_Vacunas` (`ID_Expediente`,`ID_TipoVacuna` ASC);



-- INTERES 4: HISTORIAL MASCOTAS Y SUS VACUNAS, EN ORDEN CRONOLOGICO. (PARA RANGOS)
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_MASCOTAS+VACUNAS+FECHA` ON `Proyecto1`.`Control_Vacunas` ( `ID_Expediente`,`ID_TipoVacuna`, `Fecha_Vacunacion` ASC);



-- INTERES 5: CITAS Y LOS EMAILS DE LOS DUEÑOS.
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_CITAS+EMAILS` ON `Proyecto1`.`Agenda` (`Numero_Cita`,`ID_Email` ASC);



-- INTERES 6: CITAS Y EMAILS, EN ORDEN CRONOLOGICO.
-- ____________________________________________________________________________________________________
CREATE INDEX `INDICE_CITAS+EMAILS+FECHA` ON `Proyecto1`.`Agenda` (`Numero_Cita`,`ID_Email`, `Dia_Cita` ASC);