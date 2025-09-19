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

**DEPENDENCIAS FUNCIONALES**
- DF1: equipo_id -> equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones 
- DF2: marca_id -> descripMarca
- DF3: modelo_id -> descripModelo, marca_id
- DF4: plan_id -> cuit, descripPlan, importe
- DF5: equipo_tipo_id -> descripEquipoTipo
- DF6: cuit -> nombreEmpresa, direccionEmpresa
- DF7: usuario_id -> cuil, apyn, direccionUsuario
- DF8: cuil -> usuario_id, apyn, direccionUsuario
- DF9: linea_id -> plan_id, fec_alta_linea, fec_baja_linea, equipo_id, usuario_id
- DF10: linea_id -> plan_id, fec_alta_linea, fec_baja_linea, equipo_id, cuil

**CLAVES CANDIDATAS**
- CC1: (linea_id)

**NORMALIZACION A BCNF**
- **El esquema `DISPOSITIVOS` no se encuentra en BCNF ya qeu existe al menos la DF2 donde {marca_id} no es superclave**
  - Particiono el esquema tomando la DF2
  - D1(<u>marca_id</u>, descripMarca)
  - D2(marca_id, modelo_id, descripModelo, equipo_tipo_id, descripEquipoTipo, nombreEmpresa, cuit, direcciónEmpresa, usuario_id, apyn, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde informacion ya que `D1nD2` es clave en `D1`
  - No se pierden DF's ya que: DF2 sigue valiendo en `D1`, DF1, DF3, DF4, DF5, DF6, DF7, DF8, DF9, DF10 siguen valiendo en `D2`
  - Podemos entonces decir que `D1` se encuentra en BCNF ya que DF2 es superclave
- **El esquema `D2` no se encuentra en BCNF ya que existe al menos la DF5 donde {equipo_tipo_id} no es superclave**
  - Particiono el esquema tomando la DF5
  - D3(<u>equipo_tipo_id</u>, descripEquipoTipo)
  - D4(marca_id, modelo_id, descripModelo, equipo_tipo_id, nombreEmpresa, cuit, direcciónEmpresa, usuario_id, apyn, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, <u>línea_id</u>, fec_alta_linea, fec_baja_linea) 
  - No se pierde información ya que `D3nD4` es clave en `D3`
  - No se pierden DF's ya que: DF5 sigue valiendo en `D3`, DF1, DF3, DF4, DF6, DF7, DF8, DF9, DF10 siguen valiendo en `D4`
  - Podemos entonces decir que `D3` se encuentra en BCNF ya que DF5 es superclave
- **El esquema `D4` no se encuentra en BCNF ya que existe al menos la DF6 donde {cuil} no es superclave**
  - Particiono el esquema tomando la DF6
  - D5(<u>cuit</u>, nombreEmpresa, direccionEmpresa)
  - D6(marca_id, modelo_id, descripModelo, equipo_tipo_id, cuit, usuario_id, apyn, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde informacion ya que `D5nD6` es clave en `D5`
  - No se pierden DF's ya que: DF6 sigue valiendo en `D5`, DF1, DF3, DF4, DF7, DF8, DF9, DF10 siguen valiendo en `D6`
  - Podemos entonces decir que `D5` esta en BCNF ya que DF6 es superclave
- **El esquema `D6` no se encuentra en BCNF ya que existe al menos la DF7 donde {usuario_id} no es superclave**
  - Particiono el esquema tomando la DF7
  - D7(<u>usuario_id</u> <u>cuil</u>, apyn, direccionUsuario)
  - D8(marca_id, modelo_id, descripModelo, equipo_tipo_id, cuit, usuario_id, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde información ya que `D7nD8` es clave en `D7`
  - No se pierden DF's ya que: DF7, DF8 siguen valiendo en `D8`, DF1, DF3, DF4, DF9, DF10 siguen valiendo en `D8`
  - Puedo entonces decir que `D7` esta en BCNF ya que DF7 y DF8 son superclave
- **El esquema `D8` no se encuentra en BCNF ya que existe al menos la DF3 donde {modelo_id} no es superclave**
  - Particiono el esquema tomando la DF3
  - D9(<u>modelo_id</u>, descripModelo, marca_id)
  - D10(modelo_id, equipo_tipo_id, cuit, usuario_id, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde información ya que `D9nD10` es clave en `D9`
  - No se pierden DF's ya que: DF3 sigue valiendo en `D9`, DF1, DF4, DF9, DF10 siguen valiendo en `D10`
  - Podemos entonces decir que `D9` esta en BCNF ya que DF3 es superclave
- **El esquema `D10` no se encuentra en BCNF ya que existe al menos la DF1 donde {equipo_id} no es superclave**
  - Particiono el esquema tomando la DF1
  - D11(<u>equipo_id</u>, equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones)
  - D12(cuit, usuario_id, plan_id, descripPlan, importe, equipo_id, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde información ya que `D11nD12` es clave en `D11`
  - No se pierden DF's ya que: DF1 sigue valiendo en `D11`, DF4, DF9, DF10 siguen valiendo en `D12`
  - Podemos entonces decir que `D11` se encuentra en BCNF ya que DF1 es superclave
- **El esquema `D11` no se encuentra en BCNF ya que existe al menos la DF4 donde {plan_id} no es superclave**
  - Particiono el esquema tomando la DF4
  - D13(<u>plan_id</u>, cuit, descripPlan, importe)
  - D14(usuario_id, plan_id, equipo_id, <u>línea_id</u>, fec_alta_linea, fec_baja_linea)
  - No se pierde información ya que `D13nD14` es clave en `D13`
  - No se pierden DF's ya que: DF4 sigue valiendo en `D13`, DF9, DF10 siguen valiendo en `D14`
  - Podemos entonces decir que `D13` se encuentra en BCNF ya que DF4 es superclave
- **El esquema `D14` no se encuentra en BCNF ya que existe al menos la DF9 donde {linea_id} no es superclave**
  - Particiono tomando la DF9
  - D15(<u>linea_id</u>, plan_id, fec_alta_linea, fec_baja_linea, equipo_id, usuario_id)
  - D16(<u>línea_id</u>)
  - No se pierde información ya que `D15nD16` es clave en `D15`
  - No se pierden DF's ya que: DF9 y DF10 siguen valiendo en `D15`
  - Podemos entonces decir que `D15` se encuentra en BCNF ya que DF9 y DF10 son superclave????????????????
  - Podemos entonces decir que `D16` se encuentra en BCNF ya que su atributo representa la CC y por lo tanto es trivial

**ESQUEMAS EN BCNF Y CLAVE PRIMARIA**
- D1(<u>marca_id</u>, descripMarca)
- D3(<u>equipo_tipo_id</u>, descripEquipoTipo)
- D5(<u>cuit</u>, nombreEmpresa, direccionEmpresa)
- D7(<u>usuario_id</u> <u>cuil</u>, apyn, direccionUsuario)
- D9(<u>modelo_id</u>, descripModelo, marca_id)
- D11(<u>equipo_id</u>, equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones)
- D13(<u>plan_id</u>, cuit, descripPlan, importe)
- D15(<u>linea_id</u>, plan_id, fec_alta_linea, fec_baja_linea, equipo_id, usuario_id)
- CP{<u>linea_id</u>}
- Todos estos esquemas a su vez se encuentran en 4NF ya que ninguno presenta DM's

### CONSULTAS
- el caso cuando al particionar me quedo con las "similares" (cuando el esquema D6 no va)
  - esta bien justificado que tanto DF7 como DF8 son superclave? la subrayo?  
- como justificar bien el ultimo paso, donde me queda DF9 y DF10?
  - como ya "saque" el "cuil" por haber elegido la DF7 ("usuario_id") no entiendo si ambas son superclave, o simplemente como ya "saque" el cuil la DF10 "Deja de valer"?

