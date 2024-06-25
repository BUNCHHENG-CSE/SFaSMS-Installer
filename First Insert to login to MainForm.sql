INSERT INTO tbStaff( StaffNameKH,StaffNameEN,Gender,BirthDate,StaffPosition ,StaffAddress,ContactNumber,PersonalNumber,HiredDate ) 
VALUES(N'បុគ្គលិក ១','Staff 1','Male','2000-10-1','Administrator','Phnom Penh','01011111','012344555','2010-12-5')
GO
INSERT INTO tbStaff( StaffNameKH,StaffNameEN,Gender,BirthDate,StaffPosition ,StaffAddress,ContactNumber,PersonalNumber,HiredDate ) 
VALUES(N'បុគ្គលិក ២','Staff 2','Male','2000-10-1','Accountant','Phnom Penh','01011111','012344555','2010-12-5')
GO
INSERT INTO tbUser(Username,Password,StaffID,StaffNameKH,StaffPosition)
VALUES ('Admin','admin12345'	,1	,N'បុគ្គលិក ១'​,'Administrator')
GO
INSERT INTO tbUser(Username,Password,StaffID,StaffNameKH,StaffPosition)
VALUES ('User1','user12345'	,2	,N'បុគ្គលិក ២'​,'Accountant')
GO