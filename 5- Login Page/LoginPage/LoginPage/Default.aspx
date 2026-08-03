<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LoginPage._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

 <h2>Login Page</h2>

<table>
    <tr>
        <td>Username:</td>
        <td>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td>Password:</td>
        <td>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <asp:Button ID="btnLogin"
                runat="server"
                Text="Login"
                OnClick="btnLogin_Click" />
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <asp:Label ID="lblMessage"
                runat="server"
                ForeColor="Red"></asp:Label>
        </td>
    </tr>
</table>  

</asp:Content>
