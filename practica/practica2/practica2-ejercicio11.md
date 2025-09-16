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
### CONSULTAS