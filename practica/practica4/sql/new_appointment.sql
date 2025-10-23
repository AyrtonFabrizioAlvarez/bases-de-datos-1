-- Crea un appointment para el paciente nuevo, asi probar el trigger del ejercicio8 con un nuevo paciente
INSERT INTO appointment (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card)
VALUES (20000000, NOW(), 30, '221-555-1234', 'Primera consulta general', NULL);