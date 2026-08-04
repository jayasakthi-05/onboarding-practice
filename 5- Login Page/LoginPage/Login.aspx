<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Login_Page.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <style>
    body {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: Arial, sans-serif;
    }

    .login-box {
        width: 350px;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0px 0px 10px #ccc;
    }

    .login-box input {
        width: 90%;
        padding: 8px;
    }

    .login-box button {
        padding: 8px 25px;
        cursor: pointer;
    }
</style>

    <script type="text/javascript">
        function validateForm() {

            var username = document.getElementById("<%= txtUsername.ClientID %>").value.trim();
            var password = document.getElementById("<%= txtPassword.ClientID %>").value.trim();

            if (username === "") {
                alert("Please enter your username.");
                return false;
            }

            if (password === "") {
                alert("Please enter your password.");
                return false;
            }

            return true;
        }
    </script>

</head>

<body>

<form id="form1" runat="server">

<div class="login-box">

    <h2>Login Page</h2>

    Username<br />
    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

    <br /><br />

    Password<br />
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

    <br /><br />

    <asp:Button ID="btnLogin"
        runat="server"
        Text="Login"
        OnClick="btnLogin_Click"
        OnClientClick="return validateForm();" />

    <br /><br />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    </div>

</form>

</body>
</html>