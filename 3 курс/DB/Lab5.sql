drop database if exists SportClub;
GO

create database SportClub;
GO

use SportClub;
GO


CREATE TABLE StreetCus(
	id_stc INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL UNIQUE DEFAULT N'Пустая строка'
);

CREATE TABLE Customer(
	id_c INTEGER PRIMARY KEY IDENTITY(1, 1),
	surname VARCHAR(255) NOT NULL DEFAULT N'Пустая строка',
	name VARCHAR(255) NOT NULL DEFAULT N'Пустая строка',
	patronymic VARCHAR(255) NOT NULL DEFAULT N'Пустая строка',
	email VARCHAR(255) NOT NULL UNIQUE,
	phone VARCHAR(255) NOT NULL UNIQUE,
	numberHouse INTEGER NOT NULL,
	numberFlat INTEGER NOT NULL,
	invitation BIT NOT NULL DEFAULT 0,
	id_stc INTEGER NOT NULL,
	FOREIGN KEY (id_stc) REFERENCES StreetCus(id_stc) ON DELETE CASCADE
);

CREATE TABLE Subscription(
	id_s INTEGER PRIMARY KEY IDENTITY(1, 1),
	price DECIMAL(5,2) NOT NULL,
	amountVisit INTEGER NOT NULL DEFAULT 0,
	validity DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Subscription_Cus(
	id_sc INTEGER PRIMARY KEY IDENTITY(1, 1),
	id_s INTEGER NOT NULL,
	id_c INTEGER NOT NULL,
	FOREIGN KEY(id_s) REFERENCES Subscription(id_s) ON DELETE CASCADE,
	FOREIGN KEY(id_c) REFERENCES Customer(id_c) ON DELETE CASCADE
);

CREATE TABLE StreetClub(
	id_stcl INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL UNIQUE DEFAULT N'Пустая строка'
);

CREATE TABLE Club(
	id_cl INTEGER PRIMARY KEY IDENTITY(1, 1),
	phone VARCHAR(255) NOT NULL UNIQUE,
	numberHouse INTEGER NOT NULL,
	invitation BIT NOT NULL DEFAULT 1,
	id_stcl INTEGER NOT NULL,
	FOREIGN KEY(id_stcl) REFERENCES StreetClub(id_stcl) ON DELETE CASCADE
);

CREATE TABLE TypePremise(
	id_tp INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL DEFAULT N'Пустая строка'
);

CREATE TABLE Premise(
	id_p INTEGER PRIMARY KEY IDENTITY(1, 1),
	invitation BIT NOT NULL DEFAULT 1,
	id_tp INTEGER NOT NULL,
	FOREIGN KEY(id_tp) REFERENCES TypePremise(id_tp) ON DELETE CASCADE
);

CREATE TABLE Visit(
	id_v INTEGER PRIMARY KEY IDENTITY(1, 1),
	date DATE NOT NULL UNIQUE,
	time TIME NOT NULL UNIQUE,
	id_c INTEGER NOT NULL,
	id_cl INTEGER NOT NULL,
	id_p INTEGER NOT NULL,
	FOREIGN KEY(id_c) REFERENCES Customer(id_c) ON DELETE CASCADE,
	FOREIGN KEY(id_cl) REFERENCES Club(id_cl) ON DELETE CASCADE,
	FOREIGN KEY(id_p) REFERENCES Premise(id_p) ON DELETE CASCADE
);

CREATE TABLE TypeEquipment(
	id_te INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL DEFAULT N'Пустая строка'
);

CREATE TABLE Equipment(
	id_e INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL DEFAULT N'Пустая строка',
	id_p INTEGER NOT NULL,
	id_te INTEGER NOT NULL,
	FOREIGN KEY(id_p) REFERENCES Premise(id_p) ON DELETE CASCADE,
	FOREIGN KEY(id_te) REFERENCES TypeEquipment(id_te) ON DELETE CASCADE
);

INSERT INTO StreetCus(name) VALUES ('Пушкина');
INSERT INTO StreetCus(name) VALUES ('Притыцкого');
INSERT INTO StreetCus(name) VALUES ('Немига');
INSERT INTO StreetCus(name) VALUES ('Зыбицкая');
INSERT INTO StreetCus(name) VALUES ('Янки Мавра');

INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivan@gmail.com', '+375333333333', 3, 45, 0, (SELECT id_stc FROM StreetCus WHERE name = 'Притыцкого'));
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванова', 'Карина', 'Ивановна', 'karina@gmail.com', '+375254565678', 4, 90, 1, (SELECT id_stc FROM StreetCus WHERE name = 'Пушкина'));
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivanov@gmail.com', '+375334567023', 8, 35, 0, (SELECT id_stc FROM StreetCus WHERE name = 'Янки Мавра'));
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванова', 'Карина', 'Ивановна', 'kar344@gmail.com', '+375255674499', 4, 45, 1, (SELECT id_stc FROM StreetCus WHERE name = 'Притыцкого'));
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivan123@gmail.com', '+375332301067', 3, 7, 0, (SELECT id_stc FROM StreetCus WHERE name = 'Зыбицкая'));

INSERT INTO Subscription(price, amountVisit, validity) VALUES (99.99, 10, DEFAULT);
INSERT INTO Subscription(price, amountVisit, validity) VALUES (49.99, DEFAULT, '2020-12-01');
INSERT INTO Subscription(price, amountVisit, validity) VALUES (45.77, 8, DEFAULT);
INSERT INTO Subscription(price, amountVisit, validity) VALUES (567, DEFAULT, '2021-10-08');
INSERT INTO Subscription(price, amountVisit, validity) VALUES (343, 40, DEFAULT);

INSERT INTO Subscription_Cus(id_s, id_c) VALUES ((SELECT id_s FROM Subscription WHERE price = 99.99), (SELECT id_c FROM Customer WHERE email = 'ivan@gmail.com'));
INSERT INTO Subscription_Cus(id_s, id_c) VALUES ((SELECT id_s FROM Subscription WHERE price = 99.99), (SELECT id_c FROM Customer WHERE email = 'karina@gmail.com'));
INSERT INTO Subscription_Cus(id_s, id_c) VALUES ((SELECT id_s FROM Subscription WHERE price = 49.99), (SELECT id_c FROM Customer WHERE email = 'ivanov@gmail.com'));
INSERT INTO Subscription_Cus(id_s, id_c) VALUES ((SELECT id_s FROM Subscription WHERE price = 567), (SELECT id_c FROM Customer WHERE email = 'kar344@gmail.com'));
INSERT INTO Subscription_Cus(id_s, id_c) VALUES ((SELECT id_s FROM Subscription WHERE price = 49.99), (SELECT id_c FROM Customer WHERE email = 'ivan123@gmail.com'));

INSERT INTO StreetClub(name) VALUES ('Пушкина');
INSERT INTO StreetClub(name) VALUES ('Притыцкого');
INSERT INTO StreetClub(name) VALUES ('Янки Мавра');
INSERT INTO StreetClub(name) VALUES ('Немига');
INSERT INTO StreetClub(name) VALUES ('Зыбицкая');

INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375446758798', 56, DEFAULT, (SELECT id_stcl FROM StreetClub WHERE name = 'Пушкина'));
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375444563321', 6, 0, (SELECT id_stcl FROM StreetClub WHERE name = 'Притыцкого'));
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375337659000', 78, DEFAULT, (SELECT id_stcl FROM StreetClub WHERE name = 'Немига'));
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375253338709', 1, DEFAULT, (SELECT id_stcl FROM StreetClub WHERE name = 'Зыбицкая'));
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375445674499', 6, 0, (SELECT id_stcl FROM StreetClub WHERE name = 'Немига'));

INSERT INTO TypePremise(name) VALUES ('Зал малый йоги');
INSERT INTO TypePremise(name) VALUES ('Бассейн');
INSERT INTO TypePremise(name) VALUES ('Зал тяжёлой атлетики');
INSERT INTO TypePremise(name) VALUES ('Зал лёгкой атлетики');
INSERT INTO TypePremise(name) VALUES ('Зал йоги');

INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, (SELECT id_tp FROM TypePremise WHERE name = 'Бассейн'));
INSERT INTO Premise(invitation, id_tp) VALUES (0, (SELECT id_tp FROM TypePremise WHERE name = 'Зал малый йоги'));
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, (SELECT id_tp FROM TypePremise WHERE name = 'Зал тяжёлой атлетики'));
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, (SELECT id_tp FROM TypePremise WHERE name = 'Зал лёгкой атлетики'));
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, (SELECT id_tp FROM TypePremise WHERE name = 'Зал йоги'));

INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-01-01', '20:00:00', (SELECT id_c FROM Customer WHERE email = 'ivan@gmail.com'), (SELECT id_cl FROM Club WHERE phone = '+375444563321'), (SELECT id_p FROM Premise WHERE id_tp = 2));
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-12-12', '10:00:00', (SELECT id_c FROM Customer WHERE email = 'karina@gmail.com'), (SELECT id_cl FROM Club WHERE phone = '+375444563321'), (SELECT id_p FROM Premise WHERE id_tp = 4));
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-04', '12:00:00', (SELECT id_c FROM Customer WHERE email = 'ivan@gmail.com'), (SELECT id_cl FROM Club WHERE phone = '+375337659000'), (SELECT id_p FROM Premise WHERE id_tp = 5));
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-01-15', '16:00:00', (SELECT id_c FROM Customer WHERE email = 'ivanov@gmail.com'), (SELECT id_cl FROM Club WHERE phone = '+375444563321'), (SELECT id_p FROM Premise WHERE id_tp = 3));
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-11', '17:00:00', (SELECT id_c FROM Customer WHERE email = 'ivanov@gmail.com'), (SELECT id_cl FROM Club WHERE phone = '+375445674499'), (SELECT id_p FROM Premise WHERE id_tp = 2));

INSERT INTO TypeEquipment(name) VALUES ('Атлетика');
INSERT INTO TypeEquipment(name) VALUES ('Степпер');
INSERT INTO TypeEquipment(name) VALUES ('Велотрежанёр');
INSERT INTO TypeEquipment(name) VALUES ('Эллиптические тренажеры (орбитреки)');
INSERT INTO TypeEquipment(name) VALUES ('Гребные тренажеры');

INSERT INTO Equipment(name, id_p, id_te) VALUES ('Степпер-1', (SELECT id_p FROM Premise WHERE id_tp = 1), (SELECT id_te FROM TypeEquipment WHERE name = 'Степпер'));
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантели для аквааэробики', (SELECT id_p FROM Premise WHERE id_tp = 2), (SELECT id_te FROM TypeEquipment WHERE name = 'Атлетика'));
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантеля-500г', (SELECT id_p FROM Premise WHERE id_tp = 3), (SELECT id_te FROM TypeEquipment WHERE name = 'Атлетика'));
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантеля-1кг', (SELECT id_p FROM Premise WHERE id_tp = 3), (SELECT id_te FROM TypeEquipment WHERE name = 'Атлетика'));
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Велотренажер-HMS', (SELECT id_p FROM Premise WHERE id_tp = 4), (SELECT id_te FROM TypeEquipment WHERE name = 'Велотрежанёр'));

UPDATE StreetCus SET name = N'Название улицы' WHERE id_stc = 5;
UPDATE Customer SET surname = N'Фамилия' WHERE id_c = 1;
UPDATE Subscription SET amountVisit = 50 WHERE price = 567;
UPDATE Subscription_Cus SET id_s = 2 WHERE id_sc = 1;
UPDATE StreetClub SET name = N'Название улицы' WHERE id_stcl = 3;
UPDATE Club SET numberHouse = 100 WHERE phone = '+375446758798';
UPDATE TypePremise SET name = N'Новое помещение' WHERE id_tp = 2;
UPDATE Premise SET invitation = 1 WHERE id_p = 2;
UPDATE Visit SET time = (SELECT CONVERT(TIME(0),GETDATE()) AS HourMinuteSecond) WHERE id_v = 2;
UPDATE TypeEquipment SET name = N'Новое тип оборудования' WHERE id_te = 2;
UPDATE Equipment SET name = N'Новое оборудование' WHERE id_e = 1;

DELETE from StreetCus WHERE id_stc = 2;
DELETE from Customer WHERE id_c = 1;
DELETE from Subscription WHERE id_s = 2;
DELETE from Subscription_Cus WHERE id_sc = 1;
DELETE from StreetClub WHERE id_stcl = 1;
DELETE from Club WHERE id_cl = 2;
DELETE from TypePremise WHERE id_tp = 2;
DELETE from Premise WHERE id_p = 1;
DELETE from Visit WHERE id_v = 2;
DELETE from TypeEquipment WHERE id_te = 2;
DELETE from Equipment WHERE id_e = 2;

SELECT * FROM StreetCus;
SELECT * FROM Customer;
SELECT * FROM Subscription;
SELECT * FROM Subscription_Cus;
SELECT * FROM Club;
SELECT * FROM TypePremise;
SELECT * FROM Premise;
SELECT * FROM Visit;
SELECT * FROM TypeEquipment;
SELECT * FROM Equipment;