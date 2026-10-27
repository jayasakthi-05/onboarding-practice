<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="Employees.aspx.cs"
    Inherits="EmployeeDirectory.Employees" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Employee Directory</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fb;
            color: #1f2937;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 24px;
        }

        h1 {
            margin-bottom: 8px;
        }

        .subtitle {
            color: #64748b;
            margin-bottom: 24px;
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0,0,0,.06);
            margin-bottom: 24px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 11px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
        }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 18px;
        }

        button {
            padding: 11px 18px;
            border: 0;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }

        .primary {
            background: #2563eb;
            color: white;
        }

        .secondary {
            background: #e2e8f0;
            color: #1e293b;
        }

        .search {
            max-width: 400px;
            margin-bottom: 18px;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        th {
            background: #eff6ff;
        }

        .message {
            display: block;
            margin-bottom: 16px;
            color: #b91c1c;
        }

        .success {
            color: #15803d;
        }

        .grid-button {
            padding: 7px 10px;
            margin: 2px;
        }

        @media (max-width: 650px) {
            .container {
                margin: 12px auto;
                padding: 12px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .panel {
                padding: 16px;
            }
        }
    </style>

  

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("mainForm");

        if (form) {
            form.addEventListener("submit", function (event) {
                const name = document.getElementById("txtName");
                const email = document.getElementById("txtEmail");
                const position = document.getElementById("txtPosition");
                const department = document.getElementById("ddlDepartment");
                const hireDate = document.getElementById("txtHireDate");
                const error = document.getElementById("clientError");

                if (!name || !email || !position ||
                    !department || !hireDate || !error) {
                    return;
                }

                error.textContent = "";

                if (!name.value.trim() ||
                    !email.value.trim() ||
                    !position.value.trim() ||
                    !department.value ||
                    !hireDate.value) {
                    event.preventDefault();
                    error.textContent =
                        "Please complete all employee fields.";
                    return;
                }

                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim())) {
                    event.preventDefault();
                    error.textContent =
                        "Please enter a valid email address.";
                    return;
                }

                if (hireDate.value >
                    new Date().toLocaleDateString("en-CA")) {
                    event.preventDefault();
                    error.textContent =
                        "Hire date cannot be in the future.";
                }
            });
        }

        const search = document.getElementById("txtSearch");

        if (search) {
            search.addEventListener("input", function () {
                const term = search.value.toLowerCase();

                document.querySelectorAll("#gvEmployees tbody tr")
                    .forEach(function (row) {
                        row.style.display =
                            row.textContent.toLowerCase().includes(term)
                                ? ""
                                : "none";
                    });
            });
        }
    });

    function confirmDelete() {
        return confirm(
            "Are you sure you want to delete this employee?"
        );
    }
</script>


</head>
<body>
<form id="mainForm" runat="server">
    <main class="container">
        <h1>Employee Directory</h1>
        <p class="subtitle">Manage your employee records in one place.</p>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        <span id="clientError" class="message" aria-live="polite"></span>

        <section class="panel">
            <h2 id="formHeading" runat="server">Add Employee</h2>

            <asp:HiddenField ID="hfEmployeeId" runat="server" />
<div class="form-grid" id="employeeForm">
    <div>
        <label for="txtName">Name</label>
        <asp:TextBox ID="txtName" runat="server"
            ClientIDMode="Static" MaxLength="200" />
    </div>

    <div>
        <label for="txtEmail">Email</label>
        <asp:TextBox ID="txtEmail" runat="server"
            ClientIDMode="Static" TextMode="Email" MaxLength="255" />
    </div>

    <div>
        <label for="txtPosition">Position</label>
        <asp:TextBox ID="txtPosition" runat="server"
            ClientIDMode="Static" MaxLength="100"
            placeholder="Enter position" />
    </div>

    <div>
        <label for="ddlDepartment">Department</label>
        <asp:DropDownList ID="ddlDepartment" runat="server"
            ClientIDMode="Static" />
    </div>

    <div>
        <label for="txtHireDate">Hire Date</label>
        <asp:TextBox ID="txtHireDate" runat="server"
            ClientIDMode="Static" TextMode="Date" />
    </div>
</div>

<div class="actions">
    <asp:Button ID="btnSave" runat="server"
        Text="Add Employee"
        CssClass="primary"
        OnClick="btnSave_Click" />

    <asp:Button ID="btnCancel" runat="server"
        Text="Clear"
        CssClass="secondary"
        CausesValidation="false"
        OnClick="btnCancel_Click" />
</div>

        <section class="panel">
            <h2>All Employees</h2>
            <input type="search" id="txtSearch" class="search"
                placeholder="Search by name or department..." />

            <div class="table-wrap">
                <asp:GridView ID="gvEmployees" runat="server"
    ClientIDMode="Static"
    CssClass="employee-grid"
                    AutoGenerateColumns="False" DataKeyNames="EmployeeID"
                    OnRowCommand="gvEmployees_RowCommand"
                    EmptyDataText="No employees found.">
<Columns>
    <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
    <asp:BoundField DataField="Name" HeaderText="Name" />
    <asp:BoundField DataField="Email" HeaderText="Email" />
    <asp:BoundField DataField="Position" HeaderText="Position" />
    <asp:BoundField DataField="Department" HeaderText="Department" />
    <asp:BoundField DataField="HireDate"
        HeaderText="Hire Date"
        DataFormatString="{0:dd-MMM-yyyy}" />

    <asp:TemplateField HeaderText="Actions">
        <ItemTemplate>
            <asp:Button ID="btnEdit" runat="server"
                Text="Edit"
                CommandName="EditEmployee"
                CommandArgument='<%# Eval("EmployeeID") %>'
                CssClass="grid-button"
                CausesValidation="false" 
                UseSubmitBehavior="false" />

            <asp:Button ID="btnDelete" runat="server"
                Text="Delete"
                CommandName="DeleteEmployee"
                CommandArgument='<%# Eval("EmployeeID") %>'
                CssClass="grid-button delete-button"
                CausesValidation="false"
                OnClientClick="return confirmDelete();" />
        </ItemTemplate>
    </asp:TemplateField>
</Columns>
                </asp:GridView>
            </div>
        </section>
    </main>
</form>
</body>
</html>
