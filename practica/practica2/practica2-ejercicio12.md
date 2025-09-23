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

**DEPENDENCIAS FUNCIONALES**
- DF1: codHospital -> cantidadHabitaciones, directorHospital, ciudadHospital, domicilioHospital
- DF2: ciudadHospital, domicilioHospital -> codHospital, cantidadHabitaciones, directorHospital
- DF3: dniPaciente -> domicilioPaciente, nombreApellidoPaciente
- DF4: dniPaciente, fechaInicioInternacion -> direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantDiasInternacion
- DF5: dniPaciente, fechaInicioInternacion -> direccionInternacionPaciente, telefonoInternacionPaciente, cantDiasInternacion, ciudadHOspital, domicilioHospital
- DF1 y DF2 son equivalentes ya que producen el mismo conjunto de atributos
- DF4, y DF5 son equivalentes ya que producen el mismo conjunto de atributos

**CLAVES CANDIDATAS**
- CC1: (dniPaciente, fechaInicioInternacion, doctorQueAtiendePaciente, insumoEmpleadoInternacion)

**NORMALIZACION A BCNF**
- **El esquema `INTERNACION` no se encuentra en BCNF ya que existe al menos el determinante de la DF1 donde {codHospital} no es superclave**
  - Particiono tomando la DF1
  - I1(<u>codHospital</u>, cantidadHabitaciones, directorHospital, <u>ciudadHospital</u>, <u>domicilioHospital</u>)
  - I2(codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, <u>dniPaciente</u>, domicilioPaciente, nombreApellidoPaciente, <u>fechaInicioInternacion</u>, cantDiasIntenacion, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>)
  - No se pierde información ya que `I1nI2` es clave en el esquema `I1`
  - No se pierden DF's ya que:
    - DF1, DF2 siguen valiendo en `I1`
    - DF3, DF4, DF5 siguen valiendo en `I2`
  - Podemos entonces decir que `I1` se encuentra en BCNF ya que los determinantes de las DF1, DF2 son superclave en el esquema
- **El esquema `I2` no se encuentra en BCNF ya que existe al menos el determinante de la DF3 donde {dniPaciente} no es superclave**
  - Particiono el esquema tomando la DF3
  - I3(<u>dniPaciente</u>, domicilioPaciente, nombreApellidoPaciente)
  - I4(codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, <u>dniPaciente</u>, <u>fechaInicioInternacion</u>, cantDiasIntenacion, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>)
  - No se pierde información ya que `I3nI4` es clave en el esquema `I3`
  - No se pierden DF's ya que:
    - DF3 sigue valiendo en `I3`
    - DF4, DF5 siguen valiendo en `I4`
  - Podemos entonces decir que `I3` se encuentra en BCNF ya que el determinante de la DF3 y es superclave en el esquema
- **El esquema `I4` no se encuentra en BCNF ya que existe al menos el determinante de la DF4 donde {dniPaciente, fechaInicioInternacion} no es superclave**
  - Particiono el esquema tomando la DF4
  - I5(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantDiasInternacion)
  - I6(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>)
  - No se pierde información ya que `I5nI6` es clave en el esquema `I5`
  - No se pierden DF's ya que:
    - DF4 siguen valiendo en `I5`
    - DF5 no se pierde
      - *(direccionInternacionPaciente, telefonoInternacionPaciente, cantDiasInternacion)* estan en `I5`
      - *(ciudadHOspital, domicilioHospital)* no se encuentran en `I6` pero no se pierde ya que existe una relacion indirecta a traves de la DF1 donde *(codHospital -> ciudadHOspital, domicilioHospital)*
  - Podemos entonces decir que `I5` se encuentra en BCNF ya que el determinante de la DF4 es superclave en el esquema
  - Podemos entonces decir que `I6` se encuentra en BCNF ya que el conjunto de sus atributos hacen a la CC y cualquier DF que se detecte seria trivial

**PARTICIONES EN BCNF Y CLAVE PRIMARIA**
- I1(<u>codHospital</u>, cantidadHabitaciones, directorHospital, <u>ciudadHospital</u>, <u>domicilioHospital</u>)
- I3(<u>dniPaciente</u>, domicilioPaciente, nombreApellidoPaciente)
- I5(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantDiasInternacion)
- I6(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>)
- CP{<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>}

**DEPENDENCIAS MULTIVALUADAS**
- I6(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>, <u>insumoEmpleadoInternación</u>)
- DM1: dniPaciente, fechaInicioInternacion ->> insumoEmpleadoInternacion
- DM2: dniPaciente, fechaInicioInternacion ->> doctorQueAtiendePaciente
- **Tanto DM1 como DM2, no son triviales en el esquema `I6` por lo tanto no esta en 4NF**
  - Particiono el esquema tomando la DM1
  - I7(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>insumoEmpleadoInternacion</u>)
  - I8(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>)
  - Podemos entonces decir que `I7` se encuentra en 4NF ya que solo vale la DM1 y es trivial en el esquema
  - Podemos entonces decir que `I8` se encuentra en 4NF ya que solo vale la DM2 y es trivial en el esquema

**ESQUEMAS EN 4NF**
- I1(<u>codHospital</u>, cantidadHabitaciones, directorHospital, <u>ciudadHospital</u>, <u>domicilioHospital</u>)
- I3(<u>dniPaciente</u>, domicilioPaciente, nombreApellidoPaciente)
- I5(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantDiasInternacion)
- I7(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>insumoEmpleadoInternacion</u>)
- I8(<u>dniPaciente</u>, <u>fechaInicioInternacion</u>, <u>doctorQueAtiendePaciente</u>)
- Los esquemas `I1`, `I3`, `I5` se encuentra en 4NF ya que no existen DM's en ellos
- Los esquemas `I7`, `I8` se encuentran en 4NF ya que las unicas DM's que valen en ellos son triviales

### CONSULTAS
- verificar la justificion cuando el esquema `I4` no cumple BCNF, en el caso donde NO SE PIERDE DF5