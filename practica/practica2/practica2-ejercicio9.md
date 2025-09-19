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


# 9. 
`TORNEOS (#torneo, nombre_torneo, año, #equipo, nombre_equipo, estadio_equipo, puesto, #reglamentacion, descripcion, #auspiciante)`  
- De cada torneo, se conoce su identificador (#torneo, único en el sistema) y un nombre. Un mismo torneo tiene diferentes ediciones, cada edición se realiza en un año determinado y el mismo torneo no puede repetirse el mismo año. En un año pueden realizarse varios torneos.
- Cada edición de un torneo tiene diferentes auspiciantes, identificados por #auspiciante (único en el sistema).
- En cada edición de un torneo participan varios equipos. De cada equipo se conoce su nombre, su estadio y su #equipo, que no se repite para diferentes equipos.
- Cada equipo finaliza una edición de un torneo en un puesto. Dos o más equipos no pueden finalizar en un mismo puesto.
- Además, se conoce un conjunto de reglamentaciones, identificadas por #reglamentación, aplicables a estos torneos.

### SOLUCIÓN

**DEPENDENCIAS FUNCIONALES**
- DF1: #torneo -> nombre_torneo
- DF2: #equipo -> nombre_equipo, estadio_equipo
- DF3: #torneo, #equipo, año -> puesto
- DF4: #torneo, año, puesto -> #equipo

**CLAVES CANDIDATAS**
- CC1: (#torneo, #equipo, año, #reglamentacion, descripcion, #auspiciante)
- CC2: (#torneo, año, puesto, #reglamentacion, descripcion, #auspiciante)

**NORMALIZACION A BCNF**
- **El esquema `TORNEOS` no cumple BCNF pues existe al menos la DF2 donde {#equipo} no es superclave**
  - Particiono el esquema tomando la DF2
  - T1(<u>#equipo</u>, nombre_equipo, estadio_equipo)
  - T2(<u>#torneo</u>, nombre_torneo, <u>año</u>, <u>#equipo</u>, <u>puesto</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>)
  - No se pierde información ya que `T1∩T2` es clave en `T1`
  - No se pierden DF's ya que: DF2 sigue valiendo para `T2`, DF1, DF3, DF4 siguen valiendo para `T2`
  - Podemos entonces decir que `T2` esta en BCNF ya que la DF2 es superclave
- **El esquema `T2` no se encuentra en BCNF ya que existe la DF1 donde {#torneo} no es superclave**
  - Particiono el esquema tomando la DF1
  - T3(<u>#torneo</u>, nombre_torneo)
  - T4(<u>#torneo</u>, <u>año</u>, <u>#equipo</u>, <u>puesto</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>)
  - No se pierde información ya que `T3∩T4` es clave en `T3`
  - No se pierden DF's ya que: DF1 sigue valiendo en `T3`, DF3, DF4, siguen valiendo en `T4`
  - Podemos entonces decir que `T3` se encuentra en BCNF ya que la DF1 es superclave
- **El esquema `T4` no se encuentra en BCNF ya que existe al menos la DF3 donde {#torneo, #equipo, año} no es superclave**
  - Particiono el esquema tomando la DF3
  - T5(<u>#torneo</u>, <u>#equipo</u>, <u>año</u>, puesto)
  - T6(<u>#torneo</u>, <u>año</u>, <u>#equipo</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>)
  - No se pierde información ya que `T5∩T6` es clave en `T5`
  - No se pierden DF's ya que: DF3 sigue valiendo para `T5`
  - Podemos entonces decir que `T5` se encuentra en BCNF ya que la DF3 es superclave
  - Podemos entonces decir que `T6` se encuentra en BCNF ya que todos los atributos forman la `CC1` y toda DF es trivial

**ESQUEMAS EN BCN Y CLAVE PRIMARIA**
- T1(<u>#equipo</u>, nombre_equipo, estadio_equipo)
- T3(<u>#torneo</u>, nombre_torneo)
- T5(<u>#torneo</u>, <u>#equipo</u>, <u>año</u>, puesto)
- T6(<u>#torneo</u>, <u>año</u>, <u>#equipo</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>)
- CP{<u>#torneo</u>, <u>#equipo</u>, <u>año</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>}

**DEPENDENCIAS MULTIVALUADAS**
- T6(<u>#torneo</u>, <u>año</u>, <u>#equipo</u>, <u>#reglamentacion</u>, <u>descripcion</u>, <u>#auspiciante</u>)
- DM1: #torneo, año ->> #auspiciante
- DM2: #torneo, año ->> #equipo
- DM3: #torneo, año ->> #reglamentacion
- **Tanto DM1, DM2 como DM3 no son triviales, entonces `T6` no esta en 4NF**
  - Particiono tomando la DM1
  - T7(<u>#torneo</u>, <u>año</u>, #auspiciante)
  - T8(<u>#torneo</u>, <u>año</u>, <u>#equipo</u>, <u>#reglamentacion</u>, <u>descripcion</u>)
  - No se pierde información ya que `T7∩T8` es clave en `T7`
  - No se pierden DM's ya que, DM1 sigue valiendo para `T7`, DM2, DM3 siguen valiendo para `T8`
  - Puedo entonces decir que `T7` se encuentra en 4NF ya que solo vale la DM1 y es trivial
- **Tanto DM2, como DM3 no son triviales, entonces `T8` no está en 4NF**
  - Particiono el esquema tomando la DM2
  - T9(<u>#torneo</u>, <u>año</u>, #equipo)
  - T10(<u>#torneo</u>, <u>año</u>, <u>#reglamentacion</u>, <u>descripcion</u>)
  - No se pierde información ya que `T9∩T10` es clave en `T9`
  - No se pierden DM's ya que: DM2 sigue valiento para `T9`, DM3 sigue valiendo para `T10`
  - Podemos entonces decir que `T9` esta en 4NF ya que solo vale la DM2 y es trivial
- **DM3 no es trivial, entonces `T10` no está en 4NF**
  - Particiono el esquema tomando la DM3
  - T11(<u>#torneo</u>, <u>año</u>, #reglamentacion)
  - T12(<u>#torneo</u>, <u>año</u>, <u>descripcion</u>)
  - No se pierde información ya que `T11∩T12` es clave en `T11`
  - No se pierden DM's ya que: DM3 vale en `T11`
  - Podemos entonces decir que `T11` está en 4NF ya que solo vale la DM3 y es trivial
  - Podemos entonces decir que `T12` está en 4NF ya que no posee DM's

**ESQUEMAS EN 4NF**
- T1(<u>#equipo</u>, nombre_equipo, estadio_equipo)
- T3(<u>#torneo</u>, nombre_torneo)
- T5(<u>#torneo</u>, <u>#equipo</u>, <u>año</u>, puesto)
- T7(<u>#torneo</u>, <u>año</u>, #auspiciante)
- T9(<u>#torneo</u>, <u>año</u>, #equipo)
- T11(<u>#torneo</u>, <u>año</u>, #reglamentacion)
- T12(<u>#torneo</u>, <u>año</u>, <u>descripcion</u>)
- Tantp T1, T3, T5, se encuentran en 4NF porque no poseen DM's

### CONSULTAS



