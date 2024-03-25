

Create PROCEDURE CorrectExam
    @Exam_Id INT
AS
BEGIN
    BEGIN TRY
        -- Declare variables for question ID, correct answer, and student's answer
        DECLARE @Question_id INT;
        DECLARE @Correct_Answer VARCHAR(100); -- Adjust the size based on your actual data
        DECLARE @Student_Answer VARCHAR(100); -- Adjust the size based on your actual data
        DECLARE @OverallGrade INT = 0;
        DECLARE @St_Id INT;
        DECLARE @Crs_Id INT;

        -- Cursor to loop through each question in the exam
        DECLARE exam_cursor CURSOR FOR
        SELECT Q_ID, ST_Answer
        FROM Exam_Question
        WHERE E_ID = @Exam_Id;

        OPEN exam_cursor;

        FETCH NEXT FROM exam_cursor INTO @Question_id, @Student_Answer;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @Correct_Answer = Correct_Answer
            FROM  Question
            WHERE ID = @Question_id;

            -- Update the Q_Grade column based on whether the student's answer matches the correct answer
            UPDATE Exam_Question
            SET Q_Grade = CASE WHEN @Student_Answer = @Correct_Answer THEN 10 ELSE 0 END
            WHERE E_ID = @Exam_Id AND Q_ID = @Question_id;

            -- Accumulate the overall grade
            SET @OverallGrade = @OverallGrade + CASE WHEN @Student_Answer = @Correct_Answer THEN 10 ELSE 0 END;

            FETCH NEXT FROM exam_cursor INTO @Question_id, @Student_Answer;
        END;

        -- Close and deallocate the cursor
        CLOSE exam_cursor;
        DEALLOCATE exam_cursor;

        -- Determine status based on overall grade
        DECLARE @Status VARCHAR(20);

        IF @OverallGrade < 60
            SET @Status = 'Fail';
        ELSE IF @OverallGrade >= 60 AND @OverallGrade < 80
            SET @Status = 'Good';
        ELSE IF @OverallGrade >= 80 AND @OverallGrade < 90
            SET @Status = 'Very Good';
        ELSE
            SET @Status = 'Excellent';

        -- Get St_Id for the exam from Student_Exam table or another relevant table
        SELECT @St_Id = St_Id
        FROM Student_Exam
        WHERE E_Id = @Exam_Id;

        -- Get Crs_Id for the exam from Course_Exam table
        SELECT @Crs_Id = Crs_Id
        FROM Course_Exam
        WHERE E_Id = @Exam_Id;

        -- Insert/update grade for student and course
        IF NOT EXISTS (SELECT * FROM Student_Exam WHERE St_Id = @St_Id AND E_Id = @Exam_Id)
        BEGIN
           
			INSERT INTO Student_Exam(St_Id, E_Id, Exam_Grade)
            VALUES (@St_Id, @Exam_Id, @OverallGrade);
        END
        ELSE
        BEGIN
            
			UPDATE Student_Exam
            SET Exam_Grade = @OverallGrade
            WHERE St_Id = @St_Id AND E_ID = @Exam_Id;
        END;
    END TRY
    BEGIN CATCH
        print( 'An Error has Occured, Please Enter the Correct Data');
        THROW;
    END CATCH;
END;




