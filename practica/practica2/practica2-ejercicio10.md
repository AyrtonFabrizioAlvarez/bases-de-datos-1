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
### CONSULTAS


