
--Creating Tables Of ITI Relational Database Project

--Department Table

create table Department

(D_ID int ,
 D_name nvarchar(50),
 D_Branch nvarchar(50) default 'Menofia',
 D_Description nvarchar(50) ,
 D_Capacity int default 25,
 D_ManagerID int ,

 constraint D1 primary key(D_ID))



--Student Table

create table Student

(ST_ID int ,
 F_name varchar(20),
 L_name varchar(20),
 ST_Address varchar(100),
 ST_City varchar(20) default 'cairo',
 ST_Birthdate date ,
 ST_Age as year(getdate())-year(ST_Birthdate),
 ST_Gender varchar(1),
 ST_Email varchar(100),
 ST_Password int ,
 D_num int,
 SUP_ID int,

 constraint S1 primary key(ST_ID),
 constraint S2 check(ST_Gender='M' or ST_Gender='F'),
 constraint S3 foreign key(D_num) references Department (D_ID)
 on delete set null on update cascade )

 alter table Student add constraint S4 foreign key(SUP_ID) references Student (ST_ID)

--Instructor Table

create table Instructor

(INS_ID int ,
 F_name varchar(20),
 L_name varchar(20),
 INS_Address varchar(100),
 INS_City varchar(20) default 'cairo',
 INS_Birthdate date ,
 INS_Age as year(getdate())-year(INS_Birthdate),
 INS_Gender varchar(1),
 INS_Email varchar(100),
 INS_Salary int ,
 INS_HiringType varchar(20),
 INS_Hiringdate date ,
 INS_OutCompany varchar(50),
 D_num int,

 constraint IN1 primary key(INS_ID),
 constraint IN2 check(INS_HiringType='FULL' or INS_HiringType='PART'),
 constraint IN3 check(INS_Gender='M' or INS_Gender='F'),
 constraint IN4 foreign key(D_num) references Department (D_ID)
     on delete set null on update cascade )



Alter table Department add constraint D2 foreign key(D_ManagerID) references Instructor (INS_ID)




--Course Table

create table Course

(Crs_ID int ,
 Crs_name varchar(20),
 Crs_Duration int ,

 constraint CO1 primary key(Crs_ID))



--Topic Table

create table Topic

(T_ID int ,
 T_name varchar(20),
 Crs_ID int,

 constraint T1 primary key(T_ID),
 constraint T2 foreign key(Crs_ID) references Course (Crs_ID)
 on delete set null on update cascade )



--Qusetion Table

create table Question

(Q_ID int ,
 Q_name varchar(1000),
 Q_Type varchar(10) ,
 ANS_1 varchar(100) ,
 ANS_2 varchar(100) ,
 ANS_3 varchar(100) ,
 ANS_4 varchar(100) ,
 ANS_Right varchar(100) ,
 Crs_ID int ,

 constraint Q1 primary key(Q_ID),
 constraint Q2 check(Q_Type ='MCQ' or Q_Type='T/F'),
 constraint Q3 foreign key(Crs_ID) references Course (Crs_ID)
     on delete set null on update cascade)



--Exam Table

create table Exam

(E_ID int identity(1,1),
 E_Date date,
 E_Duration int ,

 constraint E1 primary key(E_ID))




 --Creating Tables From Many To Many Relationships

 --Grade Table

create table Grade

(Grade_id int ,
 ST_ID int ,
 Crs_ID int ,
 Grade int ,
 Grade_Date date ,
 ST_Status varchar(10),

 constraint G1 primary key(Grade_id),
 constraint G2 check(ST_Status='FAIL' or ST_Status='GOOD' or ST_Status='Very Good' or ST_Status='Excellent'),
 constraint G3 foreign key(ST_ID) references Student (ST_ID) on update cascade ,
 constraint G4 foreign key(Crs_ID) references Course (Crs_ID) on update cascade )



 --Instructor_Course Table

create table Instructor_Course

(INS_ID int ,
 Crs_ID int ,

 constraint IC1 primary key(INS_ID,Crs_ID),
 constraint IC2 foreign key(INS_ID) references Instructor (INS_ID) on update cascade ,
 constraint IC3 foreign key(Crs_ID) references Course (Crs_ID) on update cascade )




--Department_Course Table

create table Department_Course

(D_ID int ,
 Crs_ID int ,

 constraint DC1 primary key(D_ID,Crs_ID),
 constraint DC2 foreign key(D_ID) references Department (D_ID) on update cascade,
 constraint DC3 foreign key(Crs_ID) references Course (Crs_ID) on update cascade )



--Course_Exam Table

create table Course_Exam

( Crs_ID int ,
  E_ID int ,
  Min_Grade int,

 constraint CE1 primary key(Crs_ID,E_ID),
 constraint CE2 foreign key(Crs_ID) references Course (Crs_ID)
 on update cascade ,
 constraint CE3 foreign key(E_ID) references Exam (E_ID)
 on update cascade )



--Student_Exam Table

create table Student_Exam

( ST_ID int ,
  E_ID int ,
  Exam_Grade int ,

 constraint SE1 primary key(ST_ID,E_ID),
 constraint SE2 foreign key(ST_ID) references Student (ST_ID)
 on update cascade ,
 constraint SE3 foreign key(E_ID) references Exam (E_ID)
 on update cascade)



 --Exam_Question Table

create table Exam_Question

( E_ID int ,
  Q_ID int ,
  ST_Answer varchar(100),
  Q_Grade int,

 constraint EQ1 primary key(E_ID,Q_ID),
 constraint EQ2 check (Q_Grade=10 or Q_Grade=0),
 constraint EQ3 foreign key(E_ID) references Exam (E_ID)
 on update cascade ,
 constraint EQ4 foreign key(Q_ID) references Question (Q_ID)
 on update cascade)


