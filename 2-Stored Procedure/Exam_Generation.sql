
alter proc Generate_Exam @Crs_Id int, @Student_Id int
as
	begin try
		if not exists (select * from Course where ID = @Crs_Id)
			begin
			print 'The Course ID You just Entered Does Not Match Any Of Our Records'
			end
		else
			if not exists (select * from Student where ST_ID = @Student_Id)
			begin
				print 'The Student ID You just Entered Does Not Match Any Of Our Records'
			end
		else
			begin
			declare @Exam_Duration int = 60
			insert into Exam(E_Date, E_Duration)
			values (getdate(), @Exam_Duration)

			declare @Exam_No int = (select scope_identity())

			insert into Exam_Question(E_ID, Q_ID)
			select top(5) @Exam_No, Q.ID
			from Question Q
			where Q.Course_ID = @Crs_Id and Q.Type = 'TFQ'
			order by newid()

			insert into Exam_Question(E_ID, Q_ID)
			select top(5) @Exam_No, Q.ID
			from Question Q
			where Q.Course_ID = @Crs_Id and Q.Type = 'MCQ'
			order by newid()

			insert into Course_Exam(E_ID, Crs_ID)
			values (@Exam_No, @Crs_Id)

			insert into Student_Exam(E_ID, ST_ID)
			values (@Exam_No, @Student_Id)

			select Q.*
			from Question Q, Exam_Question EQ, Exam E
			where Q.ID = EQ.Q_ID and E.E_ID = EQ.E_ID and E.E_ID = @Exam_No
		end
	end try
	begin catch
		print 'An Error occurred, try again'
	end catch

Generate_Exam 2, 4002

select * from Question
select * from Exam_Question
select * from Exam
select * from Course_Exam
select * from Student_Exam
select *