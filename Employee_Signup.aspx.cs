using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    
    public partial class Employee_Signup : System.Web.UI.Page
    {
        string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=vms;Integrated Security=True;";
        //string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btn_edit.Visible = false; // Hide the "Edit" button on initial page load
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            ListItem selectedItem = usertype.SelectedItem;
            string itemText = selectedItem.Text;
            //string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";
         //   string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
           // string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;


            System.Diagnostics.Trace.WriteLine($" connection done ; "+ connectionString);
            SqlConnection connection = new SqlConnection(connectionString);
            string query = "INSERT INTO Employ_Registration (Name, Mobile_No, Email, Department,password,user_type) VALUES (@Name, @Mobil_No, @Email, @Department,@password,@user_type)";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", txteName.Text);
                command.Parameters.AddWithValue("@Mobil_No", txteMbNo.Text);
                command.Parameters.AddWithValue("@Email", txteemail.Text);
                command.Parameters.AddWithValue("@Department", ddlDepartment.Text);
                command.Parameters.AddWithValue("@password", txtpassword.Text);
                command.Parameters.AddWithValue("@user_type", itemText);
                System.Diagnostics.Trace.WriteLine($" usertype is  ; "+ usertype.SelectedItem);
                command.ExecuteNonQuery();
                connection.Close();
                string alertMessage = "alert('Employee registered ');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", alertMessage, true);

                Response.Redirect("Registration.aspx");
                System.Diagnostics.Trace.WriteLine($" Data is send ; ");
               


            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
                System.Diagnostics.Trace.WriteLine($" No record found; {ex.Message}");



            }
        }
        protected void btn_edit_Click(object sender, EventArgs e)
        {
            string mobileNo = txteMbNo.Text.Trim();
            if (!string.IsNullOrEmpty(mobileNo))
            {
                if (IsMobileNoExists(mobileNo))
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
                        query += " WHERE Mobile_No = @MobileNo";
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
                            command.Parameters.AddWithValue("@MobileNo", mobileNo);
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
                    // Handle if mobile number not exists
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Mobile number does not exist.');", true);
                }
            }
        }

        protected void txteMbNo_TextChanged(object sender, EventArgs e)
        {
            string mobileNo = txteMbNo.Text.Trim();
            if (!string.IsNullOrEmpty(mobileNo))
            {
                if (IsMobileNoExists(mobileNo))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Mobile number is already registered. Please edit if needed.');", true);
                    btn_edit.Visible = true;
                    btn_save.Visible = false;
                }
                else
                {
                    btn_edit.Visible = false;
                }
            }
        }
        private bool IsMobileNoExists(string mobileNo)
        {
            bool result = false;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Employ_Registration WHERE Mobile_No = @MobileNo";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@MobileNo", mobileNo);

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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}