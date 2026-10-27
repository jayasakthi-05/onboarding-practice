USE InternTraining;
GO

IF OBJECT_ID('dbo.Employees', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Employees
    (
        EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(255) NOT NULL UNIQUE,
        Position NVARCHAR(100) NOT NULL,
        Department NVARCHAR(100) NOT NULL,
        HireDate DATE NOT NULL,
        CreatedAt DATETIME2 NOT NULL
            DEFAULT SYSDATETIME()
    );
END;
GO

USE InternTraining;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Employees';
GO