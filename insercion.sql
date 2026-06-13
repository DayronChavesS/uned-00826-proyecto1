
-- FASE 1: SE INSERTAN LOS DATOS EN LOS CATALOGOS INDEPENDIENTES --

INSERT INTO `Proyecto1`.`Catalogo_Razas` (`ID_RazaMascota`, `Raza_Mascota`)
VALUES ('1','Indefinido'); 

INSERT INTO `Proyecto1`.`Catalogo_Tipos` (`ID_TipoMascota`, `Tipo_Mascota`)
VALUES ('1','Perro'); 

INSERT INTO `Proyecto1`.`Catalogo_Examenes` (`ID_TipoExamen`, `Tipo_Examen`)
VALUES ('1','Sensorial'); 

INSERT INTO `Proyecto1`.`Catalogo_Vacunas` (`ID_TipoVacuna`, `Tipo_Vacuna`)
VALUES ('1','Aspirina-19'); 



-- FASE 2: SE INSERTAN LOS DATOS EN LAS 3 ENTIDADES PRINCIPALES --

INSERT INTO `Proyecto1`.`Dueños` (`Cedula_Dueño`, `Nombre_Dueño`, `Apellido_Dueño`, `Direccion`)
VALUES ('0101110111','Alan', 'Smith', 'Cerca del parque la amistad.'); 

INSERT INTO `Proyecto1`.`Mascotas` (`ID_Mascota`, `Cedula_Dueño`, `Nombre_Mascota`, `Fecha_Nacimiento`, `Edad_Estimada`, `ID_TipoMascota`, `ID_RazaMascota`)
VALUES ('1','0101110111', 'Firulais', '2015-11-15', '5', '1', '1'); 

INSERT INTO `Proyecto1`.`Veterinarios` (`Carnet_Veterinario`, `Cedula_Veterinario`, `Nombre_Veterinario`, `Apellido_Veterinario`, `Numero_Telefono`, `Direccion`)
VALUES ('0303330333','0202220222', 'Salvador', 'Faust', '77777777', 'Junto al mall Villa Feliz.'); 



-- FASE 3: SE INSERTAN DATOS EN EL EXPENDIENTE Y LOS CONTROLES --

INSERT INTO `Proyecto1`.`Expediente_Medico` (`ID_Expediente`, `ID_Mascota`, `Carnet_Veterinario`, `Numero_Revision`, `Motivo_Visita`, `Sintomas`, `Consideraciones_Importantes`, `Diagnostico`)
VALUES ('1','1', '0303330333', '1', 'Enfermo', 'Dolor de Estomago', 'El perro se ve decaido.', 'El perro comio mucho alimento.'); 

INSERT INTO `Proyecto1`.`Control_Examenes` (`ID_Expediente`, `ID_TipoExamen`, `Fecha_Examen`, `Hallazgos`)
VALUES ('1', '1', '2020-11-1', 'No se detectaron tumores.'); 

INSERT INTO `Proyecto1`.`Control_Medicamentos` (`ID_Expediente`, `Medicamento_Dosis`)
VALUES ('1', 'Se receto Aspirina, 5g por una semana.'); 

INSERT INTO `Proyecto1`.`Control_Vacunas` (`ID_Expediente`, `ID_TipoVacuna`, `Fecha_Vacunacion`, `Comentario`, `Carnet_Veterinario`)
VALUES ('1', '1', '2020-11-1', 'El perro no mostro signos de dolor.', '0303330333'); 



-- FASE 4: SE INSERTAN LOS DATOS EN LOS CATALOGOS DEPENDIENTES --

INSERT INTO `Proyecto1`.`Catalogo_EmailsClientes` (`ID_Email`, `Cedula_Dueño`, `Email`)
VALUES ('1','0101110111', 'alan@email.com'); 

INSERT INTO `Proyecto1`.`Catalogo_TelefonosClientes` (`ID_Telefono`, `Cedula_Dueño`, `Numero_Telefono`)
VALUES ('1','0101110111', '88888888'); 



-- FASE 5: SE INSERTAN LOS DATOS PARA AGENDAR UNA CITA --

INSERT INTO `Proyecto1`.`Agenda` (`Numero_Cita`, `ID_Mascota`, `ID_Email`, `Dia_Cita`, `Hora_Cita`)
VALUES ('1', '1', '1', '2020-11-01', '16:30:00'); 

