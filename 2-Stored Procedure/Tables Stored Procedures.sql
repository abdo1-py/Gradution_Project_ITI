alter proc view_student_data
	@student_id int = null
as
begin try
	if @student_id is null
		begin
			select *
			from student
		end
	else
		if @student_id is not null and not exists (select * from Student where ST_ID = @student_id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from Student
			where ST_ID = @student_id
		end
end try
begin catch
	print('There was an error, please try again')
end catch
view_student_data
------------------------
alter proc add_student
    @id int = null,
    @fname varchar(50) = null,
    @lname varchar(50) = null,
    @address varchar(50) = null,
    @city varchar(50) = null,
    @birthdate date = null,
    @gender varchar(10) = null,
    @email varchar(100) = null,
    @password int = null,
    @department_no int = null,
    @super_id int = null
as
begin try
	if @id is null
		begin
			print('You need to enter student id.')
		end
	else
		if @department_no is null
			begin
				print('You need to enter department id.')
			end
	else
		if @super_id is null
			begin
				print('You need to enter team leader id.')
			end
	else
		if @id is not null and exists (select * from student where st_id = @id)
			begin
				print ('A student is already registered with this id.')
			end
    else
		if @department_no is not null and not exists (select * from department where D_ID = @department_no)
			begin
				print ('The department id you just entered does not exist.')
			end
	else
		if @super_id is not null and not exists (select * from Student where ST_ID = @super_id)
			begin
				print('The team leader id you just entered does not exist.')
			end
    else
		begin
			insert into student
			values(@id, @fname, @lname, @address, @city, @birthdate, @gender, @email, @password, @department_no, @super_id)
			print('The new student data got saved successfully.')
		end
end try
begin catch
	print('There was an error, please try again')
end catch

add_student 9005,'Youssef', 'Fathy', 'Nirco, Zahraa El Maadi', 'Cairo', '1999-10-05', 'M', 'yousseffathy@yahoo.com', 7773000, 101, 4001
view_student_data 9005
--------------------------
alter proc update_student
    @id int = null,
    @fname varchar(50) = null,
    @lname varchar(50) = null,
    @address varchar(50) = null,
    @city varchar(50) = null,
    @birthdate date = null,
    @gender varchar(10) = null,
    @email varchar(100) = null,
    @password bigint = null,
    @department_no int = null,
	@super_id int = null
as
begin try
	if @id is null
		begin
			print('You need to enter student id')
		end
	else
		if @id is not null and not exists (select * from student where ST_ID = @id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		if @department_no is not null and not exists (select * from department where d_id = @department_no)
			begin
				print ('The department id you just entered does not exist.')
			end
	else
		if @super_id is not null and not exists (select * from student where st_id = @super_id)
			begin
				print ('The team leader id you just entered does not exist.')
			end
	else
		begin
			update Student
			set F_name = isnull(@fname, F_name),
				L_name = isnull(@lname, L_name),
				ST_Address = isnull(@address, ST_Address),
				ST_City = isnull(@city, ST_City),
				ST_Birthdate = isnull(@birthdate, ST_Birthdate),
				ST_Gender = isnull(@gender, ST_Gender),
				ST_Email = isnull(@email, ST_Email),
				ST_Password = isnull(@password, ST_Password),
				D_num = isnull(@department_no, D_num),
				SUP_ID = isnull(@super_id, Sup_Id)
			where ST_ID = @id
			print('Student record got updated successfully.')
		end
end try
begin catch
	print('There was an error, please try again')
end catch

update_student @id = 4001, @fname = 'Ali'
select * from Student where st_id = 4001
-------------------------------
alter proc delete_student

	@student_id int = null
as
begin try
	if @student_id is null
		begin
			print('You need to enter student id')
		end
	else
		if @student_id is not null and not exists (select * from student where ST_ID = @student_id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		begin
			delete from Student
			where ST_ID = @student_id
			print('Student record got deleted successfully.')
		end
end try
begin catch
	print('There was an error, please try again')
end catch

delete_student 9005
select * from Student where ST_ID = 9005

------------------------------------------------------------------------------------------------------------------------

create proc View_Question
	@question_id int
as
	if not exists (select * from Question where ID = @question_id)
		begin
			print('The question id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from Question
			where ID = @question_id
		end

View_Question 2
--------------------------------
create proc add_question
    @id int,
    @question varchar(max),
    @type varchar(50),
    @answer_1 varchar(max),
    @answer_2 varchar(max),
    @answer_3 varchar(max),
    @answer_4 varchar(max),
    @correct_answer varchar(max),
    @course_id int
as
	if exists (select * from question where id = @id)
		begin
			print ('This question already exists in the database.')
		end
    else
		if not exists (select * from course where id = @course_id)
			begin
				print('This course id does not match any of our records.')
			end
	else
		begin
			insert into question
			values(@id, @question, @type, @answer_1, @answer_2, @answer_3, @answer_4, @correct_answer, @course_id)
			print('The new question got inserted successfully.')
		end

add_question 719, 'What does the <canvas> element in HTML5 provide?', 'MCQ', 'A container for audio content.', 'A container for video content.', 'A way to draw graphics using JavaScript.', 'A form element for input validation.', 'A way to draw graphics using JavaScript.', 32
select * from Question where ID = 719
--------------------------------
alter proc Update_Question
	@question_id int,
	@type varchar(50),
	@new_question varchar(max),
	@new_answer1 varchar(max),
	@new_answer2 varchar(max),
	@new_answer3 varchar(max) = null,
	@new_answer4 varchar(max) = null,
	@new_correct_answer varchar(max),
	@new_course_id int
as
	if not exists (select * from question where id = @question_id)
		begin
			print('The question id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from course where id = @new_course_id)
			begin
				print('This course id does not match any of our records.')
			end
	else
		begin
			update Question
			set Type = @type,
				Question = @new_question,
				Answer_1 = @new_answer1,
				Answer_2 = @new_answer2,
				Answer_3 = @new_answer3,
				Answer_4 = @new_answer4,
				Correct_Answer = @new_correct_answer,
				Course_ID = @new_course_id
			where id = @question_id
			print('question got updated successfully')
		end
select * from Question
Update_Question @question_id = 1, @type = 'MCQ', @new_question = 'Which of the following data sources can be connected to Power BI for data visualization?', @new_answer1 = 'Excel files', @new_answer2 = 'Web services', @new_answer3 = 'SQL Server databases', @new_answer4 = 'All of the above', @new_correct_answer = 'All of the above', @new_course_id = 1
select * from Question
Update_Question @question_id = 1,@type = 'TFQ', @new_question = 'Power BI allows data visualization from multiple sources.', @new_answer1 = '[True]', @new_answer2 = '[False]', @new_correct_answer = '[True]', @new_course_id = 1
select * from Question
-----------------------------------------
create proc delete_question
	@question_id int
as
	if not exists (select * from question where id = @question_id)
		begin
			print('The question id you just entered does not match any of our records.')
		end
	else
		begin
			delete from Question
			where ID = @question_id
			print('Question record got deleted successfully.')
		end

delete_question 719
-------------------------------------------------------------------------------------------
create proc View_Department
	@department_id int
as
	if not exists (select * from Department where D_ID = @department_id)
		begin
			print('The department id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from Department
			where D_ID = @department_id
		end

View_Department 103
-------------------------------------------
alter proc add_department
    @id int,
    @name varchar(50) = null,
    @branch varchar(50) = null,
    @description varchar(max) = null,
    @capacity int = null,
    @manager_id int = null
as
	if exists (select * from department where d_id = @id)
	begin
		print('Either you did not pass an id for the department or the id already exists.')
    end
	else
		if not exists (select * from instructor where ins_id = @manager_id)
		begin
			print('Either you did not pass an id for the manager or the id you just entered does not exist.')
		end
    else
    begin
        insert into department
        values(@id, @name, @branch, @description, @capacity, @manager_id)
        print('The new department data got saved successfully.')
    end

add_department 149, 'Data Science', 'Smart Village', 'Data Science and AI', 20, 1
select * from Department where D_ID = 149
-------------------------------------------
alter proc update_department
    @id int = null,
    @name varchar(50) = null,
    @branch varchar(50) = null,
    @description varchar(max) = null,
    @capacity int = null,
    @manager_id int = null
as
	if not exists (select * from department where d_id = @id)
	begin
		print('Either you did not pass an id for the department or the id does not exist.')
    end
	else
	if @manager_id is not null and not exists (select * from instructor where ins_id = @manager_id)
	begin
		print('The manager id does not exist.')
	end
	else
		begin
			update Department
			set D_name = isnull(@name, D_name),
				D_Branch = isnull(@branch, D_Branch),
				D_Description = isnull(@description, D_Description),
				D_Capacity = isnull(@capacity, D_Capacity),
				D_ManagerID = isnull(@manager_id, D_ManagerID)
			where D_ID = @id
			print('Department record got updated successfully.')
		end

update_department @id = 149, @description = 'Information Systems'
select * from Department where D_ID = 149
---------------------------------------------
create proc Delete_Department
	@id int
as
	if not exists (select * from department where d_id = @id)
		begin
			print('The department id you just entered does not match any of our records.')
		end
	else
		begin
			delete from department
			where d_id = @id
			print('Department record got deleted successfully.')
		end

Delete_Department 148
select * from department where d_id = 148
---------------------------------------------------------------------------------------------------------------
create proc View_Instructor
	@id int
as
	if not exists (select * from Instructor where ins_id = @id)
		begin
			print('The instructor id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from instructor
			where ins_id = @id
		end

View_Instructor 9
-------------------------------------------------
create proc add_instructor
    @id int = null,
    @fname varchar(50) = null,
    @lname varchar(50) = null,
    @gender varchar(10) = null,
	@email varchar(100) = null,
	@salary int = null,
	@hiring_type varchar(20)= null,
	@hiring_date date = null,
    @out_company varchar(50) = null,
    @department_no int = null
as
	if exists (select * from instructor where ins_id = @id)
	begin
		print ('Either you did not pass an id or an instructor is already registered with this id.')
    end
    else
	if not exists (select * from department where d_id = @department_no)
	begin
		print ('Either you did not pass a department id or the department id you just entered does not exist.')
    end
    else
    begin
        insert into instructor
        values(@id, @fname, @lname, @gender, @email, @salary, @hiring_type, @hiring_date, @out_company, @department_no)
        print('The new instructor data got saved successfully.')
    end

add_instructor @id = 130, @fname = 'Muhammad', @lname = 'Omar', @gender = 'M', @email = 'momo19@icloud.com', @salary = 4200, @hiring_type = 'Full Time', @hiring_date = '2023-6-30', @out_company = 'Ikea', @department_no = 101
select * from Instructor where ins_id = 130
-----------------------------------------------
alter proc update_instructor
    @id int,
    @fname varchar(50) = null,
    @lname varchar(50) = null,
    @gender varchar(10) = null,
	@email varchar(100) = null,
	@salary int = null,
	@hiring_type varchar(20)= null,
	@hiring_date date = null,
    @out_company varchar(50) = null,
    @department_no int = null
as
	if not exists (select * from instructor where ins_id = @id)
		begin
			print('The instructor id you just entered does not match any of our records.')
		end
	else
		if @department_no is not null and not exists (select * from department where d_id = @department_no)
		begin
			print('The department id you just entered does not exist.')
		end
	else
		begin
			update instructor
			set f_name = isnull(@fname, f_name),
				l_name = isnull(@lname, l_name),
				ins_Gender = isnull(@gender, ins_Gender),
				ins_email = isnull(@email, ins_email),
				ins_salary = isnull(@salary, ins_salary),
				ins_hiringtype = isnull(@hiring_type, ins_hiringtype),
				ins_hiringdate = isnull(@hiring_date, ins_hiringdate),
				ins_outcompany = isnull(@out_company, ins_outcompany),
				d_num = isnull(@department_no, d_num)
			where ins_id = @id
			print('Instructor record got updated successfully.')
		end

update_instructor @id = 130, @fname = 'Alimisa'
select * from Instructor where ins_id = 130
-----------------------------------------------------------
create proc Delete_Instructor
	@id int
as
	if not exists (select * from instructor where ins_id = @id)
		begin
			print('The instructor id you just entered does not match any of our records.')
		end
	else
		begin
			delete from instructor
			where ins_id = @id
			print('Instructor record got deleted successfully.')
		end

Delete_Instructor 130
select * from instructor where ins_id = 130
----------------------------------------------------------
create proc View_Topic
	@id int
as
	if not exists (select * from topic where id = @id)
		begin
			print('The topic id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from topic
			where id = @id
		end

View_Topic 22
----------------------------------------------------------
create proc Add_Topic
    @id int = null,
    @topic_name varchar(50) = null,
    @course_id int = null
as
	if exists (select * from topic where id = @id)
	begin
		print ('Either you did not pass a topic id or there is a topic already registered with this id.')
    end
    else
	if not exists (select * from course where id = @course_id)
	begin
		print ('Either you did not pass a course id or the course id you just entered does not exist.')
    end
    else
    begin
        insert into topic
        values(@id, @topic_name, @course_id)
        print('The new topic data got saved successfully.')
    end

Add_Topic 441, 'Power BI Dashboards', 1
select * from topic
----------------------------------------------------------
alter proc Update_Topic
    @id int,
    @topic_name varchar(50) = null,
    @course_id int = null
as
	if not exists (select * from topic where id = @id)
		begin
			print('The topic id you just entered does not match any of our records.')
		end
	else
		if @course_id is not null and not exists (select * from course where id = @course_id)
		begin
			print('The course id you just entered does not exist.')
		end
	else
		begin
			update topic
			set topic_name = isnull(@topic_name, topic_name),
				course_id = isnull(@course_id, course_id)
			where id = @id
			print('Topic record got updated successfully.')
		end

Update_Topic 441, 'D,mm'
select * from topic where id = 441
-----------------------------------------------------------
create proc Delete_Topic
	@id int
as
	if not exists (select * from topic where id = @id)
		begin
			print('The topic id you just entered does not match any of our records.')
		end
	else
		begin
			delete from topic
			where id = @id
			print('Topic record got deleted successfully.')
		end

Delete_Topic 441
select * from topic where id = 441
----------------------------------------------------------------------------------------------------------------------------------
create proc View_Course
	@id int
as
	if not exists (select * from course where id = @id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from course
			where id = @id
		end

View_Course 1
------------------------------------------------------
create proc Add_Course
    @id int = null,
    @course_name varchar(50) = null,
    @duration int = null
as
	if exists (select * from course where id = @id)
	begin
		print ('Either you did not pass any course id or there is a course already registered with this id.')
    end
    else
    begin
        insert into course
        values(@id, @course_name, @duration)
        print('The new course data got saved successfully.')
    end

Add_Course 45, 'CS50', 120
select * from course where id = 45
-----------------------------------------------------
create proc Update_Course
    @id int,
    @course_name varchar(50) = null,
    @duration int = null
as
	if not exists (select * from course where id = @id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		begin
			update course
			set course_name = isnull(@course_name, course_name),
				duration = isnull(@duration, duration)
			where id = @id
			print('Course record got updated successfully.')
		end

Update_Course 45, 'NO SQL', 22
select * from course where id = 45
-----------------------------------------------------
create proc Delete_Course
	@id int
as
	if not exists (select * from course where id = @id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		begin
			delete from course
			where id = @id
			print('Course record got deleted successfully.')
		end

Delete_Course 45
select * from course where id = 45
----------------------------------------------------------------------------------------------------------------------------------
create proc View_Exam
	@id int
as
	if not exists (select * from exam where e_id = @id)
		begin
			print('The exam id you just entered does not match any of our records.')
		end
	else
		begin
			select *
			from exam
			where e_id = @id
		end

select * from exam
View_Exam 7
select getdate()
-----------------------------------------------------------------------------------------
alter proc Add_Exam
    @date date = null,
    @duration int = 60
as
    begin
		if @date is null
			set @date = getdate()
        insert into exam
        values(@date, @duration)
        print('The new exam data got saved successfully.')
    end

Add_Exam @date= '1999-03-07'
select* from exam 
---------------------------------------------------------------------------------------
alter proc Update_Exam
    @id int = null,
    @date date = null,
    @duration int = null
as
	if @id is null
		print('Youn need to enter an exam id.')
	else
		if @id is not null and not exists (select * from exam where e_id = @id)
		begin
			print('The exam id you just entered does not match any of our records.')
		end
	else
		begin
			update exam
			set e_date = isnull(@date, e_date),
				e_duration = isnull(@duration, e_duration)
			where e_id = @id
			print('Exam record got updated successfully.')
		end

Update_Exam 8, '2024-3-1'
select * from exam
-----------------------------------------------------------------------------------------
create proc Delete_Exam
	@id int
as
	if not exists (select * from exam where e_id = @id)
		begin
			print('The exam id you just entered does not match any of our records.')
		end
	else
		begin
			delete from exam
			where e_id = @id
			print('Exam record got deleted successfully.')
		end

Delete_Exam 9
select * from exam
---------------------------------------------------------------------------------------------------------------------------
create proc Add_Grade
	@St_id int,
	@Crs_id int,
	@Grade int = null,
	@Status varchar(10) = null
as
	if not exists (select * from student where st_id = @St_id)
		begin
			print('The student id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from course where id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
    else
    begin
        insert into grade
        values(@St_id, @Crs_id, @Grade, @Status)
        print('The new grade data got saved successfully.')
    end

Add_Grade @St_id = 4003, @Crs_id = 1, @Grade = 9, @Status = 'Good'
	select * from grade
------------------------------------------------------------------------------------
create proc View_Grade
	@St_id int = null,
	@Crs_id int = null
as
	if @St_id is null
		begin
			print('You need to enter student id')
		end
	else
		if @Crs_id is null
			begin
				print('You need to enter course id')
			end
	else
		if @St_id is not null and not exists (select * from grade where st_id = @St_id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		if @Crs_id is not null and not exists (select * from grade where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from grade
			where st_id = @St_id and crs_id = @Crs_id
		end

View_Grade 4003, 1
--------------------------------------------------------------------------------------
create proc Update_Grade

	@St_id int = null,
	@Crs_id int = null,
	@Grade int = null,
	@status varchar(10) = null
as
	if @St_id is null
		begin
			print('You need to enter student id')
		end
	else
		if @Crs_id is null
			begin
				print('You need to enter course id')
			end
	else
		if @St_id is not null and not exists (select * from grade where st_id = @St_id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		if @Crs_id is not null and not exists (select * from grade where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
    else
		begin
			update grade
			set grade = isnull(@grade, grade),
				st_status = isnull(@status, st_status)
			where st_id = @St_id and crs_id = @Crs_id
			print('Grade record got updated successfully.')
		end

Update_Grade @St_id = 4003, @Crs_id = 1, @Grade = 3, @status = 'fail'
select * from grade
---------------------------------------------------------------------------------------
create proc Delete_Grade
	@St_id int,
	@Crs_id int
as
	if not exists (select * from grade where st_id = @St_id)
		begin
			print('The student id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from grade where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
    else
		begin
			delete from grade
			where st_id = @St_id and crs_id = @Crs_id
			print('Grade record got deleted successfully.')
		end

Delete_Grade 4003, 1
select * from grade
----------------------------------------------------------------------------------------------------------------------------------
alter proc Add_Exam_Question
	@Ex_id int,
	@Q_id int,
	@St_Answer varchar(100) = null,
	@Q_Grade int = null
as
	if not exists (select * from exam where e_id = @Ex_id)
		begin
			print('The exam id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from question where id = @Q_id)
			begin
				print('The question id you just entered does not match any of our records.')
			end
    else
    begin
        insert into exam_question
        values(@Ex_id, @Q_id, @St_Answer, @Q_Grade)
        print('The new exam_question data got saved successfully.')
    end

Add_Exam_Question @Ex_id = 10, @Q_id = 140, @St_Answer = 'List files and directories', @Q_Grade = 10
Add_Exam_Question @Ex_id = 10, @Q_id = 141, @St_Answer = 'rm', @Q_Grade = 0
select * from exam_question
----------------------------------------------------------------------------------------------------
create proc View_Exam_Question
	@Ex_id int = null,
	@Q_id int = null
as
	if @Ex_id is null
		begin
			print('You need to enter exam id')
		end
	else
		if @Q_id is null
			begin
				print('You need to enter question id')
			end
	else
		if @Ex_id is not null and not exists (select * from exam_question where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
	else
		if @Q_id is not null and not exists (select * from exam_question where q_id = @Q_id)
			begin
				print('The question id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from exam_question
			where e_id = @Ex_id and q_id = @Q_id
		end

View_Exam_Question @Ex_id = 10, @Q_id = 140
---------------------------------------------------------------------------------------------------
create proc Update_Exam_Question

	@Ex_id int = null,
	@Q_id int = null,
	@St_Answer varchar(100) = null,
	@Q_Grade int = null
as
	if @Ex_id is null
		begin
			print('You need to enter exam id')
		end
	else
		if @Q_id is null
			begin
				print('You need to enter question id')
			end
	else
		if @Ex_id is not null and not exists (select * from exam_question where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
	else
		if @Q_id is not null and not exists (select * from exam_question where q_id = @Q_id)
			begin
				print('The question id you just entered does not match any of our records.')
			end
    else
		begin
			update exam_question
			set st_answer = isnull(@St_Answer, st_answer),
				q_grade = isnull(@Q_Grade, q_grade)
			where e_id = @Ex_id and q_id = @Q_id
			print('Exam_question record got updated successfully.')
		end

Update_Exam_Question @Ex_id = 10, @Q_id = 140, @St_Answer = 'Remove files and directories', @Q_Grade = 0
select * from exam_question
------------------------------------------------------------------------------------------------------
create proc Delete_Exam_Question
	@Ex_id int,
	@Q_id int
as
	if not exists (select * from exam_question where e_id = @Ex_id)
		begin
			print('The exam id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from exam_question where q_id = @Q_id)
			begin
				print('The question id you just entered does not match any of our records.')
			end
    else
		begin
			delete from exam_question
			where e_id = @Ex_id and q_id = @Q_id
			print('Exam_question record got deleted successfully.')
		end

Delete_Exam_Question @Ex_id = 10, @Q_id = 140
select * from exam_question
-----------------------------------------------------------------------------------------------------
alter proc Add_Course_Exam
	@Crs_id int,
	@Ex_id int,
	@Min_Grade int = null
as
	if not exists (select * from course where id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
    else
    begin
        insert into course_exam
        values(@Crs_id, @Ex_id, @Min_Grade)
        print('The new course_exam data got saved successfully.')
    end

Add_Course_Exam @Crs_id = 11, @Ex_id = 5, @Min_Grade = 60
select * from course_exam
----------------------------------------------------------------------------------------------------
create proc View_Course_Exam
	@Crs_id int = null,
	@Ex_id int = null
as
	if @Crs_id is null
		begin
			print('You need to enter course id')
		end
	else
		if @Ex_id is null
			begin
				print('You need to enter exam id')
			end
	else
		if @Ex_id is not null and not exists (select * from course_exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
	else
		if @Crs_id is not null and not exists (select * from course_exam where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from course_exam
			where e_id = @Ex_id and crs_id = @Crs_id
		end

View_Course_Exam @Crs_id = 11, @Ex_id = 5
---------------------------------------------------------------------------------------------------
alter proc Update_Course_Exam

	@Crs_id int = null,
	@Ex_id int = null,
	@Min_Grade int = null
as
	if @Ex_id is null
		begin
			print('You need to enter exam id')
		end
	else
		if @Crs_id is null
			begin
				print('You need to enter course id')
			end
	else
		if @Ex_id is not null and not exists (select * from course_exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
	else
		if @Crs_id is not null and not exists (select * from course_exam where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
    else
		begin
			update course_exam
				set min_grade = isnull(@Min_Grade, min_grade)
			where e_id = @Ex_id and crs_id = @Crs_id
			print('Course_Exam record got updated successfully.')
		end

Update_Course_Exam 11, 5, 90
select * from course_exam
---------------------------------------------------------------------------------------------------
create proc Delete_Course_Exam
	@Crs_id int,
	@Ex_id int
as
	if not exists (select * from course_Exam where crs_id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from course_exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
    else
		begin
			delete from course_exam
			where crs_id = @Crs_id and e_id = @Ex_id
			print('Course_exam record got deleted successfully.')
		end

Delete_Course_Exam 11, 5
select * from course_exam
----------------------------------------------------------------------------------------------------------------------------------
create proc Add_Student_Exam
	@St_id int,
	@Ex_id int
as
	if not exists (select * from student where st_id = @St_id)
		begin
			print('The student id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
    else
    begin
        insert into student_exam
        values(@St_id, @Ex_id)
        print('The new student_exam data got saved successfully.')
    end


Add_Student_Exam 4009, 2
select * from Student_Exam
-----------------------------------------------------------------------------------------
create proc View_Student_Exam
	@St_id int = null,
	@Ex_id int = null
as
	if @St_id is null
		begin
			print('You need to enter student id')
		end
	else
		if @Ex_id is null
			begin
				print('You need to enter exam id')
			end
	else
		if @St_id is not null and not exists (select * from student_exam where st_id = @St_id)
			begin
				print('The student id you just entered does not match any of our records.')
			end
	else
		if @Ex_id is not null and not exists (select * from student_exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from student_exam
			where st_id = @St_id and e_id = @Ex_id
		end

View_Student_Exam 4008, 2
----------------------------------------------------------------------------------------
create proc Update_Student_Exam

	@old_St_id int = null,
	@old_Ex_id int = null,
	@new_St_id int = null,
	@new_Ex_id int = null
as
	if @old_St_id is null
		begin
			print('You need to enter the old student id')
		end
	else
		if @old_Ex_id is null
			begin
				print('You need to enter the old exam id')
			end
	else
		if @old_St_id is not null and not exists (select * from student_exam where st_id = @old_St_id)
			begin
				print('The old student id you just entered does not match any of our records.')
			end
	else
		if @old_Ex_id is not null and not exists (select * from student_exam where e_id = @old_Ex_id)
			begin
				print('The old exam id you just entered does not match any of our records.')
			end
	else
		if @new_St_id is not null and not exists (select * from student where st_id = @new_St_id)
			begin
				print('The new student id you just entered does not match any of our records.')
			end
	else
		if @new_Ex_id is not null and not exists (select * from exam where e_id = @new_Ex_id)
			begin
				print('The new exam id you just entered does not match any of our records.')
			end
    else
		begin
			update student_exam
			set st_id = isnull(@new_St_id, @old_St_id),
				e_id = isnull(@new_Ex_id, @old_Ex_id)
			where st_id = @old_St_id and e_id = @old_Ex_id
			print('Student_course record got updated successfully.')
		end

Update_Student_Exam @old_St_id = 4009, @old_Ex_id = 2, @new_Ex_id = 7
select * from student_exam
-----------------------------------------------------------------------------------------
create proc Delete_Student_Exam
	@St_id int,
	@Ex_id int
as
	if not exists (select * from student_exam where st_id = @St_id)
		begin
			print('The student id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from student_exam where e_id = @Ex_id)
			begin
				print('The exam id you just entered does not match any of our records.')
			end
    else
		begin
			delete from student_exam
			where st_id = @St_id and e_id = @Ex_id
			print('Student_exam record got deleted successfully.')
		end

Delete_Student_Exam 4009, 2
select * from student_exam
----------------------------------------------------------------------------------------------------------------------------------
create proc Add_Department_Course
	@D_id int,
	@Crs_id int
as
	if not exists (select * from course where id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from department where d_id = @D_id)
			begin
				print('The department id you just entered does not match any of our records.')
			end
    else
    begin
        insert into department_course
        values(@D_id, @Crs_id)
        print('The new department_course data got saved successfully.')
    end


select * from department, course
Add_Department_Course @D_id=101, @Crs_id=1
select * from department_course
--------------------------------------------------------------------------------
alter proc View_Department_Course
	@D_id int = null,
	@Crs_id int = null
as
	if @D_id is null
		begin
			print('You need to enter department id')
		end
	else
		if @Crs_id is null
			begin
				print('You need to enter course id')
			end
	else
		if @Crs_id is not null and not exists (select * from department_course where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
	else
		if @D_id is not null and not exists (select * from department_course where d_id = @D_id)
			begin
				print('The department id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from Department_Course
			where d_id = @D_id and crs_id = @Crs_id
		end

View_Department_Course 101, 1

--------------------------------------------------------------------------------
alter proc Update_Department_Course

	@old_D_id int = null,
	@old_Crs_id int = null,
	@new_D_id int = null,
	@new_Crs_id int = null
as
	if @old_D_id is null
		begin
			print('You need to enter the old department id')
		end
	else
		if @old_Crs_id is null
			begin
				print('You need to enter the old course id')
			end
	else
		if @old_Crs_id is not null and not exists (select * from department_course where crs_id = @old_Crs_id)
			begin
				print('The old course id you just entered does not match any of our records.')
			end
	else
		if @old_D_id is not null and not exists (select * from department_course where d_id = @old_D_id)
			begin
				print('The old department id you just entered does not match any of our records.')
			end
	else
		if @new_Crs_id is not null and not exists (select * from course where id = @new_Crs_id)
			begin
				print('The new course id you just entered does not match any of our records.')
			end
	else
		if @new_D_id is not null and not exists (select * from department where d_id = @new_D_id)
			begin
				print('The new department id you just entered does not match any of our records.')
			end
    else
		begin
			update department_course
			set d_id = isnull(@new_D_id, @old_D_id),
				crs_id = isnull(@new_Crs_id, @old_Crs_id)
			where d_id = @old_D_id and crs_id = @old_Crs_id
			print('Department_course record got updated successfully.')
		end

select* from department, course
Update_Department_Course @old_D_id=101, @old_Crs_id=1, @new_D_id = 105, @new_Crs_id = 2
select * from department_course
-----------------------------------------------------------------------------------------
create proc Delete_Department_Course
	@D_id int,
	@Crs_id int
as
	if not exists (select * from department_course where crs_id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from department_course where d_id = @D_id)
			begin
				print('The department id you just entered does not match any of our records.')
			end
    else
		begin
			delete from department_course
			where d_id = @D_id and crs_id = @Crs_id
			print('Department_course record got deleted successfully.')
		end

Delete_Department_Course 105, 2
select * from department_course
------------------------------------------------------------------------------------------------------------------------------
create proc Add_Instructor_Course
	@Ins_id int,
	@Crs_id int
as
	if not exists (select * from course where id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from instructor where ins_id = @Ins_id)
			begin
				print('The instructor id you just entered does not match any of our records.')
			end
    else
    begin
        insert into instructor_course
        values(@Ins_id, @Crs_id)
        print('The new instructor_course data got saved successfully.')
    end


Add_Instructor_Course 10, 1
select * from instructor_course
----------------------------------------------------------------------------------------------
alter proc View_Instructor_Course
	@Ins_id int = null,
	@Crs_id int = null
as
	if @Ins_id is null
		begin
			print('You need to enter instructor id')
		end
	else
		if @Crs_id is null
			begin
				print('You need to enter course id')
			end
	else
		if @Crs_id is not null and not exists (select * from instructor_course where crs_id = @Crs_id)
			begin
				print('The course id you just entered does not match any of our records.')
			end
	else
		if @Ins_id is not null and not exists (select * from instructor_course where ins_id = @Ins_id)
			begin
				print('The instructor id you just entered does not match any of our records.')
			end
	else
		begin
			select *
			from Instructor_Course
			where ins_id = @Ins_id and crs_id = @Crs_id
		end

View_Instructor_Course 10, 1
---------------------------------------------------------------------------------------------
create proc Update_Instructor_Course

	@old_Ins_id int = null,
	@old_Crs_id int = null,
	@new_Ins_id int = null,
	@new_Crs_id int = null
as
	if @old_Ins_id is null
		begin
			print('You need to enter the old instructor id')
		end
	else
		if @old_Crs_id is null
			begin
				print('You need to enter the old course id')
			end
	else
		if @old_Crs_id is not null and not exists (select * from instructor_course where crs_id = @old_Crs_id)
			begin
				print('The old course id you just entered does not match any of our records.')
			end
	else
		if @old_Ins_id is not null and not exists (select * from instructor_course where ins_id = @old_Ins_id)
			begin
				print('The old instructor id you just entered does not match any of our records.')
			end
	else
		if @new_Crs_id is not null and not exists (select * from course where id = @new_Crs_id)
			begin
				print('The new course id you just entered does not match any of our records.')
			end
	else
		if @new_Ins_id is not null and not exists (select * from instructor where ins_id = @new_Ins_id)
			begin
				print('The new instructor id you just entered does not match any of our records.')
			end
    else
		begin
			update instructor_course
			set ins_id = isnull(@new_Ins_id, @old_Ins_id),
				crs_id = isnull(@new_Crs_id, @old_Crs_id)
			where ins_id = @old_Ins_id and crs_id = @old_Crs_id
			print('Instructor_course record got updated successfully.')
		end

Update_Instructor_Course @old_Crs_id = 2, @old_Ins_id = 10, @new_Crs_id = 3, @new_Ins_id = 9
select * from instructor_course
------------------------------------------------------------------------------
create proc Delete_Instructor_Course
	@Ins_id int,
	@Crs_id int
as
	if not exists (select * from instructor_course where crs_id = @Crs_id)
		begin
			print('The course id you just entered does not match any of our records.')
		end
	else
		if not exists (select * from instructor_course where ins_id = @Ins_id)
			begin
				print('The instructor id you just entered does not match any of our records.')
			end
    else
		begin
			delete from instructor_course
			where ins_id = @Ins_id and crs_id = @Crs_id
			print('Instructor_course record got deleted successfully.')
		end

Delete_Instructor_Course @Ins_id = 9, @Crs_id = 2
select * from instructor_course
----------------------------------------------------------------------------------------------------------------------------
