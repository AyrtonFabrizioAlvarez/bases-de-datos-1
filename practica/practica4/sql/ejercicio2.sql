-- PATIENT (patient_id , patient_name, patient_address, patient_city, primary_phone, secondary_phone)
-- DOCTOR (doctor_id, doctor_name, doctor_address, doctor_city, doctor_speciality) 
-- APPOINTMENT (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
-- MEDICAL_REVIEW (patient_id, appointment_date, doctor_id)
-- PRESCRIBED_MEDICATION (patient_id, appointment_date, medication_name)

-- Hallar aquellos pacientes que para todas sus consultas médicas
-- siempre hayan dejado su número de teléfono primario (nunca el teléfono secundario). 

SELECT DISTINCT p.patient_id, p.patient_name, p.primary_phone, a.contact_phone
FROM patient p INNER JOIN appointment a ON p.patient_id = a.patient_id
WHERE NOT EXISTS (
    SELECT *
    FROM appointment a2
    WHERE p.patient_id = a2.patient_id AND p.primary_phone <> a2.contact_phone
)

