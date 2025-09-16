> [!WARNING]
> Por ahora no esta chequeado

> [!IMPORTANT]
> ## Pasos para normalizar hasta 4NF
> 1. Encontrar las dependencias funcionales
> 2. Encontrar las claves candidatas
> 3. Verificar si el esquema cumple con la definición de BCNF, si no se cumple descomponer la relación sin perder información ni dependencias funcionales
>     - Si se pierden dependencias funcionales, llevar a 3NF
> - Esto hasta dejar las particiones en BCNF o 3FN
> 4. Expresar en este punto, cual es la clave primaria y que particiones quedaron en BCNF o 3FN (según corresponda)
> 5. Encontrar las dependencias multivaluadas sobre la última partición realizada (aquella que tiene la clave primaria del esquema) y verificar 4NF, si no se cumple dividir la relación
> - Esto se hace hasta dejar las particiones del esquema en 4FN
> 6. Expresar las particiones resultantes que quedaron en 4FN o Explicar porque las particiones descriptas en el ítem 4 (excepto la analizada en el punto 5)
quedaron en 4FN
> 7. Indicar que particiones en 4FN quedan en el esquema final (que no sean proyecciones de atributos claves de otras particiones en 4FN)


## 12. 
`INTERNACION (codHospital, cantidadHabitaciones, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, domicilioHospital, ciudadHospital, directorHospital, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación)`  
**Donde:**
- cantidadHabitaciones es la cantidad de habitaciones que hay en cada hospital
- direcciónInternacionPaciente y telefonoInternacionPaciente, indican la dirección y el teléfono que deja un paciente cuando se interna
- domicilioPaciente es el domicilio que figura en el dni del paciente
- Un paciente para una internación es atendido por muchos doctores (doctorQueAtiendePaciente)
- Para una internación de un paciente, se emplean varios insumos (insumoEmpleadoInternación)
- El código de hospital (codHospital) es único.
- Existe un único director por hospital. Un director podría dirigir más de un hospital
- Un paciente en la misma fecha no puede estar internado en diferentes hospitales
- En un domicilioHospital de una ciudad existe un único hospital

### SOLUCIÓN
### CONSULTAS