# Secure Login System

## Project Overview
This project is a secure login system developed using ASP.NET Web Forms, C#, and SQL Server. It validates user credentials against the database and uses BCrypt password hashing to verify passwords securely.

## Technologies Used
- ASP.NET Web Forms
- C#
- .NET Framework 4.7.2
- SQL Server
- ADO.NET
- BCrypt.Net-Next
- Visual Studio
- IIS (Internet Information Services)

## Features
- Username and password login
- Required-field validation
- Database-based credential verification
- BCrypt password hash verification
- Parameterized SQL query to help prevent SQL injection
- Generic error message for invalid credentials
- Error handling for login database failures

## Database Setup

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Create a database named `LoginDb`.
4. Create the following table:

```sql
CREATE TABLE dbo.Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(100) NOT NULL
);
```

## Configuration

Update the `LoginDb` connection string in `Web.config` to match your SQL Server configuration:

```xml
<connectionStrings>
    <add name="LoginDb"
         connectionString="Data Source=localhost;Initial Catalog=LoginDb;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

When running the application through IIS with Windows Authentication for SQL Server, ensure that the IIS application pool identity has the required permissions on the `LoginDb` database.

## Password Security

Passwords are not stored as plain text. The application uses BCrypt to verify a submitted password against the stored password hash.

New users must be registered with a BCrypt password hash. Do not insert plain-text passwords into the `PasswordHash` column.

## Username and Password
  
Username - testuser
Password - Test@12345

## How to Run in Visual Studio

1. Open the solution in Visual Studio.
2. Restore the NuGet packages if prompted.
3. Confirm that SQL Server is running and the `LoginDb` database and `Users` table exist.
4. Check the connection string in `Web.config`.
5. Build the solution and confirm that the build succeeds.
6. Run the application using Visual Studio.
7. Enter valid credentials for a user stored in the database.

## IIS Deployment

### Prerequisites
- IIS installed and enabled on Windows.
- ASP.NET 4.x and the required IIS components installed.
- .NET Framework 4.7.2 or a compatible .NET Framework version available.
- SQL Server running with the `LoginDb` database and `Users` table created.
- The application built and its required assemblies and configuration files available for deployment.

### Deployment Steps

1. Build the application in Visual Studio.
2. Prepare the application for deployment using the Visual Studio publish process, including the required application files, assemblies, `Web.config`, and `Login.aspx`.
3. Open IIS Manager by pressing `Windows + R`, entering `inetmgr`, and pressing Enter.
4. Expand the computer name and select **Sites**.
5. Create or configure the website with the following settings:
   - **Site name:** `loginpage`
   - **Binding type:** HTTP
   - **Port:** `8082`
   - **Physical path:** The folder containing the deployed application files.
6. Configure the application pool to use **.NET CLR v4.0** and **Integrated** pipeline mode.
7. Ensure that the IIS application pool identity has the necessary SQL Server permissions for the `LoginDb` database. For this deployment, the application pool identity is `IIS APPPOOL\LoginPage`.
8. Start the website in IIS.
9. Open the following URL in a browser:

   `http://localhost:8082/Login.aspx`

### IIS Verification

- Confirm that the login page opens in the browser.
- Submit the form with empty fields and verify that required-field validation messages appear.
- Test with valid credentials and verify that the login succeeds.
- Test with an incorrect password or unknown username and verify that a generic invalid-credentials message appears.
- Confirm that the application can connect to the SQL Server database without an IIS database-permission error.

## Testing

- **Valid username and password:** Displays a login success message.
- **Incorrect password:** Displays a generic invalid-credentials message.
- **Unknown username:** Displays the same generic invalid-credentials message.
- **Empty fields:** Displays required-field validation messages.
- **Database connection failure:** Displays an appropriate generic error message without exposing sensitive database details.
