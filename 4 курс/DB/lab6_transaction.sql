--create database SportClub;
--GO

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

CREATE TABLE StreetCus(
	id_stc INTEGER PRIMARY KEY IDENTITY(1, 1),
	name NVARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Customer(
	id_c INTEGER PRIMARY KEY IDENTITY(1, 1),
	surname NVARCHAR(255) NOT NULL,
	name NVARCHAR(255) NOT NULL,
	patronymic NVARCHAR(255) NOT NULL,
	email NVARCHAR(255) NOT NULL UNIQUE,
	phone NVARCHAR(255) NOT NULL UNIQUE,
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
	[name] NVARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Club(
	id_cl INTEGER PRIMARY KEY IDENTITY(1, 1),
	phone NVARCHAR(255) NOT NULL UNIQUE,
	numberHouse INTEGER NOT NULL,
	invitation BIT NOT NULL DEFAULT 1,
	id_stcl INTEGER NOT NULL,
	FOREIGN KEY(id_stcl) REFERENCES StreetClub(id_stcl)
);

CREATE TABLE TypePremise(
	id_tp INTEGER PRIMARY KEY IDENTITY(1, 1),
	name NVARCHAR(255) NOT NULL
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
	name NVARCHAR(255) NOT NULL
);

CREATE TABLE Equipment(
	id_e INTEGER PRIMARY KEY IDENTITY(1, 1),
	name NVARCHAR(255) NOT NULL,
	id_p INTEGER NOT NULL,
	id_te INTEGER NOT NULL,
	FOREIGN KEY(id_p) REFERENCES Premise(id_p),
	FOREIGN KEY(id_te) REFERENCES TypeEquipment(id_te)
);

INSERT INTO StreetCus(name) VALUES (N'�������');
INSERT INTO StreetCus(name) VALUES (N'����������');
INSERT INTO StreetCus(name) VALUES (N'������');
INSERT INTO StreetCus(name) VALUES (N'��������');
INSERT INTO StreetCus(name) VALUES (N'���� �����');

INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES (N'������', N'����', N'��������', N'ivan@gmail.com', N'+375333333333', 3, 45, 0, 2);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES (N'�������', N'������', N'��������', N'karina@gmail.com', N'+375254565678', 4, 90, 1, 1);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES (N'������', N'����', N'��������', N'ivanov@gmail.com', N'+375334567023', 8, 35, 0, 5);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES (N'�������', N'������', N'��������', N'kar344@gmail.com', N'+375255674499', 4, 45, 1, 2);
INSERT INTO Customer(surname, name, patronymic, email, phone, numberHouse, numberFlat, invitation, id_stc)
VALUES (N'������', N'����', N'��������', N'ivan123@gmail.com', N'+375332301067', 3, 7, 0, 4);

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

INSERT INTO StreetClub([name]) VALUES (N'�������');
INSERT INTO StreetClub([name]) VALUES (N'����������');
--INSERT INTO StreetClub([name]) VALUES (N'����������');
INSERT INTO StreetClub([name]) VALUES (N'������');
INSERT INTO StreetClub([name]) VALUES (N'��������');

INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES (N'+375446758798', 56, DEFAULT, 1);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES (N'+375444563321', 6, 0, 2);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES (N'+375337659000', 78, DEFAULT, 4);
--INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES (N'+375253338709', 1, DEFAULT, 5);
INSERT INTO Club(phone, numberHouse, invitation, id_stcl) VALUES (N'+375445674499', 6, 0, 4);

INSERT INTO TypePremise(name) VALUES (N'��� ����� ����');
INSERT INTO TypePremise(name) VALUES (N'�������');
INSERT INTO TypePremise(name) VALUES (N'��� ������ ��������');
INSERT INTO TypePremise(name) VALUES (N'��� ����� ��������');
INSERT INTO TypePremise(name) VALUES (N'��� ����');

INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 2);
INSERT INTO Premise(invitation, id_tp) VALUES (0, 1);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 3);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 4);
INSERT INTO Premise(invitation, id_tp) VALUES (DEFAULT, 5);

INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-06-01', '20:00:00', 1, 2, 1);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-12-12', '10:00:00', 2, 2, 4);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-04', '12:00:00', 1, 3, 5);
INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2020-05-15', '16:00:00', 3, 2, 3);
--INSERT INTO Visit(date, time, id_c, id_cl, id_p) VALUES ('2021-03-11', '17:00:00', 3, 5, 1);

INSERT INTO TypeEquipment(name) VALUES (N'��������');
INSERT INTO TypeEquipment(name) VALUES (N'��������');
INSERT INTO TypeEquipment(name) VALUES (N'�����������');
INSERT INTO TypeEquipment(name) VALUES (N'������������� ��������� (���������)');
INSERT INTO TypeEquipment(name) VALUES (N'������� ���������');

INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1', 2, 2);
INSERT INTO Equipment(name, id_p, id_te) VALUES (N'������� ��� ������������', 1, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-500�', 3, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1��', 3, 1);
INSERT INTO Equipment(name, id_p, id_te) VALUES (N'������������-HMS', 4, 3);


--�����
TRUNCATE TABLE Equipment
BEGIN TRY
BEGIN TRAN
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1', 2, 2);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'������� ��� ������������', 1, 1);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-500�', 3, 1);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1��', 3, 1);
COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH

SELECT * FROM Equipment;


--�������
SET IMPLICIT_TRANSACTIONS ON
GO
INSERT INTO Equipment(name, id_p, id_te) VALUES (N'���������', 4, 3);
GO
SELECT @@TRANCOUNT AS �������
GO
ROLLBACK TRAN
SELECT @@TRANCOUNT AS �������
SET IMPLICIT_TRANSACTIONS OFF


--���������
TRUNCATE TABLE Equipment
PRINT '���������� ���������� ' + CONVERT(CHAR, @@TRANCOUNT)
BEGIN TRAN insert1
	PRINT '������ ���������� � ���������� '
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1', 2, 2);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'������� ��� ������������', 1, 1);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-500�', 3, 1);
	INSERT INTO Equipment(name, id_p, id_te) VALUES (N'�������-1��', 3, 1);
	BEGIN TRAN insert2
		PRINT '������ ���������� � ���������� '
		INSERT INTO Equipment(name, id_p, id_te) VALUES (N'���������', 33, 3);
	COMMIT TRAN
COMMIT TRAN
PRINT '���������� ���������� ' + CONVERT(CHAR, @@TRANCOUNT)

SELECT * FROM Equipment;

DROP FUNCTION IF EXISTS f1;
GO
CREATE FUNCTION f1(@inv BIT)
RETURNS TABLE AS
RETURN(
	SELECT * FROM dbo.Customer 
	WHERE invitation = @inv
);
GO

DROP FUNCTION IF EXISTS f2;
GO
CREATE FUNCTION f2()
RETURNS INT AS
BEGIN
	DECLARE @sum INT;
	SET @sum = (SELECT SUM(price) FROM dbo.Subscription_Cus sc
			JOIN dbo.Subscription s ON s.id_s = sc.id_s);
	RETURN @sum;
END;
GO

DROP FUNCTION IF EXISTS f3;
GO
CREATE FUNCTION f3(@name NVARCHAR(255))
RETURNS TABLE AS
RETURN(
	SELECT * FROM dbo.Customer 
	WHERE name = @name
);
GO

SELECT * FROM dbo.f1(0);
SELECT dbo.f2() AS '�������';
SELECT * FROM dbo.f3('������');