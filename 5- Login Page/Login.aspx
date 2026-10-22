
<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LoginPageSecure._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <h2>Login</h2>
                <hr />

                <div class="form-group">
                    <asp:Label ID="lblUsername" runat="server"
                        AssociatedControlID="txtUsername"
                        Text="Username"></asp:Label>

                    <asp:TextBox ID="txtUsername" runat="server"
                        CssClass="form-control" MaxLength="50"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="valUsername"
                        runat="server" ControlToValidate="txtUsername"
                        ErrorMessage="Please enter your username."
                        ForeColor="Red" Display="Dynamic" />
                </div>

                <br />

                <div class="form-group">
                    <asp:Label ID="lblPassword" runat="server"
                        AssociatedControlID="txtPassword"
                        Text="Password"></asp:Label>

                    <asp:TextBox ID="txtPassword" runat="server"
                        TextMode="Password" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="valPassword"
                        runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Please enter your password."
                        ForeColor="Red" Display="Dynamic" />
                </div>

                <br />

                <asp:Button ID="btnLogin" runat="server"
                    Text="Login" CssClass="btn btn-primary"
                    OnClick="btnLogin_Click" />

                <br /><br />

                <asp:Label ID="lblMessage" runat="server"
                    EnableViewState="false"></asp:Label>
            </div>
        </div>
    </main>
</asp:Content>
