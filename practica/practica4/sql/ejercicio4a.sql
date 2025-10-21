-- Obtener la cantidad de doctores por cada paciente que tiene disponible en su ciudad

SELECT patient_id, count(doctor_id) AS total_doctors
FROM doctor_per_patients
GROUP BY patient_id;