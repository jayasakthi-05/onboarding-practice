**Employee Directory**

1. Project Overview

The **Employee Directory** is an ASP.NET Web Forms application developed using C#, SQL Server, and ADO.NET. It allows users to manage employee information through a simple web interface.

The application supports adding, viewing, editing, deleting, and searching employee records.

2. Technologies Used

- ASP.NET Web Forms (.NET Framework)
- C#
- SQL Server
- ADO.NET
- HTML
- CSS
- JavaScript
- IIS (Internet Information Services)
- Visual Studio / Visual Studio Code

3. Features

- **List Employees:** View employee records in a table.
- **Add Employee:** Add new employee details.
- **Edit Employee:** Update existing employee information.
- **Delete Employee:** Delete employee records after confirmation.
- **Search Employees:** Search employees by name or department.
- **Form Validation:** Validate required fields, email format, and hire date.
- **Database Integration:** Store and retrieve employee information using SQL Server.
- **Responsive Interface:** Use a clean interface for managing employee records.

4. Prerequisites

Install or enable the following software before running the project:

- Windows operating system
- SQL Server
- SQL Server Management Studio (SSMS)
- IIS (Internet Information Services)
- ASP.NET 4.x and .NET Extensibility 4.x IIS features
- ASP.NET Web Forms support for the .NET Framework version used by the project
- A code editor such as Visual Studio or Visual Studio Code

5. Database Setup

Step 1: Create the Database

1. Open SQL Server Management Studio (SSMS).
2. Connect to your local SQL Server instance.
3. Open the `EmployeeDirectory.sql` file included in this project.
4. Review the script and confirm that its table and column names match the application's SQL queries.
5. Execute the script to create the required database objects.

**Important:** The application expects a database named `InternTraining` with the following tables and columns.

Departments Table

| Column | Description |
|---|---|
| Id | Primary key |
| Name | Department name |

Employees Table

| Column | Description |
|---|---|
| Id | Primary key |
| FirstName | Employee's first name |
| LastName | Employee's last name |
| Email | Employee's email address |
| Position | Employee's job position |
| DepartmentId | Department reference |
| HireDate | Employee's hire date |
| Salary | Employee's salary |

The `DepartmentId` column should reference `Departments.Id`.

**Note:** Ensure that the SQL script creates this schema before running the application. Do not execute a different schema script over an existing database without checking its contents first.

6. Connection String

The application uses the `InternTrainingConnection` connection string configured in `Web.config`.

Example for a local SQL Server instance using Windows Authentication:

```xml
<connectionStrings>
    <add name="InternTrainingConnection"
         connectionString="Data Source=localhost;Initial Catalog=InternTraining;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

Update the server name and authentication settings if your SQL Server configuration is different.

7. IIS Deployment

Follow these steps to run the application using local IIS.

Step 1: Enable IIS Features

1. Open **Control Panel**.
2. Select **Programs → Turn Windows features on or off**.
3. Enable:
   - Internet Information Services
   - World Wide Web Services
   - Application Development Features
   - ASP.NET 4.x
   - .NET Extensibility 4.x
   - ISAPI Extensions
   - ISAPI Filters
4. Click **OK** and wait for the installation to finish.

Step 2: Configure the IIS Website

1. Open **IIS Manager**.
2. Locate the existing `intern-local` website.
3. Keep its current port `8081` so that other local projects are not affected.
4. Confirm that the website's physical path points to the parent directory containing the `EmployeeDirectory` folder.

Step 3: Configure the Application

1. In IIS Manager, locate the `EmployeeDirectory` folder under `intern-local`.
2. Right-click the folder and select **Convert to Application**, if it is not already configured as an application.
3. Select an application pool configured for **.NET CLR v4.0** and **Integrated** pipeline mode.
4. Apply the changes.

Step 4: Verify the Connection

Ensure that SQL Server is running and the connection string in `Web.config` matches your local database.

Step 5: Run the Application

Open your browser and navigate to:

**http://localhost:8081/EmployeeDirectory/Employees.aspx**

The Employee Directory page should load.

8. Validation

### Client-Side Validation

JavaScript validation helps check the form before submission.

- Required fields must be filled in.
- Email addresses must use a valid format.
- Hire dates must not be in the future.

### Server-Side Validation

C# validation in the code-behind checks submitted employee details before saving them to the database.

Server-side validation is important even when client-side validation is enabled.

9. CRUD Operations

The application supports the following database operations:

- **Create:** Add a new employee.
- **Read:** Display employee records.
- **Update:** Edit and save employee details.
- **Delete:** Remove an employee after confirmation.

The application also supports searching employee records by name or department.

Parameterized SQL queries are used for database operations to help prevent SQL injection.

10. Visual Verification

The following screenshots demonstrate the main features of the Employee Directory application.

**Employee List:**

Displays employee records in a table.

![Employee List](employee-list.png)

**Add Employee Form:**

Shows the form used to enter a new employee's details.

![Add Employee](add-employee.png)

**Edit Employee Form:**

Shows an existing employee's details before updating them.

![Edit Employee](edit-employee.png)

**Search Employee:**

Demonstrates searching for an employee by name or department.

![Search Employee](search-employee.png)

**Delete Confirmation:**

Shows the confirmation dialog before an employee record is deleted.

![Delete Confirmation](delete-confirmation.png)

11. Security Considerations

- Use parameterized SQL queries for database operations.
- Validate input on both the client and server.
- Use appropriate database permissions.
- Keep connection strings and environment-specific settings configured correctly.
- Confirm deletion before removing employee records.

12. Conclusion

The Employee Directory project demonstrates ASP.NET Web Forms development, C# programming, SQL Server database integration, validation, and CRUD operations. It can be deployed locally using IIS for testing and demonstration purposes.
