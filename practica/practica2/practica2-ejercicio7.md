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


## 7. 
`MEDICION_AMBIENTAL(#medicion, #pozo, valor_medicion, #parametro, fecha_medicion, cuil_operario, #instrumento, nombre_parametro, valor_ref, descripcion_pozo, fecha_perforacion, apellido_operario, nombre_operario, fecha_nacimiento, marca_instrumento, modelo_instrumento, dominio_vehiculo, fecha_adquisicion)`  
**Donde:**
- Cada medición es realizada por un operario en un pozo, en una fecha determinada. En ella se miden varios parámetros, y para cada uno se obtiene un valor. Notar que un mismo parámetro (#parametro) puede ser medido en diferentes mediciones. Independientemente de las mediciones, todo parámetro tiene un nombre y valor de referencia, y el #parametro es único en el sistema.
- En cada medición se utilizan varios instrumentos, independientemente de los parámetros medidos. De cada instrumento se conoce la marca y modelo.
- De cada operario se conoce su cuit, nombre, apellido y fecha de nacimiento.
- La empresa cuenta con vehículos, y de cada uno se conoce la fecha en la que fue adquirido. El dominio (patente) de cada vehículo es único en el sistema.
- Un pozo tiene una descripción y una fecha de perforación. El identificador #pozo es único en el sistema.

**1. Dependencias Funcionales**  
- DF1: #medicion -> cuil_operario,  #pozo, fecha_medicion 
- DF2: #medicion, #parametro -> valor_medicion
- DF3: #parametro -> nombre_parametro, valor_ref
- DF4: #instrumento -> marca_instrumento, modelo_instrumento
- DF5: cuil_operario -> apellido_operario, nombre_operario, fecha_nacimiento
- DF6: dominio_vehiculo -> fecha_adquisicion
- DF7: #pozo -> descripcion_pozo, fecha_perforacion

**2. Claves Candidatas**
- CC1:(#medicion, #parametro, #instrumento, dominio_vehiculo)

**3. Verificacion de los esquemas en BCNF**  
- **El esquema `MEDICION_AMBIENTAL` no esta en BCNF, pues existe la DF2 tal que {#medicion, #parametro} no es parte de la superclave**
    - Particiono el esquema tomando la DF2  
    - MA1(<u>#medicion</u>, <u>#parametro<u>, valor_medicion)  
    - MA2(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, nombre_parametro, valor_ref, descripcion_pozo, fecha_perforacion, apellido_operario, nombre_operario, fecha_nacimiento, marca_instrumento, modelo_instrumento, <u>dominio_vehiculo</u>, fecha_adquisicion)  
    - No se pierde información ya que `MA1nMA2` es clave en `MA1`
    - No se pierden DF's ya que: DF2 sigue valiento para `MA1`, DF1, DF3, DF4, DF5, DF6, DF7 siguen valiento para `MA2`
    - Podemos entonces decir que `MA1` esta en BCNF (no se pierde información ni DF's)  
- **El esquema `MA2` no esta en BCNF, pues existe la DF3 tal que {#parametro} no es parte de la superclave**
    - Particiono el esquema tomando la DF3
    - MA3(<u>#parametro<u>, nombre_parametro, valor_ref)  
    - MA4(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, descripcion_pozo, fecha_perforacion, apellido_operario, nombre_operario, fecha_nacimiento, marca_instrumento, modelo_instrumento, <u>dominio_vehiculo</u>, fecha_adquisicion)  
    - No se pierde información ya que `MA3nMA4` es clave en `MA3`
    - No se pierden DF's ya que: DF3 sigue valiendo para `MA3`, DF1, DF4, DF5, DF6, DF7 siguen valiendo para `MA3`
    - Podemos entonces decir que `MA3` esta en BCNF (no se pierde informacion ni DF's)
- **El esquema `MA4` no esta en BCNF ya que existe la DF4 tal que {#parametro} no es parte de la superclave**
  - Particiono el esquema tomando la DF4
  - MA5(<u>#instrumento</u>, marca_instrumento, modelo_instrumento)  
  - MA6(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, descripcion_pozo, fecha_perforacion, apellido_operario, nombre_operario, fecha_nacimiento, <u>dominio_vehiculo</u>, fecha_adquisicion)  
  - No se pierde informacion ya que `MA5nMA6` es clave en `MA5`
  - No se pierden DF's ya que: DF4 sigue valiendo para `MA5`, DF1, DF5, DF6, DF7 siguen valiendo para `MA5`
  - Podemos entonces decir que `MA5` esta en BCNF (no se pierde información ni DF's)  
- **El esquema `MA6` no esta en BCNF ya que existe la DF5 tal que {cuil_operario} no es parte de la superclave**    
    - Particiono el esquema tomando la DF5
    - MA7(<u>cuil_operario</u>, apellido_operario, nombre_operario, fecha_nacimiento)  
    - MA8(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, descripcion_pozo, fecha_perforacion, <u>dominio_vehiculo</u>, fecha_adquisicion)  
    - No se pierde informacion ya que `MA7nMA8` es clave en `MA7`
    - No se pierden DF's ya que: DF5 sigue valiendo para `MA7`, DF1, DF6, DF7 siguen valiendo para `MA8`
    - Podemos entonces decir qeu `MA7` esta en BCNF (no pierde informacion ni DF's)
- **El esquema `MA8` no esta en BCNF ya que existe la DF6 tal que {dominio_vehiculo} no es parte de la superclave**  
    - Particiono el esquema tomando la DF6
    - MA9(<u>dominio_vehiculo</u>, fecha_adquisicion)  
    - MA10(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, descripcion_pozo, fecha_perforacion, <u>dominio_vehiculo</u>)  
    - No se pierde informacion ya que `MA9nMA10` es clave en `MA9`
    - No se pierden DF's ya que: DF6 sigue Valiendo para `MA9` DF1, DF7 sigue valiendo para `MA10`
    - Podemos entonces decir que `MA9` esta en BCNF (no se pierde información ni DF's)
- **El esquema `MA10` no se encuentra en BCNF ya que existe la DF7 tal que {#pozo} no es parte de la superclave**  
    - Particiono el esquema tomando la DF7
    - MA11(<u>#pozo</u>, descripcion_pozo, fecha_perforacion)  
    - MA12(<u>#medicion</u>, #pozo, <u>#parametro</u>, fecha_medicion, cuil_operario, <u>#instrumento</u>, <u>dominio_vehiculo</u>)
    - No se pierde informacion ya que `MA11nMA12` es clave en `MA11`
    - No se pierden DF's ya que la DF7 sigue valiendo para `MA11`, DF1 sigue valiendo para `MA12`
    - Podemos entonces decir que `MA11` esta en BCNF (no se pierde informacion ni DF's)
- **El esquema `MA12` no eata en BCNF ya que existe la DF1 tal que {#medicion} no es parte de la superclave**
    - Particiono el esquema tomando la DF1
    - MA13(<u>#medicion</u>, cuil_operario,  #pozo, fecha_medicion)  
    - MA14(<u>#medicion</u>, <u>#parametro</u>, <u>#instrumento</u>, <u>dominio_vehiculo</u>)  
    - No se pierde informacion ya que `MA13nMA14` es clave en `MA13`
    - No se pierden DF's ya que la DF1 sigue valiendo para `MA13`
    - Podemos entonces decir que `MA13` esta en BCNF (no se pierde información ni DF's)
    - Podemos entonces decir que `MA14` esta en BCNF (sus atributos forman la clave y cualquier dependencia es trivial)

**4. Particiones en BCNF y Clave Primaria**  
- MA1(<u>#medicion</u>, <u>#parametro<u>, valor_medicion)  
- MA3(<u>#parametro<u>, nombre_parametro, valor_ref)  
- MA5(<u>#instrumento</u>, marca_instrumento, modelo_instrumento)  
- MA7(<u>cuil_operario</u>, apellido_operario, nombre_operario, fecha_nacimiento)  
- MA9(<u>dominio_vehiculo</u>, fecha_adquisicion)  
- MA11(<u>#pozo</u>, descripcion_pozo, fecha_perforacion)
- MA13(<u>#medicion</u>, cuil_operario,  #pozo, fecha_medicion)  
- MA14(<u>#medicion</u>, <u>#parametro</u>, <u>#instrumento</u>, <u>dominio_vehiculo</u>)  
- CP:(<u>#medicion</u>, <u>#parametro</u>, <u>#instrumento</u>, <u>dominio_vehiculo</u>)

**5. Dependencias Multivaluadas**  
- MA14(<u>#medicion</u>, <u>#parametro</u>, <u>#instrumento</u>, <u>dominio_vehiculo</u>)  
- DM1: #medicion ->> #parametro, #instrumento
- DM2: vacío ->> dominio_vehiculo
- tanto DM1 como DM2 no son DM triviales, por lo tanto `MA14` no esta en 4NF
    - Particiono el esquema tomando la DM1
    - MA15(<u>#medicion</u>, <u>#parametro</u>, <u>#instrumento</u>)
    - MA16(<u>dominio_vehiculo</u>)
    - Podemos entonces decir que `MA15` se encuentra en 4NF ya que solo posee DM triviales
    - Podemos entonces decir que `MA16` se encuentra en 4NF ya que solo posee DM triviales

**6. Particiones en 4NF**
- MA1(<u>#medicion</u>, <u>#parametro<u>, valor_medicion)  
- MA3(<u>#parametro<u>, nombre_parametro, valor_ref)  
- MA5(<u>#instrumento</u>, marca_instrumento, modelo_instrumento)  
- MA7(<u>cuil_operario</u>, apellido_operario, nombre_operario, fecha_nacimiento)  
- MA9(<u>dominio_vehiculo</u>, fecha_adquisicion)  
- MA11(<u>#pozo</u>, descripcion_pozo, fecha_perforacion)
- MA13(<u>#medicion</u>, cuil_operario,  #pozo, fecha_medicion)  
- Todas estos esquemas se encuentran en 4NF ya que ninguno presenta DM


### SOLUCIÓN
### CONSULTAS


