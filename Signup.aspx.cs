﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing.Aztec.Internal;

namespace VMS
{
   
    public partial class Signup : System.Web.UI.Page
    {
        // string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";

        string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btn_edit.Visible = false; // Hide the "Edit" button on initial page load

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
                System.Diagnostics.Trace.WriteLine($"sign up loads");
                }
                else if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "Admin")
                {
                    employeelink.Visible = false;
                }
                else
                {
                System.Diagnostics.Trace.WriteLine($"sign up else  loads");

                Response.Redirect("Authenticate_User.aspx");
                }
            
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
           // string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
           //    string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

            string query = "INSERT INTO Visitor_Registration (Name, Mobile_No, Email, Company) VALUES (@Name, @Mobil_No, @Email, @Company)";
            try
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Open the connection
                connection.Open();

                // Create the command and set its parameters
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", txtName.Text);
                    command.Parameters.AddWithValue("@Mobil_No", txtMbNo.Text);
                    command.Parameters.AddWithValue("@Email", txtemail.Text);
                    command.Parameters.AddWithValue("@Company", txtcompany.Text);

                    // Execute the command
                    command.ExecuteNonQuery();
                }

                // Close the connection
                connection.Close();

                // Redirect to the registration page upon successful insertion
                Response.Redirect("Registration.aspx");
            }
        }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        protected void btn_edit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                if (IsNameExists(name))
                {
                    string query = "UPDATE Visitor_Registration SET ";
                    List<string> fieldsToUpdate = new List<string>();
                    if (!string.IsNullOrEmpty(txtMbNo.Text))
                    {
                        fieldsToUpdate.Add("Mobile_No = @MobileNo");
                    }
                    if (!string.IsNullOrEmpty(txtemail.Text))
                    {
                        fieldsToUpdate.Add("Email = @Email");
                    }
                    if (!string.IsNullOrEmpty(txtcompany.Text))
                    {
                        fieldsToUpdate.Add("Company = @Company");
                    }
                    if (fieldsToUpdate.Count > 0)
                    {
                        query += string.Join(", ", fieldsToUpdate);
                        query += " WHERE Name = @Name";
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            SqlCommand command = new SqlCommand(query, connection);
                            if (!string.IsNullOrEmpty(txtMbNo.Text))
                            {
                                command.Parameters.AddWithValue("@MobileNo", txtMbNo.Text);
                            }
                            if (!string.IsNullOrEmpty(txtemail.Text))
                            {
                                command.Parameters.AddWithValue("@Email", txtemail.Text);
                            }
                            if (!string.IsNullOrEmpty(txtcompany.Text))
                            {
                                command.Parameters.AddWithValue("@Company", txtcompany.Text);
                            }
                            command.Parameters.AddWithValue("@Name", name);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Handle if update successful
                                // Response.Redirect("Registration.aspx");

                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert(' Visitor details updated successfully.');", true);
                            }
                            else
                            {
                                // Handle if update failed
                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Failed to update Visitor details.');", true);
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Name does not exist.');", true);
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
                    string query = "SELECT COUNT(*) FROM Visitor_Registration WHERE Name = @Name";
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

        private void LoadVisitorDetailsByName(string name)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM Visitor_Registration WHERE Name = @Name";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Name", name);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtName.Text = reader["Name"].ToString();
                                txtMbNo.Text = reader["Mobile_No"].ToString();
                                txtemail.Text = reader["Email"].ToString();
                                txtcompany.Text = reader["Company"].ToString();
                            }
                        }
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



        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                if (IsNameExists(name))
                {
                    // Assuming IsNameExists checks if the name already exists in the system
                    LoadVisitorDetailsByName(name);
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Name is already registered. Please edit if needed.');", true);
                    btn_edit.Visible = true;
                    btn_submit.Visible = false;
                }
                else
                {
                    btn_edit.Visible = false;
                    btn_submit.Visible = true; // Ensure that the submit button is visible if the name doesn't exist
                }
            }
            else
            {
                // Clear fields and reset button visibility if name is empty
                ClearFields();
            }
        }
        private void ClearFields()
        {
            txtMbNo.Text = "";
            txtemail.Text = "";
            txtcompany.Text = "";
            btn_edit.Visible = false;
            btn_submit.Visible = true;
        }
    }
}