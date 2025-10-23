SELECT patient_id, COUNT(patient_id) as appointments
        FROM appointment a
        WHERE a.patient_id = patient_id AND patient_id=10004427
        GROUP BY patient_id;