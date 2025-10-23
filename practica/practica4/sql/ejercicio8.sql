-- PATIENT (patient_id , patient_name, patient_address, patient_city, primary_phone, secondary_phone)
-- DOCTOR (doctor_id, doctor_name, doctor_address, doctor_city, doctor_speciality) 
-- APPOINTMENT (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
-- MEDICAL_REVIEW (patient_id, appointment_date, doctor_id)
-- PRESCRIBED_MEDICATION (patient_id, appointment_date, medication_name)
-- DOCTOR_PER_PATIENTS (patient_id, patient_city, doctor_id)
-- APPOINTMENTS_PER_PATIENT (idApP, id_patient, count_appointments, last_update, user)

-- Crear un Trigger de modo que al insertar un dato en la tabla Appointment, se 
-- actualice la cantidad de appointments del paciente, la fecha de actualización y el 
-- usuario responsable de la misma (actualiza la tabla APPOINTMENTS PER PATIENT).

DROP TRIGGER IF EXISTS tr_update_appointments_per_patient;

DELIMITER //

CREATE TRIGGER tr_update_appointments_per_patient
AFTER INSERT ON appointment
FOR EACH ROW
BEGIN
    INSERT INTO appointments_per_patient (id_patient, count_appointments, last_update, user)
    VALUES (NEW.patient_id, 1, NOW(), CURRENT_USER())
    ON DUPLICATE KEY UPDATE
        count_appointments = count_appointments + 1,
        last_update = NOW(),
        user = CURRENT_USER();
END //

DELIMITER ;