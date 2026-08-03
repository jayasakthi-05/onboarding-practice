using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LoginPage
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
        
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Username and Password are required.";
                return;
            }

            
            if (username.Length < 3 || username.Length > 20)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid username or password.";
                return;
            }

            
            const string validUsername = "admin";
            const string validPassword = "Password123";

            if (username == validUsername && password == validPassword)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Login successful!";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid username or password.";
            }
        }
        

        }
    }
