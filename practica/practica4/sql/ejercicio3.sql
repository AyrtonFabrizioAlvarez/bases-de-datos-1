-- PATIENT (patient_id , patient_name, patient_address, patient_city, primary_phone, secondary_phone)
-- DOCTOR (doctor_id, doctor_name, doctor_address, doctor_city, doctor_speciality) 
-- APPOINTMENT (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card) 
-- MEDICAL_REVIEW (patient_id, appointment_date, doctor_id)
-- PRESCRIBED_MEDICATION (patient_id, appointment_date, medication_name)

-- Crear una vista llamada ‘doctors_per_patients’ que muestre los id de los pacientes y los id de doctores de la ciudad donde vive el paciente.

CREATE OR REPLACE VIEW appointments.doctor_per_patients AS (
    SELECT DISTINCT p.patient_id, p.patient_city, d.doctor_id
    FROM patient AS p LEFT JOIN doctor AS d ON p.patient_city = d.doctor_city
)