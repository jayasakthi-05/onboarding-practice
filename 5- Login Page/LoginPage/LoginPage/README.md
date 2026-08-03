\# ASP.NET Login Page



\## IIS Setup



1\. Open IIS Manager.

2\. Right-click \*\*Sites\*\* and select \*\*Add Website\*\*.

3\. Site Name: LoginPage

4\. Physical Path: Select this project folder.

5\. Port: 8082 (or any available port).

6\. Click \*\*OK\*\*.

7\. Browse the website from IIS.



\## Application Pool



\- .NET CLR Version: \*\*v4.0\*\*

\- Managed Pipeline Mode: \*\*Integrated\*\*



\## Folder Permissions



If required, grant \*\*IIS\_IUSRS\*\* Read \& Execute permission to the project folder.



\## Test Credentials



\- Username: \*\*admin\*\*

\- Password: \*\*Password123\*\*



\## Security Note



This project uses hardcoded credentials only for demonstration purposes. In a real production application, credentials should never be stored in the source code. Passwords should be securely hashed and stored in a database.

