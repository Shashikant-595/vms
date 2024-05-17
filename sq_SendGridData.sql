CREATE PROCEDURE sp_GetEmployeeData
AS
BEGIN
    SELECT Name, Mobile_No, Email, Employee_ID, Department, Password, User_Type
    FROM Employee
    FOR JSON AUTO;
END;