-- PATIENT (patient_id , patient_name, patient_address, patient_city, primary_phone, secondary_phone)
-- DOCTOR (doctor_id, doctor_name, doctor_address, doctor_city, doctor_speciality) 
-- APPOINTMENT (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
-- MEDICAL_REVIEW (patient_id, appointment_date, doctor_id)
-- PRESCRIBED_MEDICATION (patient_id, appointment_date, medication_name)

-- DOCTOR_PER_PATIENTS (patient_id, patient_city, doctor_id)
-- APPOINTMENTS_PER_PATIENT (idApP, id_patient, count_appointments, last_update, user)


-- Crear un Stored Procedure que realice los siguientes pasos dentro de una transacción:
-- a. Realizar la siguiente consulta: cada pacient (identificado por id_patient), 
-- calcule la cantidad de appointments que tiene registradas.
-- Registrar la fecha en la que se realiza esta carga y además del usuario con el se realiza.
-- b. Guardar el resultado de la consulta en un cursor.
-- c. Iterar el cursor e insertar los valores correspondientes en la tabla
-- APPOINTMENTS PER PATIENT. Tenga en cuenta que last_update es la 
-- fecha en que se realiza esta carga, es decir la fecha actual, mientras que
-- user es el usuario logueado actualmente, utilizar las correspondientes funciones para esto. 

DROP PROCEDURE IF EXISTS load_appointments_per_patient;

DELIMITER //
CREATE PROCEDURE load_appointments_per_patient ()
BEGIN
    START TRANSACTION;
    BEGIN
        DECLARE patient INT;
        DECLARE appointments_qty INT DEFAULT 0;
        DECLARE fin INT DEFAULT 0;

        DECLARE primer_cursor CURSOR FOR         
        SELECT patient_id, COUNT(patient_id) as appointments
        FROM appointment a
        WHERE a.patient_id = patient_id
        GROUP BY patient_id;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

        OPEN primer_cursor;
        loop_cursor : LOOP

            FETCH NEXT FROM primer_cursor INTO patient, appointments_qty;

            IF fin = 1 THEN
                LEAVE loop_cursor;
            END IF;

            INSERT INTO appointments_per_patient (id_patient, count_appointments, last_update, user)
            VALUES (patient, appointments_qty, NOW(), CURRENT_USER());

        END LOOP;
        CLOSE primer_cursor;
        COMMIT;
    END;
END //
DELIMITER ;