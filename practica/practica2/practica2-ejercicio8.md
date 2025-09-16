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


