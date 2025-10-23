-- Genero un paciente que viva en un lugar donde no viva ningun doctor, para visualizar mejor el ejercicio 4
INSERT INTO patient (patient_id, patient_name, patient_address, patient_city, primary_phone, secondary_phone)
VALUES (999, 'Prueba Sin Doctor', 'Calle Falsa 123', 'Atlantis', '1111-1111', NULL);
