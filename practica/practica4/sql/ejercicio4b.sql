-- Obtener los nombres de los pacientes sin doctores en su ciudad

SELECT p.patient_name
FROM patient p INNER JOIN doctor_per_patients as dpp ON p.patient_id = dpp.patient_id
WHERE dpp.doctor_id IS NULL;