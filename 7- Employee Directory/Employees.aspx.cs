using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace EmployeeDirectory
{
    public partial class Employees : Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["InternTrainingConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDepartments();
                LoadEmployees();
            }
        }

        private void LoadDepartments()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT Id, Name FROM dbo.Departments ORDER BY Name", con))
            {
                con.Open();
                ddlDepartment.DataSource = cmd.ExecuteReader();
                ddlDepartment.DataTextField = "Name";
                ddlDepartment.DataValueField = "Id";
                ddlDepartment.DataBind();
            }

            ddlDepartment.Items.Insert(
                0, new ListItem("-- Select Department --", ""));
        }

        private void LoadEmployees()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT e.Id AS EmployeeID,
                       LTRIM(RTRIM(e.FirstName + ' ' + e.LastName)) AS Name,
                       e.Email,
                       e.Position,
                       d.Name AS Department,
                       e.HireDate
                FROM dbo.Employees e
                INNER JOIN dbo.Departments d ON e.DepartmentId = d.Id
                ORDER BY e.Id DESC", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvEmployees.DataSource = dt;
                gvEmployees.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string position = txtPosition.Text.Trim();
            string departmentId = ddlDepartment.SelectedValue;
            DateTime hireDate;

            
if (string.IsNullOrWhiteSpace(name) ||
    string.IsNullOrWhiteSpace(email) ||
    string.IsNullOrWhiteSpace(position) ||
    string.IsNullOrWhiteSpace(departmentId) ||
    !DateTime.TryParse(txtHireDate.Text, out hireDate))
{
    lblMessage.CssClass = "message error";
    lblMessage.Text = "Please fill in all fields correctly.";
    return;
}

if (!System.Text.RegularExpressions.Regex.IsMatch(
    email, @"^[^\s@]+@[^\s@]+\.[^\s@]+$"))
{
    lblMessage.CssClass = "message error";
    lblMessage.Text = "Please enter a valid email address.";
    return;
}

if (hireDate.Date > DateTime.Today)
{
    lblMessage.CssClass = "message error";
    lblMessage.Text = "Hire date cannot be in the future.";
    return;
}

int parsedDepartmentId;

if (!int.TryParse(departmentId, out parsedDepartmentId) ||
    !ddlDepartment.Items.Cast<ListItem>()
        .Any(item => item.Value == departmentId))
{
    lblMessage.CssClass = "message error";
    lblMessage.Text = "Please select a valid department.";
    return;
}


            string[] nameParts = name.Split(
                new char[] { ' ' }, 2,
                StringSplitOptions.RemoveEmptyEntries);

            string firstName = nameParts[0];
            string lastName = nameParts.Length > 1 ? nameParts[1] : "";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string employeeId = hfEmployeeId.Value;
                string query;

                if (string.IsNullOrEmpty(employeeId))
                {
                    query = @"
                        INSERT INTO dbo.Employees
                            (FirstName, LastName, Email, Position,
                             DepartmentId, HireDate, Salary)
                        VALUES
                            (@FirstName, @LastName, @Email, @Position,
                             @DepartmentId, @HireDate, 0)";
                }
                else
                {
                    query = @"
                        UPDATE dbo.Employees
                        SET FirstName = @FirstName,
                            LastName = @LastName,
                            Email = @Email,
                            Position = @Position,
                            DepartmentId = @DepartmentId,
                            HireDate = @HireDate
                        WHERE Id = @Id";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Position", position);
                    cmd.Parameters.AddWithValue("@DepartmentId",
                        parsedDepartmentId);
                    cmd.Parameters.AddWithValue("@HireDate", hireDate);

                    if (!string.IsNullOrEmpty(employeeId))
                    {
                        cmd.Parameters.AddWithValue("@Id",
                            Convert.ToInt32(employeeId));
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ClearForm();
            LoadEmployees();
            lblMessage.CssClass = "message success";
            lblMessage.Text = "Employee saved successfully.";
        }

        protected void gvEmployees_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditEmployee")
            {
                lblMessage.Text = "Edit clicked. Employee ID: " + e.CommandArgument;
                EditEmployee(Convert.ToInt32(e.CommandArgument));
            }
            else if (e.CommandName == "DeleteEmployee")
            {
                DeleteEmployee(Convert.ToInt32(e.CommandArgument));
            }
        }

        private void EditEmployee(int id)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT FirstName, LastName, Email, Position,
                       DepartmentId, HireDate
                FROM dbo.Employees
                WHERE Id = @Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        hfEmployeeId.Value = id.ToString();
                        txtName.Text = (reader["FirstName"].ToString() + " " +
                            reader["LastName"].ToString()).Trim();
                        txtEmail.Text = reader["Email"].ToString();
                        txtPosition.Text = reader["Position"].ToString();
                        ddlDepartment.SelectedValue =
                            reader["DepartmentId"].ToString();
                        txtHireDate.Text =
                            Convert.ToDateTime(reader["HireDate"])
                            .ToString("yyyy-MM-dd");

                        formHeading.InnerText = "Edit Employee";
                        btnSave.Text = "Update Employee";
                        lblMessage.Text = "";
                    }
                }
            }
        }

        private void DeleteEmployee(int id)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM dbo.Employees WHERE Id = @Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            ClearForm();
            LoadEmployees();
            lblMessage.Text = "Employee deleted successfully.";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblMessage.Text = "";
        }

        private void ClearForm()
        {
            hfEmployeeId.Value = "";
            txtName.Text = "";
            txtEmail.Text = "";
            txtPosition.Text = "";
            txtHireDate.Text = "";

            if (ddlDepartment.Items.Count > 0)
                ddlDepartment.SelectedIndex = 0;

            formHeading.InnerText = "Add Employee";
            btnSave.Text = "Save Employee";
        }
    }
}
