CREATE PROCEDURE Exam_Answer
    @Exam_Id INT,
    @Question VARCHAR(100), -- Adjust the size based on your actual data
    @Student_Answer VARCHAR(100) -- Adjust the size based on your actual data
AS
BEGIN
    BEGIN TRY
        DECLARE @Question_id INT;

        -- Get the ID of the question
        SELECT @Question_id = ID
        FROM Question Q
        WHERE Question = @Question;

        -- Update the student's answer
        UPDATE Exam_Question
        SET ST_Answer = @Student_Answer
        WHERE E_ID = @Exam_Id AND Q_ID = @Question_id;
    END TRY
    BEGIN CATCH
        -- Log the error or perform any necessary actions for error handling
    PRINT 'An error occurred. Please try again with valid input.';
        THROW;
    END CATCH;
END;
