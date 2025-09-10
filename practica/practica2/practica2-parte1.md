## 1.​ Indicar la opción correcta.
**Dado el siguiente esquema:**  
`MapasPublicados (idMapa, proyección, escalaMapa, idSitioWeb, dominioSitioWeb,especialidadSitioWeb, dueñosSitioWeb, fechaPublicaciónMapa, valorPublicación)`  

**Donde:**
- A un sitio web se le cobra un valor (“valorPublicación”) por cada fecha (“fechaPublicaciónMapa”) en la cual publique un mapa.
- Un sitio web puede tener varios dueños (“dueñosSitioWeb”).
- Un sitio web posee un único dominio (“dominioSitioWeb”).
- El identificador de un mapa (“idMapa”) es único.
- El identificador de un sitio web (“idSitioWeb”) es único.
- Un mapa se genera con una proyección y a una escala.
- “especialidadSitioWeb” es la especialidad de un sitio.

**Seleccione la frase que considera verdadera**  
- El esquema tiene una clave candidata
- El esquema tiene más de una clave candidata

### SOLUCIÓN
***Primero analizamos las dependencias funcionales `DF` que existen y a partir de ahi podemos ver si tenemos 1 o mas claves candidatas `CC`***  
- DF1- idMapa -> proyeccion, escalaMapa
- DF2- idSitioWeb -> dominioSitioWeb, especialidadSitioWeb
- DF3- idMapa, idSitioWeb, fechaPublicacionMapa -> valorPublicacion

***A partir de las dependencias funcionales `DF` señaladas anteriormente podemos ver que tenemos una sola clave candidata `CC`***  
- CC(idMapa, idSitioWeb, fechaPublicacionMapa, valorPublicacion)



## 2. Clave candidata
**Dado el siguiente esquema donde se cumplen las siguientes dependencias funcionales df1 y df2:**
- E(a, b, c, d, e, f)​
- df1- a->b, c
- df2- c->d, e

**¿Cuál de las siguientes CC es la correcta?**  
- 1. CC(a,c)
- 2. CC(a)
- 3. CC(a,f)
- 4. CC(a,c,f)
- 5. CC(f)

### SOLUCIÓN
***En este caso por las DF anunciadas podemos ver que:***  
- con 'a' determinamos 'b' y 'c', y a su vez, con 'c' determinamos 'd' y 'e'
- con esto podríamos pensar que sería la opción 2 'CC(a)', pero no hay que olvidar que en este caso 'E' tambien tiene un atributo 'f' que quedaría "colgado"
- por lo tanto la respuesta correcta es la 3 'CC(a,f)'



## 3. Indicar la opción correcta
**Dada la relación:**  
`ALUMNO (DNI, nyAp, nroLegajo, promedio, #libroUsadoEnCarrera)`  

**En la que se cumple las siguientes dependencias funcionales:** ​ 
- DF1) DNI → nyAp, nroLegajo, promedio
- DF2) nroLegajo → nyAp, DNI, promedio

**¿Cuál de las siguientes afirmaciones es correcta?**
- a) La relación ALUMNO tiene dos claves candidatas y tendrá dos claves primarias.
- b) La relación ALUMNO tiene dos claves candidatas y tendrá una clave primaria.
- c) No puedo identificar una clave.
- d) Ninguna de las anteriores.

### SOLUCIÓN
***Para analizar esto primero podemos ver que:***
- para obtener toda la informacion de 'ALUMNO', tenemos 2 `CC`
- CC1(dni, #libroUsadoEnCarrera)
- CC2(nroLegajo, #libroUsadoEnCarrera)
- la respuesta correcta es la opcion b '(2 CC y 1 CP)' ya que
  - CP(dni, #libroUsadoEnCarrera), nos permite obtener todos los atributos de 'ALUMNO'
  - CP(nroLegajo, #libroUsadoEnCarrera), nos permite obtener todos los atributos de 'ALUMNO'

### CONSULTAR
- ACA "SIMPLEMENTE" DECIDIRIA YO CUAL ES LA CLAVE PRIMARIA O SI ESTO SALE DE NORMALIZAR A 4FN (recien lo vi hoy y no lo entendi del todo)
- EXISTE EL CASO DONDE TENGO 2 CLAVES PRIMARIAS?


## 4. Dependencias funcionales
**Dado el siguiente esquema:**  
`TIENDA (#aplicacion, nombre_aplicacion, descripcion, #categoria, #etiqueta, #desarrollador, nombre_apellido_desarrollador, #actualizacion, descripcion_cambios)`  

**Donde:**  
- #aplicacion, #categoria, #etiqueta y #desarrollador son únicos en el sistema.
- Una aplicación tiene un nombre y una descripción, y puede actualizarse muchas veces
- Para cada actualización de una aplicación se registra un texto con los cambios realizados. El #actualización es secuencial, cada aplicación define los suyos y
puede repetirse entre distintas aplicaciones.
- Cada aplicación tiene una única categoría y muchas etiquetas. Las etiquetas pueden ir cambiando con cada actualización de la aplicación (en cada actualización puede haber un conjunto diferente de etiquetas). La categoría nunca cambia, es decir que se mantiene igual sin importar las actualizaciones.
- Una aplicación es realizada por varios desarrolladores de los cuales se conoce su nombre y apellido.

**Seleccione las DFs válidas / mínimas: Para las que no se seleccionen, indicar el motivo.**
- 1)​ #aplicacion, #actualizacion -> nombre_aplicacion, descripcion
- 2)​ #aplicacion, #actualizacion -> descripcion_cambios            
- 3)​ nombre_apellido_desarrollador -> #desarrollador               
- 4)​ #desarrollador -> nombre_apellido_desarrollador              
- 5)​ #aplicación -> #categoria

**Encontró alguna dependencia funcional más, que no se menciona entre las opciones?**

### SOLUCIÓN
### CONSULTAS
Sobre las DF's presentadas
- ¿Puedo agegar 'descripcion_cambios'?¿Sería obligar que cada actualizacion cambie todos los campos? 
- ¿la 3 sería incorrecta, ya que la DF correcta es la 4?
Sobre las DF's que considero faltantes
- DF1- #aplicacion, #actualizacion -> #etiquetas (aca debo tratar como una DF MULTIVALUADA?)


## 5.1 Dependencias multivaluadas
**Dado el siguiente esquema:**  
`CURSOS(#curso, titulo_curso, #nro_modulo, titulo_modulo, contenido_modulo, nombre_autor, email_autor, contraseña_autor, año_edicion, calificacion, referencia)`  

**Donde:**  
- Cada curso (#curso) se va editando todos los años, y en cada año (año_edicion) puede cambiar sus módulos, no así el título y el autor.
- En cada año que se edita un curso, recibe varias calificaciones anónimas.
- El email de cada autor se usa como login, y no puede repetirse en el sistema.
- Los números de módulo (#nro_modulo) son secuenciales (modulo 1, 2, 3, etc). Es decir, en cada edición de cada curso se enumeran los módulos de la misma forma, y se pueden repetir en diferentes ediciones de cursos.
- Cada curso tiene múltiples referencias bibliográficas, que se mantienen a través de todas sus ediciones.

**Dadas las siguientes DF:**  
- #curso -> titulo_curso, email_autor
- #curso, año_edicion, #nro_modulo -> titulo_modulo, contenido_modulo
- email_autor -> nombre_autor, contraseña_autor

**Dada la siguiente CC:**  
- (#curso, año_edicion, #nro_modulo, calificacion, referencia)

**Y el esquema en BCNF**  
`CURSOS_N (#curso, año_edicion, #nro_modulo, calificacion, referencia)`

**Seleccione las DM que son válidas a la vez en el esquema CURSOS_N:**  
- #curso ->> año_edicion
- #curso ->> referencia
- #curso,año_edicion ->> calificacion
- referencia ->> #curso
- año_edicion ->> #curso

**Existe alguna dependencia multivaluada más que no se menciona entre las opciones?**  

### SOLUCIÓN
### CONSULTAS


## 5.2 Dependencias multivaluadas
### a)​ Seleccione cuál de las siguientes dependencias multivaluadas es válida, por sí sola, en el esquema y además cumple en ser trivial. Justifique su elección.​
​
`R1 (#curso, #profesor, año)​`  
Donde un curso se desarrolla cada año y en él participan varios profesores que
pueden variar por los años.​
​
**Dependencias multivaluadas:​**  
- DM1: #curso ->> #curso, #profesor, año​
- DM2: #curso, año ->> #profesor​
- DM3: #curso ->> #profesor​
- DM4: #profesor, #curso, año ->> #profesor​

#### SOLUCIÓN
#### CONSULTAS

### b)​ Dado el siguiente esquema, elija un conjunto de dependencias multivaluadas válidas para el esquema:​
​
`R2 (#Línea, #Ramal, #Colectivo, dniEmpleado)​`  
Donde cada línea de colectivo posee diversos ramales, numerados
secuencialmente a partir de uno, y estos ramales poseen varios colectivos,
exclusivos de cada ramal. En la empresa trabajan diversos empleados. ​
​
**Dependencias multivaluadas:​**
- DM1: #Linea ->> #Ramal​
- DM2: #Linea ->> #Colectivos​
- DM3: #Linea, #Ramal ->> #Colectivo​
- DM4: #Linea, #Colectivo ->> #Ramal​
- DM5: #Linea ->> dniEmpleado​
- DM6: { } ->> dniEmpleado​

#### SOLUCIÓN
#### CONSULTAS

### c)​ Para el esquema dado, el cual se sabe está en BCNF, seleccione de entre las posibles un conjunto de dependencias multivaluadas válidas en el esquema. ¿Está actualmente en 4FN? Justifique por cada DM, porque es válida o porque no.​
​
`R3 (#pelicula, #autor, #actor, #equipo_rodaje, #auspiciante)​`  
Donde una película es realizada por varios autores, los cuales pueden realizar
varias películas. En ella participan varios actores, también ellos pueden
participar en muchas películas. En el rodaje de cada película se ven
involucrados varios equipos de rodaje y varios auspiciantes. ​

#### SOLUCIÓN
#### CONSULTAS

### d)​ Dado el siguiente esquema con la siguiente clave candidata:​
​
`PROGRAMA(#programa, nombre, genero, descripcion)​`  
`CANAL(#canal, nombre)​`  
`PROGRAMA_CANAL(#programa, #canal, dia, hora)​`  
CC = {#programa, #canal, dia, hora}​  
Donde un programa puede estar en muchos canales, y en cada canal se da en
diferentes días y horarios.​
​

### e) Marcar la opción correcta y justificar:​ ​
- A. Las 3 relaciones se encuentran en 4FN​
- B. Las 3 relaciones se encuentran en BCNF y no es posible llevarlas a 4FN​
- C. Las relaciones PROGRAMA y CANAL se encuentran en BCNF (no siendo
posible llevarlas a 4FN) y PROGRAMA_CANAL se encuentra en 4FN​
- D. Las relaciones PROGRAMA y CANAL se encuentran en 4NF,
PROGRAMA_CANAL se encuentra en BCFN y puede llevarse a 4FN​
- E. Las relaciones PROGRAMA y CANAL se encuentran en 4NF
PROGRAMA_CANAL se encuentra en BCFN y no puede llevarse a 4FN