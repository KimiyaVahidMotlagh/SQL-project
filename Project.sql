DROP TABLE DaneshjODarse;
DROP TABLE Darse;
DROP TABLE Danshgo;
DROP TABLE Ostad;

DROP VIEW ProfessorCoursesView;
DROP VIEW StudentCoursesView;

CREATE TABLE Ostad (
	OstadID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	Department VARCHAR(255) 
);

CREATE TABLE Danshgo (
	DaneshgoID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	DanshgoMajor VARCHAR(255),
	PhoneNumber VARCHAR(255)
);

CREATE TABLE Darse (
	DarseID INT PRIMARY KEY IDENTITY,
	DarseName VARCHAR(255) NOT NULL,
	OstadID INT REFERENCES Ostad(OstadID),
);

CREATE TABLE DaneshjODarse (
	DDID INT PRIMARY KEY IDENTITY,
	DaneshgoID INT REFERENCES Danshgo(DaneshgoID),
	DarseID INT REFERENCES Darse(DarseID),
);

INSERT INTO Ostad (FirstName, LastName, Email, Department) VALUES
('Ali', 'Karimi', 'A.K@Ex.com', 'CE'),
('Sara', 'Ahmadi', 'S.A@Ex.com', 'Math'),
('Mehdi', 'Rezayee', 'M.R@Ex.com', 'Physics'),
('Sheis', 'Abolmaali', 'Sh.A@Ex.com', 'CE'),
('Dalile', 'Motlagh', 'A.M@Ex.com', 'Art'),
('Raziyee', 'Rezayee', 'R.R@Ex.com', 'Litriture'),
('Sara', 'Davodi', 'S.D@Ex.com', 'CE'),
('Fateme', 'Mali', 'F.M@Ex.com', 'Physics'),
('Yeghane', 'Abotalebi', 'Y.A@Ex.com', 'Physics'),
('Dalileh', 'Rashidi', 'D.R@Ex.com', 'CE')
;


INSERT INTO Danshgo (FirstName, LastName, Email, DanshgoMajor, PhoneNumber) VALUES
('Maryam', 'Eskandaryan', 'M.E@Ex.com', 'CE', '09000000000'),
('Kimiya', 'VahidMotlagh', 'K.VM@Ex.com', 'CE', '09050000000'),
('Yeghane', 'Rezayee', 'Y.R@Ex.com', 'CE', '09000000000'),
('Maedeh', 'Mehrbod', 'M.M@Ex.com', 'CE', '09000000000'),
('Yeghane', 'EtemadiFar', 'Y.E@Ex.com', 'CE', '09000000000'),
('Fatemeh', 'Nariman', 'F.N@Ex.com', 'CE', '09000000000'),
('Fatemeh', 'Shaheb', 'F.Sh@Ex.com', 'CE', '09000000000'),
('Fatemeh', 'Bahrami', 'F.B@Ex.com', 'CE', '09000000000'),
('Fatezeh', 'Bozorghi', 'F.B@Ex.com', 'CE', '09000000000'),
('Ali', 'Hossaini', 'A.H@Ex.com', 'CE', '09000000000')
;

INSERT INTO Darse (DarseName, OstadID) VALUES
('Az Payghah Dade', 2),
('Madar Elec', 3),
('Logic Madar', 4),
('Tennis', 5),
('Tejarat', 2),
('Az Madar Manteghi', 8),
('Rayanesh', 6),
('Mathematics', 2),
('Physics', 9),
('Litriture', 5)
;

INSERT INTO DaneshjODarse (DaneshgoID, DarseID) VALUES
(1, 1),
(2, 2),
(3, 4),
(5, 4),
(7, 2),
(9, 1),
(5, 7),
(8, 8),
(4, 9),
(2, 8)
;

--SELECT

SELECT * FROM Ostad;
SELECT FirstName AS Name, LastName AS Family
	FROM Ostad
	WHERE Department ='CE'
	ORDER BY LastName;


--GROUP BY

SELECT Darse.DarseName, COUNT(DaneshjODarse.DaneshgoID) AS StudentCount
	FROM Darse
	LEFT JOIN DaneshjODarse ON DaneshjODarse.DarseID = Darse.DarseID
	GROUP BY Darse.DarseName
	HAVING COUNT(DaneshjODarse.DaneshgoID)>=1;


--JOIN

SELECT Danshgo.FirstName, Danshgo.LastName, Darse.DarseName
	FROM Danshgo
	LEFT JOIN DaneshjODarse ON DaneshjODarse.DaneshgoID = Danshgo.DaneshgoID
	LEFT JOIN Darse ON Darse.DarseID = DaneshjODarse.DarseID;

--SUBQUERY

SELECT FirstName, LastName
	FROM Danshgo
	WHERE DaneshgoID IN (
		SELECT DaneshgoID
		FROM DaneshjODarse 
		WHERE DarseID = (
			SELECT DarseID
			FROM Darse
			WHERE DarseName= 'Mathematics')
	);


--TRANACTION

BEGIN TRANSACTION;
BEGIN TRY
	
	INSERT INTO DaneshjODarse (DaneshgoID, DarseID) VALUES
	(3, 3)

	COMMIT;
END TRY
BEGIN CATCH
	ROLLBACK;
	PRINT 'Error in transaction:' + ERROR_MESSAGE();
END CATCH;


--VEIW
create view ProfessorCoursesView as
select
o.OstadID,
o.FirstName + ' ' + o.LastName as
ProfessorFullName,
o.Email as professorEmail,
o.Department,
d.DarseID,
d.DarseName,
COUNT (dd.DaneshgoID) AS
StudentCount 
from
Ostad o
LEFT JOIN
Darse d on o.OstadID = d.DarseID
LEFT join 
DaneshjODarse dd on d.DarseID = dd.DarseID
GROUP BY
o.OstadID, o.FirstName,o.LastName,o.Email,o.Department,d.DarseID,d.DarseName;


CREATE VIEW StudentCoursesView as 
select
dj.DaneshgoID,
dj.FirstName + ' ' +dj.LastName as
StudentfullName,
dj.Email as StudentEmail,
dj.DanshgoMajor as Major,
dj.PhoneNumber,
d.DarseID,
d.DarseName,
o.FirstName + ' ' +o.LastName as ProfessorName

from 
Danshgo dj
 join 
 DaneshjODarse dd on dj.DaneshgoID =dd.DaneshgoID
 join
 Darse d on dd.DarseID =d.DarseID
 join 
 Ostad o on d.OstadID = o.OstadID;



SELECT * FROM ProfessorCoursesView;
SELECT * FROM StudentCoursesView WHERE 
Major = 'CE';

--USERMANAGMENT

CREATE LOGIN ProfessorLogin WITH 
Password = 'pro1234';
CREATE USER ProfessorAhmadi for LOGIN ProfessorLogin;

CREATE LOGIN StudentLogin WITH 
PASSWORD = 'ST1234';
CREATE USER StudentRezayee FOR LOGIN StudentLogin;

GRANT SELECT,UPDATE ON Ostad TO ProfessorAhmadi;

GRANT SELECT,INSERT,UPDATE ON Darse TO ProfessorAhmadi;

GRANT SELECT ON DaneshjODarse TO ProfessorAhmadi;

GRANT SELECT ON Danshgo TO ProfessorAhmadi;
GRANT CREATE VIEW TO ProfessorAhmadi;

---------------------------------------------
GRANT SELECT ON Danshgo TO StudentRezayee;
GRANT SELECT ON Darse TO StudentRezayee;
GRANT SELECT,INSERT ON DaneshjODarse TO StudentRezayee;



EXECUTE AS USER = 'ProfessorAhmadi';
GO
SELECT * FROM Ostad;
GO
INSERT INTO Darse(DarseName,OstadID)
VALUES ('PAYEGAH DADE', 1);
GO
SELECT * FROM Danshgo;
go
delete from Danshgo where DaneshgoID =1;
go
REVERT;
--------------------------------------------
EXECUTE AS USER = 'StudentRezayee';
GO
INSERT INTO DaneshjODarse (DaneshgoID,DarseID)
VALUES (1,1);
GO

SELECT * FROM Danshgo;
go
SELECT * from Danshgo where DaneshgoID =1;
go
CREATE TABLE TESTTABLE (ID INT);
GO
REVERT;



