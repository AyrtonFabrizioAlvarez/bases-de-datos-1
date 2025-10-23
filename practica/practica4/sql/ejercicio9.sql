-- PATIENT (patient_id , patient_name, patient_address, patient_city, primary_phone, secondary_phone)
-- DOCTOR (doctor_id, doctor_name, doctor_address, doctor_city, doctor_speciality) 
-- APPOINTMENT (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
-- MEDICAL_REVIEW (patient_id, appointment_date, doctor_id)
-- PRESCRIBED_MEDICATION (patient_id, appointment_date, medication_name)
-- DOCTOR_PER_PATIENTS (patient_id, patient_city, doctor_id)
-- APPOINTMENTS_PER_PATIENT (idApP, id_patient, count_appointments, last_update, user)

-- Crear un stored procedure que sirva para agregar un appointment, junto el registro 
-- de un doctor que lo atendió (medical_review) y un medicamento que se le recetó 
-- (prescribed_medication), dentro de una sola transacción.

-- El stored procedure debe recibir los siguientes parámetros:
-- patient_id, doctor_id, appointment_duration, contact_phone, appointment_address, medication_name.

-- El appointment_date será la fecha actual. Los atributos restantes deben ser obtenidos de la tabla Patient (o 
-- dejarse en NULL)

DELIMITER //
CREATE PROCEDURE new_appointment (
    IN in_patient_id INT,
    IN in_doctor_id INT,
    IN in_appointment_duration INT,
    IN in_contact_phone VARCHAR(45),
    IN in_appointment_address VARCHAR(255),
    IN in_medication_name VARCHAR(30))
BEGIN
    START TRANSACTION;
    BEGIN
        INSERT INTO appointment (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card)
        VALUES (in_patient_id, NOW(), in_appointment_duration, in_contact_phone, in_appointment_address, NULL);
        INSERT INTO medical_review (patient_id, appointment_date, doctor_id)
        VALUES (in_patient_id, NOW(), in_doctor_id);
        INSERT INTO prescribed_medication (patient_id, appointment_date, medication_name)
        VALUES (in_patient_id, NOW(), in_medication_name);
        COMMIT;
    END;
END //
DELIMITER ;