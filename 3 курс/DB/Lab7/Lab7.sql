drop database if exists SportClub;
GO

create database SportClub;
GO

use SportClub;
GO

DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS TypeEquipment;
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Premise;
DROP TABLE IF EXISTS TypePremise;
DROP TABLE IF EXISTS Club;
DROP TABLE IF EXISTS StreetClub;
DROP TABLE IF EXISTS Subscription_Cus;
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS StreetCus;
DROP VIEW IF EXISTS General_select;
DROP VIEW IF EXISTS Select_sub_cus;
DROP VIEW IF EXISTS Select_equipment;
DROP VIEW IF EXISTS Select_street_club;
DROP VIEW IF EXISTS Street_cus;
DROP VIEW IF EXISTS Type_premise;
DROP VIEW IF EXISTS Type_equipment;

CREATE TABLE StreetCus(
	id_stc INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Customer(
	id_c INTEGER PRIMARY KEY IDENTITY(1, 1),
	surname VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	patronymic VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	phone VARCHAR(255) NOT NULL UNIQUE,
	numberHouse INTEGER NOT NULL,
	numberFlat INTEGER NOT NULL,
	invitation BIT NOT NULL DEFAULT 0,
	id_stc INTEGER NOT NULL,
	FOREIGN KEY (id_stc) REFERENCES StreetCus(id_stc)
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
	FOREIGN KEY(id_s) REFERENCES Subscription(id_s),
	FOREIGN KEY(id_c) REFERENCES Customer(id_c)
);

CREATE TABLE StreetClub(
	id_stcl INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Club(
	id_cl INTEGER PRIMARY KEY IDENTITY(1, 1),
	phone VARCHAR(255) NOT NULL UNIQUE,
	numberHouse INTEGER NOT NULL,
	invitation BIT NOT NULL DEFAULT 1,
	id_stcl INTEGER NOT NULL,
	FOREIGN KEY(id_stcl) REFERENCES StreetClub(id_stcl)
);

CREATE TABLE TypePremise(
	id_tp INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL
);

CREATE TABLE Premise(
	id_p INTEGER PRIMARY KEY IDENTITY(1, 1),
	invitation BIT NOT NULL DEFAULT 1,
	id_tp INTEGER NOT NULL,
	FOREIGN KEY(id_tp) REFERENCES TypePremise(id_tp)
);

CREATE TABLE Visit(
	id_v INTEGER PRIMARY KEY IDENTITY(1, 1),
	date DATE NOT NULL UNIQUE,
	time TIME NOT NULL UNIQUE,
	id_c INTEGER NOT NULL,
	id_cl INTEGER NOT NULL,
	id_p INTEGER NOT NULL,
	FOREIGN KEY(id_c) REFERENCES Customer(id_c),
	FOREIGN KEY(id_cl) REFERENCES Club(id_cl),
	FOREIGN KEY(id_p) REFERENCES Premise(id_p)
);

CREATE TABLE TypeEquipment(
	id_te INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL
);

CREATE TABLE Equipment(
	id_e INTEGER PRIMARY KEY IDENTITY(1, 1),
	name VARCHAR(255) NOT NULL,
	id_p INTEGER NOT NULL,
	id_te INTEGER NOT NULL,
	FOREIGN KEY(id_p) REFERENCES Premise(id_p),
	FOREIGN KEY(id_te) REFERENCES TypeEquipment(id_te)
);

INSERT INTO StreetCus(name) VALUES ('Пушкина');
INSERT INTO StreetCus(name) VALUES ('Притыцкого');
INSERT INTO StreetCus(name) VALUES ('Немига');
INSERT INTO StreetCus(name) VALUES ('Зыбицкая');
INSERT INTO StreetCus(name) VALUES ('Янки Мавра');

INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivan@gmail.com', '+375333333333', 3, 45, 0, 2);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванова', 'Карина', 'Ивановна', 'karina@gmail.com', '+375254565678', 4, 90, 1, 1);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivanov@gmail.com', '+375334567023', 8, 35, 0, 5);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванова', 'Карина', 'Ивановна', 'kar344@gmail.com', '+375255674499', 4, 45, 1, 2);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES ('Иванов', 'Иван', 'Иванович', 'ivan123@gmail.com', '+375332301067', 3, 7, 0, 4);

INSERT INTO Subscription(price, amountVisit, validity) VALUES (99.99, 10, DEFAULT);
INSERT INTO Subscription(price, amountVisit, validity) VALUES (49.99, DEFAULT, '2020-12-01');
INSERT INTO Subscription(price, amountVisit, validity) VALUES (45.77, 8, DEFAULT);
INSERT INTO Subscription(price, amountVisit, validity) VALUES (567, DEFAULT, '2021-10-08');
INSERT INTO Subscription(price, amountVisit, validity) VALUES (343, 40, DEFAULT);

INSERT INTO Subscription_Cus(id_s, id_c) VALUES (1, 1);
INSERT INTO Subscription_Cus(id_s, id_c) VALUES (1, 2);
INSERT INTO Subscription_Cus(id_s, id_c) VALUES (2, 3);
INSERT INTO Subscription_Cus(id_s, id_c) VALUES (4, 4);
INSERT INTO Subscription_Cus(id_s, id_c) VALUES (2, 5);

INSERT INTO StreetClub(name) VALUES ('Пушкина');
INSERT INTO StreetClub(name) VALUES ('Притыцкого');
INSERT INTO StreetClub(name) VALUES ('Янки Мавра');
INSERT INTO StreetClub(name) VALUES ('Немига');
INSERT INTO StreetClub(name) VALUES ('Зыбицкая');

INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375446758798', 56, DEFAULT, 1);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375444563321', 6, 0, 2);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375337659000', 78, DEFAULT, 4);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375253338709', 1, DEFAULT, 5);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES ('+375445674499', 6, 0, 4);

INSERT INTO TypePremise(name) VALUES ('Зал малый йоги');
INSERT INTO TypePremise(name) VALUES ('Бассейн');
INSERT INTO TypePremise(name) VALUES ('Зал тяжёлой атлетики');
INSERT INTO TypePremise(name) VALUES ('Зал лёгкой атлетики');
INSERT INTO TypePremise(name) VALUES ('Зал йоги');

INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 2);
INSERT INTO Premise(invitation, id_tp) VALUES (0, 1);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 3);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 4);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 5);

INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-01-01', '20:00:00', 1, 2, 1);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-12-12', '10:00:00', 2, 2, 4);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-04', '12:00:00', 1, 3, 5);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-01-15', '16:00:00', 3, 2, 3);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-11', '17:00:00', 3, 5, 1);

INSERT INTO TypeEquipment(name) VALUES ('Атлетика');
INSERT INTO TypeEquipment(name) VALUES ('Степперы');
INSERT INTO TypeEquipment(name) VALUES ('Велотрежанёр');
INSERT INTO TypeEquipment(name) VALUES ('Эллиптические тренажеры (орбитреки)');
INSERT INTO TypeEquipment(name) VALUES ('Гребные тренажеры');

INSERT INTO Equipment(name, id_p, id_te) VALUES ('Степпер-1', 2, 2);
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантели для аквааэробики', 1, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантеля-500г', 3, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Гантеля-1кг', 3, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES ('Велотренажер-HMS', 4, 3);

GO
CREATE VIEW General_select AS
	SELECT  c.email AS Почта, c.invitation AS Приглашение, c.[name] AS Имя, c.surname AS Фамилия,
		c.patronymic AS Отчество, CONCAT(' № ', c.numberFlat) AS Квартира, 
		CONCAT(' № ', c.numberHouse) AS Дом, c.phone AS Номер_тел, scus.[name] AS Улица_клиента,
		sc.[name] Улица_клуба, p.invitation AS Посылка, tp.[name] AS Тип_посылки,		
		v.[date] AS Дата, v.time AS Время, cl.invitation AS Приглашения, CONCAT(' № ', cl.numberHouse) AS Номер_дома_клуба, 
		cl.phone AS Номер_телефона_клуба, e.[name] AS Оборудование, sub.amountVisit AS  Количество_визитов, 
		CONCAT(sub.price, ' BYN ') AS Цена, sub.validity AS Срок_действия, te.[name] AS Тип_оборудования
FROM Visit v
	JOIN Club cl ON v.id_cl = cl.id_cl
	JOIN Customer c ON v.id_c = c.id_c
	JOIN Premise p ON v.id_p = p.id_p
	JOIN StreetClub sc ON cl.id_stcl = sc.id_stcl
	JOIN TypePremise tp ON p.id_tp = tp.id_tp
	JOIN StreetCus scus ON c.id_stc = scus.id_stc
	JOIN Equipment e ON e.id_p = p.id_p
	JOIN Subscription_Cus subc ON subc.id_c = c.id_c
	JOIN Subscription sub ON sub.id_s = subc.id_sc
	JOIN TypeEquipment te ON e.id_te = te.id_te
GO
SELECT * FROM General_select;

GO
CREATE VIEW Select_street_club AS 
	SELECT  CONCAT(' № ', c.numberHouse) AS Номер_дома_клуба, c.phone AS Номер_телефона_клуба,
			sc.[name] AS Улица_клуба, c.invitation AS Приглашения
FROM Club c
 JOIN StreetClub sc ON c.id_stcl = sc.id_stcl	
GO
SELECT * FROM Select_street_club;

GO
CREATE VIEW Street_cus AS 
	SELECT  c.[name] AS Имя, c.surname AS Фамилия,
			c.patronymic AS Отчество, c.email AS Почта, CONCAT(' № ', c.numberFlat) AS Квартира, 
			CONCAT(' № ',c.numberHouse) AS Дом, c.phone AS Номер_тел, c.invitation AS Приглашения,
			sc.[name] AS Улица_клуба
FROM Customer c
 JOIN StreetCus sc ON c.id_stc = sc.id_stc
GO
SELECT * FROM Street_cus;

GO
CREATE VIEW Type_premise AS  
SELECT p.invitation AS Приглашения, tp.[name] AS Тип FROM Premise p
		JOIN TypePremise tp ON p.id_tp = tp.id_tp
GO
SELECT * FROM Type_premise;

GO
CREATE VIEW Type_equipment AS  
SELECT e.[name] AS Оборудование, te.[name] AS Тип_оборудование FROM Equipment e
		JOIN TypeEquipment te ON e.id_te = te.id_te
GO
SELECT * FROM Type_equipment;




--22