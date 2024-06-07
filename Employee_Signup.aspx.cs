﻿using CsQuery.Engine.PseudoClassSelectors;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls;
using System.Windows.Documents;

namespace VMS
{

    public partial class Employee_Signup : System.Web.UI.Page
    {
        string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=VMS;Integrated Security=True;";

        //string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Btn_edit.Visible = false; // Hide the "Edit" button on initial page load

                if (Session["User_id"] != null)
                {
                    // Retrieve the User_id session variable and set it as the text of the userIdInput textbox
                    string userId = Session["User_id"].ToString();
                    userIdInput.Text = userId;
                }

            }
            // Check if the user is logged in as Admin
            if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
            {

            }
            else
            {
                Response.Redirect("Authenticate_User.aspx");
            }
        }

      


        protected void Btn_save_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.ListItem selectedItem = usertype.SelectedItem;
            System.Web.UI.WebControls.ListItem selectedItem1 = ddlDepartment.SelectedItem;
            string itemText = selectedItem.Text;
            string itemText1 = selectedItem1.Text;

            System.Diagnostics.Trace.WriteLine($" connection done ; " + connectionString);
            SqlConnection connection = new SqlConnection(connectionString);
            string query = "INSERT INTO Employ_Registration (Name, Mobile_No, Email, Employee_ID, Department,password,user_type) VALUES (@Name, @Mobil_No, @Email, @EmployeeID, @Department,@password,@user_type)";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", txteName.Text);
                command.Parameters.AddWithValue("@Mobil_No", txteMbNo.Text);
                command.Parameters.AddWithValue("@Email", txteemail.Text);
                command.Parameters.AddWithValue("@EmployeeID", txtID.Text);
                command.Parameters.AddWithValue("@Department", itemText1);
                command.Parameters.AddWithValue("@password", txtpassword.Text);
                command.Parameters.AddWithValue("@user_type", itemText);
                System.Diagnostics.Trace.WriteLine($" usertype is  ; " + usertype.SelectedItem);
                command.ExecuteNonQuery();
                connection.Close();

                string alertMessage = "alert('Employee registered successfully.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", alertMessage, true);

               
            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                string alertMessage = $"alert('An error occurred: {ex.Message}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", alertMessage, true);
                System.Diagnostics.Trace.WriteLine($" No record found; {ex.Message}");
            }
        }
        protected void Btn_edit_Click(object sender, EventArgs e)
        {
            string name = txteName.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                if (IsNameExists(name))
                {
                    string query = "UPDATE Employ_Registration SET ";
                    List<string> fieldsToUpdate = new List<string>();

                    if (!string.IsNullOrEmpty(txteName.Text))
                    {
                        fieldsToUpdate.Add("Name = @Name");
                    }
                    if (!string.IsNullOrEmpty(txteemail.Text))
                    {
                        fieldsToUpdate.Add("Email = @Email");
                    }
                    if (!string.IsNullOrEmpty(txtID.Text))
                    {
                        fieldsToUpdate.Add("Employee_Id = @EmployeeId");
                    }
                    if (!string.IsNullOrEmpty(ddlDepartment.Text))
                    {
                        fieldsToUpdate.Add("Department = @Department");
                    }
                    if (!string.IsNullOrEmpty(txtpassword.Text))
                    {
                        fieldsToUpdate.Add("password = @Password");
                    }
                    if (usertype.SelectedItem != null)
                    {
                        fieldsToUpdate.Add("user_type = @UserType");
                    }

                    if (fieldsToUpdate.Count > 0)
                    {
                        query += string.Join(", ", fieldsToUpdate);
                        query += " WHERE Name = @OriginalName";

                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            SqlCommand command = new SqlCommand(query, connection);

                            if (!string.IsNullOrEmpty(txteName.Text))
                            {
                                command.Parameters.AddWithValue("@Name", txteName.Text);
                            }
                            if (!string.IsNullOrEmpty(txteemail.Text))
                            {
                                command.Parameters.AddWithValue("@Email", txteemail.Text);
                            }
                            if (!string.IsNullOrEmpty(txtID.Text))
                            {
                                command.Parameters.AddWithValue("@EmployeeId", txtID.Text);
                            }
                            if (!string.IsNullOrEmpty(ddlDepartment.Text))
                            {
                                command.Parameters.AddWithValue("@Department", ddlDepartment.Text);
                            }
                            if (!string.IsNullOrEmpty(txtpassword.Text))
                            {
                                command.Parameters.AddWithValue("@Password", txtpassword.Text);
                            }
                            if (usertype.SelectedItem != null)
                            {
                                command.Parameters.AddWithValue("@UserType", usertype.SelectedItem.Text);
                            }
                            command.Parameters.AddWithValue("@OriginalName", name);

                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                // Handle if update successful
                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Employee details updated successfully.');", true);
                            }
                            else
                            {
                                // Handle if update failed
                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Failed to update employee details.');", true);
                            }
                        }
                    }
                    else
                    {
                        // Handle if no field is updated
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No field is updated.');", true);
                    }
                }
                else
                {
                    // Handle if name does not exist
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Employee does not exist.');", true);
                }
            }
        }

        private bool IsNameExists(string name)
        {
            bool result = false;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Employ_Registration WHERE Name = @Name";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Name", name);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    result = count > 0;
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
            }
            return result;
        }

        private void LoadEmployeeDetails(string name)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM Employ_Registration WHERE Name = @Name";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Name", name);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        txteName.Text = reader["Name"].ToString();
                        txteMbNo.Text = reader["Mobile_No"].ToString();
                        txteemail.Text = reader["Email"].ToString();
                        txtID.Text = reader["Employee_ID"].ToString();
                        ddlDepartment.SelectedValue = reader["Department"].ToString();
                        txtpassword.Text = reader["password"].ToString();
                        usertype.SelectedValue = reader["user_type"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
            }
        }
        //private void LoadEmployeeData()
        //{
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        string query = "SELECT * FROM Employ_Registration";
        //        SqlCommand command = new SqlCommand(query, connection);

        //        connection.Open();
        //        SqlDataReader reader = command.ExecuteReader();
        //        GridView2.DataSource = reader;
        //        GridView2.DataBind();
        //    }
        //}
        private void SendEmployeeDataToClients()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Employ_Registration";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                var employeeData = new List<string>();
                while (reader.Read())
                {
                    // Convert the employee data to a JSON string or any preferred format
                    var data = $"{reader["Name"]}, {reader["Mobile_No"]}, {reader["Email"]}, {reader["Employee_ID"]}, {reader["Department"]}, {reader["password"]}, {reader["user_type"]}";
                    employeeData.Add(data);
                }
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();
                hubContext.Clients.All.ReceiveEmployeeData(employeeData);
            }
        }

        protected void txteName_TextChanged(object sender, EventArgs e)
        {
            string userName = txteName.Text.Trim(); // Update to read the username textbox
            if (!string.IsNullOrEmpty(userName))
            {
                if (IsNameExists(userName))
                {
                    LoadEmployeeDetails(userName); // Assuming LoadEmployeeDetails accepts a username parameter
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Username is already registered. Please edit if needed.');", true);
                    Btn_edit.Visible = true;
                    Btn_save.Visible = false;
                }
                else
                {
                    Btn_edit.Visible = false;
                    // Optionally, you might want to show a message indicating that the username is available.
                }
            }

        }
        [System.Web.Services.WebMethod]
        public static List<string> GetMatchingNames(string prefix)
        {
            List<string> names = new List<string>();
            string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=vms;Integrated Security=True;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Name FROM Employ_Registration WHERE Name LIKE @Prefix + '%'";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Prefix", prefix);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    names.Add(reader["Name"].ToString());
                }
            }

            return names;
        }
    }
}