
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using BCrypt.Net;

namespace LoginPageSecure
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            string connectionString =
                ConfigurationManager.ConnectionStrings["LoginDb"]
                .ConnectionString;

            try
            {
                string storedHash = null;

                using (SqlConnection connection =
                    new SqlConnection(connectionString))
                {
                    string query =
                        "SELECT PasswordHash FROM dbo.Users WHERE Username = @Username";

                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Username", username);

                        connection.Open();

                        object result = command.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            storedHash = result.ToString();
                        }
                    }
                }

                if (!string.IsNullOrEmpty(storedHash) &&
                    BCrypt.Net.BCrypt.Verify(password, storedHash))
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Login successful!";
                }
                else
                {
                    lblMessage.ForeColor =
                        System.Drawing.Color.Red;
                    lblMessage.Text =
                        "Invalid username or password.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
                lblMessage.Text = Server.HtmlEncode(ex.Message);
            }
        }
    }
}
