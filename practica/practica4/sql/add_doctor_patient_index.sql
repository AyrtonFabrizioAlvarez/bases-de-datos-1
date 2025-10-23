-- Para el punto C del ejercicio 11, podemos mejorar la performance de la consulta, agregando indices a los campos
-- que nos obligan a hacer full scan de las tablas doctor y patient

CREATE INDEX idx_doctor_specialty ON doctor(doctor_specialty);
CREATE INDEX idx_patient_city ON patient(patient_city);
