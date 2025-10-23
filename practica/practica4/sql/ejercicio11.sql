-- Considerando la siguiente consulta:
-- Analice su plan de ejecución mediante el uso de la sentencia EXPLAIN.
-- a. ¿Qué atributos del plan de ejecución encuentra relevantes para evaluar la performance de la consulta?
-- b. Observe en particular el atributo type ¿cómo se están aplicando los JOIN entre las tablas involucradas?
-- c. Según lo que observó en los puntos anteriores, ¿qué mejoras se pueden realizar para optimizar la consulta? 
-- d. Aplique las mejoras propuestas y vuelva a analizar el plan de ejecución. ¿Qué cambios observa?

EXPLAIN SELECT count(a.patient_id) 
FROM appointment a, patient p, doctor d, medical_review mr
WHERE a.patient_id = p.patient_id 
AND a.patient_id = mr.patient_id 
AND a.appointment_date = mr.appointment_date
AND mr.doctor_id = d.doctor_id
AND d.doctor_specialty = 'Cardiology'
AND p.patient_city = 'Rosario';


-- A
-- salida del comando EXPLAIN + CONSULTA

-- | id | select_type | table | partitions | type   | possible_keys     | key       | key_len | ref                                                        | rows | filtered | Extra                                      |
-- +----+-------------+-------+------------+--------+-------------------+-----------+---------+------------------------------------------------------------+------+----------+--------------------------------------------+
-- |  1 | SIMPLE      | d     | NULL       | ALL    | PRIMARY           | NULL      | NULL    | NULL                                                       |  100 |    10.00 | Using where                                |
-- |  1 | SIMPLE      | p     | NULL       | ALL    | PRIMARY           | NULL      | NULL    | NULL                                                       | 1000 |    10.00 | Using where; Using join buffer (hash join) |
-- |  1 | SIMPLE      | mr    | NULL       | ref    | PRIMARY,doctor_id | doctor_id | 8       | appointments.d.doctor_id,appointments.p.patient_id         |    1 |   100.00 | Using index                                |
-- |  1 | SIMPLE      | a     | NULL       | eq_ref | PRIMARY           | PRIMARY   | 9       | appointments.p.patient_id,appointments.mr.appointment_date |    1 |   100.00 | Using index                                |
-- +----+-------------+-------+------------+--------+-------------------+-----------+---------+------------------------------------------------------------+------+----------+--------------------------------------------+
-- 
-- -- que campos nos muestra
-- 
-- | **Atributo**      | **Qué indica**                                                            
-- | ----------------- | ------------------------------------------------------------------------- |
-- | **id**            | Orden lógico de ejecución de la consulta                                  |                                                                                                                                                                                                                                                                                        |
-- | **select_type**   | Tipo de subconsulta o bloque (`SIMPLE`, `PRIMARY`, `SUBQUERY`, `DERIVED`) |                                                                                                                                                                                                                                                                        |
-- | **table**         | Nombre o alias de la tabla usada en esa etapa                             |                                                                                                                                                                                                                                                                                            |
-- | **type**          | **Método de acceso a la tabla** (cómo lee las filas)                      |
-- | **possible_keys** | Índices que *podrían* usarse según el optimizador                         |                                                                                                                                                                                                                                              |
-- | **key**           | Índice que **efectivamente se usó**                                       |
-- | **key_len**       | Longitud de la parte del índice que se usa (en bytes)                     |
-- | **ref**           | Qué columna o constante se comparó con el índice                          |                                                                                                                                                                                                                                                                       |
-- | **rows**          | Estimación del número de filas que MySQL espera leer                      |
-- | **filtered**      | Porcentaje estimado de filas que pasan el `WHERE`                         |                                                                                                                                                                                                                                                              |
-- | **Extra**         | Detalles adicionales sobre cómo se procesa esa tabla                      |
-- 
-- -- como analizamos estos atributos y cuales son de nuestro interes en un primer scan
-- - type: Es el indicador más importante.
--     - system / const: lee 1 fila.
--     - eq_ref: usa clave primaria/única.
--     - ref: usa índice no único.
--     - range: usa índice con un rango (>, <, BETWEEN).
--     - index: recorre solo el índice (no toda la tabla).
--     - ALL: full table scan, recorre todas las filas.
-- - possible_keys:
--     - Si aparece NULL, no hay índice adecuado para los WHERE o JOIN.
--     - Si ves uno útil acá que luego no se usa, puede haber un problema de diseño del índice o de estadística.
-- - key
--     - Si es NULL, no se usó ningún índice.
--     - Si aparece un nombre, MySQL lo usó para acceder a las filas.
--     - Si usa un índice poco relevante (por ejemplo, la PK sin condición sobre esa columna), hay espacio para optimizar.
-- - rows
--     - Cuantas más filas, más trabajo. Las multiplicaciones de estas estimaciones entre etapas te dan el costo total aproximado.
-- - filtered
--     - Si es bajo (<10 %), el filtro es selectivo.
--     - Si es alto (~100 %), el filtro no reduce casi nada.
--     - Te ayuda a decidir dónde conviene aplicar filtros o índices.
-- - Extra
--     - “Using where”: aplica condiciones del WHERE.
--     - “Using index”: no necesita leer datos fuera del índice → rápido.
--     - “Using join buffer”: hace join en memoria → probablemente falta índice.
--     - “Using temporary” / “Using filesort”: usa tablas o sorting temporales → caro.
-- 


-- B
-- Los JOIN se aplican en el orden que muestra el EXPLAIN

-- Primero realiza un full scan de la tabla doctor (d),
-- aplicando el filtro por especialidad (doctor_specialty = 'Cardiology').
-- Al no tener índice en esa columna, el acceso es secuencial (type = ALL).

-- Segundo realiza un full scan de la tabla patient (p),
-- y aplica el join con los doctores obtenidos.
-- Como tampoco hay índice sobre patient_city, MySQL usa un "join buffer" (hash join)
-- para emparejar las filas (type = ALL, Extra = Using join buffer).

-- Tercero, se une la tabla medical_review (mr),
-- utilizando las columnas doctor_id y patient_id para el emparejamiento.
-- En este caso, el join se apoya en un índice no único (type = ref).

-- Cuarto, se une la tabla appointment (a),
-- usando la combinación (patient_id, appointment_date) como clave primaria o índice único.
-- Este join es el más eficiente (type = eq_ref), ya que accede a una sola fila por coincidencia.

-- Entonces los JOIN se realizan secuencialmente (nested loops),
-- comenzando con tablas sin índices (full scans) y finalizando con joins indexados.

-- C
-- una solución es agregar indices sobre los campos que estan forzando que esta consulta realice
-- full scan sobre la tabla doctor y patient

-- D
-- Una vez agregados los índices (ver "add_doctor_patient_index.sql") obtenemos la siguiente salida

-- +----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+
-- | id | select_type | table | partitions | type   | possible_keys                | key              | key_len | ref                                                        | rows | filtered | Extra       |
-- +----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+
-- |  1 | SIMPLE      | p     | NULL       | ref    | PRIMARY,idx_patient_city     | idx_patient_city | 768     | const                                                      |   82 |   100.00 | Using index |
-- |  1 | SIMPLE      | mr    | NULL       | ref    | PRIMARY,doctor_id            | PRIMARY          | 4       | appointments.p.patient_id                                  |   31 |   100.00 | Using index |
-- |  1 | SIMPLE      | d     | NULL       | eq_ref | PRIMARY,idx_doctor_specialty | PRIMARY          | 4       | appointments.mr.doctor_id                                  |    1 |    19.00 | Using where |
-- |  1 | SIMPLE      | a     | NULL       | eq_ref | PRIMARY                      | PRIMARY          | 9       | appointments.p.patient_id,appointments.mr.appointment_date |    1 |   100.00 | Using index |
-- +----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+