-- Considerando la siguiente consulta:
-- Analice su plan de ejecución mediante el uso de la sentencia EXPLAIN.
-- a. ¿Qué atributos del plan de ejecución encuentra relevantes para evaluar la performance de la consulta?
-- b. Observe en particular el atributo type ¿cómo se están aplicando los JOIN entre las tablas involucradas?
-- c. Según lo que observó en los puntos anteriores, ¿qué mejoras se pueden realizar para optimizar la consulta? 
-- d. Aplique las mejoras propuestas y vuelva a analizar el plan de ejecución. ¿Qué cambios observa?

EXPLAIN SELECT count(a.patient_id) 
FROM appointment a
INNER JOIN patient p ON a.patient_id = p.patient_id
INNER JOIN medical_review mr ON a.patient_id = mr.patient_id AND a.appointment_date = mr.appointment_date
INNER JOIN doctor d ON mr.doctor_id = d.doctor_id
WHERE d.doctor_specialty = 'Cardiology' AND p.patient_city = 'Rosario';


+----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+
| id | select_type | table | partitions | type   | possible_keys                | key              | key_len | ref                                                        | rows | filtered | Extra       |
+----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+
|  1 | SIMPLE      | p     | NULL       | ref    | PRIMARY,idx_patient_city     | idx_patient_city | 768     | const                                                      |   82 |   100.00 | Using index |
|  1 | SIMPLE      | mr    | NULL       | ref    | PRIMARY,doctor_id            | PRIMARY          | 4       | appointments.p.patient_id                                  |   31 |   100.00 | Using index |
|  1 | SIMPLE      | d     | NULL       | eq_ref | PRIMARY,idx_doctor_specialty | PRIMARY          | 4       | appointments.mr.doctor_id                                  |    1 |    19.00 | Using where |
|  1 | SIMPLE      | a     | NULL       | eq_ref | PRIMARY                      | PRIMARY          | 9       | appointments.p.patient_id,appointments.mr.appointment_date |    1 |   100.00 | Using index |
+----+-------------+-------+------------+--------+------------------------------+------------------+---------+------------------------------------------------------------+------+----------+-------------+