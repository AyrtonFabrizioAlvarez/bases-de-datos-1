## 6. 
`SUSCRIPCION (#suscripcion, email, nombre_usuario, #plan, nombre_plan, texto_condiciones, precio, email_adicional, nombre_adicional, #contenido, titulo, sinopsis, duracion, fecha_adicional)`  
**Donde:**
- Cada suscripción es realizada por un único usuario (identificado por el email) y un plan, pero además hay usuarios adicionales que la utilizan (email_adicional). De cada usuario adicional que se suma a la suscripción, se guarda la fecha.
- Un plan de suscripción tiene un nombre (que no puede garantizarse que sea único en el sistema), condiciones, y un precio mensual.
- Cada contenido tiene un título, sinopsis y duración. El #contenido es único en el sistema, pero del título no puede garantizarse que lo sea.
- De cada suscripción se sabe qué contenidos fueron reproducidos, sin distinción sobre qué usuario (titular o adicionales) reprodujo cada uno.

### SOLUCIÓN
### CONSULTAS



## 7. 
`MEDICION_AMBIENTAL(#medicion, #pozo, valor_medicion, #parametro, fecha_medicion, cuil_operario, #instrumento, nombre_parametro, valor_ref, descripcion_pozo, fecha_perforacion, apellido_operario, nombre_operario, fecha_nacimiento, marca_instrumento, modelo_instrumento, dominio_vehiculo, fecha_adquisicion)`  
**Donde:**
- Cada medición es realizada por un operario en un pozo, en una fecha determinada. En ella se miden varios parámetros, y para cada uno se obtiene un valor. Notar que un mismo parámetro (#parametro) puede ser medido en diferentes mediciones. Independientemente de las mediciones, todo parámetro tiene un nombre y valor de
referencia, y el #parametro es único en el sistema.
- En cada medición se utilizan varios instrumentos, independientemente de los parámetros medidos. De cada instrumento se conoce la marca y modelo.
- De cada operario se conoce su cuit, nombre, apellido y fecha de nacimiento.
- La empresa cuenta con vehículos, y de cada uno se conoce la fecha en la que fue adquirido. El dominio (patente) de cada vehículo es único en el sistema.
- Un pozo tiene una descripción y una fecha de perforación. El identificador #pozo es único en el sistema.

### SOLUCIÓN
### CONSULTAS



## 8. 
`FESTIVALES (#festival, denominacion_festival, localidad, cuil_musico, nombre_musico, fecha_nacimiento, #banda, nombre_banda, estilo_musical, #tema, nombre_tema, duracion, instrumento, cuil_auspiciante, url_plataforma_entradas, #sponsor)`  
**Donde:**
- Para cada festival se conoce su denominación y la localidad en la que se realiza. Más de un festival podría tener la misma denominación.
- De cada banda se conoce su nombre y estilo musical.
- De cada músico se conoce su cuil, nombre y su fecha de nacimiento. Tenga en cuenta que varios músicos podrían tener el mismo nombre.
- Para cada tema interpretado por una banda en un festival se conoce su nombre y duración. Además, de cada músico que participó en el tema se sabe con qué
instrumento lo hizo.
- Los #tema pueden repetirse para las distintas bandas.
- Un festival puede tener varios auspiciantes, y se vendieron entradas al mismo a través de varias plataformas.
- Se tiene además un registro de todas los sponsors que han participado de los distintos festivales realizados.

### SOLUCIÓN
### CONSULTAS



## 9. 
`TORNEOS (#torneo, nombre_torneo, año, #equipo, nombre_equipo, estadio_equipo, puesto, #reglamentacion, descripcion, #auspiciante)`  
- De cada torneo, se conoce su identificador (#torneo, único en el sistema) y un nombre. Un mismo torneo tiene diferentes ediciones, cada edición se realiza en un año determinado y el mismo torneo no puede repetirse el mismo año. En un año pueden realizarse varios torneos.
- Cada edición de un torneo tiene diferentes auspiciantes, identificados por #auspiciante (único en el sistema).
- En cada edición de un torneo participan varios equipos. De cada equipo se conoce su nombre, su estadio y su #equipo, que no se repite para diferentes equipos.
- Cada equipo finaliza una edición de un torneo en un puesto. Dos o más equipos no pueden finalizar en un mismo puesto.
- Además, se conoce un conjunto de reglamentaciones, identificadas por #reglamentación, aplicables a estos torneos.

### SOLUCIÓN
### CONSULTAS


## 10. 
`DISPOSITIVOS (marca_id, descripMarca, modelo_id, descripModelo, equipo_tipo_id, descripEquipoTipo, nombreEmpresa, cuit, direcciónEmpresa, usuario_id, apyn, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, línea_id, fec_alta_linea, fec_baja_linea)`  
**Donde:**
- Para cada equipo interesa conocer su tipo, modelo, imei, fecha en que se dio de alta, fecha en que se da de baja y las observaciones que sean necesarias.
- De cada marca se conoce su descripción
- ​De cada modelo se conoce su descripción y a qué marca pertenece.
- ​Para cada plan, se registra qué empresa lo brinda, descripción e importe del mismo.
- ​Para cada tipo de equipo se conoce la descripción
- ​Para cada empresa se registra el nombre, cuit y dirección
- De cada usuario se registra su nombre y apellido, número de documento, dirección y CUIL​
- Para cada línea se necesita registrar qué plan posee, la fecha de alta de la línea, la fecha de baja, el equipo que la posee y el usuario de la misma.

### SOLUCIÓN
### CONSULTAS



## 11. 
`ORGANIZACION_EVENTOS (#evento, fecha_evento, motivo_evento, #salon, nombre_salon, #grupo, nombre_grupo, nro_integrantes_grupo, #organizador, nombre_organizador, telefono_organizador, años_exp_organizador, #persona_staff, nombre_persona_staff, telefono_persona_staff, rol_persona_staff)`  
**Donde:**
- De cada evento se conoce un identificador, que es único, la fecha, el motivo, el salón de fiestas donde se desarrollará y el grupo que tocará en el mismo.
- De cada salón de fiestas posible se conoce un número identificador, único en el sistema y su nombre.
- De los grupos se conoce un identificador (único) su nombre y la cantidad de integrantes que lo conforman. Además, se sabe que cada grupo de los registrados en el sistema tiene un contrato de exclusividad con un único organizador.
- De los organizadores se conoce su nombre, teléfono y los años de experiencia que lleva en su trabajo. También tiene asociado un número que lo identifica.
- Cada organizador tiene contrato con muchos grupos, sin embargo este solo organiza cada una de sus fechas disponibles con un único grupo, que será el que toque la noche del evento.
- Cada evento contrata a una serie de personas que serán el staff del mismo. De cada uno de estos se conoce un identificador, único en el sistema, el nombre, el teléfono y el rol que ocupa.

### SOLUCIÓN
### CONSULTAS



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


