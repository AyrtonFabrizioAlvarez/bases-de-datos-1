-- Obtener los doctores que comparten ciudad con más de cinco pacientes.

SELECT doctor_id, COUNT(patient_id) AS total_patient_in_area
FROM doctor_per_patients
GROUP BY doctor_id
HAVING COUNT(patient_id) > 5;