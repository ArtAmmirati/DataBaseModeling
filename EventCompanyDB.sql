USE MASTER;
if (select count(*) 
    from sys.databases where name = 'EventCompanyDB') > 0
BEGIN
    DROP DATABASE EventCompanyDB  	
END	
	Print 'EventCompanyDB Dropped'
Begin
	CREATE DATABASE EventCompanyDB
	
End
	Print 'EventCompanyDB Created'
Go
USE EventCompanyDB
GO -- Database was checked if existed, if the answer was yes, it was dropped then recreated
CREATE TABLE [MEMBERS] (
	MemberID int NOT NULL IDENTITY(1,1),
	MemberNumber nvarchar(75) NOT NULL, 
	FirstName nvarchar(75) NOT NULL,
	MiddleName nvarchar(75) NOT NULL,
	LastName nvarchar(75) NOT NULL,
	Phone nvarchar (15) NOT NULL,
	Gender nvarchar(10) NOT NULL,
	Email nvarchar(75) NOT NULL,
	DOB nvarchar(50) NOT NULL,
	Joined nvarchar(50) NOT NULL,
	[Current] nvarchar(10) NOT NULL,
	Subscription nvarchar(25) Not Null,
	PlanID int NOT NULL
	
  PRIMARY KEY  (MEMBERID),
   CHECK ([Current] in ('YES','NO')),
   CHECK (Subscription in ('Monthly', 'Quarterly', 'Yearly', 'Biennial')),
   CONSTRAINT UC_MemNum UNIQUE (MemberNumber)
)
-- Members table created and has two checks one for current members as yes/no
-- and one for checking the subscription as monthly, quarterly, yearly, biennially
-- Member Number was made UNIQUE so they cant be duplicateed
GO
CREATE TABLE [ADDRESSES] (
	AddressID int NOT NULL IDENTITY (1,1),
	MemberID int NOT NULL,
	AddressLine1 nvarchar(75) NOT NULL,
	AddressLine2 nvarchar(75) NOT NULL,
	StateProvance nvarchar(75) NOT NULL,
	PostalCode nvarchar(10) NOT NULL,
	AddressType nvarchar(75) NOT NULL,
  PRIMARY KEY  (AddressID)  
)
-- address table was created with address id as the primary key
GO
CREATE TABLE [CREDIT_CARDS] (
	CreditCardID int NOT NULL IDENTITY(1,1),
	MemberID int NOT NULL,
	CardType nvarchar(75) NOT NULL,
	CardNumber nvarchar(75) NOT NULL,
	SecurityCode int NOT NULL,
	ExpireDate nvarchar (50) NOT NULL,
   PRIMARY KEY  (CreditCardID)
)
-- creditd card table created with primary key as credit card id
GO
CREATE TABLE INTERESTS (
	InterestID int NOT NULL IDENTITY(1,1),
	MemberID int NOT NULL,
	Interest1 nvarchar(256) NOT NULL,
	Interest2 nvarchar(256) NOT NULL,
	Interest3 nvarchar(256) NOT NULL,
   PRIMARY KEY (InterestID)
)
-- interests table was created with interest id as primary key
GO
CREATE TABLE [ATTENDEES] (
	AttendeeID int NOT NULL IDENTITY(1,1),
	EventID int NOT NULL,
	MemberID int NOT NULL,
  PRIMARY KEY (AttendeeID)
)
GO
CREATE TABLE [EVENTS] (
	EventID int NOT NULL IDENTITY(1,1),
	Title nvarchar(256) NOT NULL,
	Lecturer nvarchar(256) NOT NULL,
	DateOfEvent nvarchar (50) NOT NULL,
  PRIMARY KEY (EventID)
)
GO
CREATE TABLE [TRANSACTIONS] (
	TransactionID int NOT NULL IDENTITY(1,1),
	CreditCardID int NOT NULL,
	TransDate nvarchar (50) NOT NULL,
	Amount smallmoney NOT NULL,
	CreditCardResults nvarchar(50) NOT NULL,
  PRIMARY KEY (TransactionID),
  CHECK (CreditCardResults in ('Approved','Declined','Invalid', 'Pending'))
)

-- Transactions table has a check for credit card results as approved, declined, invalid, pending
GO
CREATE TABLE [PLAN_FEES] (
	PlanID int NOT NULL IDENTITY(1,1),
	PymtPlans nvarchar(25) NOT NULL,
	PlanRates smallmoney NOT NULL,
  PRIMARY KEY (PlanID)
)
GO
CREATE TABLE [NOTES] (
	NoteID int NOT NULL IDENTITY(1,1),
	MemberID int NOT NULL,
	Notes nvarchar(MAX) NOT NULL,
   PRIMARY KEY (NoteID)
)
GO --Members Password Table created with a primary key of PasswordID and a UNIQUE constraint
-- on the memberID to prevent any member from being input with 2 passwords

CREATE TABLE [MEMBERPASSWORD](
	[PasswordID] int NOT NULL IDENTITY(1,1),
	MemberID int NOT NULL, 
	PasswordHash Nvarchar(60) NOT NULL,
	ChangedDate date not null DEFAULT GETDATE(),
	LoginName NVARCHAR(60) NOT NULL,
   PRIMARY KEY (PasswordID),
   CONSTRAINT UC_MembID UNIQUE (MemberID)
	)
--===========================================================
--below are all the inserts for the above tables

GO
INSERT INTO PLAN_FEES (PymtPlans, PlanRates)
	VALUES
		('Monthly', 9.99),('Quarterly', 27.00),('Annually', 99.00),('Biennial',189.00),('FREE',0.00)
GO
INSERT INTO NOTES (MemberID,Notes)
	VALUES
		(1,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(2,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(3,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(4,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(5,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(6,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(7,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(8,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(9,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(10,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(11,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(12,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(13,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(14,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
		(15,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id');
GO
INSERT INTO [dbo].[MEMBERS]
           ([MemberNumber],[FirstName],[MiddleName],[LastName],[Phone]
           ,[Gender],[Email],[DOB],[Joined],[Current],[Subscription],[PlanID]
           )
     VALUES
			('M0001','Otis','Brooke','Fallon','818-873-3863','Male','bfallon0@artisteer.com','June 29, 1971','April 7, 2017','Yes','Monthly',1),
			('M0002','Katee','Virgie','Gepp','503-689-8066','Female','vgepp1@nih.gov','April 3, 1972','November 29, 2017','Yes','Monthly',1),
			('M0003','Lilla','Charmion','Eatttok','210-426-7426','Female','ceatttok2@google.com.br','December 13, 1975','February 26, 2017','Yes','Quarterly',2),
			('M0004','Ddene','Shelba','Clapperton','716-674-1640','Female','sclapperton3@mapquest.com','February 19, 1997','November 5, 2017','Yes','Quarterly',2),
			('M0005','Audrye','Agathe','Dawks','305-415-9419','Female','adawks4@mlb.com','February 7, 1989','January 15, 2016','Yes','Monthly',1),
			('M0006','Fredi','Melisandra','Burgyn','214-650-9837','Female','mburgyn5@cbslocal.com','May 31, 1956','March 13, 2017','Yes','Yearly',3),
			('M0007','Dimitri','Francisco','Bellino','937-971-1026','Male','fbellino6@devhub.com','October 12, 1976','August 9, 2017','Yes','Monthly',1),
			('M0008','Enrico','Cleve','Seeney','407-445-6895','Male','cseeney7@macromedia.com','February 29, 1988','September 9, 2016','Yes','Yearly',3),
			('M0009','Marylinda','Jenine','OSiaghail','206-484-6850','Female','josiaghail8@tuttocitta.it','February 6, 1965','November 21, 2016','No','Yearly',3),
			('M0010','Luce','Codi','Kovalski','253-159-6773','Male','ckovalski9@facebook.com','March 31, 1978','December 22, 2017','Yes','Monthly',1),
			('M0011','Claiborn','Shadow','Baldinotti','253-141-4314','Male','sbaldinottia@discuz.net','December 26, 1991','March 19, 2017','Yes','Monthly',1),
			('M0012','Isabelle','Betty','Glossop','412-646-5145','Female','bglossopb@msu.edu','February 17, 1965','April 25, 2016','Yes','Quarterly',2),
			('M0013','Davina','Lira','Wither','404-495-3676','Female','lwitherc@smugmug.com','December 16, 1957','March 21, 2016','Yes','Yearly',3),
			('M0014','Panchito','Hashim','De Gregorio','484-717-6750','Male','hdegregoriod@a8.net','October 14, 1964','January 27, 2017','Yes','Monthly',1),
			('M0015','Rowen','Arvin','Birdfield','915-299-3451','Male','abirdfielde@over-blog.com','January 9, 1983','October 6, 2017','No','Monthly',1)

GO
INSERT INTO [dbo].[ADDRESSES]
           ([MemberID]
           ,[AddressLine1]
           ,[AddressLine2]
           ,[StateProvance]
           ,[PostalCode]
           ,[AddressType])
     VALUES
          
			(1,'020 New Castle Way','Port Washington','New York','11054','MAILING'),		
			(2,'8 Corry Parkway','Newton','Massachusetts','2458','MAILING'),		
			(3,'39426 Stone Corner Drive','Peoria','Illinois','61605','MAILING'),		
			(4,'921 Granby Junction','Oklahoma City','Oklahoma','73173','MAILING'),			
			(5,'77 Butternut Parkway','Saint Paul','Minnesota','55146','MAILING'),			
			(6,'821 Ilene Drive','Odessa','Texas','79764','MAILING'	),	
			(7,'1110 Johnson Court','Rochester','New York','14624','MAILING'),		
			(8,'6 Canary Hill','Tallahassee','Florida','32309','MAILING'),		
			(9,'9 Buhler Lane','Bismarck','North Dakota','58505','MAILING'),			
			(10,'99 Northwestern Pass','Midland','Texas','79710','MAILING'	),		
			(11,'69 Spenser Hill','Provo','Utah','84605','MAILING'),	
			(12,'3234 Kings Court','Tacoma','Washington','98424','MAILING'),		
			(13,'3 Lakewood Gardens Circle','Columbia','South Carolina','29225','MAILING'),		
			(14,'198 Muir Parkway','Fairfax','Virginia','22036','MAILING'),			
			(15,'258 Jenna Drive','Pensacola','Florida','32520','MAILING'),
			(4,'P.O. Box 7088','Newton','Massachusetts','2458','BILLING'),			
			(8,'P.O. Box 255','Tallahassee','Florida','32309','BILLING'),			
			(12,'P.O. Box 1233','Tacoma','Washington','98424','BILLING');			
		
INSERT INTO [dbo].[EVENTS]
           ([Title]
           ,[Lecturer]
           ,[DateOfEvent])
     VALUES			
			('"The History of Human Emotions"','Tiffany Watt Smith','42747')
			,('"How Great Leaders Inspire Action"','Simon Sinek','42788')
			,('"The Puzzle of Motivation"','Dan Pink','42799')
			,('"Your Elusive Creative Genius"','Elizabeth Gilbert','42841')
			,('"Why are Programmers So Smart?"','Andrew Comeau','42856')

INSERT INTO [dbo].[ATTENDEES]
           ([EventID]
           ,[MemberID])
     VALUES	
			(1,2),(1,3),(1,4),(1,5),(1,6),(1,8),(1,10),(1,11),(1,12),(1,13),(1,15)
			,(2,3),(2,4),(2,5),(2,7),(2,8),(2,9),(2,10),(2,11),(2,13),(2,14),(2,15)
			,(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,12),(3,14),(3,15)
			,(4,1),(4,2),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,12),(4,14),(4,15)
			,(5,1),(5,3),(5,4),(5,12),(5,13)

INSERT INTO [dbo].[CREDIT_CARDS]
           ([MemberID]
           ,[CardType]
           ,[CardNumber]
           ,[SecurityCode]
           ,[ExpireDate])
     VALUES
			(1,'americanexpress','337941553240515','1234','43709')
			,(2,'visa','4041372553875903','1234','43858')
			,(3,'visa','4041593962566','1234','43552')
			,(4,'jcb','3559478087149594','1234','43585')
			,(5,'jcb','3571066026049076','1234','43302')
			,(6,'diners-club-carte-blanche','30423652701879','1234','43230')
			,(7,'jcb','3532950215393858','1234','43523')
			,(8,'jcb','3569709859937370','1234','43544')
			,(9,'jcb','3529188090740670','1234','43588')
			,(10,'jcb','3530142576111598','1234','43773')
			,(11,'mastercard','5108756299877313','1234','43311')
			,(12,'jcb','3543168150106220','1234','43273')
			,(13,'jcb','3559166521684728','1234','43754')
			,(14,'diners-club-carte-blanche','30414677064054','1234','43262')
			,(15,'jcb','3542828093985763','1234','43914')

		
INSERT INTO [dbo].[INTERESTS]
           ([MemberID]
           ,[Interest1]
           ,[Interest2]
           ,[Interest3])
     VALUES
				
			 (1,'Acting','Video Games','Crossword Puzzles')			
			,(2,'Calligraphy','NULL','NULL')			
			,(3,'Movies','Restaurants','Woodworking')			
			,(4,'Juggling','Quilting','NULL')			
			,(5,'Electronics','NULL','NULL')			
			,(6,'Sewing','Cooking','Movies')			
			,(7,'Botany','Skating','NULL')			
			,(8,'Dancing','Coffee','Foreign Languages')			
			,(9,'Fashion','NULL','NULL')			
			,(10,'Woodworking','NULL','NULL')			
			,(11,'Homebrewing','Geneology','Movies, Scrapbooking')			
			,(12,'Surfing','Amateur Radio','NULL')			
			,(13,'Computers','NULL','NULL')			
			,(14,'Writing','Singing','NULL')			
			,(15,'Reading','Pottery','NULL')			

INSERT INTO [dbo].[TRANSACTIONS]
           ([CreditCardID]
           ,[TransDate]
           ,[Amount]
           ,[CreditCardResults])
     VALUES				
				('1','42832','9.99','Approved'),		
				('1','42862','9.99','Approved'),		
				('1','42893','9.99','Declined'),		
				('1','42894','9.99','Approved'),		
				('1','42923','9.99','Approved'),		
				('1','42954','9.99','Approved'),		
				('1','42985','9.99','Approved'),		
				('1','43015','9.99','Approved'),		
				('1','43046','9.99','Approved'),		
				('1','43076','9.99','Approved'),		
				('1','43107','9.99','Approved'),		
				('2','43068','9.99','Approved'),		
				('2','43098','9.99','Approved'),		
				('3','42792','27','Approved'),		
				('3','42881','27','Approved'),		
				('3','42973','27','Approved'),		
				('3','43065','27','Declined'),		
				('3','43066','27','Approved'),		
				('4','43044','27','Approved'),		
				('5','42384','9.99','Approved'),		
				('5','42415','9.99','Approved'),		
				('5','42444','9.99','Approved'),		
				('5','42475','9.99','Approved'),		
				('5','42505','9.99','Approved'),		
				('5','42536','9.99','Approved'),		
				('5','42566','9.99','Approved'),		
				('5','42597','9.99','Approved'),		
				('5','42628','9.99','Approved'),		
				('5','42658','9.99','Approved'),		
				('5','42689','9.99','Approved'),		
				('5','42719','9.99','Approved'),		
				('5','42750','9.99','Approved'),		
				('5','42781','9.99','Approved'),		
				('5','42809','9.99','Approved'),		
				('5','42840','9.99','Approved'),		
				('5','42870','9.99','Approved'),		
				('5','42901','9.99','Approved'),		
				('5','42931','9.99','Approved'),		
				('5','42962','9.99','Approved'),		
				('5','42993','9.99','Approved'),		
				('5','43023','9.99','Approved'),		
				('5','43054','9.99','Approved'),		
				('5','43084','9.99','Approved'),		
				('5','43115','9.99','Approved'),		
				('6','42807','99','Approved'),		
				('7','42956','9.99','Approved'),		
				('7','42987','9.99','Approved'),		
				('7','43017','9.99','Approved'),		
				('7','43048','9.99','Approved'),		
				('7','43078','9.99','Approved'),		
				('7','43109','9.99','Approved'),		
				('8','42622','99','Approved'),		
				('8','42987','99','Approved'),		
				('9','42695','99','Approved'),		
				('10','43091','9.99','Approved'),		
				('10','43122','9.99','Approved'),		
				('11','42813','9.99','Approved'),		
				('11','42844','9.99','Approved'),		
				('11','42874','9.99','Approved'),		
				('11','42905','9.99','Approved'),		
				('11','42935','9.99','Declined'),		
				('11','42936','9.99','Approved'),		
				('11','42966','9.99','Approved'),		
				('11','42997','9.99','Approved'),		
				('11','43027','9.99','Approved'),		
				('11','43058','9.99','Approved'),		
				('11','43088','9.99','Approved'),		
				('11','43119','9.99','Approved'),		
				('12','42485','27','Approved'),		
				('12','42576','27','Approved'),		
				('12','42668','27','Approved'),		
				('12','42760','27','Approved'),		
				('12','42850','27','Approved'),		
				('12','42941','27','Approved'),		
				('12','43033','27','Approved'),		
				('12','43125','27','Approved'),		
				('13','42450','99','Approved'),		
				('13','42481','99','Approved'),		
				('14','42762','9.99','Approved'),		
				('14','42793','9.99','Approved'),		
				('14','42821','9.99','Approved'),		
				('14','42852','9.99','Approved'),		
				('14','42882','9.99','Approved'),		
				('14','42913','9.99','Approved'),		
				('14','42943','9.99','Approved'),		
				('14','42974','9.99','Approved'),		
				('14','43005','9.99','Approved'),		
				('14','43035','9.99','Approved'),		
				('14','43066','9.99','Approved'),		
				('14','43096','9.99','Approved'),		
				('14','43127','9.99','Approved'),		
				('15','43014','9.99','Invalid ')	

--================Constraints==================

-- below are all my foreign key additions to the above tables

GO
ALTER TABLE Notes			ADD CONSTRAINT FK_NoteMember	 FOREIGN KEY (MemberID)     REFERENCES Members(MemberID);
ALTER TABLE Transactions	ADD CONSTRAINT FK_TransCC		 FOREIGN KEY (CreditCardID) REFERENCES Credit_Cards(CreditCardID);
ALTER TABLE Attendees		ADD CONSTRAINT FK_AttdEvent		 FOREIGN KEY (EventID)      REFERENCES [Events](EventID);
ALTER TABLE Attendees		ADD CONSTRAINT FK_AttdMemb		 FOREIGN KEY (MemberID)     REFERENCES Members(MemberID);
ALTER TABLE Interests		ADD CONSTRAINT FK_IntrdMemb		 FOREIGN KEY (MemberID)     REFERENCES Members(MemberID);
ALTER TABLE Credit_Cards	ADD CONSTRAINT FK_CCMemb		 FOREIGN KEY (MemberID)     REFERENCES Members(MemberID);
ALTER TABLE Addresses		ADD CONSTRAINT FK_AddrMemb		 FOREIGN KEY (MemberID)     REFERENCES Members(MemberID);
ALTER TABLE Members			ADD CONSTRAINT FK_MembPlan       FOREIGN KEY (PlanID)       REFERENCES Plan_Fees(PlanID);
ALTER TABLE MemberPassword  ADD CONSTRAINT FK_MembPass		 FOREIGN KEY (MemberID)		REFERENCES Members(MemberID);

--======================Updates===================================
-- had trouble with converting the exel time to sql time. 
-- Needed to run some update statements to allow my squence to function properly.
-- first conversion of excel date wast to datetime, then another to data type date
-- some other problems arose in regards to the Members, credit card, events and transaction tables
-- so those were cast to smalldatetimt after subtraction of 2. then anothe cast to date
-- Not 100% sure why i could not use the same syntax for all, but they work as needed for all functions
UPDATE MEMBERS
SET DOB = CONVERT(NVARCHAR(50),CONVERT(datetime, dob,101))
ALTER TABLE members
ALTER COLUMN dob DATETIME

UPDATE MEMBERS
SET DOB = CONVERT(datetime,CONVERT(date, dob,101))
ALTER TABLE members
ALTER COLUMN dob DATE
--======================================================

UPDATE MEMBERS
SET Joined = CONVERT(NVARCHAR(50),CONVERT(datetime, Joined,101))
ALTER TABLE MEMBERS
ALTER COLUMN JOINED DATETIME

UPDATE MEMBERS
SET Joined = CONVERT(datetime,CONVERT(date, Joined,101))
ALTER TABLE MEMBERS
ALTER COLUMN JOINED DATE

--=========================================================

UPDATE CREDIT_CARDS
SET ExpireDate = CONVERT(NVARCHAR(50),cast(ExpireDate - 2 as smalldatetime))
ALTER TABLE CREDIT_CARDS
ALTER COLUMN EXPIREDATE smalldatetime

UPDATE CREDIT_CARDS
SET ExpireDate = CONVERT(smalldatetime,CONVERT(date, ExpireDate,101))
ALTER TABLE CREDIT_CARDS
ALTER COLUMN EXPIREDATE DATe

--==========================================================
UPDATE EVENTS
SET DateOfEvent = CONVERT(NVARCHAR(50) ,CAST(DateofEvent - 2 as smalldatetime))
ALTER TABLE EVENTS
ALTER COLUMN DateOfEvent smallDATETIME

UPDATE EVENTS
SET DateOfEvent = CONVERT(smalldatetime,CONVERT(date, DateOfEvent,101))
ALTER TABLE EVENTS
ALTER COLUMN DateOfEvent DATE

--==========================================================
UPDATE TRANSACTIONS
SET TransDate = CONVERT(NVARCHAR(50),CAST(TransDate - 2 as smalldatetime))
ALTER TABLE TRANSACTIONS
ALTER COLUMN TransDate DATETIME

UPDATE TRANSACTIONS
SET TransDate = CONVERT(datetime,CONVERT(date, TransDate,101))
ALTER TABLE TRANSACTIONS
ALTER COLUMN TransDate DATE


--================ Views and Stored Procedures ======================================
--===================================================================================
--===================================================================================
-- view of the members contact list
-- this view displays the concatenated full name and full mailing addresss of all members
-- proof select statement below
go
CREATE VIEW MembContactList
AS
SELECT M.[FirstName],M.[LastName],A.[AddressLine1],A.[StateProvance],A.[PostalCode],M.[Phone],M.[Email]
FROM MEMBERS M
LEFT JOIN ADDRESSES A
ON M.MEMBERID = A.MEMBERID
WHERE A.AddressType = 'MAILING';

--select * from membcontactlist
--===================================================================================
--view of all the members emails  with their Concatenated first and last names
go
CREATE VIEW MembEmailList
AS
SELECT Concat(M.[FirstName] , '   ' , M.[LastName]) as [Full Name],M.[Email]
FROM MEMBERS M;
--select * from membemaillist
--===================================================================================
-- of the members birthday for the current month
-- concatenated full name and month name and day
-- select statement  for proving view below

GO  
CREATE VIEW MembersBDMonth
AS
select concat(lastname, ', ', firstname) [Member Name],DATEPART(dd, dob) as [DAY],DATENAME(MM, dob) as [MONTH]
from Members
where DATENAME(month, DOB) = DATENAME(month, getdate()) 

--select * from MembersBDMonth ORDER BY DAY ASC
--===========================================================================
-- this is a stored procedure that determins the attendance of an event

go
IF OBJECT_ID ( 'spEventAttendence', 'P' ) IS NOT NULL   
    DROP PROCEDURE spEventAttendence;  
go  
CREATE PROCEDURE spEventAttendence  
    @startdate date,   
    @enddate date   
AS   
	select count (a.memberid) AS Attendance ,e.Title, e.DateOfEvent
	FROM EVENTS e
	join ATTENDEES a
	on e.EventID = a.EventID
	WHERE E.DateOfEvent between  @startdate and  @enddate
	group by e.EventID, e.Title, e.DateOfEvent

-- proof below   
--execute spEventAttendence '2017-01-01','2017-03-12'
--==============================================================================

-- stored procedure for counting the new members between for a given set of dates
Go
IF OBJECT_ID ( 'spNewMembers', 'P' ) IS NOT NULL   
    DROP PROCEDURE spNewMembers;  
GO  
CREATE PROCEDURE spNewMembers  
    @startdate date,   
    @enddate date   
AS   
	Select COUNT ([MemberID]) AS [New Members],DATENAME(MM,(MAX(Joined))) 'Month'
	FROM MEMBERS
	WHERE Joined between  @startdate and  @enddate
	Group By Month(Joined)
--execute spNewMembers '2016-03-1' , '2016-04-31
--===============================================================================
-- veiw that shows the members ID  of expired  credit cards
GO  
CREATE VIEW MemberCCexpired
AS
SELECT MemberID, ExpireDate FROM CREDIT_CARDS
WHERE ExpireDate >= GETDATE()

GO
--select * from MemberCCexpired


go -- this view will identify when the persons last password change was
CREATE VIEW MemPWLastChanged
AS
SELECT m.MemberID, CONCAT(m.FirstName , '  ', m.LastName) [Full Name], mp.ChangedDate [PassWord Last Changed]
FROM MEMBERPASSWORD mp
JOIN MEMBERS m
ON mp.MemberID = m.MemberID
--================================================================================

-- stored procedure for  calculating the monthly income from all members
-- for a given time period
go
IF OBJECT_ID ( 'spMonthlyIncomeFromMemb ', 'P' ) IS NOT NULL   
    DROP PROCEDURE spMonthlyIncomeFromMemb ;  
go  
CREATE PROCEDURE spMonthlyIncomeFromMemb 
    @startdate date,   
    @enddate date   
AS   
	
   select SUM(amount) [income], DATENAME(MM,(MAX(TransDate))) 'Month'
	from TRANSACTIONS
	where TransDate BETWEEN @startdate and @enddate
	Group By Month (Transdate);

------execute spMonthlyIncomeFromMemb '2017-03-1' , '2017-03-31'

--===================================================================================
-- the following view was created using union all
-- each script calculates the information for each subscription type
-- final view results in all members whos subscription has ended for their 
-- respective payment plans.
go
CREATE VIEW MembersWhoNeedToBCharged
AS
		select  m.joined,m.MemberID,cc.CreditCardID,PE.PlanRates, MAX(cc.ExpireDate)[Credit Card Expiration]
		from MEMBERS m 
		join PLAN_FEES pe
		on m.PlanID = pe.PlanID
		join CREDIT_CARDS cc
		on m.MemberID = cc.MemberID
		join TRANSACTIONS t
		on cc.CreditCardID = t.CreditCardID
		where m.[Current] = 'yes' and pe.PlanID = 1 and m.Subscription = 'Monthly' and 
		(dateadd(MONTH,1,m.Joined) <= getdate())
		and t.CreditCardResults = 'approved' and  ExpireDate !< GETDATE()	
		group by m.memberid	, m.Joined,cc.CreditCardID,PE.PlanRates
Union ALL
		select  m.Joined, m.memberid,cc.CreditCardID,PE.PlanRates, MAX(cc.ExpireDate)[Credit Card Expiration]
		from MEMBERS m 
		join PLAN_FEES pe
		on m.PlanID = pe.PlanID
		join CREDIT_CARDS cc
		on m.MemberID = cc.MemberID
		join TRANSACTIONS t
		on cc.CreditCardID = t.CreditCardID
		where m.[Current] = 'yes' and pe.PlanID = 2 and m.Subscription = 'Quarterly' and 
		(dateadd(MONTH,3,m.Joined) <= getdate())
		and t.CreditCardResults = 'approved'	and  ExpireDate !< GETDATE()
		group by m.memberid	, m.Joined,cc.CreditCardID,PE.PlanRates
UNION ALL
		select  m.Joined, m.memberid,cc.CreditCardID,PE.PlanRates, MAX(cc.ExpireDate)[Credit Card Expiration]
		from MEMBERS m 
		join PLAN_FEES pe
		on m.PlanID = pe.PlanID
		join CREDIT_CARDS cc
		on m.MemberID = cc.MemberID
		join TRANSACTIONS t
		on cc.CreditCardID = t.CreditCardID
		where m.[Current] = 'yes' and pe.PlanID = 3 and m.Subscription = 'Yearly' and
		(dateadd(YEAR,1,m.Joined) <= getdate())
		and t.CreditCardResults = 'approved' and  ExpireDate !< GETDATE()
		group by m.memberid	, m.Joined,cc.CreditCardID,PE.PlanRates
UNION All
		select m.Joined, m.memberid,cc.CreditCardID,PE.PlanRates, MAX(cc.ExpireDate)[Credit Card Expiration]
		from MEMBERS m 
		join PLAN_FEES pe
		on m.PlanID = pe.PlanID
		join CREDIT_CARDS cc
		on m.MemberID = cc.MemberID
		join TRANSACTIONS t
		on cc.CreditCardID = t.CreditCardID
		where m.[Current] = 'yes' and pe.PlanID = 4 and m.Subscription = 'Biennial' and 
		(dateadd(YEAR,2,m.Joined) <= getdate())
		and t.CreditCardResults = 'approved' and  ExpireDate !< GETDATE()
		group by m.memberid	, m.Joined,cc.CreditCardID,PE.PlanRates
--===================================================================================
--Select * From MembersWhoNeedToBCharged
--This stored procedure identifies which members need to renew their suvscripions
GO
CREATE PROCEDURE SP_MembersWhoNeedToBCharged
 AS
 BEGIN
	IF EXISTS (select * from MembersWhoNeedToBCharged)
	BEGIN
		INSERT INTO TRANSACTIONS( CreditCardID, TransDate, Amount,CreditCardResults)
		VALUES (
		
		        (SELECT TOP 1 CreditCardID  from MembersWhoNeedToBCharged),
				(SELECT CAST(GETDATE() AS DATE)),
				(SELECT TOP 1 PlanRates from MembersWhoNeedToBCharged),
				'Pending')		
	END
END
--===================================================================================
-- THIS IS THE STORED PROCEDURE THAT WILL ENCRYPT THE PASSWORDS using SHA@_512
GO
CREATE PROCEDURE SP_PasswordHashs
    @MemberID int, 
    @Password NVARCHAR(60), 
    @LoginName NVARCHAR(60), 
    @responseMessage NVARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRY
        INSERT INTO [MEMBERPASSWORD] (MemberID, PasswordHash, LoginName)
        VALUES(@MemberID, HASHBYTES('SHA2_512', @Password), @LoginName)

        SET @responseMessage='Success'

    END TRY
    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH
END


--===================================================================
------THIS WORKS WITH  ABOVE STORED PROCEDURE
------ THIS WILL ALLOW USER TO INPUT THE PASSWORD AND LOGIN INFOMATION
go
DECLARE @responseMessage NVARCHAR(250)

EXEC SP_PasswordHashs
	    @MemberID  = 2,
		@Password = 'Pass123',
		@LoginName = 'vgepp1@nih.gov',
		@responseMessage= @responseMessage OUTPUT

Select @responseMessage as ResponseMessage



------SELECT *  FROM MEMBERPASSWORD

--=========================================================================

--THIS PROCEDURE WILL AUTHENTICATE THE USER USING AN ENCRYPTED PASSWORD
GO
CREATE PROCEDURE sp_LOGINS
    @LoginName NVARCHAR(254),
    @Password NVARCHAR(50),
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @PASSWORDID INT

    IF EXISTS (SELECT TOP 1 PASSWORDID FROM MEMBERPASSWORD WHERE LoginName=@LoginName)
    BEGIN
        SET @PASSWORDID=(SELECT PASSWORDID FROM MEMBERPASSWORD 
		WHERE LoginName=@LoginName AND PasswordHash=HASHBYTES('SHA2-512', @Password))

       IF @PASSWORDID IS NOT NULL
           SET @responseMessage='Incorrect Password'
       ELSE 
           SET @responseMessage='Successfully Logged In'
   END
       ELSE
           SET @responseMessage='Invalid Login'

END
--===============================================================================
go
--THESE ARE THE TESTS FOR THE  LOGIN / PASSWORD VALIDATION
begin
DECLARE	@responseMessage nvarchar(250)

----Correct login and password


EXEC	sp_LOGINS
		@LoginName = 'vgepp1@nih.gov',
		@Password = 'Pass123',
		@responseMessage = @responseMessage OUTPUT

SELECT	@responseMessage as '@responseMessage'

--Incorrect login
EXEC	sp_LOGINS
		@LoginName = 'vgepp1@nih.gov1', 
		@Password = 'Pass123' ,
		@responseMessage = @responseMessage OUTPUT

SELECT	@responseMessage as '@responseMessage'

--Incorrect password
EXEC	sp_LOGINS
		@LoginName = 'vgepp1@nih.gov' , 
		@Password =  'password',
		@responseMessage = @responseMessage OUTPUT

SELECT	@responseMessage as '@responseMessage'

end



--CREATE LOGIN <login_name> WITH PASSWORD = '<enterStrongPasswordHere>' MUST_CHANGE;  