--CREATE DATABASE dbStoreDataSFASMS ON (NAME = dbStoreDataSFASMS , FILENAME= "D:\SQL DataBase\SFASMS\dbStoreDataSFASMS.mdf", Size = 8MB, MaxSize =UNLIMITED, FileGrowth = 8MB)
--LOG ON (NAME = dbStoreDataSFASMS_log, FILENAME ="D:\SQL DataBase\SFASMS\dbStoreDataSFASMS_log.ldf", Size = 8MB, MaxSize =UNLIMITED, FileGrowth =10%)
--GO
CREATE DATABASE dbStoreDataSFASMS;
GO
USE dbStoreDataSFASMS
/****************************** Create All  Table  ************************************ */
-- tbStaff
CREATE TABLE tbStaff(
	StaffID INT PRIMARY KEY IDENTITY(1,1),
	StaffNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	StaffNameEN VARCHAR (100) NOT NULL,
	Gender VARCHAR (6)NOT NULL,
	BirthDate DATE NOT NULL,
	StaffPosition VARCHAR (100) NOT NULL,
	StaffAddress VARCHAR (1000) NOT NULL,
	ContactNumber VARCHAR (10) NOT NULL,
	PersonalNumber VARCHAR (10) NULL,
	HiredDate DATE NOT NULL,
	Photo VARBINARY (max) NULL
)
GO
-- tbStudent
CREATE TABLE tbStudent(
	StudentID INT PRIMARY KEY IDENTITY(1,1),
	StudentNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	StudentNameEN VARCHAR (100) NOT NULL,
	Gender VARCHAR (6) NOT NULL,
	BirthDate DATE NOT NULL,
	StudentAddress VARCHAR (1000) NOT NULL,
	PersonalNumber VARCHAR (10) NOT NULL,
	ParentNumber VARCHAR (10) NOT NULL,
	Photo VARBINARY(max) NULL,
)
GO
-- tbLecturer
CREATE TABLE tbLecturer(
	LecturerID INT PRIMARY KEY IDENTITY(1,1),
	LecturerNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	LecturerNameEN VARCHAR (100) NOT NULL,
	Gender VARCHAR (6) NOT NULL,
	BirthDate DATE NOT NULL,
	LecturerAddress VARCHAR (1000) NOT NULL,
	ContactNumber VARCHAR (10) NOT NULL,
	PersonalNumber VARCHAR (10) NULL,
	Photo VARBINARY(max) NULL,
)
GO
-- tbSubject 
CREATE TABLE tbSubject(
	SubjectID INT PRIMARY KEY IDENTITY(1,1),
	SubjectName VARCHAR (50)NOT NULL,
	SubjectDescription VARCHAR (100) NULL,
)
GO
-- tbRoom 
CREATE TABLE tbRoom(
	RoomNo INT PRIMARY KEY IDENTITY (1,1),
	RoomNumber INT NOT NULL,
	BuildingLetter VARCHAR (10) NOT NULL
)
GO
-- tbMajor
CREATE TABLE tbMajor(
	MajorID INT PRIMARY KEY IDENTITY (1,1),
	MajorNameKH NVARCHAR(100) Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	MajorNameEN VARCHAR (70) NOT NULL,
	MajorNameAbbreviation VARCHAR (5) NULL,
	MajorCost MONEY NOT NULL,
	MajorDescription VARCHAR (200) NULL
)
GO
-- tbStudentSummary 
CREATE TABLE tbStudentSummary(
	StuSumID INT PRIMARY KEY IDENTITY(1,1) ,
	RegisterDate DATE NOT NULL,
	Degree VARCHAR (50) NOT NULL,
	StudentID INT NOT NULL,
	RoomNo INT NOT NULL,
	MajorID INT NOT NULL,
	StudentNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	MajorNameKH NVARCHAR(100) Collate SQL_Latin1_General_CP850_Bin NOT NULL,
CONSTRAINT FKStudentIDStudentSummary FOREIGN KEY (StudentID) 
	REFERENCES tbStudent(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKRoomNoStudentSummary FOREIGN KEY (RoomNo) 
	REFERENCES tbRoom(RoomNo) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKMajorIDStudentSummary FOREIGN KEY (MajorID) 
	REFERENCES tbMajor(MajorID) ON DELETE CASCADE ON UPDATE CASCADE,
)
GO
-- tbSchedule 
CREATE TABLE tbSchedule(
	ScheduleID INT PRIMARY KEY IDENTITY(1,1),
	Semester TINYINT NOT NULL,
	StudyYears TINYINT NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	Session TINYINT NOT NULL,
	Shifts VARCHAR (20) NOT NULL,
	RoomNo INT NOT NULL,
	MajorID INT NOT NULL,
	MajorNameEN VARCHAR (70) NOT NULL,
CONSTRAINT FKRoomNoSchedule FOREIGN KEY (RoomNo) 
	REFERENCES tbRoom(RoomNo) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKMajorIDSchedule FOREIGN KEY (MajorID) 
	REFERENCES tbMajor(MajorID) ON DELETE CASCADE ON UPDATE CASCADE,
)
GO
-- tbPaymentStatus
CREATE TABLE tbPaymentStatus(
	PaymentStatusID INT PRIMARY KEY IDENTITY(1,1),
	SemesterOneStatus BIT NULL,
	SemesterTwoStatus BIT NULL,
	OneYearStatus BIT NULL,
	StudentID INT NOT NULL,
	StudentNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
CONSTRAINT FKStudentIDPaymentStatus FOREIGN KEY(StudentID) 
	REFERENCES tbStudent(StudentID) ON DELETE CASCADE ON  UPDATE CASCADE
)
GO
-- tbPayment
CREATE TABLE tbPayment(
	PaymentNo INT PRIMARY KEY IDENTITY(1,1), 
	PayDate DATE NOT NULL,
	PaidAmount MONEY NOT NULL,
	PaymentStatusID INT NOT NULL,
	StaffID INT NOT NULL,
	MajorID INT NOT NULL, 
	StaffNameKH NVARCHAR(100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	StaffPosition VARCHAR(100) NOT NULL,
	MajorCost MONEY NOT NULL,
CONSTRAINT FKPaymentStatusIDPayment FOREIGN KEY (PaymentStatusID) 
	REFERENCES tbPaymentStatus(PaymentStatusID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKStaffIDPayment FOREIGN KEY (StaffID) 
	REFERENCES tbStaff(StaffID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKMajorIDPayment FOREIGN KEY (MajorID) 
	REFERENCES tbMajor(MajorID) ON DELETE CASCADE ON UPDATE CASCADE,
)
GO
-- tbInvoice 
CREATE TABLE tbInvoice(
	InvoiceNo INT PRIMARY KEY IDENTITY(1,1),
	InvoiceDate DATE NOT NULL,
	InvoiceAmount MONEY NOT NULL,
	PaymentStatusID INT NOT NULL,
	StaffID INT NOT NULL,
	MajorID INT NOT NULL,
	StaffNameKH NVARCHAR(100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	StaffPosition VARCHAR(100) NOT NULL,
	MajorCost MONEY NOT NULL,
CONSTRAINT FKPaymentStatusIDInvoice FOREIGN KEY (PaymentStatusID) 
	REFERENCES tbPaymentStatus(PaymentStatusID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKStaffIDInvoice FOREIGN KEY (StaffID) 
	REFERENCES tbStaff(StaffID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKMajorIDInvoice FOREIGN KEY (MajorID) 
	REFERENCES tbMajor(MajorID) ON DELETE CASCADE ON UPDATE CASCADE,
)
GO
-- tbExam
CREATE TABLE tbExam(
	SubjectID INT,
	StudentID INT,
	ExamScore INT NOT NULL,
	Grade char (2) NULL,
	GPA float NULL,
	SubjectName VARCHAR (50),
CONSTRAINT FKSubjectIDExam FOREIGN KEY (SubjectID) 
	REFERENCES tbSubject(SubjectID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKStudentIDExam FOREIGN KEY (StudentID) 
	REFERENCES tbStudent(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PKSubjectIDStudentIDExam PRIMARY KEY (SubjectID,StudentID)
)
GO
-- tbUser 
CREATE TABLE tbUser(
	UserID INT PRIMARY KEY IDENTITY(1,1),
	Username VARCHAR (100) NOT NULL,
	Password VARCHAR (100)  NOT NULL,
	StaffID INT NOT NULL,
	StaffNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
	StaffPosition VARCHAR (100) NOT NULL,
CONSTRAINT FKStaffIDUser FOREIGN KEY (StaffID) 
	REFERENCES tbStaff(StaffID) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

-- tbAttendance 
CREATE TABLE tbAttendance(
	AttendanceID INT PRIMARY KEY IDENTITY(1,1),
	TimeRecorded TIME NOT NULL,
	DateRecorded DATE NOT NULL,
	Status BIT NOT NULL,
	Generation INT NULL,
	StudyYear DATE NULL,
	Class CHAR(3) NULL,
	StudentID INT NOT NULL,
	StudentNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin NOT NULL,
CONSTRAINT FKStudentIDAttendance FOREIGN KEY (StudentID)
	REFERENCES tbStudent(StudentID) ON DELETE CASCADE ON UPDATE CASCADE
)
GO
-- tbSubjectScheduleDetail:
CREATE TABLE tbSubjectScheduleDetail ( 
	SubjectID INT,
	ScheduleID INT,
	SubjectName VARCHAR (50),
	DaysOfTheWeek VARCHAR(20),
CONSTRAINT FKSubjectIDSubScheDetail FOREIGN KEY(SubjectID) 
	REFERENCES tbSubject(SubjectID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKScheduleIDSubScheDetail FOREIGN KEY(ScheduleID) 
	REFERENCES tbSchedule(ScheduleID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT UQ_SubjectScheduleDetail UNIQUE (ScheduleID, SubjectID, DaysOfTheWeek)
)
GO
--  tbLecturerScheduleDetail
CREATE TABLE tbLecturerScheduleDetail(
	LecturerID INT,
	ScheduleID INT,
	LecturerNameKH NVARCHAR (100)Collate SQL_Latin1_General_CP850_Bin,
	DaysOfTheWeek VARCHAR(20),
CONSTRAINT FKLecturerIDLecScheDetail FOREIGN KEY(LecturerID) 
	REFERENCES tbLecturer(LecturerID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FKScheduleIDLecScheDetail FOREIGN KEY(ScheduleID) 
	REFERENCES tbSchedule(ScheduleID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT UQ_LecturerScheduleDetail UNIQUE (ScheduleID, LecturerID, DaysOfTheWeek)
)
GO


/****************************** Create All  Store Procedure  ************************************ */

--Read All Staff
CREATE PROCEDURE spReadALLStaff  
AS 
BEGIN 
	SELECT  StaffID,StaffNameKH FROM tbStaff
END;
GO
-- Get All Staff ID
CREATE PROCEDURE spReadALLStaffID
AS 
BEGIN
	SELECT StaffID FROM tbStaff
END;
GO
-- Read One StaffNameKH and One StaffPosition
CREATE PROCEDURE spReadOneStaffNameKHandPosition ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 StaffNameKH,StaffPosition FROM tbStaff WHERE StaffID = @id
END;
GO
-- Read One Staff
CREATE PROCEDURE spReadOneStaff ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbStaff WHERE StaffID = @id
END;
GO
-- Insert Staff
CREATE PROCEDURE spInsertStaff (   @snKH NVARCHAR (100), @snEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @pos VARCHAR (100), @ad VARCHAR (100), @cn VARCHAR (10), @pn VARCHAR (10) =  NULL, @hd DATE, @ph VARBINARY (max) = NULL ) 
AS 
BEGIN 
	INSERT INTO tbStaff VALUES  (  @snKH, @snEN, @gen, @bd, @pos, @ad, @cn, @pn, @hd, @ph )
END;
GO
-- Update Staff
CREATE PROCEDURE spUpdateStaff ( @id INT, @snKH NVARCHAR (100), @snEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @pos VARCHAR (100), @ad VARCHAR (100), @cn VARCHAR (10), @pn VARCHAR (10) =  NULL, @hd DATE, @ph VARBINARY (max) = NULL ) 
AS 
BEGIN 
	
	UPDATE tbStaff SET  
		StaffNameKH = @snKH, 
		StaffNameEN = @snEN,
		Gender = @gen, 
		BirthDate = @bd, 
		StaffPosition = @pos, 
		StaffAddress = @ad, 
		ContactNumber = @cn, 
		PersonalNumber = @pn, 
		HiredDate = @hd, 
		Photo = @ph 
		WHERE StaffID = @id
END;
GO
--Read All Student
CREATE PROCEDURE spReadALLStudent  
AS 
BEGIN 
	SELECT  StudentID,StudentNameKH FROM tbStudent
END;
GO
--Read All StudentName KH
CREATE PROCEDURE spReadOneStudentNameKH   ( @id INT ) 
AS 
BEGIN 
	SELECT  StudentNameKH FROM tbStudent WHERE StudentID = @id
END;
GO
-- Read One Student
CREATE PROCEDURE spReadOneStudent ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbStudent WHERE StudentID = @id
END;
GO
-- Read One Student ID and Photo
CREATE PROCEDURE spReadOneStudentIDandPhoto ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 StudentNameKH,Photo FROM tbStudent WHERE StudentID = @id
END;
GO
-- Get All StudentID
CREATE PROCEDURE spReadALLStudentID
AS 
BEGIN
	SELECT StudentID FROM tbStudent
END;
GO
-- Insert Student
CREATE PROCEDURE spInsertStudent (  @stunKH NVARCHAR (100), @stunEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @stuad VARCHAR (100), @psn VARCHAR (10), @prn VARCHAR (10) , @stuph VARBINARY (max) = NULL ) 
AS 
BEGIN 
	INSERT INTO tbStudent VALUES  (  @stunKH, @stunEN, @gen, @bd, @stuad, @psn, @prn,  @stuph )
END;
GO
-- Update Student
CREATE PROCEDURE spUpdateStudent ( @id INT, @stunKH NVARCHAR (100), @stunEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @stuad VARCHAR (100), @psn VARCHAR (10), @prn VARCHAR (10) , @stuph VARBINARY (max) = NULL ) 
AS 
BEGIN 
	UPDATE tbStudent SET  
		StudentNameKH = @stunKH, 
		StudentNameEN = @stunEN,
		Gender = @gen, 
		BirthDate = @bd, 
		StudentAddress = @stuad, 
		PersonalNumber = @psn, 
		ParentNumber = @prn,
		Photo = @stuph 
		WHERE StudentID = @id
END;
GO
--Read All Lecturer
CREATE PROCEDURE spReadALLLecturer  
AS 
BEGIN 
	SELECT  LecturerID,LecturerNameKH FROM tbLecturer
END;
GO
-- Get All Lecturer ID 
CREATE PROCEDURE spReadALLLecturerID
AS 
BEGIN
	SELECT LecturerID FROM tbLecturer
END;
GO
-- Read One Lecturer
CREATE PROCEDURE spReadOneLecturer ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbLecturer WHERE LecturerID = @id
END;
GO
CREATE PROCEDURE spReadOneLecturerNameKH ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 LecturerNameKH FROM tbLecturer WHERE LecturerID = @id
END;
GO
-- Insert Lecturer
CREATE PROCEDURE spInsertLecturer ( @lecnKH NVARCHAR (100), @lecnEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @lecad VARCHAR (100), @cn VARCHAR (10), @pn VARCHAR (10) =NULL, @lecph VARBINARY (max) = NULL ) 
AS 
BEGIN 
	INSERT INTO tbLecturer VALUES  (  @lecnKH, @lecnEN, @gen, @bd, @lecad, @cn, @pn,  @lecph )
END;
GO
-- Update Lecturer
CREATE PROCEDURE spUpdateLecturer ( @id INT, @lecnKH NVARCHAR (100), @lecnEN VARCHAR (100), @gen VARCHAR (6), @bd DATE, @lecad VARCHAR (100), @cn VARCHAR (10), @pn VARCHAR (10) =NULL, @lecph VARBINARY (max) = NULL) 
AS 
BEGIN 
	UPDATE tbLecturer SET  
		LecturerNameKH = @lecnKH, 
		LecturerNameEN = @lecnEN,
		Gender = @gen, 
		BirthDate = @bd, 
		LecturerAddress = @lecad, 
		ContactNumber = @cn, 
		PersonalNumber = @pn,
		Photo = @lecph 
		WHERE LecturerID = @id
END;
GO
--Read All Subject
CREATE PROCEDURE spReadALLSubject  
AS 
BEGIN 
	SELECT  *  FROM tbSubject
END;
GO
-- Get All Subject ID and Subject Name 
CREATE PROCEDURE spReadALLSubjectID
AS 
BEGIN
	SELECT SubjectID FROM tbSubject
END;
GO
-- Read One Subject
CREATE PROCEDURE spReadOneSubject ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbSubject WHERE SubjectID = @id
END;
GO
-- Read One Subject Name
CREATE PROCEDURE spReadOneSubjectName ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 SubjectName FROM tbSubject WHERE SubjectID = @id
END;
GO
-- Insert Subject
CREATE PROCEDURE spInsertSubject ( @subn VARCHAR (50), @subdec VARCHAR (100) =NULL) 
AS 
BEGIN 
	INSERT INTO tbSubject VALUES  ( @subn,@subdec )
END;
GO
-- Update Subject
CREATE PROCEDURE spUpdateSubject ( @id INT, @subn VARCHAR (50), @subdec VARCHAR (100) =NULL) 
AS 
BEGIN 
	UPDATE tbSubject SET  
		SubjectName = @subn, 
		SubjectDescription= @subdec
		WHERE SubjectID = @id
END;
GO
--Read All Room
CREATE PROCEDURE spReadALLRoom  
AS 
BEGIN 
	SELECT  *  FROM tbRoom
END;
GO
-- Get All Room ID
CREATE PROCEDURE spReadALLRoomNo
AS 
BEGIN
	SELECT RoomNo FROM tbRoom
END;
GO
-- Read One Room
CREATE PROCEDURE spReadOneRoom ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbRoom WHERE RoomNo = @id
END;
GO
-- Insert Room
CREATE PROCEDURE spInsertRoom (@rn INT, @bl VARCHAR (10) ) 
AS 
BEGIN 
	INSERT INTO tbRoom VALUES  ( @rn,@bl )
END;
GO
-- Update Room
CREATE PROCEDURE spUpdateRoom ( @no INT, @rn INT, @bl VARCHAR (10)) 
AS 
BEGIN 
	UPDATE tbRoom SET  
		RoomNumber = @rn, 
		BuildingLetter= @bl
		WHERE RoomNo = @no
END;
GO
--Read All Major
CREATE PROCEDURE spReadALLMajor  
AS 
BEGIN 
	SELECT  *  FROM tbMajor
END;
GO
-- Get All Major ID
CREATE PROCEDURE spReadALLMajorID
AS 
BEGIN
	SELECT MajorID FROM tbMajor
END;
GO
-- Read One Major
CREATE PROCEDURE spReadOneMajor ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbMajor WHERE MajorID = @id
END;
GO
-- Read One Major Name
CREATE PROCEDURE spReadOneMajorNameEN ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 MajorNameEN FROM tbMajor WHERE MajorID = @id
END;
GO
-- Read One Major Name KH
CREATE PROCEDURE spReadOneMajorNameKH ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 MajorNameKH FROM tbMajor WHERE MajorID = @id
END;
GO
-- Read One Major Cost
CREATE PROCEDURE spReadOneMajorCost ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 MajorCost FROM tbMajor WHERE MajorID = @id
END;
GO
-- Insert Major
CREATE PROCEDURE spInsertMajor (@mnKH NVARCHAR(100),  @mnEN VARCHAR(70), @mna VARCHAR (5)= NULL,@mc MONEY,@mdec VARCHAR(200)=NULL ) 
AS 
BEGIN 
	INSERT INTO tbMajor VALUES  (@mnKH,@mnEN,@mna,@mc,@mdec )
END;
GO
-- Update Major
CREATE PROCEDURE spUpdateMajor ( @id INT, @mnKH NVARCHAR(100) ,@mnEN VARCHAR(70), @mna VARCHAR (5)= NULL,@mc MONEY,@mdec VARCHAR(200)=NULL) 
AS 
BEGIN 
	UPDATE tbMajor SET  
		MajorNameKH = @mnKH,
		MajorNameEN = @mnEN,
		MajorNameAbbreviation = @mna,
		MajorCost = @mc,
		MajorDescription = @mdec
		WHERE MajorID = @id
END;
GO
--Read All StudentSummary
CREATE PROCEDURE spReadALLStudentSummary
AS 
BEGIN 
	SELECT  StuSumID,StudentNameKH FROM tbStudentSummary
END;
GO
-- Read One StudentSummary
CREATE PROCEDURE spReadOneStudentSummary ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbStudentSummary WHERE StuSumID = @id
END;
GO
-- Insert StudentSummary
CREATE PROCEDURE spInsertStudentSummary ( @rd DATE, @deg VARCHAR (50), @stuid INT, @rn INT, @maid INT, @stunKH NVARCHAR (100), @mnKH NVARCHAR (100) ) 
AS 
BEGIN 
	INSERT INTO tbStudentSummary VALUES  (  @rd, @deg, @stuid, @rn, @maid, @stunKH, @mnKH)
END;
GO
-- Update StudentSummary
CREATE PROCEDURE spUpdateStudentSummary ( @id INT, @rd DATE, @deg VARCHAR (50), @stuid INT, @rn INT, @maid INT, @stunKH NVARCHAR (100), @mnKH NVARCHAR (100) ) 
AS 
BEGIN 
	UPDATE tbStudentSummary SET  
		RegisterDate = @rd,
		Degree = @deg,
		StudentID = @stuid,
		RoomNo = @rn,
		MajorID = @maid,
		StudentNameKH = @stunKH,
		MajorNameKH = @mnKH
		WHERE StuSumID = @id
END;
GO
--Read All PaymentStatus
CREATE PROCEDURE spReadALLPaymentStatus
AS 
BEGIN 
	SELECT  PaymentStatusID,StudentNameKH FROM tbPaymentStatus
END;
GO
-- Get All PaymentStatus ID
CREATE PROCEDURE spReadALLPaymentStatusID
AS 
BEGIN
	SELECT PaymentStatusID FROM tbPaymentStatus
END;
GO
-- Read One PaymentStatus
CREATE PROCEDURE spReadOnePaymentStatus ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbPaymentStatus WHERE PaymentStatusID = @id
END;
GO
-- Insert PaymentStatus
CREATE PROCEDURE spInsertPaymentStatus ( @sos BIT, @sts BIT, @oys BIT, @stuid INT, @stunKH  NVARCHAR (100)) 
AS 
BEGIN 
	INSERT INTO tbPaymentStatus VALUES  ( @sos , @sts , @oys , @stuid , @stunKH )
END;
GO
-- Update PaymentStatus
CREATE PROCEDURE spUpdatePaymentStatus ( @id INT, @sos BIT, @sts BIT, @oys BIT, @stuid INT, @stunKH  NVARCHAR (100) ) 
AS 
BEGIN 
	UPDATE tbPaymentStatus SET  
		SemesterOneStatus = @sos,
		SemesterTwoStatus = @sts,
		OneYearStatus = @oys,
		StudentID = @stuid,
		StudentNameKH = @stunKH
		WHERE PaymentStatusID = @id
END;
GO
--Read All Payment
CREATE PROCEDURE spReadALLPayment
AS 
BEGIN 
	SELECT  PaymentNo,StudentNameKH 
	FROM tbPayment INNER JOIN tbPaymentStatus
	ON tbPayment.PaymentStatusID = tbPaymentStatus.PaymentStatusID
END;
GO
-- Read One Payment
CREATE PROCEDURE spReadOnePayment ( @no INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbPayment WHERE PaymentNo = @no
END;
GO
-- Read One StudentNameKH 
CREATE PROCEDURE spReadOneStudentNameKHPayment ( @no INT ) 
AS 
BEGIN 
	SELECT StudentNameKH 
	FROM tbPayment INNER JOIN tbPaymentStatus
	ON tbPayment.PaymentStatusID = tbPaymentStatus.PaymentStatusID
	WHERE tbPayment.PaymentNo = @no
END;
GO
-- Insert Payment
CREATE PROCEDURE spInsertPayment ( @pd DATE, @pa MONEY, @pmsid INT, @staid INT, @mid INT,@stanKH NVARCHAR(100),@stapos NVARCHAR(100),@mcost MONEY) 
AS 
BEGIN 
	INSERT INTO tbPayment VALUES  (  @pd , @pa , @pmsid , @staid , @mid ,@stanKH ,@stapos,@mcost  )
END;
GO
-- Update Payment
CREATE PROCEDURE spUpdatePayment ( @no INT, @pd DATE, @pa MONEY, @pmsid INT, @staid INT, @mid INT,@stanKH NVARCHAR(100),@stapos NVARCHAR(100),@mcost MONEY ) 
AS 
BEGIN 
	UPDATE tbPayment SET  
		PayDate = @pd,
		PaidAmount= @pa,
		PaymentStatusID = @pmsid,
		StaffID = @staid,
		MajorID = @mid,
		StaffNameKH = @stanKH,
		StaffPosition = @stapos,
		MajorCost = @mcost
		WHERE PaymentNo = @no
END;
GO
--Read All Invoice
CREATE PROCEDURE spReadALLInvoice
AS 
BEGIN 
	SELECT  InvoiceNo,StudentNameKH 
	FROM tbInvoice INNER JOIN tbPaymentStatus
	ON tbInvoice.PaymentStatusID = tbPaymentStatus.PaymentStatusID
END;
GO
-- Read One StudentNameKH 
CREATE PROCEDURE spReadOneStudentNameKHInvoice ( @no INT ) 
AS 
BEGIN 
	SELECT  StudentNameKH 
	FROM tbInvoice INNER JOIN tbPaymentStatus
	ON tbInvoice.PaymentStatusID = tbPaymentStatus.PaymentStatusID
	WHERE tbInvoice.InvoiceNo = @no
END;
GO
-- Read One Invoice
CREATE PROCEDURE spReadOneInvoice ( @no INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbInvoice WHERE InvoiceNo = @no
END;
GO
-- Insert Invoice
CREATE PROCEDURE spInsertInvoice ( @ind DATE, @ina MONEY, @pmsid INT, @staid INT, @mid INT,@stanKH NVARCHAR(100),@stapos NVARCHAR(100),@mcost MONEY) 
AS 
BEGIN 
	INSERT INTO tbInvoice VALUES  ( @ind , @ina , @pmsid , @staid , @mid ,@stanKH ,@stapos,@mcost  )
END;
GO
-- Update Invoice
CREATE PROCEDURE spUpdateInvoice ( @no INT, @ind DATE, @ina MONEY, @pmsid INT, @staid INT, @mid INT,@stanKH NVARCHAR(100),@stapos NVARCHAR(100),@mcost MONEY ) 
AS 
BEGIN 
	UPDATE tbInvoice SET  
		InvoiceDate = @ind,
		InvoiceAmount= @ina,
		PaymentStatusID = @pmsid,
		StaffID = @staid,
		MajorID = @mid,
		StaffNameKH = @stanKH,
		StaffPosition = @stapos,
		MajorCost = @mcost
		WHERE InvoiceNo = @no
END;
GO
--Read All Exam
CREATE PROCEDURE spReadALLExam
AS 
BEGIN 
	SELECT * FROM tbExam
END;
GO
-- Read One Exam
CREATE PROCEDURE spReadOneExam ( @subid INT,@stuid INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbExam WHERE SubjectID = @subid AND StudentID = @stuid
END;
GO
-- Insert Exam
CREATE PROCEDURE spInsertExam ( @subid INT, @stuid INT, @scor INT, @grade char (2), @GPA FLOAT, @subn VARCHAR(50)) 
AS 
BEGIN 
	INSERT INTO tbExam VALUES  (  @subid , @stuid , @scor , @grade  , @GPA , @subn )
END;
GO
-- Update Exam
CREATE PROCEDURE spUpdateExam (  @subid INT, @stuid INT, @scor INT, @grade char (2), @GPA FLOAT, @subn VARCHAR(50)) 
AS 
BEGIN 
	UPDATE tbExam SET  
		ExamScore = @scor,
		Grade = @grade,
		GPA = @GPA,
		SubjectName = @subn
		WHERE SubjectID = @subid AND StudentID = @stuid
END;
GO
--Read All Attendance
CREATE PROCEDURE spReadALLAttendance
AS 
BEGIN 
	SELECT AttendanceID,StudentID,TimeRecorded,DateRecorded,Status,StudentNameKH FROM tbAttendance
END;
GO
-- Read One Attendance
CREATE PROCEDURE spReadOneAttendance ( @attid INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbAttendance WHERE AttendanceID = @attid 
END;
GO
-- Insert Attendance
CREATE PROCEDURE spInsertAttendance ( @tr TIME, @dr DATE, @st BIT, @gen INT, @sty DATE,@cla CHAR(3) ,@stuid INT,@stunKH NVARCHAR (100)) 
AS 
BEGIN 
	INSERT INTO tbAttendance VALUES  (  @tr , @dr , @st , @gen , @sty ,@cla ,@stuid ,@stunKH )
END;
GO
-- Update Attendance
CREATE PROCEDURE spUpdateAttendance (  @attid INT, @tr TIME, @dr DATE, @st BIT, @gen INT, @sty DATE,@cla CHAR(3) ,@stuid INT,@stunKH NVARCHAR (100)) 
AS 
BEGIN 
	UPDATE tbAttendance SET  
		TimeRecorded = @tr,
		DateRecorded = @dr,
		Status = @st,
		Generation = @gen,
		StudyYear = @sty,
		Class = @cla,
		StudentID = @stuid,
		StudentNameKH = @stunKH
		WHERE AttendanceID = @attid
END;
GO
--Read All User
CREATE PROCEDURE spReadALLUser  
AS 
BEGIN 
	SELECT  UserID,Username  FROM tbUser
END;
GO
--Read All User
CREATE PROCEDURE spReadUserTOLogin  
AS 
BEGIN 
	SELECT  Username,Password,StaffPosition  FROM tbUser
END;
GO
-- Read One User
CREATE PROCEDURE spReadOneUser ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbUser WHERE UserID = @id
END;
GO
-- Read One User To Verified Credentials
CREATE PROCEDURE spVerifiedUserCredential(@usr VARCHAR(100), @passwd VARCHAR (100))
AS 
BEGIN
	SELECT TOP 1 * FROM tbUser WHERE  Username = @usr AND Password = @passwd
END
GO
-- Insert User
CREATE PROCEDURE spInsertUser ( @usr VARCHAR(100), @passwd VARCHAR (100),@staid INT,@stanKH NVARCHAR(100),@stapos VARCHAR(100) ) 
AS 
BEGIN 
	INSERT INTO tbUser VALUES  (  @usr,@passwd,@staid,@stanKH,@stapos )
END;
GO
-- Update User
CREATE PROCEDURE spUpdateUser (@id INT, @usr VARCHAR(100), @passwd VARCHAR (100),@staid INT,@stanKH NVARCHAR(100),@stapos VARCHAR(100)) 
AS 
BEGIN 
	UPDATE tbUser SET  
		Username = @usr,
		Password= @passwd,
		StaffID= @staid,
		StaffNameKH = @stanKH,
		StaffPosition = @stapos
		WHERE UserID = @id
END;
GO
--Read All Schedule
CREATE PROCEDURE spReadALLSchedule
AS 
BEGIN 
	SELECT  ScheduleID,MajorNameEN,StudyYears,tbRoom.RoomNumber,Shifts,StartDate,EndDate
	FROM tbSchedule INNER JOIN tbRoom 
	ON tbSchedule.RoomNo = tbRoom.RoomNo
END;
GO

-- Read One Schedule
CREATE PROCEDURE spReadOneSchedule ( @id INT ) 
AS 
BEGIN 
	SELECT TOP 1 * FROM tbSchedule WHERE ScheduleID = @id
END;
GO
-- Insert Schedule
CREATE PROCEDURE spInsertSchedule (@sem TINYINT,@sy TINYINT,@sd DATE,@ed DATE,@sess TINYINT,@shi VARCHAR (20),@rn INT ,@mid INT,@mnEN VARCHAR (70)) 
AS 
BEGIN 
	INSERT INTO tbSchedule VALUES  (@sem ,@sy ,@sd ,@ed ,@sess ,@shi,@rn  ,@mid ,@mnEN )
END;
GO
-- Update Schedule
CREATE PROCEDURE spUpdateSchedule (  @id INT,@sem TINYINT,@sy TINYINT,@sd DATE,@ed DATE,@sess TINYINT,@shi VARCHAR (20),@rn INT ,@mid INT,@mnEN VARCHAR (70)) 
AS 
BEGIN 
	UPDATE tbSchedule SET  
		Semester = @sem ,
		StudyYears =  @sy ,
		StartDate =  @sd ,
		EndDate =  @ed ,
		Session =  @sess ,
		Shifts= @shi,
	 	RoomNo = @rn  ,
		MajorID = @mid ,
		MajorNameEN =  @mnEN 
		WHERE ScheduleID = @id
END;
GO

-- Read One  Subject Schedule Detail
CREATE PROCEDURE spReadOneSubScheDetail ( @id INT ) 
AS 
BEGIN 
	SELECT  tbSubjectScheduleDetail.SubjectID,tbSubjectScheduleDetail.SubjectName,tbSubjectScheduleDetail.DaysOfTheWeek 
	FROM tbSchedule RIGHT JOIN tbSubjectScheduleDetail
	ON tbSchedule.ScheduleID = tbSubjectScheduleDetail.ScheduleID
	WHERE tbSchedule.ScheduleID = @id;
END;
GO
-- Insert Subject Schedule Detail
CREATE PROCEDURE spInsertSubScheDetail (@subID INT,@scheID INT ,@subn VARCHAR(50),@dotw VARCHAR(20))
AS 
BEGIN 
	INSERT INTO tbSubjectScheduleDetail VALUES(@subID,@scheID,@subn,@dotw)
END;
GO
-- Update Subject Schedule Detail
CREATE PROCEDURE spUpdateSubScheDetail (@oldsubid INT ,@subID INT,@scheID INT ,@subn VARCHAR(50))
AS 
BEGIN 
	UPDATE tbSubjectScheduleDetail SET 
		SubjectID =@subID,
		SubjectName =@subn
	WHERE ScheduleID = @scheID AND SubjectID = @oldsubid
END;
GO

-- Read One  Lecturer Schedule Detail
CREATE PROCEDURE spReadOneLecScheDetail ( @id INT ) 
AS 
BEGIN 
	SELECT tbLecturerScheduleDetail.LecturerID,tbLecturerScheduleDetail.LecturerNameKH,tbLecturerScheduleDetail.DaysOfTheWeek 
	FROM tbSchedule RIGHT JOIN tbLecturerScheduleDetail 
	ON tbSchedule.ScheduleID = tbLecturerScheduleDetail.ScheduleID
	WHERE tbSchedule.ScheduleID = @id;
END;
GO
-- Insert Lecturer Schedule Detail
CREATE PROCEDURE spInsertLecScheDetail (@lecID INT,@scheID INT ,@lecnKH NVARCHAR(100),@dotw VARCHAR(20))
AS 
BEGIN 
	INSERT INTO tbLecturerScheduleDetail VALUES(@lecID,@scheID,@lecnKH,@dotw)
END;
-- Update Lecturer Schedule Detail
GO
CREATE PROCEDURE spUpdateLecScheDetail (@oldlecid INT ,@lecID INT,@scheID INT ,@lecnKH NVARCHAR(100))
AS 
BEGIN 
	UPDATE tbLecturerScheduleDetail SET 
		LecturerID =@lecID,
		LecturerNameKH =@lecnKH
	WHERE ScheduleID = @scheID AND LecturerID = @oldlecid
END;
GO

/****************************** Create All  Trigger To Update The Denormalized Table  ************************************ */

CREATE TRIGGER trgUpdateMajorNameKH_tbStudentSummary
ON tbMajor
AFTER UPDATE
AS
BEGIN
   SET NOCOUNT ON;
   UPDATE tbStudentSummary
   SET tbStudentSummary.MajorNameKH = i.MajorNameKH
   FROM tbStudentSummary ss
   INNER JOIN inserted i ON ss.MajorNameKH = i.MajorNameKH
   INNER JOIN deleted d ON ss.MajorNameKH = d.MajorNameKH
   WHERE i.MajorNameKH <> d.MajorNameKH
END;
GO

  CREATE TRIGGER trgUpdateStudentNameKH_tbStudentSummary_tbPaymentStatus_tbAttendance
  ON tbStudent
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE tbStudentSummary
    SET tbStudentSummary.StudentNameKH = i.StudentNameKH
    FROM tbStudentSummary ss
    INNER JOIN inserted i ON ss.StudentNameKH = i.StudentNameKH
    INNER JOIN deleted d ON ss.StudentNameKH = d.StudentNameKH
    WHERE i.StudentNameKH <> d.StudentNameKH

	 UPDATE tbPaymentStatus
    SET tbPaymentStatus.StudentNameKH = i.StudentNameKH
    FROM tbPaymentStatus ps
    INNER JOIN inserted i ON ps.StudentNameKH = i.StudentNameKH
    INNER JOIN deleted d ON ps.StudentNameKH = d.StudentNameKH
    WHERE i.StudentNameKH <> d.StudentNameKH

	
	UPDATE tbAttendance
    SET tbAttendance.StudentNameKH = i.StudentNameKH
    FROM tbAttendance a
    INNER JOIN inserted i ON a.StudentNameKH = i.StudentNameKH
    INNER JOIN deleted d ON a.StudentNameKH = d.StudentNameKH
    WHERE i.StudentNameKH <> d.StudentNameKH
  END;
  GO


  CREATE TRIGGER trgUpdateMajorNameEN_tbSchedule
  ON tbMajor
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE tbSchedule
    SET tbSchedule.MajorNameEN = i.MajorNameEN
    FROM tbSchedule sc
    INNER JOIN inserted i ON sc.MajorNameEN = i.MajorNameEN
    INNER JOIN deleted d ON sc.MajorNameEN = d.MajorNameEN
    WHERE i.MajorNameKH <> d.MajorNameKH
  END;
  GO

  CREATE TRIGGER trgUpdateMajorCost_tbPayment_tbInvoice
  ON tbMajor
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE tbPayment
    SET tbPayment.MajorCost = i.MajorCost
    FROM tbPayment p
    INNER JOIN inserted i ON p.MajorCost = i.MajorCost
    INNER JOIN deleted d ON p.MajorCost = d.MajorCost
    WHERE i.MajorNameKH <> d.MajorNameKH

	 UPDATE tbInvoice
    SET tbInvoice.MajorCost = i.MajorCost
    FROM tbInvoice inv
    INNER JOIN inserted i ON inv.MajorCost = i.MajorCost
    INNER JOIN deleted d ON inv.MajorCost = d.MajorCost
    WHERE i.MajorNameKH <> d.MajorNameKH
  END;
  GO

  CREATE TRIGGER trgUpdateStaffNameKHAndPosition_tbPayment_tbInvoice_tbUser
  ON tbStaff
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
	UPDATE tbPayment
    SET tbPayment.StaffNameKH = i.StaffNameKH,
      tbPayment.StaffPosition = i.StaffPosition
    FROM tbPayment p
    INNER JOIN inserted i ON p.StaffID = i.StaffID
    INNER JOIN deleted d ON p.StaffID = d.StaffID
    WHERE i.StaffNameKH <> d.StaffNameKH OR
        i.StaffPosition <> d.StaffPosition;

		UPDATE tbInvoice
    SET tbInvoice.StaffNameKH = i.StaffNameKH,
      tbInvoice.StaffPosition = i.StaffPosition
    FROM tbInvoice inv
    INNER JOIN inserted i ON inv.StaffID = i.StaffID
    INNER JOIN deleted d ON inv.StaffID = d.StaffID
    WHERE i.StaffNameKH <> d.StaffNameKH OR
        i.StaffPosition <> d.StaffPosition;

    UPDATE tbUser
    SET tbUser.StaffNameKH = i.StaffNameKH,
      tbUser.StaffPosition = i.StaffPosition
    FROM tbUser u
    INNER JOIN inserted i ON u.StaffID = i.StaffID
    INNER JOIN deleted d ON u.StaffID = d.StaffID
    WHERE i.StaffNameKH <> d.StaffNameKH OR
        i.StaffPosition <> d.StaffPosition;
  END;
  GO

  CREATE TRIGGER trgUpdateSubjectName_tbExam_tbSubjectScheduleDetail
  ON tbSubject
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE tbExam
    SET tbExam.SubjectName = i.SubjectName
    FROM tbExam e
    INNER JOIN inserted i ON e.SubjectName = i.SubjectName
    INNER JOIN deleted d ON e.SubjectName = d.SubjectName
    WHERE i.SubjectName <> d.SubjectName

	 UPDATE tbSubjectScheduleDetail
    SET tbSubjectScheduleDetail.SubjectName = i.SubjectName
    FROM tbSubjectScheduleDetail ssd
    INNER JOIN inserted i ON ssd.SubjectName = i.SubjectName
    INNER JOIN deleted d ON ssd.SubjectName = d.SubjectName
    WHERE i.SubjectName <> d.SubjectName
  END;
  GO

  CREATE TRIGGER trgUpdateLecturer_tbLecturerScheduleDetail
  ON tbLecturer
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE tbLecturerScheduleDetail
    SET tbLecturerScheduleDetail.LecturerNameKH = i.LecturerNameKH
    FROM tbLecturerScheduleDetail lsd
    INNER JOIN inserted i ON lsd.LecturerNameKH = i.LecturerNameKH
    INNER JOIN deleted d ON lsd.LecturerNameKH = d.LecturerNameKH
    WHERE i.LecturerNameKH <> d.LecturerNameKH
  END;
  GO