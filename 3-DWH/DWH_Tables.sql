
-- DIMENSIONAL TABLES 


CREATE TABLE [dbo].[STUDENT_DIM]
(
    [STUDENT_SK] [int] identity (1,1) PRIMARY KEY ,
	[ST_ID_BK] [int] NOT NULL,
	[F_NAME] [varchar](20) NULL,
	[L_NAME] [varchar](20) NULL,
	[ST_ADDRESS] [varchar](100) NULL,
	[ST_CITY] [varchar](20) NULL,
	[ST_BIRTHDATE] [date] NULL,
	[ST_AGE] [int] NULL,
	[ST_GENDER] [varchar](1) NULL,
	[ST_EMAIL] [varchar](100) NULL,
	[ST_PASSWARD] [int] NOT NULL,
	[D_NUM] [int] NULL,
	[SUP_ID] [int] NULL,

	[starting_date] [datetime] not null default (getdate()),
	[ending_date] [datetime] null ,
	[is_current] [int] not null default (1),
	[Source_Code] [int] NOT NULL )



CREATE TABLE [dbo].[COURSE_DIM]
(
    [COURSE_SK] [int] identity (1,1) PRIMARY KEY ,
	[CRS_ID_BK] [int] NOT NULL,
	[CRS_NAME] [varchar](20) NULL,
	[CRS_DURATION] [INT] NULL,

	[TOPIC_ID_BK] [int] NOT NULL,
	[TOPIC_NAME] [varchar](20) NULL,
	[TOPIC_DURATION] [INT] NULL,
	
	[QUESTION_ID_BK] [int] NOT NULL,
	[QUESTION_NAME] [varchar](1000) NULL,
	[QUESTION_TYPE] [varchar](10) NULL,
	[ANS1] [varchar](100) NULL,
	[ANS2] [varchar](100) NULL,
	[ANS3] [varchar](100) NULL,
	[ANS4] [varchar](100) NULL,
	[ANS_RIGHT] [varchar](100) NULL,
 
	[starting_date] [datetime] not null default (getdate()),
	[ending_date] [datetime] null ,
	[is_current] [int] not null default (1),
	[Source_Code] [int] NOT NULL )




CREATE TABLE [dbo].[INSTRUCTOR_DIM]
(
    [INSTRUCTOR_SK] [int] identity (1,1) PRIMARY KEY ,
	[INS_ID_BK] [int] NOT NULL unique ,
	[F_NAME] [varchar](20) NULL,
	[L_NAME] [varchar](20) NULL,
	[INS_ADDRESS] [varchar](100) NULL,
	[INS_CITY] [varchar](20) NULL,
	[INS_BIRTHDATE] [date] NULL,
	[INS_AGE] [int] NULL,
	[INS_GENDER] [varchar](1) NULL,
	[INS_EMAIL] [varchar](100) NULL,
	[INS_SALARY] [int] NOT NULL,
	[INS_HIRING_TYPE] [varchar](20) NULL,
	[INS_HIRING_DATE] [date] NULL,
	[INS_OUT_COMPANY] [varchar](50) NULL,
	[D_NUM] [int] NULL,

	[starting_date] [datetime] not null default (getdate()),
	[ending_date] [datetime] null ,
	[is_current] [int] not null default (1),
	[Source_Code] [int] NOT NULL )




CREATE TABLE [dbo].[DEPARTMENT_DIM]
(
    [DEPARTMENT_SK] [int] identity (1,1) PRIMARY KEY ,
	[D_ID_BK] [int] NOT NULL unique ,
	[D_NAME] [varchar](50) NULL,
	[D_BRANCH] [varchar](50) NULL,
	[D_DESCRIPTION] [varchar](50) NULL,
	[D_CAPACITY] [INT] NULL,
	[D_MANAGER_ID] [INT] NULL,

	[starting_date] [datetime] not null default (getdate()),
	[ending_date] [datetime] null ,
	[is_current] [int] not null default (1),
	[Source_Code] [int] NOT NULL )




CREATE TABLE [dbo].[EXAM_DIM]
(
    [EXAM_SK] [int] identity (1,1) PRIMARY KEY ,
	[E_ID_BK] [int] NOT NULL,
	[E_DATE] [DATE] NULL,
	[E_DURATION] [INT] NULL,

	[CRS_ID_BK] [int] NOT NULL,
	[ST_ID_BK] [INT] NULL,
	[MIN_GRADE] [INT] NULL,
	
	[QUESTION_ID_BK] [int] NOT NULL,
	[ST_ANSWER] [varchar](100) NULL,
	[QUESTION_GRADE] [INT] NULL,
 
	[starting_date] [datetime] not null default (getdate()),
	[ending_date] [datetime] null ,
	[is_current] [int] not null default (1),
	[Source_Code] [int] NOT NULL )



-- HIERARCHY TABLES 

CREATE TABLE [dbo].[INSTRUCTOR_COURSES]
(
    [INS_ID_BK] [int] NOT NULL ,
	[CRS_ID_BK] [int] NOT NULL ,

    constraint IC1 primary key( INS_ID_BK , Crs_ID_BK ))

CREATE TABLE [dbo].[DEPARTMENT_COURSES]
(
    [D_ID_BK] [int] NOT NULL ,
	[CRS_ID_BK] [int] NOT NULL ,

    constraint DC1 primary key( D_ID_BK , Crs_ID_BK ))


-- FACT TABLE


CREATE TABLE [dbo].[GRADE_FACT]
(
    [GRADE_FACT_SK] [int] identity (1,1) PRIMARY KEY ,
	[STUDENT_SK_FK] [int] null ,
	[COURSE_SK_FK] [int] null,
	[INSTRUCTOR_SK_FK] [int] null,
	[DEPARTMENT_SK_FK] [int] null ,
	[Date_SK_FK] [int] null ,
	[EXAM_SK_FK] [INT] NULL,
	[EXAM_ID] [INT] NULL,
	[EXAM_GRADE] [int] NOT NULL,
	[EXAM_Date] [DATE] NOT NULL,

	[Created_at] [Datetime] not null default (getdate()),
	[Source_Code] [int] NOT NULL )

CREATE TABLE [dbo].[Total_GRADE_FACT]
(
    [GRADE_FACT_SK] [int] identity (1,1) PRIMARY KEY ,
	[STUDENT_SK_FK] [int] null ,
	[COURSE_SK_FK] [int] null,
	[Date_SK_FK] [int] null ,
	[Grade_ID] [INT] NULL,
	[GRADE] [int] NOT NULL,
	[GRADE_Date] [DATE] NOT NULL,
	[ST_STATUS] [VARCHAR](10) NOT NULL,

	[Created_at] [Datetime] not null default (getdate()),
	[Source_Code] [int] NOT NULL )

-- LAST LOAD TABLE


CREATE TABLE [dbo].[LAST_LOAD] 
(
  [id] [int] , 
  [last_details] [varchar] (20) , 
  [last_date] [datetime] , 
  [last_id] [int] )
