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

**DEPENDENCIAS FUNCIONALES**  
- DF1: #evento -> fecha_evento, motivo_evento, #salon, #grupo
- DF2: #salon -> nombre_salon
- DF3: #grupo -> nombre_grupo, nro_integrantes_grupo, #organizador
- DF4: #organizador -> nombre_organizador, telefono_organizador, años_exp_organizador
- DF5: #organizador, fecha_evento -> #grupo
- DF6: #persona_staff -> nombre_persona_staff, telefono_persona_staff, rol_persona_staff

**CLAVES CANDIDATAS**  
- CC1: (#evento, #persona_staff)

**NORMALIZANDO A BCNF**
- **El esquema `ORGANIZACION_EVENTOS` no esa en BCNF ya que existe al menos la DF6 donde {#persona_staff} no es superclave**
  - Particiono tomando la DF6
  - O1(<u>#persona_staff</u> -> nombre_persona_staff, telefono_persona_staff, rol_persona_staff)
  - O2(<u>#evento</u>, fecha_evento, motivo_evento, #salon, nombre_salon, #grupo, nombre_grupo, nro_integrantes_grupo, #organizador, nombre_organizador, telefono_organizador, años_exp_organizador, <u>#persona_staff</u>)
  - No se pierde informacion ya que `O1nO2` es clave en el esquema `O1`
  - No se pierden DF's ya que: DF6 sigue valiendo para `O1`, DF1, DF2, DF3, DF4, DF5 siguen valiendo para `O2`
  - Podemos entonces decir que el esquema `O2` esta en BCNF ya que solo vale la DF6 y es superclave
- **El esquema `O2` no se encuentra en BCNF ya que existe al menos la DF4 donde {#organizador} no es superclave**
  - Particiono tomando la DF4
  - O3(<u>#organizador</u>, nombre_organizador, telefono_organizador, años_exp_organizador)
  - O4(<u>#evento</u>, fecha_evento, motivo_evento, #salon, nombre_salon, #grupo, nombre_grupo, nro_integrantes_grupo, #organizador, <u>#persona_staff</u>)
  - No se pierde información ya que `O3nO4` es clave en el esquema `O3`
  - No se pierden DF's ya que: DF4 sigue valiendo en `O3`, DF1, DF2, DF3, DF5 siguen valiendo para `O4`
  - Podemos entonces decir que `O3` se encuentra en BCNF ya que solo vale la DF4 y es superclave
- **El esquema `O4` no se encuentra en BCNF ya que existe al menos la DF3 donde {#grupo} no es superclave**
  - Particiono tomando la DF3
  - O5(<u>#grupo</u>, nombre_grupo, nro_integrantes_grupo, #organizador)
  - O6(<u>#evento</u>, fecha_evento, motivo_evento, #salon, nombre_salon, #grupo, <u>#persona_staff</u>)
  - No se pierde información ya que `O5nP6` es clave en el esquema `O5`
  - No se pierden DF's ya que: DF3 sigue valiendo en `O5`, DF1, DF2, DF5
  - Podemos entonces decir que el esquema `O5` se encuentra en BCNF ya que solo vale la DF3 y es superclave
- **El esquema `O6` no se encuentra en BCNF ya que existe al menos la DF5 donde {#organizador, fecha_evento} no es superclave**
  - Particiono tomando la DF5
  - O7(<u>#organizador</u>, <u>fecha_evento</u>, #grupo)
  - O8(<u>#evento</u>, fecha_evento, motivo_evento, #salon, nombre_salon, <u>#persona_staff</u>)
  - No se pierde informacion ya que `O7nO8` es clave en el esquema `O7`
  - No se pierden DF's ya que: DF5 sigue valiendo en `O7`, DF1, DF2 siguen valiendo en `O7`
  - Podemos entonces decir que el esquema `O7` se encuentra en BCNF ya que solo vale la DF5 y es superclave
- **El esquema `O8` no se encuentra en BCNF ya que existe al menos la DF2 donde {#salon} no es superclave**
  - Partciono el esquema tomando la DF2
  - O9(<u>#salon</u>, nombre_salon)
  - O10(<u>#evento</u>, fecha_evento, motivo_evento, <u>#persona_staff</u>)
  - No se pierde informacion ya que `O9nO10` es clave en el esquema `O9`
  - No se pierden DF's ya que: DF2 sigue valiendo en `O9`, DF1 sigue valiendo en `O10`
  - Podemos entonces decir que el esquema `O9` se encuentra en BCNF ya que solo vale la DF2 y es superclave
- **El esquema `O10` no se encuentra en BCNF ya que existe al menos la DF1 donde {#evento} no es superclave**
  - Particiono tomando la DF1
  - O11(<u>#evento</u>, fecha_evento, motivo_evento, #salon, #grupo)
  - O12(<u>#evento</u>, <u>#persona_staff</u>)
  - No se pierde informacion ya que `O11nO12` es clave en el esquema `O11`
  - No se pierden DF's ya que: DF1 sigue valiendo en `O11`
  - Podemos entonces decir que el esquema `O11` se encuentra en BCNF ya que solo vale la DF1 y es superclave
  - Podemos entonces decir que el esquema `O12` se encuentra en BCNF ya que todos sus atributos hacen a la CC y es trivial

**ESQUEMAS EN BCNF Y CLAVE PRIMARIA**
- O1(<u>#persona_staff</u> -> nombre_persona_staff, telefono_persona_staff, rol_persona_staff)
- O3(<u>#organizador</u>, nombre_organizador, telefono_organizador, años_exp_organizador)
- O5(<u>#grupo</u>, nombre_grupo, nro_integrantes_grupo, #organizador)
- O7(<u>#organizador</u>, <u>fecha_evento</u>, #grupo)
- O9(<u>#salon</u>, nombre_salon)
- O11(<u>#evento</u>, fecha_evento, motivo_evento, #salon, #grupo)
- O12(<u>#evento</u>, <u>#persona_staff</u>)
- CP{<u>#evento</u>, <u>#persona_staff</u>}

**DEPENDENCIAS MULTIVALUADAS**
- O12(<u>#evento</u>, <u>#persona_staff</u>)
- DM1: #evento ->> #persona_staff
- El esquema `O12` se encuentra en 4NF ya que solo vale la DM1 y es trivial

**ESQUEMAS EN 4NF**
- O1(<u>#persona_staff</u>, nombre_persona_staff, telefono_persona_staff, rol_persona_staff)
- O3(<u>#organizador</u>, nombre_organizador, telefono_organizador, años_exp_organizador)
- O5(<u>#grupo</u>, nombre_grupo, nro_integrantes_grupo, #organizador)
- O7(<u>#organizador</u>, <u>fecha_evento</u>, #grupo)
- O9(<u>#salon</u>, nombre_salon)
- O11(<u>#evento</u>, fecha_evento, motivo_evento, #salon, #grupo)
- O12(<u>#evento</u>, <u>#persona_staff</u>)
- Los esquemas `O1`, `O3`, `O5`, `O7`, `O9`, `O11` se encuentran en 4NF ya que no tienen DM's
- El esquema `O12` se encuentra en 4NF ya que solo vale la DM1 y es trivial