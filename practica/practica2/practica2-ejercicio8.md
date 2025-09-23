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

**DEPENDECIAS FUNCIONALES**  
- DF1: #festival -> denominacion_festival, localidad 
- DF2: #banda -> nombre_banda, estilo_musical
- DF3: cuil_musico -> nombre_musico, fecha_nacimiento
- DF4: #festival, #banda, #tema -> nombre_tema, duracion
- DF5: #festival, #banda, #tema, cuil_musico -> instrumento

**CLAVES CANDIDATAS**  
CC1: (#festival, #banda, cuil_musico, #tema, cuil_auspiciante, url_plataforma_entradas, #sponsor)

**NORMALIZACION A BCNF**  
- **El esquema `FESTIVALES` no cumple con BCNF ya que existe al menos el determinante de la DF1 donde {#festival} no es superclave**
  - Particiono el esquema tomando la DF1
  - F1(<u>#festival</u>, denominacion_festival, localidad)  
  - F2(<u>#festival</u>, <u>cuil_musico</u>, nombre_musico, fecha_nacimiento, <u>#banda</u>, nombre_banda, estilo_musical, <u>#tema</u>, nombre_tema, duracion, instrumento, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - No se pierde información ya que `F1∩F2` es clave en `F1`
  - No se pierden DF's ya que:
    - DF1 sigue valiendo para `F1`
    - DF2, DF3, DF4, DF5 siguen valiendo para `F2`
  - Podemos entonces decir que `F1` esta en BCNF ya que el determinante de la DF1 es superclave en el esquema
- **El esquema `F2` no cumple con BCNF ya que existe al menos el determinante de la DF2 donde {#banda} no es superclave**
  - Particiono el esquema tomando la DF2
  - F3(<u>#banda</u>, nombre_banda, estilo_musical)
  - F4(<u>#festival</u>, <u>cuil_musico</u>, nombre_musico, fecha_nacimiento, <u>#banda</u>, <u>#tema</u>, nombre_tema, duracion, instrumento, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - No se pierde informacion ya que `F3∩F4` es clave en `F3`
  - No se pierden DF's ya que:
    - DF2 sigue valiendo para `F3`
    - DF3, DF4, DF5 siguen valiendo para `F4`
  - Podemos entonces decir que `F3` esta en BCNF ya que el determinante de la DF2 es superclave en el esquema
- **El esquema `F4` no cumple con BCNF ya que existe al menos el determinante de la DF3 donde {cuil_musico} no es superclave**
  - Particiono el esquema tomando la DF3
  - F5(<u>cuil_musico</u>, nombre_musico, fecha_nacimiento)
  - F6(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, nombre_tema, duracion, instrumento, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - No se pierde información ya que `F5∩F6` es clave en `F5`
  - No se pierden las DF's ya que:
    - DF3 sigue valiendo para `F5`
    - DF4, DF5 siguen valiendo para `F6`
  - Podemos entonces decir que `F5` esta en BCNF ya que el determinante de la DF3 es superclave en el esquema
- **El esquema `F6` no cumple con BCNF ya que existe al menos el determinante de la DF4 donde {#festival, #banda, #tema} no es superclave**
  - Particiono el esquema tomando la DF4
  - F7(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, nombre_tema, duracion)
  - F8(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, instrumento, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - No se pierde información ya que `F7∩F8` es clave en `F7`
  - No se pierden DF's ya que:
    - DF4 sigue valiendo en `F7`
    - DF5 sigue valiendo en `F8`
  - Podemos entonces decir que `F7` esta en BCNF ya que el determinante de la DF4 es superclave en el esquema
- **El esquema `F8` no cumple con BCNF ya que existe al menos el determinante de la DF5 donde {<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_musico</u>} no es superclave**
  - Particiono el esquema tomando la DF5
  - F9(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_musico</u>, instrumento)
  - F10(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - No se pierde información ya que `F9∩F10` es clave en `F9`
  - No se pierden DF's ya que :
    - DF5 sigue valiendo para `F9`
  - Podemos entonces decir que `F9` se encuentra en BCNF ya que el determinante de la DF5 es superclave en el esquema
  - Podemos entonces decir que `F10` se encuentra en BCNF ya que todos sus atributos forman la CC y ademas cualquier dependencia que se detecte es trivial

**ESQUEMAS EN BCNF Y CLAVE PRIMARIA**  
- F1(<u>#festival</u>, denominacion_festival, localidad)  
- F3(<u>#banda</u>, nombre_banda, estilo_musical)
- F5(<u>cuil_musico</u>, nombre_musico, fecha_nacimiento)
- F7(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, nombre_tema, duracion)
- F9(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_musico</u>, instrumento)
- F10(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
- CP{<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>}

**DEPENDENCIAS MULTIVALUADAS**  
- F10(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_auspiciante</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
- DM1: #festival ->> cuil_auspiciante
- DM2: #festival ->> url_plataforma_entradas
- DM3: #festival ->> #sponsor
- **Tanto DM1, DM2, DM3 no son triviales, por lo tanto `F10` no se encuentra en 4NF**
  - Particiono el esquema tomando la DM1
  - F11(<u>#festival</u>, cuil_auspiciante)
  - F12(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>url_plataforma_entradas</u>, <u>#sponsor</u>)
  - Podemos entonces decir que `F11` se encuentra en 4NF ya que solo vale la DM1 y es trivial
- **Tanto DM2, DM3 no son triviales, por lo tanto `F11` no se encuentra en 4NF**
  - Particiono el esquema tomando la DM2
  - F13(<u>#festival</u>, url_plataforma_entradas)
  - F14(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>, <u>#sponsor</u>)
  - Podemos entonces decir que `F13` se encuentra en 4NF ya que solo vale la DM2 y es trivial
- **DM3 no es trivial, por lo tanto `F14` no se encuentra en 4NF**
  - Particiono el esquema tomando la DM3
  - F15(<u>#festival</u>, #sponsor)
  - F16(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>)
  - Podemos entonces decir que `F15` se encuentra en 4NF ya que solo vale la DM3 y es trivial
  - Podemos entonces decir que `F16` se encuentra en 4NF ya que no posee DM

**ESQUEMAS EN 4NF**    
- F1(<u>#festival</u>, denominacion_festival, localidad)  
- F3(<u>#banda</u>, nombre_banda, estilo_musical)
- F5(<u>cuil_musico</u>, nombre_musico, fecha_nacimiento)
- F7(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, nombre_tema, duracion)
- F9(<u>#festival</u>, <u>#banda</u>, <u>#tema</u>, <u>cuil_musico</u>, instrumento)
- F11(<u>#festival</u>, cuil_auspiciante)
- F13(<u>#festival</u>, url_plataforma_entradas)
- F15(<u>#festival</u>, #sponsor)
- F16(<u>#festival</u>, <u>cuil_musico</u>, <u>#banda</u>, <u>#tema</u>)
- Los esquemas `F1`, `F3`, `F5`, `F7`, `F9`, se encuentran en 4NF ya que ninguno presenta DM
- Los esquemas `F11`, `F13`, `F15`, `F16` se encuentran en 4NF ya que solo poseen DM's triviales