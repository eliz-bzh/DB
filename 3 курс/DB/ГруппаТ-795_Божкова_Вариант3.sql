CREATE DATABASE Hospital;
GO

USE Hospital;
GO

DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS HospitalWard;
DROP TABLE IF EXISTS Branch;
GO

/*
ВАРИАНТ 3. 
I.Создайте и заполните базу данных больницы. Примечание: не для всех отношений
указаны ключевые поля. Если они не указаны, их нужно добавить!
Отношение «Отделения» (поля «Номер отделения» и «Название отделения»).
Отношение «Больничные палаты» (поля «Номер палаты», «Количество коек»,
«Отделение»).
Отношение «Врачи» (поля «ФИО врача», «Отделение», «Специализация»).
Отношение «Пациенты»
II.Выборка данных:
 вывести упорядоченные списки пациентов в каждой палате с указанием ФИО врача
и диагноза;
 вывести упорядоченные списки по количеству свободных коек в каждой палате;
 сформировать запрос на получение данных о пациентах хирургического отделения
(не учитывать выписанных пациентов).
III.Один из запросов задания No2 написать двумя способами и объяснить, какой из
вариантов будет работать быстрее и почему.
*/

CREATE TABLE Branch(
	num_branch INTEGER PRIMARY KEY IDENTITY(1, 1),
	name_branch VARCHAR(50) NOT NULL
);

CREATE TABLE HospitalWard(
	num_ward DECIMAL(3,0) PRIMARY KEY IDENTITY(1, 1),
	amount_bed INTEGER NOT NULL,
	branch INTEGER NOT NULL,
	FOREIGN KEY (branch) REFERENCES Branch(num_branch) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Doctor(
	id_doctor DECIMAL(6,0) PRIMARY KEY IDENTITY(1, 1),
	fio_doctor VARCHAR(50) NOT NULL,
	branch INTEGER NOT NULL,
	specialization VARCHAR(50) NOT NULL,
	FOREIGN KEY (branch) REFERENCES Branch(num_branch) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Patient(
	registration_number DECIMAL(6,0) PRIMARY KEY IDENTITY(1, 1),
	fio VARCHAR(40) NOT NULL,
	sex VARCHAR(1) NOT NULL DEFAULT 'м',
	birthday DATE NOT NULL,
	policy_number VARCHAR(15) NOT NULL,
	receiptDate DATE NOT NULL,
	ward DECIMAL(3,0) NOT NULL,
	doctor DECIMAL(6,0) NOT NULL,
	diagnosis VARCHAR(200) NOT NULL,
	dischargeDate DATE,
	FOREIGN KEY (ward) REFERENCES HospitalWard(num_ward) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (doctor) REFERENCES Doctor(id_doctor) ON DELETE NO ACTION,
	CONSTRAINT G_CK CHECK (sex IN (N'м', N'ж'))
);

INSERT INTO Branch (name_branch) VALUES 
('Кардиологическое'), ('Онкологическое'), ('Педиатрическое'), ('Инфекционное'), ('Хирургическое')

INSERT INTO HospitalWard (amount_bed, branch)
VALUES (5, 1), (1, 2), (3, 3), (10, 4), (5, 5) 

INSERT INTO Doctor (fio_doctor, branch, specialization)
VALUES ('Коробанько Дарья Николаевна', 5, 'Хирург'),
('Божкова Елизавета Юрьевна', 3, 'Педиатр'),
('Выговская Екатерина Руслановна', 1, 'Кардиолог'),
('Крайко Владислав Алексеевич', 2, 'Онколог'),
('Грицкевич Иван Аркадьевич', 4, 'Инфекционист')

INSERT INTO Patient (fio, sex, birthday, policy_number, receiptDate, ward, doctor, diagnosis, dischargeDate) 
VALUES ('Форд Генри Уильямский', DEFAULT, CONVERT(DATETIME, '1936-07-30', 120), '342234', CONVERT(DATETIME, '2020-01-12', 120), 1, 3, 'Cтенокардия', CONVERT(DATETIME, '2020-02-05', 120)),
('Пушкин Александр Сергеевич', DEFAULT, CONVERT(DATETIME, '1920-10-24', 120), '112267', CONVERT(DATETIME, '2020-02-10', 120), 4, 5, 'Коронавирус', CONVERT(DATETIME, '2020-03-05', 120)),
('Божкова Арина Юрьевна', 'ж', CONVERT(DATETIME, '2018-02-15', 120), '544321', CONVERT(DATETIME, '2020-06-01', 120), 3, 2, 'Ангина', NUll),
('Иванов Иван Иванович', DEFAULT, CONVERT(DATETIME, '1980-08-21', 120), '742325', CONVERT(DATETIME, '2020-01-08', 120), 5, 1, 'Гангрена', CONVERT(DATETIME, '2020-02-05', 120)),
('Иванова Карина Ивановна', 'ж', CONVERT(DATETIME, '1990-01-28', 120), '932034', CONVERT(DATETIME, '2020-04-22', 120), 2, 4, 'Опухоль', NUll),
('Достоевский Фёдор Михайлович', DEFAULT, CONVERT(DATETIME, '1940-07-30', 120), '982234', CONVERT(DATETIME, '2020-05-06', 120), 5, 1, 'Ангиома', NUll)

--вывести упорядоченные списки пациентов в каждой палате с указанием ФИО врача и диагноза
SELECT fio, sex, birthday, policy_number, receiptDate, ward, fio_doctor, diagnosis, dischargeDate
FROM Patient
JOIN Doctor ON Patient.doctor = Doctor.id_doctor
ORDER BY ward;

--вывести упорядоченные списки по количеству свободных коек в каждой палате
SELECT hw.num_ward, hw.amount_bed - (SELECT COUNT(*) FROM Patient P WHERE P.ward = hw.num_ward) AS [Free]
FROM HospitalWard hw
ORDER BY [Free];

--сформировать запрос на получение данных о пациентах хирургического отделения (не учитывать выписанных пациентов).
SELECT fio, sex, birthday, policy_number, receiptDate, ward, name_branch,  fio_doctor, diagnosis, dischargeDate
FROM Patient
JOIN Doctor ON Patient.doctor = Doctor.id_doctor
JOIN HospitalWard ON HospitalWard.num_ward = Patient.ward
JOIN Branch ON Branch.num_branch = HospitalWard.branch
WHERE name_branch = 'Хирургическое'
AND dischargeDate IS NULL;