using System;

namespace Login_Page
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();


            // Server-side validation
            if (string.IsNullOrWhiteSpace(username))
            {
                lblMessage.Text = "Username is required.";
                return;
            }


            if (string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Password is required.";
                return;
            }


            // Dummy credentials
            if (username == "admin" && password == "Password123")
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Login Successful!";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid username or password.";
            }
        }
    }
}