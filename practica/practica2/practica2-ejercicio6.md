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


## 6. 
`SUSCRIPCION (#suscripcion, email, nombre_usuario, #plan, nombre_plan, texto_condiciones, precio, email_adicional, nombre_adicional, #contenido, titulo, sinopsis, duracion, fecha_adicional)`  
**Donde:**
- Cada suscripción es realizada por un único usuario (identificado por el email) y un plan, pero además hay usuarios adicionales que la utilizan (email_adicional). De cada usuario adicional que se suma a la suscripción, se guarda la fecha.
- Un plan de suscripción tiene un nombre (que no puede garantizarse que sea único en el sistema), condiciones, y un precio mensual.
- Cada contenido tiene un título, sinopsis y duración. El #contenido es único en el sistema, pero del título no puede garantizarse que lo sea.
- De cada suscripción se sabe qué contenidos fueron reproducidos, sin distinción sobre qué usuario (titular o adicionales) reprodujo cada uno.

### SOLUCIÓN

**Dependencias Funcionales:**  
- DF1: #suscripcion -> email, #plan 
- DF2: #suscripcion, email_adicional -> fecha_adicional XXXX
- DF3: email -> nombre_usuario XXXXX
- DF4: email_adicional -> nombre_adicional 
- DF5: #plan -> nombre_plan, texto_condiciones, precio
- DF6: #contenido -> titulo, sinopsis, duracion

**Claves Candidatas:**  
- CC1: (#suscripcion, email_adicional, #contenido)

**Verificacion de los esquemas en BCNF**  
- **El esquema `SUSCRIPCION` no esta en BCNF pues existe la DF2 donde {#suscripcion, email_adicional} no es superclave**  
    - Particiono el esquema considerando la DF2   
    - S1(<u>#suscripcion</u>, <u>email_adicional</u>, fecha_adicional)  
    - S2(<u>#suscripcion</u>, email, nombre_usuario, #plan, nombre_plan, texto_condiciones, precio, <u>email_adicional</u>, nombre_adicional, <u>#contenido</u>, titulo, sinopsis, duracion)  
    - No se pierde información ya que `S1nS2` es clave en `S1`  
    - No se pierden DF's ya que: DF1, DF3, DF4, DF5, DF6 sigue valiendo para `S2`, DF2 sigue valiendo para `S1`    
    - Podemos entonces decir que `S1` esta en BCNF (no se pierde informacion ni DF's)

- **El esquema `S2` no esta en BCNF pues existe la DF3 donde {email} no es superclave**  
    - Particiono el esquema considerando la DF3  
    - S3(<u>email</u>, nombre_usuario)  
    - S4(<u>#suscripcion</u>, email, #plan, nombre_plan, texto_condiciones, precio, <u>email_adicional</u>, nombre_adicional, <u>#contenido</u>, titulo, sinopsis, duracion)  
    - No se pierde información ya que `S3nS4` es clave en `S3`  
    - No se pierden DF's ya que: DF3 sigue valiendo para `S3`, DF1, DF4, DF5, DF6 sigue valiendo para `S4`  
    - Podemos entonces decir que `S3` esta en BCNF (no se pierde informacion ni DF's)  

- **El esquema `S4` no esta en BCNF pues existe la DF4 donde {email_adicional} no es superclave**  
    - Particiono el esquema considerando la DF4  
    - S5(<u>email_adicional</u>, nombre_adicional)  
    - S6(<u>#suscripcion</u>, email, #plan, nombre_plan, texto_condiciones, precio, <u>email_adicional</u>, <u>#contenido</u>, titulo, sinopsis, duracion)  
    - No se pierde información ya que `S5nS6` es clave en `S5`  
    - No se pierden DF's ya que: DF4 sigue valiendo para `S5`, DF5, DF5 siguen valiendo para `S6`  
    - Podemos entonces decir que `S5` esta en BCNF (no se pierde informacion ni DF's) 

- **El esquema `S6` no esta en BCNF pues existe la DF5 donde {#plan} no es superclave**  
    - Particiono el esquema considerando la DF5  
    - S7(<u>#plan</u>, nombre_plan, texto_condiciones, precio)  
    - S8(<u>#suscripcion</u>, email, #plan, <u>email_adicional</u>, <u>#contenido</u>, titulo, sinopsis, duracion)  
    - No se pierde información ya que `S7nS8` es clave en `S7`  
    - No se pierden DF's ya que: DF5 sigue valiendo para `S7`, DF6 sigue valiendo para `S8`
    - Podemos entonces decir que `S7` esta en BCNF (no se pierde informacion ni DF's)  

- **El esquema `S8` no estan en BCNF pues existe la DF6 donde {#contenido} no es superclave**  
    - Particiono el esquema considerando la DF6  
    - S9(<u>#contenido</u>, titulo, sinopsis, duracion)  
    - S10(<u>#suscripcion</u>, email, #plan, <u>email_adicional</u>, <u>#contenido</u>)  
    - No se pierde información ya que `S9nS10` es clave en `S9`  
    - No se pierden DF's ya que: DF6 sigue valiendo para `S9`  
    - Podemos entonces decir que `S9` esta en BCNF (no se pierde informaciín ni DF's)   
 
- **El esquema `S10` no esta en BCNF pues existe la DF1 donde {#suscripcion} no es superclave**  
    - Particiono el esquema considerando la DF1  
    - S11(<u>#suscripcion</u>, email, #plan)  
    - S12(<u>#suscripcion</u>, <u>email_adicional</u>, <u>#contenido</u>)  
    - No se pierde información ya que `S11nS12` es clave en `S11`  
    - No se pierden DF's ya que: DF1 sigue valiendo para `S11`  
    - Podemos entonces decir que `S11` esta en BCNF (no se pierde información ni DF's)  
    - Podemos entonces decir que `S12` esta en BCNF ya que todos sus atributos forman parte de la clave y cualquier dependencia que se detecte sería trivial

**Particiones en BCNF y Clave Primaria**  
- S1(<u>#suscripcion</u>, <u>email_adicional</u>, fecha_adicional)  
- S3(<u>email</u>, nombre_usuario)  
- S5(<u>email_adicional</u>, nombre_adicional)  
- S7(<u>#plan</u>, nombre_plan, texto_condiciones, precio)  
- S9(<u>#contenido</u>, titulo, sinopsis, duracion)  
- S11(<u>#suscripcion</u>, email, #plan)  
- S12(<u>#suscripcion</u>, <u>email_adicional</u>, <u>#contenido</u>)  
- CP{<u>#suscripcion</u>, <u>email_adicional</u>, <u>#contenido</u>}

**Dependencias Multivaluadas**  
- S12(<u>#suscripcion</u>, <u>email_adicional</u>, <u>#contenido</u>)  
- DM1- #suscripcion ->> email_adicional  
- DM2- #suscripcion ->> #contenido  
- Tanto DM1, DM2 no son DM triviales, por lo tanto `S12` no esta en 4NF  
    - Particiono el esquema considerando la DM1  
    - S13(<u>#suscripcion</u>, <u>email_adicional</u>)  
    - S14(<u>#suscripcion</u>, <u>#contenido</u>)  
    - Podemos entonces decir que `S13` esta en 4NF ya que solo posee DM triviales  
    - Podemos entonces decir que `S14` esta en 4NF ya que solo posee DM triviales  

**Particiones en 4NF**
- S1(<u>#suscripcion</u>, <u>email_adicional</u>, fecha_adicional)  
- S3(<u>email</u>, nombre_usuario)  
- S5(<u>email_adicional</u>, nombre_adicional)  
- S7(<u>#plan</u>, nombre_plan, texto_condiciones, precio)  
- S9(<u>#contenido</u>, titulo, sinopsis, duracion)  
- S11(<u>#suscripcion</u>, email, #plan)  
- Todas estos esquemas se encuentran en 4NF ya que ninguno presenta DM
