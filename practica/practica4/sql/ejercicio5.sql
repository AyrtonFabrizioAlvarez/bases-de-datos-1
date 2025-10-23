-- Escribe y ejecute la sentencia correspondiente para crear la siguiente tabla:
-- APPOINTMENTS_PER_PATIENT
-- idApP: int(11) PK AI
-- id_patient: int(11) 
-- count_appointments: int(11) 
-- last_update: datetime 
-- user: varchar(16)

-- Table APPOINTMENTS_PER_PATIENT
DROP TABLE IF EXISTS appointments_per_patient;

CREATE TABLE `appointments_per_patient` (
    `idApP` int(11) AUTO_INCREMENT NOT NULL,
    `id_patient` int(11) NOT NULL UNIQUE,
    `count_appointments` int(11),
    `last_update` DATETIME,
    `user` varchar(16) NOT NULL,
    PRIMARY KEY (`idApP`),
    FOREIGN KEY (`id_patient`) REFERENCES `patient`(`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;